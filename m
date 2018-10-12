Received: from eggs.gnu.org ([2001:4830:134:3::10]:57961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gAynI-0006qS-Rr
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 10:52:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gAynE-0001IZ-Nt
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 10:52:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50428)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1gAynE-0001Hz-F2
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 10:51:56 -0400
References: <1535739372-24454-1-git-send-email-Liam.Merwick@oracle.com>
	<1535739372-24454-5-git-send-email-Liam.Merwick@oracle.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <1d34f37c-94cb-61af-58a6-dae10ddc2ce5@redhat.com>
Date: Fri, 12 Oct 2018 16:51:53 +0200
MIME-Version: 1.0
In-Reply-To: <1535739372-24454-5-git-send-email-Liam.Merwick@oracle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="vR1nh9PV8HiiPr30uQ7uh7NyvKnQaKk9f"
Subject: Re: [Qemu-devel] [PATCH v3 4/8] qemu-img: potential Null pointer
 deref in img_commit()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Liam Merwick <Liam.Merwick@oracle.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vR1nh9PV8HiiPr30uQ7uh7NyvKnQaKk9f
From: Max Reitz <mreitz@redhat.com>
To: Liam Merwick <Liam.Merwick@oracle.com>, qemu-devel@nongnu.org
Message-ID: <1d34f37c-94cb-61af-58a6-dae10ddc2ce5@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 4/8] qemu-img: potential Null pointer
 deref in img_commit()
References: <1535739372-24454-1-git-send-email-Liam.Merwick@oracle.com>
 <1535739372-24454-5-git-send-email-Liam.Merwick@oracle.com>
In-Reply-To: <1535739372-24454-5-git-send-email-Liam.Merwick@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 31.08.18 20:16, Liam Merwick wrote:
> The function block_job_get() may return NULL so before dereferencing
> the 'job' pointer in img_commit() it should be checked.

It may not because the job yields before executing anything (if it
started successfully; but otherwise, commit_active_start() would have
returned an error).  Therefore, I think the better solution is to
assert(job) here.

(It would be a serious bug if block_job_get() returned NULL here, so
it's definitely not something we can be quiet about.  But this patch
makes it so the user doesn't even notice.)

Max

> Signed-off-by: Liam Merwick <Liam.Merwick@oracle.com>
> Reviewed-by: Darren Kenny <Darren.Kenny@oracle.com>
> Reviewed-by: Mark Kanda <Mark.Kanda@oracle.com>
> ---
>  qemu-img.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/qemu-img.c b/qemu-img.c
> index b12f4cd19b0a..51fe09bd08ed 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -1029,6 +1029,9 @@ static int img_commit(int argc, char **argv)
>      }
> =20
>      job =3D block_job_get("commit");
> +    if (job =3D=3D NULL) {
> +        goto unref_backing;
> +    }
>      run_block_job(job, &local_err);
>      if (local_err) {
>          goto unref_backing;
>=20



--vR1nh9PV8HiiPr30uQ7uh7NyvKnQaKk9f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlvAtQkACgkQ9AfbAGHV
z0Dkggf8DxgnBNFUzjXv+Bb/K7YEJFsH7FyxToLpgtOdOxr9QbCl6EkYVg8uElXw
fHTMPpdViJT8SpL5GAQI55sz6wnlI6E6NFLtzxE40aoPYtQ2sz1JbRo8IUutCJ2F
5f1JvOxahuQ+uEthfGBsZIljF4nfSP79HuFPxT5/fLzT2oge+lFsd6kLVwh2qzep
+FW8BayPhb+uT5eNOPDc0CBQl+iZHs8jHkz0IENuqth8v2/8W/b8uJBoxsdq3wW4
PlIDfjCgXNvk9Iv4noqj3/gNIXlHVF7B7URlM/RsrAUk5QyktUrutvWoc20ill30
4qEuvbiQO3LGSpFAh1J8NxXkFyUTJg==
=7s+f
-----END PGP SIGNATURE-----

--vR1nh9PV8HiiPr30uQ7uh7NyvKnQaKk9f--
