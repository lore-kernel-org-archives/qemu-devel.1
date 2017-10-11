Received: from eggs.gnu.org ([2001:4830:134:3::10]:58610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e2IVn-0004m1-I9
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 11:01:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e2IVi-0003Dr-2X
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 11:01:31 -0400
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:46646)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e2IVh-0003DL-SG
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 11:01:25 -0400
Received: by mail-wm0-x233.google.com with SMTP id m72so5609171wmc.1
	for <qemu-devel@nongnu.org>; Wed, 11 Oct 2017 08:01:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1507732945-23555-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1507732945-23555-1-git-send-email-stefanb@linux.vnet.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 11 Oct 2017 16:01:03 +0100
Message-ID: <CAFEAcA-TRT0TbkfVF7TFdGJQRWSdTaTgmyhvebfix+SSsP+a+A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2] tpm: Use EMSGSIZE instead of EBADMSG to
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, amarnath.valluri@intel.com, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>

On 11 October 2017 at 15:42, Stefan Berger <stefanb@linux.vnet.ibm.com> wrote:
> EBADMSG was only added to OpenBSD very recently. To make QEMU compilable
> on older OpenBSD versions use EMSGSIZE instead when a mismatch between
> number of received bytes and message size indicated in the header was
> found.
>
> Return -EMSGSIZE and convert all other errnos in the same functions to
> return the negative errno.
>
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> ---
>  hw/tpm/tpm_util.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/hw/tpm/tpm_util.c b/hw/tpm/tpm_util.c
> index fb929f6..a83c6f4 100644
> --- a/hw/tpm/tpm_util.c
> +++ b/hw/tpm/tpm_util.c
> @@ -71,7 +71,7 @@ static int tpm_util_test(int fd,
>          return errno;
>      }
>      if (n != requestlen) {
> -        return EFAULT;
> +        return -EFAULT;
>      }
>
>      FD_ZERO(&readfds);
> @@ -85,13 +85,13 @@ static int tpm_util_test(int fd,
>
>      n = read(fd, &buf, sizeof(buf));
>      if (n < sizeof(struct tpm_resp_hdr)) {
> -        return EFAULT;
> +        return -EFAULT;
>      }
>
>      resp = (struct tpm_resp_hdr *)buf;
>      /* check the header */
>      if (be32_to_cpu(resp->len) != n) {
> -        return EBADMSG;
> +        return -EMSGSIZE;
>      }
>
>      *return_tag = be16_to_cpu(resp->tag);

You also need to change the "return errno;" lines. "errno"
contains positive errno values, so for a "return 0-or-negative-errno"
convention you want "return -errno;".

thanks
-- PMM
