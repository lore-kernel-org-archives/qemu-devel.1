Received: from eggs.gnu.org ([2001:4830:134:3::10]:36198)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cqPGA-0004EP-JG
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 15:15:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cqPG9-0003Bk-Fg
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 15:15:58 -0400
References: <1490118490-5597-1-git-send-email-pbonzini@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6df766d1-66ed-1717-fb96-fe096c68c065@redhat.com>
Date: Tue, 21 Mar 2017 14:15:43 -0500
MIME-Version: 1.0
In-Reply-To: <1490118490-5597-1-git-send-email-pbonzini@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="k9PAVtvaExtR6swuPqSjVQUKKrLI5Mi1m"
Subject: Re: [Qemu-devel] [PATCH for-2.9] blockjob: avoid recursive
 AioContext locking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: jsnow@redhat.com, famz@redhat.com, stefanha@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--k9PAVtvaExtR6swuPqSjVQUKKrLI5Mi1m
From: Eric Blake <eblake@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: jsnow@redhat.com, famz@redhat.com, stefanha@redhat.com,
 qemu-block@nongnu.org
Message-ID: <6df766d1-66ed-1717-fb96-fe096c68c065@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9] blockjob: avoid recursive AioContext
 locking
References: <1490118490-5597-1-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1490118490-5597-1-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/21/2017 12:48 PM, Paolo Bonzini wrote:
> Streaming or any other block job hangs when performed on a block device=

> that has a non-default iothread.  This happens because the AioContext
> is acquired twice by block_job_defer_to_main_loop_bh and then released
> only once by BDRV_POLL_WHILE.  (Insert rants on recursive mutexes, whic=
h
>=20
> unfortunately are a temporary but necessary evil for iothreads at the

Why the blank line?

> moment).
>=20
> Luckily, the reason for the double acquisition is simple; the function
> acquires the AioContext for both the job iothread and the BDS iothread,=

> in case the BDS iothread was changed while the job was running.  It
> is therefore enough to skip the second acquisition when the two
> AioContexts are one and the same.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  blockjob.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>=20

Makes sense from the description.
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--k9PAVtvaExtR6swuPqSjVQUKKrLI5Mi1m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY0XvfAAoJEKeha0olJ0NqFJUH/22FUmkWlcQMgVo4fsF4zqo5
L+usnVKyCQJEVikuv2lYfxTyXNq724CpcVtkzJRSyoQS6GO+oJ/4N+tUKcvIqnRH
KjseQW92fYYrnFaiO+TGzByLJpWs8O83d9bKlMkPBjdyt43gebH6m6M0i9LxOIE3
kK27ABv61H6STQiuwGIZZ3Q8088ePXFQnWsujpNZlVeiosa3XMJicmSM2rYFzbje
l304dwd9pBZYM9DF4FUN0iM5b7bK/IFuI3MdUTlvGgPyugpkwN43Yt5PE3ahS5gJ
EflvceJcsyu5OBhHYXIfLI/f5cMd0huV9iHaAAWotqGc0O0tLNIurVneQaR9A6I=
=A07R
-----END PGP SIGNATURE-----

--k9PAVtvaExtR6swuPqSjVQUKKrLI5Mi1m--
