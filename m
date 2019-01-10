Received: from eggs.gnu.org ([209.51.188.92]:44494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ghRJD-0004xf-FF
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 22:47:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ghR74-00040N-5C
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 22:34:35 -0500
References: <20190109041452.31240-1-eblake@redhat.com>
	<20190109041452.31240-3-eblake@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <dc8ff7c1-9893-7f90-c06c-9b969485aae2@redhat.com>
Date: Wed, 9 Jan 2019 21:34:16 -0600
MIME-Version: 1.0
In-Reply-To: <20190109041452.31240-3-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="vpCaj2p0FzeXZCGh7HEGyzVuYjttnIxJ7"
Subject: Re: [Qemu-devel] [PATCH 2/5] nbd: Allow bitmap export during QMP
 nbd-server-add
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com, qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>, jsnow@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vpCaj2p0FzeXZCGh7HEGyzVuYjttnIxJ7
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz
 <mreitz@redhat.com>, jsnow@redhat.com
Message-ID: <dc8ff7c1-9893-7f90-c06c-9b969485aae2@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/5] nbd: Allow bitmap export during QMP
 nbd-server-add
References: <20190109041452.31240-1-eblake@redhat.com>
 <20190109041452.31240-3-eblake@redhat.com>
In-Reply-To: <20190109041452.31240-3-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/8/19 10:14 PM, Eric Blake wrote:
> With the experimental x-nbd-server-add-bitmap command, there was
> a window of time where a client could see the export but not the
> associated dirty bitmap, which can cause a client that planned
> on using the dirty bitmap to be forced to treat the entire image
> as dirty as a safety fallback.  Furthermore, if the QMP client
> successfully exports a disk but then fails to add the bitmap, it
> has to take on the burden of removing the export.  Since we don't
> allow changing a dirty bitmap once it is exported (whether to a
> different bitmap, or removing advertisement of the bitmap), it is
> nicer to make the bitmap tied to the export at the time the export
> is created, and automatically failing to export if the bitmap is
> not available.
>=20
> Since there is working libvirt demo code that uses both the bitmap
> export and the ability to specify an alternative name (rather than
> exposing the private-use bitmap that libvirt created to merge in
> several persistent bitmaps when doing a differential backup), the
> two new parameters do not need to be marked experimental.  See
> https://www.redhat.com/archives/libvir-list/2018-October/msg01254.html,=

> https://kvmforum2018.sched.com/event/FzuB/facilitating-incremental-back=
up-eric-blake-red-hat

=2E..

> +#
> +# @bitmap-export-name: How the bitmap will be seen by nbd clients
> +#                      (default @bitmap). The NBD client must use
> +#                      NBD_OPT_SET_META_CONTEXT with "qemu:dirty-bitma=
p:NAME"
> +#                      to access the exposed bitmap. (since 4.0)
>  #

Actually, on re-reading my libvirt code, it turns out that I had
differential backups working without the use of bitmap-export-name,
because I always created a temporary bitmap (with the name I planned to
expose, namely "vda" if the bitmap belonged to the device that libvirt
calls "vda") and merged in the persistent bitmaps into the temporary
bitmap.  Of course, right now we only support one backup NBD job at a
time (because we don't support parallel NBD servers), but thinking ahead
to when we may support that, it becomes obvious that libvirt can't pick
the same name for two separate temporary bitmaps being used by two
parallel backup jobs.  On the other hand, Nir requested that libvirt
backup job XMLs support some sort of name or UUID, and it is just as
easy to ensure that the temporary bitmap is given the name of the backup
job (which will be unique) rather than the name of the device being
backed up.

And my proposed patches for 'qemu-nbd --list' make it easy to
definitively query what names are actually being exported.

So at this point, I'm leaning towards NOT exposing a way to remap the
exported bitmap name.  We can always add it later if it proves useful,
but I'd rather not be burdened with being stuck with it since libvirt
hasn't used it so far.  I'll spin v2 of this series along those lines.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--vpCaj2p0FzeXZCGh7HEGyzVuYjttnIxJ7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEY3OaSlgimHGqKqRv3g5py3orov0FAlw2vTgACgkQ3g5py3or
ov2T1gf9EzmCyjNR/lunBHdxTO/e3rHYA+hSlVtnfQCLUHK5LlKiDhofjtcrjE2e
OFo+gzbpcZG+6gAyWcXXfqOZgZnrcSnyTqVHzwV8G5fIUSb48g5ODyrpzeyUFh2t
ZschqfTywtoLDO6r6/IGDYdcFzvviRWoR4aw5blVD4yVkasBD6q3ucBdmHmjztCc
elloIWM31xFVDaLlxedLU/AQbhjozqf+0FaNHf8GPXufMMCW3ht2GBi9Y9Qtv/Xc
asvS8uVblWpU8CowAii6fmnqafDaAGCfhqxjdcB/OJomS8IAH51TfWjavlSg98E+
vCrKfMvjo1gXPUE0Y7YZeAIg436zWA==
=kTtN
-----END PGP SIGNATURE-----

--vpCaj2p0FzeXZCGh7HEGyzVuYjttnIxJ7--
