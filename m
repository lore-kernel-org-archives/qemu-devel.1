Received: from eggs.gnu.org ([2001:4830:134:3::10]:43064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1e2xvK-0001PI-IE
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 07:14:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1e2xvJ-0001ea-ON
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 07:14:38 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:36050)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1e2xvJ-0001eH-Iq
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 07:14:37 -0400
Received: by mail-oi0-x242.google.com with SMTP id s185so3628301oif.3
	for <qemu-devel@nongnu.org>; Fri, 13 Oct 2017 04:14:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1507751249-3035-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1507751249-3035-1-git-send-email-stefanb@linux.vnet.ibm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 13 Oct 2017 13:14:35 +0200
Message-ID: <CAJ+F1CK7MW5kY5eaiHGyk7hvxKyOBNJi7MHo9warfXbSp4LzPA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] tpm: Use EMSGSIZE instead of EBADMSG to
 compile on OpenBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: QEMU <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Amarnath Valluri <amarnath.valluri@intel.com>

Hi

On Wed, Oct 11, 2017 at 9:47 PM, Stefan Berger
<stefanb@linux.vnet.ibm.com> wrote:
> EBADMSG was only added to OpenBSD very recently. To make QEMU compilable
> on older OpenBSD versions use EMSGSIZE instead when a mismatch between
> number of received bytes and message size indicated in the header was
> found.
>
> Return -EMSGSIZE and convert all other errnos in the same functions to
> return the negative errno.
>
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


Looks good to me,
but given that the return value isn't used, perhaps you could have
changed the function to return a bool success instead?


> ---
>  hw/tpm/tpm_util.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/hw/tpm/tpm_util.c b/hw/tpm/tpm_util.c
> index fb929f6..73d7796 100644
> --- a/hw/tpm/tpm_util.c
> +++ b/hw/tpm/tpm_util.c
> @@ -68,10 +68,10 @@ static int tpm_util_test(int fd,
>
>      n =3D write(fd, request, requestlen);
>      if (n < 0) {
> -        return errno;
> +        return -errno;
>      }
>      if (n !=3D requestlen) {
> -        return EFAULT;
> +        return -EFAULT;
>      }
>
>      FD_ZERO(&readfds);
> @@ -80,18 +80,18 @@ static int tpm_util_test(int fd,
>      /* wait for a second */
>      n =3D select(fd + 1, &readfds, NULL, NULL, &tv);
>      if (n !=3D 1) {
> -        return errno;
> +        return -errno;
>      }
>
>      n =3D read(fd, &buf, sizeof(buf));
>      if (n < sizeof(struct tpm_resp_hdr)) {
> -        return EFAULT;
> +        return -EFAULT;
>      }
>
>      resp =3D (struct tpm_resp_hdr *)buf;
>      /* check the header */
>      if (be32_to_cpu(resp->len) !=3D n) {
> -        return EBADMSG;
> +        return -EMSGSIZE;
>      }
>
>      *return_tag =3D be16_to_cpu(resp->tag);
> --
> 2.5.5
>



--=20
Marc-Andr=C3=A9 Lureau
