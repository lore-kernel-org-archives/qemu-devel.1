Received: from eggs.gnu.org ([209.51.188.92]:39690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hMJdB-0002pk-OJ
	for qemu-devel@nongnu.org; Thu, 02 May 2019 17:52:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hMJdA-00028r-NG
	for qemu-devel@nongnu.org; Thu, 02 May 2019 17:52:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55410)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1hMJdA-00028X-En
	for qemu-devel@nongnu.org; Thu, 02 May 2019 17:52:40 -0400
References: <tencent_9962D5F9426BA267581CCB79DB1FE17AD508@qq.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d23b59fa-2909-f124-3aab-cc5ded90f063@redhat.com>
Date: Thu, 2 May 2019 16:52:37 -0500
MIME-Version: 1.0
In-Reply-To: <tencent_9962D5F9426BA267581CCB79DB1FE17AD508@qq.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Q408gS0RnRblfdc4E9BjHNYJ8W6F8pMxq"
Subject: Re: [Qemu-devel] [PATCH v2 2/4] qga: Fix an enum conversion
 warningin commands-win32.c, hit by clang.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: driver1998 <driver1998@foxmail.com>, qemu-devel <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Q408gS0RnRblfdc4E9BjHNYJ8W6F8pMxq
From: Eric Blake <eblake@redhat.com>
To: driver1998 <driver1998@foxmail.com>, qemu-devel <qemu-devel@nongnu.org>
Message-ID: <d23b59fa-2909-f124-3aab-cc5ded90f063@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/4] qga: Fix an enum conversion warningin
 commands-win32.c, hit by clang.
References: <tencent_9962D5F9426BA267581CCB79DB1FE17AD508@qq.com>
In-Reply-To: <tencent_9962D5F9426BA267581CCB79DB1FE17AD508@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 5/2/19 4:18 PM, driver1998 wrote:
> On 5/1/19 2:25 AM, Eric Blake wrote:
>> This adds lots of explicit casts. Are they actually necessary? Without=

>> seeing the actual warning, it seems fishy to have to be this explicit.=

>=20
> So here are the warnings, on clang version 9.0.0 (trunk 351977).
>=20
> qga/commands-win32.c:461:24: error: implicit conversion from enumeratio=
n type 'enum GuestDiskBusType' to different
>       enumeration type 'STORAGE_BUS_TYPE' (aka 'enum _STORAGE_BUS_TYPE'=
) [-Werror,-Wenum-conversion]
>     [BusTypeUnknown] =3D GUEST_DISK_BUS_TYPE_UNKNOWN,
>                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~

> qga/commands-win32.c:486:12: error: implicit conversion from enumeratio=
n type 'STORAGE_BUS_TYPE'
>       (aka 'enum _STORAGE_BUS_TYPE') to different enumeration type 'Gue=
stDiskBusType' (aka 'enum GuestDiskBusType')
>       [-Werror,-Wenum-conversion]
>     return win2qemu[(int)bus];
>     ~~~~~~ ^~~~~~~~~~~~~~~~~~

Where is enum STORAGE_BUS_TYPE defined? I see GuestDiskBusType (via
qga/qapi-schema.json's 'enum':'GuestDiskBusType'), but if
STORAGE_BUS_TYPE is a type declared by some external project, we are
probably better off writing a two-way conversion table or switch
statement, rather than relying on the two enums currently happening to
have identical values (but where that might break if we accidentally
rearrange our .json QAPI file or if the external file changes their
enum).  In fact, it looks like win2qemu[] is supposed to be that table,
but it was incorrectly written.  You WANT to do:

diff --git i/qga/commands-win32.c w/qga/commands-win32.c
index d40d61f605c..6b67f16faf1 100644
--- i/qga/commands-win32.c
+++ w/qga/commands-win32.c
@@ -457,7 +457,7 @@ void qmp_guest_file_flush(int64_t handle, Error **err=
p)

 #ifdef CONFIG_QGA_NTDDSCSI

-static STORAGE_BUS_TYPE win2qemu[] =3D {
+static GuestDiskBusType win2qemu[] =3D {
     [BusTypeUnknown] =3D GUEST_DISK_BUS_TYPE_UNKNOWN,
     [BusTypeScsi] =3D GUEST_DISK_BUS_TYPE_SCSI,
     [BusTypeAtapi] =3D GUEST_DISK_BUS_TYPE_IDE,

with no casts needed, either in the table or in the function that
references the table.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--Q408gS0RnRblfdc4E9BjHNYJ8W6F8pMxq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlzLZqUACgkQp6FrSiUn
Q2r8+QgAgIfrpzuIMPxr4fUBmtMhGDGm7SLvTTXn6UpK57wFa/mPcRp+HVYH5epJ
0TQOCWopMshCsXNbH8FvBnSnF4Q4rQlKEzGNxoVlJSXQF6rFHXl+g1WLjjO64+Vp
E4Ld9/ay6ui9r9q3kk+Fmo1/waTwtkpZSVUHf7a2aVsItDww/gL9r2jvTxNNy5Z/
8M6s3fvUcgAuIbELWghbw1cKimNEmeSYdu6tvMZ33aUGGtKCdab7uFuqEDZUB2Dp
Z0R/KjDA6lMkWb93LXWU3i5fEU1HXQnrexSlJZ2hP1FYv+/km/9AiDd0RvVsLVvH
oZFpvFQPZZ+1OKj3SVsKd6yXazfLdw==
=e+Oi
-----END PGP SIGNATURE-----

--Q408gS0RnRblfdc4E9BjHNYJ8W6F8pMxq--
