Received: from eggs.gnu.org ([2001:4830:134:3::10]:46807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eCT7F-00087i-Ao
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 11:22:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eCT79-0000xC-MB
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 11:22:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55780)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eCT79-0000wg-Fz
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 11:22:07 -0500
Date: Wed, 8 Nov 2017 17:22:05 +0100
From: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <20171108162205.GD13150@boraha>
References: <1510016336-4086-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1510016336-4086-3-git-send-email-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1510016336-4086-3-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/5] tpm: pull tpm_util_send() out of
 tpm_util_test()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, amarnath.valluri@intel.com

Hi Stefan,

On Mon, Nov 06, 2017 at 07:58:53PM -0500, Stefan Berger wrote:
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> ---
>  hw/tpm/tpm_util.c | 33 ++++++++++++++++++++++++++-------
>  1 file changed, 26 insertions(+), 7 deletions(-)
>=20
> diff --git a/hw/tpm/tpm_util.c b/hw/tpm/tpm_util.c
> index daf1faa..396e793 100644
> --- a/hw/tpm/tpm_util.c
> +++ b/hw/tpm/tpm_util.c
> @@ -53,10 +53,11 @@ bool tpm_util_is_selftest(const uint8_t *in, uint32=
_t in_len)
>   * A basic test of a TPM device. We expect a well formatted response h=
eader
>   * (error response is fine) within one second.
>   */
> -static int tpm_util_test(int fd,
> -                         unsigned char *request,
> -                         size_t requestlen,
> -                         uint16_t *return_tag)
> +static int tpm_util_tx(int fd,

The function is not just tx, but write & read. Call it
tpm_util_request() instead?

> +                       unsigned char *request,
> +                       size_t requestlen,
> +                       unsigned char *response,
> +                       size_t responselen)
>  {
>      struct tpm_resp_hdr *resp;
>      fd_set readfds;
> @@ -65,7 +66,6 @@ static int tpm_util_test(int fd,
>          .tv_sec =3D 1,
>          .tv_usec =3D 0,
>      };
> -    unsigned char buf[1024];
> =20
>      n =3D write(fd, request, requestlen);
>      if (n < 0) {
> @@ -84,17 +84,36 @@ static int tpm_util_test(int fd,
>          return -errno;
>      }
> =20
> -    n =3D read(fd, &buf, sizeof(buf));
> +    n =3D read(fd, response, responselen);
>      if (n < sizeof(struct tpm_resp_hdr)) {
>          return -EFAULT;
>      }
> =20
> -    resp =3D (struct tpm_resp_hdr *)buf;
> +    resp =3D (struct tpm_resp_hdr *)response;
>      /* check the header */
>      if (be32_to_cpu(resp->len) !=3D n) {
>          return -EMSGSIZE;
>      }
> =20
> +    return 0;
> +}
> +
> +static int tpm_util_test(int fd,
> +                         unsigned char *request,
> +                         size_t requestlen,
> +                         uint16_t *return_tag)
> +{
> +    struct tpm_resp_hdr *resp;
> +    unsigned char buf[1024];
> +    ssize_t ret;
> +
> +    ret =3D tpm_util_tx(fd, request, requestlen,
> +                      buf, sizeof(buf));
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
> +    resp =3D (struct tpm_resp_hdr *)buf;
>      *return_tag =3D be16_to_cpu(resp->tag);
> =20
>      return 0;
> --=20
> 2.5.5
>=20
>=20

Looks fine otherwise,

Reviewed-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
