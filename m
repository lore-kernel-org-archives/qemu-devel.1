Received: from eggs.gnu.org ([2001:4830:134:3::10]:41105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fXtiF-0004Cz-Pl
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 15:33:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fXtiE-0006DC-7F
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 15:33:15 -0400
From: Max Reitz <mreitz@redhat.com>
References: <152750903916.663961.9369851345277129751.stgit@bahia.lan>
	<ac4381db-2953-de6a-c5bf-27d81f68d418@redhat.com>
Message-ID: <6e43b87e-b1bc-7481-fe9b-139de3a25cf6@redhat.com>
Date: Tue, 26 Jun 2018 21:33:10 +0200
MIME-Version: 1.0
In-Reply-To: <ac4381db-2953-de6a-c5bf-27d81f68d418@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="IhzffELfudcLLWyQfNcsXkSQmfoUE4OwB"
Subject: Re: [Qemu-devel] [PATCH v4] block: fix QEMU crash with scsi-hd and
 drive_del
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-stable@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IhzffELfudcLLWyQfNcsXkSQmfoUE4OwB
From: Max Reitz <mreitz@redhat.com>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-stable@nongnu.org
Message-ID: <6e43b87e-b1bc-7481-fe9b-139de3a25cf6@redhat.com>
Subject: Re: [PATCH v4] block: fix QEMU crash with scsi-hd and drive_del
References: <152750903916.663961.9369851345277129751.stgit@bahia.lan>
 <ac4381db-2953-de6a-c5bf-27d81f68d418@redhat.com>
In-Reply-To: <ac4381db-2953-de6a-c5bf-27d81f68d418@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-06-26 21:30, Max Reitz wrote:
> On 2018-05-28 14:03, Greg Kurz wrote:
>> Removing a drive with drive_del while it is being used to run an I/O
>> intensive workload can cause QEMU to crash.
>>
>> An AIO flush can yield at some point:
>>
>> blk_aio_flush_entry()
>>  blk_co_flush(blk)
>>   bdrv_co_flush(blk->root->bs)
>>    ...
>>     qemu_coroutine_yield()
>>
>> and let the HMP command to run, free blk->root and give control
>> back to the AIO flush:
>>
>>     hmp_drive_del()
>>      blk_remove_bs()
>>       bdrv_root_unref_child(blk->root)
>>        child_bs =3D blk->root->bs
>>        bdrv_detach_child(blk->root)
>>         bdrv_replace_child(blk->root, NULL)
>>          blk->root->bs =3D NULL
>>         g_free(blk->root) <=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =
blk->root becomes stale
>>        bdrv_unref(child_bs)
>>         bdrv_delete(child_bs)
>>          bdrv_close()
>>           bdrv_drained_begin()
>>            bdrv_do_drained_begin()
>>             bdrv_drain_recurse()
>>              aio_poll()
>>               ...
>>               qemu_coroutine_switch()
>>
>> and the AIO flush completion ends up dereferencing blk->root:
>>
>>   blk_aio_complete()
>>    scsi_aio_complete()
>>     blk_get_aio_context(blk)
>>      bs =3D blk_bs(blk)
>>  ie, bs =3D blk->root ? blk->root->bs : NULL
>>             ^^^^^
>>             stale
>>
>> The problem is that we should avoid making block driver graph
>> changes while we have in-flight requests. Let's drain all I/O
>> for this BB before calling bdrv_root_unref_child().
>>
>> Signed-off-by: Greg Kurz <groug@kaod.org>
>> ---
>> v4: - call blk_drain() in blk_remove_bs() (Kevin)
>>
>> v3: - start drained section before modifying the graph (Stefan)
>>
>> v2: - drain I/O requests when detaching the BDS (Stefan, Paolo)
>> ---
>>  block/block-backend.c |    5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/block/block-backend.c b/block/block-backend.c
>> index 89f47b00ea24..bee1f0e41461 100644
>> --- a/block/block-backend.c
>> +++ b/block/block-backend.c
>> @@ -768,6 +768,11 @@ void blk_remove_bs(BlockBackend *blk)
>> =20
>>      blk_update_root_state(blk);
>> =20
>> +    /* bdrv_root_unref_child() will cause blk->root to become stale a=
nd may
>> +     * switch to a completion coroutine later on. Let's drain all I/O=
 here
>> +     * to avoid that and a potential QEMU crash.
>> +     */
>> +    blk_drain(blk);
>>      bdrv_root_unref_child(blk->root);
>>      blk->root =3D NULL;
>>  }
>=20
> For some reason, this patch breaks iotest 083 (with -nbd) on tmpfs for =
me.
>=20
> Only on tmpfs, though, so it's probably not going to be just a simple
> reference output fix.

Scratch that, it seems that it's not just tmpfs but just breakage in
general.  I suppose that's better.

Max


--IhzffELfudcLLWyQfNcsXkSQmfoUE4OwB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlsylPcACgkQ9AfbAGHV
z0BO0Qf/W8gmmMrJvq4iISOPbUlAMO5Op+r4UoCU/bdWv42vKHboJI59p4NoUk1U
knkxAsBICbmgZqSFgUeEZNatuHZ6MNwad41iclTp+SJJDEzpLnNSPuwjD8ngl7P1
t26sj1ilRdXAi6bKucRXkiWSiMglcUXmWCbrLhUGOwsPR8xmTBqt+plD04VAy6Bv
ZAM/2aKSYH3fdfVJDQXjrb89GFpNBMEN9DZWBIvUEr2clrPB/59jM+rLg485l0QP
D4T+hg+SnD9jyk0DdxUo5uBZ8fgrH1s9RJbi164EAO9iUhCJw1TnU0KowT0W0MU6
TiwJgc2l7iK2uji07uvUonKIK7bZRg==
=rzop
-----END PGP SIGNATURE-----

--IhzffELfudcLLWyQfNcsXkSQmfoUE4OwB--
