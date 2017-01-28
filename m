Received: from eggs.gnu.org ([2001:4830:134:3::10]:41426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cXVn4-0007KO-DH
	for qemu-devel@nongnu.org; Sat, 28 Jan 2017 11:23:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cXVn1-0001og-7X
	for qemu-devel@nongnu.org; Sat, 28 Jan 2017 11:23:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55130)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1cXVn0-0001oU-UB
	for qemu-devel@nongnu.org; Sat, 28 Jan 2017 11:23:47 -0500
References: <1485362572-7246-1-git-send-email-den@openvz.org>
	<1e511c84-c9fa-1d4e-8a73-e48c0b29a59a@redhat.com>
	<1251c8d7-3862-2cb9-a3c8-aa6d3c8e3924@openvz.org>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <6c3d6ad4-3f77-3a5a-c619-fd242b58a730@redhat.com>
Date: Sat, 28 Jan 2017 17:23:30 +0100
MIME-Version: 1.0
In-Reply-To: <1251c8d7-3862-2cb9-a3c8-aa6d3c8e3924@openvz.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="NxljPCRCJSRkpW9GuGfldwn441XksBFsI"
Subject: Re: [Qemu-devel] [PATCH 1/1] block: add missed BDRV_O_NOCACHE when
 block device is opened without file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NxljPCRCJSRkpW9GuGfldwn441XksBFsI
From: Max Reitz <mreitz@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>
Message-ID: <6c3d6ad4-3f77-3a5a-c619-fd242b58a730@redhat.com>
Subject: Re: [PATCH 1/1] block: add missed BDRV_O_NOCACHE when block device is
 opened without file
References: <1485362572-7246-1-git-send-email-den@openvz.org>
 <1e511c84-c9fa-1d4e-8a73-e48c0b29a59a@redhat.com>
 <1251c8d7-3862-2cb9-a3c8-aa6d3c8e3924@openvz.org>
In-Reply-To: <1251c8d7-3862-2cb9-a3c8-aa6d3c8e3924@openvz.org>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 25.01.2017 20:44, Denis V. Lunev wrote:
> On 01/25/2017 08:59 PM, Max Reitz wrote:
>> [CC-ing John]
>>
>> On 25.01.2017 17:42, Denis V. Lunev wrote:
>>> Technically there is a problem when the guest DVD is created by libvi=
rt
>>> with AIO mode 'native' on Linux. Current QEMU is unable to start the
>>> domain configured as follows:
>>>     <disk type=3D'file' device=3D'cdrom'>
>>>       <driver name=3D'qemu' type=3D'raw' cache=3D'none' io=3D'native'=
/>
>>>       <target dev=3D'sdb' bus=3D'scsi'/>
>>>       <readonly/>
>>>     </disk>
>>> The problem comes from the combination of 'cache' and 'io' options.
>>>
>>> 'io' option is common option and it is removed from block driver
>>> specific options. 'cache' originally is not. The patch makes 'cache'
>>> option common. This works fine as long as cdrom media insertion
>>> later on.
>>>
>>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>>> CC: Kevin Wolf <kwolf@redhat.com>
>>> CC: Max Reitz <mreitz@redhat.com>
>>> ---
>>>  blockdev.c | 18 +++++++++++++++---
>>>  1 file changed, 15 insertions(+), 3 deletions(-)
>> There was a Red Hat BZ for this:
>>
>> https://bugzilla.redhat.com/show_bug.cgi?id=3D1342999
>>
>> There is now a corresponding BZ for libvirt:
>>
>> https://bugzilla.redhat.com/show_bug.cgi?id=3D1377321
>>
>> The gist is that it was determined to be a problem with libvirt.
>>
>> RHEL has a downstream commit to work around this issue by ignoring the=

>> cache mode set for empty CD-ROMs -- but that is only because that was
>> simpler than fixing libvirt.
>>
>> (Note that it's ignoring the cache mode instead of actually evaluating=
 it.)
>>
> This is what I have exactly started from:
> http://ftp.redhat.com/pub/redhat/linux/enterprise/7Server/en/RHEV/SRPMS=
/qemu-kvm-rhev-2.6.0-27.el7.src.rpm
>=20
> This package starts VM well for the above mentioned configuration:
>=20
>     <disk type=3D'file' device=3D'cdrom'>
>       <driver name=3D'qemu' type=3D'raw' cache=3D'none' io=3D'native'/>=

>       <target dev=3D'sdb' bus=3D'scsi'/>
>       <readonly/>
>     </disk>
>=20
> but the problem comes later at 'change' moment. It reports
>=20
> 'Details: internal error: unable to execute QEMU command 'change':
> aio=3Dnative was specified, but it requires cache.direct=3Don, which
> was not specified.)'
>=20
>=20
> Thus partial solution implemented by the RedHat is really
> partial and does not work at the second stage.

Yes, because it is not supposed to work for that. The only thing the
downstream patch does is ignore the cache mode so you can still start
the VM even if libvirt decides to specify a cache parameter for an empty
drive (which it should not do).

>                                                I have started from
>=20
> diff --git a/blockdev.c b/blockdev.c
> index d280dc4..e2c9053 100644  =20
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -608,6 +608,13 @@ static BlockBackend *blockdev_init(const char
> *file, QDict *bs_opts,
>              goto early_err;
>          }
> =20
> +        if (qdict_haskey(bs_opts, BDRV_OPT_CACHE_DIRECT)) {
> +            bdrv_flags |=3D BDRV_O_NOCACHE;
> +        }
> +        if (qdict_haskey(bs_opts, BDRV_OPT_CACHE_NO_FLUSH)) {
> +            bdrv_flags |=3D BDRV_O_NO_FLUSH;
> +        }
> +
>          blk_rs =3D blk_get_root_state(blk);
>          blk_rs->open_flags    =3D bdrv_flags;
>          blk_rs->read_only     =3D !(bdrv_flags & BDRV_O_RDWR);
>=20
> The problem for us is that we have such previously valid configurations=

> in the field.
>=20
>>> May be this has already discussed, but still. AIO=3Dnative for CDROM =
without
>>> media seems important case.
>> First, I personally don't find aio=3Dnative very important for CD-ROM
>> drives. Yes, we shouldn't make IDE CD-ROM slower than necessary, but I=

>> don't think aio=3Dnative will make the difference between "Slow like
>> CD-ROMs are in reality" and "As fast as virtio".
> the problem for me is that each clone() call is costly and counts. That=

> is why we are trying to avoid it whenever possible. That is why 'native=
'
> mode is MUCH better. Also it would be very nice not to use cached
> IO, which is very good for memory overcommit situations.
>=20
> Here I am fighting not with the performance, which does not make
> any real sense, but with a memory footprint.

Fair enough. Still, specifying a cache mode for an empty drive simply
doesn't make sense.

Have you considered inserting a null-co:// file at startup as a
workaround? If you use the old 'change' (or blockdev-change-medium)
command, it should retain AIO and cache mode.

>> Second, all this patch does is revert some changes done by commit
>> 91a097e7478940483e76d52217f05bc05b98d5a5, which was very deliberate.
>>
>> Third, you may then be asking for the recommended way to put an
>> aio=3Dnative medium into a CD-ROM drive. Good thing you ask, because w=
e
>> have a way that we want to recommend but can't because it's still
>> considered experimental:
>>
>> The BDS is added using blockdev-add, with all of the appropriate cachi=
ng
>> and aio options. Then it's inserted into the drive using the
>> x-blockdev-insert-medium command, and the drive is closed using
>> blockdev-close-tray.
> the problem, again, is that with x-blockdev-insert-medium I can not
> deal with block driver options, or may be I am missing something.

x-blockdev-insert-medium just inserts a BDS as a medium. The BDS is
added via blockdev-add which allows you to set all of these options.

>> There are a couple of issues with this: First, blockdev-add and
>> x-blockdev-insert-medium are still experimental. The good news are tha=
t
>> I think the reason why the latter is experimental has actually
>> disappeared and we can just drop the x- by now. The
>> not-so-good-but-not-so-bad-either news are that we plan to get
>> blockdev-add declared non-experimental for 2.9. Let's see how it goes.=

> Does this mean that x-blockdev-del would also lose x- prefix?

As far as I'm aware, yes.

>> The other issue is that of course it's more cumbersome to use than a
>> simple 'change' via HMP. I argue that if someone communicates with a V=
M
>> by hand, they either have to deal with this added complexity or they
>> cannot use aio=3Dnative for CD-ROM drives -- which, as I said, I don't=

>> think is too bad.
> this is how 'virsh change-media' works at the moment, at least with
> latest downstreams.
> That is why this is not that clear.

Well, that can be easily changed, the question is how fast that will be.
You would still need to make libvirt aware of what cache mode to use for
the new medium, and that may require deeper changes.

(I supposed libvirt only stores a cache mode per drive while it should
actually store a cache mode per image.)

Max


--NxljPCRCJSRkpW9GuGfldwn441XksBFsI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliMxY0SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9APwwH/0jL53VvYMATPHcb+gqTa9b0qc+r+0dQ
gyoUl1a3wtxzR8b8hz2QtHeN0XkGZ3au8RrT3awIhSsem5uiulQy15YYjFzodUy6
79P4DR6krJM8GlqEvKs+8oLo4VDPWjdRFyuNBqxQdA99AySf93Tqd7sVS9iOhc1I
wyV1rpUbHf/CBWkn3/LEAy2HFyw53YQGUFgIR6XnOQiYt64RkOVjd3unUIAYpOYR
rV3In6PAMDPvGXs1e90W9S4fZa7t8uvwIogzyn2DtAzivZJrG/TgoaMSyFVt8gKf
jsjY1+TdfosT2Gxh3X+69IVtudYCUUWuybcdMqrjt/D1u9awy3AdnNI=
=1uMa
-----END PGP SIGNATURE-----

--NxljPCRCJSRkpW9GuGfldwn441XksBFsI--
