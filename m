Received: from eggs.gnu.org ([2001:4830:134:3::10]:48495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dG3v6-0006sf-Vf
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:44:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dG3v5-0008Aj-O7
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:44:17 -0400
References: <20170503122539.282182-1-vsementsov@virtuozzo.com>
	<20170503122539.282182-10-vsementsov@virtuozzo.com>
	<33ce370d-939f-d02e-0177-1184ae9f4fa7@redhat.com>
	<47488066-bd0f-834d-85d8-63d7289cb0fd@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <18c4b1ad-bc30-a598-36b8-612c01b00dee@redhat.com>
Date: Wed, 31 May 2017 15:43:53 +0200
MIME-Version: 1.0
In-Reply-To: <47488066-bd0f-834d-85d8-63d7289cb0fd@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="LAX79ckRIh6C6cM5faLqFfQJCI8WoPeOp"
Subject: Re: [Qemu-devel] [PATCH 09/25] block/dirty-bitmap: add readonly
 field to BdrvDirtyBitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LAX79ckRIh6C6cM5faLqFfQJCI8WoPeOp
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com,
 famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com
Message-ID: <18c4b1ad-bc30-a598-36b8-612c01b00dee@redhat.com>
Subject: Re: [PATCH 09/25] block/dirty-bitmap: add readonly field to
 BdrvDirtyBitmap
References: <20170503122539.282182-1-vsementsov@virtuozzo.com>
 <20170503122539.282182-10-vsementsov@virtuozzo.com>
 <33ce370d-939f-d02e-0177-1184ae9f4fa7@redhat.com>
 <47488066-bd0f-834d-85d8-63d7289cb0fd@virtuozzo.com>
In-Reply-To: <47488066-bd0f-834d-85d8-63d7289cb0fd@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-05-30 08:50, Vladimir Sementsov-Ogievskiy wrote:
> Thank you for this scenario. Hmm.
>=20
> So, as I need guarantee that image and bitmap are unchanged,
> bdrv_set_dirty should return error and fail the whole write. Ok?

I don't know. That would mean that you couldn't commit to an image that
has a persistent auto-loading bitmap, which doesn't seem very nice to me.=


I'm not quite sure what to do myself. So first I'd definitely want the
commit operation to succeed. That means we'd have to automatically make
the bitmap non-readonly once we write to it. The "readonly" flag would
then be an "unchanged" flag, rather, to signify that the bitmap has not
been changed since it was loaded, which means that it does not need to
be written back to the image file.

Now the issue remains that if you modify a persistent bitmap that is
stored in an image file that is opened RO when it's closed, you won't be
able to write the modifications back.

So in addition, I guess we'd need to "flush" all persistent bitmaps
(that is, write all modifications back to the file and set the
"unchanged" flag (you could also call it "dirty" and then mean the
opposite) for each bitmap) not only when the image is closed or
invalidated, but also when it is reopened read-only.

(block-commit reopens the backing BDS R/W, then writes to them, thus
modifying the dirty bitmaps, and finally reopens the BDS as read-only;
before that happens, we will have to flush the modified bitmap data.)

Max

> 29.05.2017 21:35, Max Reitz wrote:
>> On 2017-05-03 14:25, Vladimir Sementsov-Ogievskiy wrote:
>>> It will be needed in following commits for persistent bitmaps.
>>> If bitmap is loaded from read-only storage (and we can't mark it
>>> "in use" in this storage) corresponding BdrvDirtyBitmap should be
>>> read-only.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com=
>
>>> ---
>>>   block/dirty-bitmap.c         | 16 ++++++++++++++++
>>>   include/block/dirty-bitmap.h |  3 +++
>>>   2 files changed, 19 insertions(+)
>> Revisiting this again after the whole series: So you never really make=

>> sure that the read-only bitmaps are not written to (except for these
>> assertions). The idea is that you only set it for read-only BDS and
>> read-only BDS are never written to. But that assumption is not true,
>> generally, and can be broken e.g. using a commit job:
>>
>> $ ./qemu-img create -f qcow2 backing.qcow2 64M
>> Formatting 'backing.qcow2', fmt=3Dqcow2 size=3D67108864 encryption=3Do=
ff
>>      cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
>> $ ./qemu-img create -f qcow2 -b backing.qcow2 top.qcow2
>> Formatting 'top.qcow2', fmt=3Dqcow2 size=3D67108864
>>      backing_file=3Dbacking.qcow2 encryption=3Doff cluster_size=3D6553=
6
>>      lazy_refcounts=3Doff refcount_bits=3D16
>> $ x86_64-softmmu/qemu-system-x86_64 -qmp stdio
>> {"QMP": {"version": {"qemu": {"micro": 50, "minor": 9, "major": 2},
>> "package": " (v2.9.0-632-g4a52d43-dirty)"}, "capabilities": []}}
>> {'execute': 'qmp_capabilities'}
>> {"return": {}}
>> {'execute': 'blockdev-add',
>>   'arguments': {'node-name': 'backing-node', 'driver': 'qcow2',
>>                 'file': {'driver': 'file', 'filename': 'backing.qcow2'=
}}}
>> {"return": {}}
>> {'execute': 'block-dirty-bitmap-add',
>>   'arguments': {'node': 'backing-node', 'name': 'foo',
>>                 'persistent': true, 'autoload': true}}
>> {"return": {}}
>> {'execute': 'blockdev-del', 'arguments': {'node-name': 'backing-node'}=
}
>> {"return": {}}
>> {'execute': 'blockdev-add',
>>   'arguments': {'node-name': 'top-node', 'driver': 'qcow2',
>>                 'file': {'driver': 'file', 'filename': 'top.qcow2'}}}
>> {"return": {}}
>> {'execute': 'human-monitor-command',
>>   'arguments': {'command-line': 'qemu-io top-node "write 0 64k"'}}
>> wrote 65536/65536 bytes at offset 0
>> 64 KiB, 1 ops; 0.0079 sec (7.852 MiB/sec and 125.6281 ops/sec)
>> {"return": ""}
>> {'execute': 'block-commit',
>>   'arguments': {'device': 'top-node', 'job-id': 'commit-job'}}
>> {"return": {}}
>> qemu-system-x86_64: block/dirty-bitmap.c:571: bdrv_set_dirty: Assertio=
n
>> `!bdrv_dirty_bitmap_readonly(bitmap)' failed.
>> [1]    10872 abort (core dumped)  x86_64-softmmu/qemu-system-x86_64 -q=
mp
>> stdio
>>
>> So there needs to be something else than just assertions to make sure
>> that read-only bitmaps are never written to.
>>
>> Max
>>
>=20



--LAX79ckRIh6C6cM5faLqFfQJCI8WoPeOp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZLsiZEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQFEO
B/916GyYNMzOY2NZ270KE0NWRRXh8FBl78TLEqmrEXTG3WUmJBDKxRkKui9Gg9t5
V64kupeR1lS8nRvQ5QLhtj/Hsxtwm4R4MkBI6g3yI5/8iiYW7LhLQcBFfdRnNe03
3DzOS6npyMEFte4Raxt26eC0/abEVo5yq7YYkeZao7H4Cs3r83CKctTTvHwkfXQq
HgPJYcbguuNp6wIED6ulEBzqDknKq2WyCuXKUrvwdHGaNnXR6/ULIqvfkLf4GJwv
8IS8B7NFIQpPzCFudwc5GODrUin8tgjKyVdSPQ1/7263xr8fmJJJdvVXj1XQeTxv
DlmgcLgCoV1mzDP6dUVvOqCH
=LSuC
-----END PGP SIGNATURE-----

--LAX79ckRIh6C6cM5faLqFfQJCI8WoPeOp--
