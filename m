Received: from eggs.gnu.org ([2001:4830:134:3::10]:47060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIFqe-00059F-GY
	for qemu-devel@nongnu.org; Mon, 14 May 2018 11:57:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIFqd-0006hJ-Mk
	for qemu-devel@nongnu.org; Mon, 14 May 2018 11:57:16 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:42326)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fIFqd-0006h3-IR
	for qemu-devel@nongnu.org; Mon, 14 May 2018 11:57:15 -0400
Received: by mail-oi0-x244.google.com with SMTP id t27-v6so11139773oij.9
	for <qemu-devel@nongnu.org>; Mon, 14 May 2018 08:57:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CACKT+Ap2MHCrSCT-0_=KG9UrGAtO7F3EGue6-63-XJxry9=C=w@mail.gmail.com>
References: <CACKT+Ap2MHCrSCT-0_=KG9UrGAtO7F3EGue6-63-XJxry9=C=w@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 May 2018 16:56:54 +0100
Message-ID: <CAFEAcA-nnU2E6CKPiGqoAq1sSYtvf4Hxp3MtYiCvigr4i8-+Ow@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] handle all fdt_get_phandle_errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jonathan Marler <johnnymarler@gmail.com>
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alexander Graf <agraf@suse.de>, QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>

On 4 May 2018 at 19:37, Jonathan Marler <johnnymarler@gmail.com> wrote:
> Signed-off-by: Jonathan Marler <johnnymarler@gmail.com>

Hi; thanks for this patch.

> ---
>  device_tree.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/device_tree.c b/device_tree.c
> index 52c3358..2b75905 100644
> --- a/device_tree.c
> +++ b/device_tree.c
> @@ -379,8 +379,12 @@ uint32_t qemu_fdt_get_phandle(void *fdt, const char
> *path)
>
>      r = fdt_get_phandle(fdt, findnode_nofail(fdt, path));
>      if (r == 0) {
> -        error_report("%s: Couldn't get phandle for %s: %s", __func__,
> -                     path, fdt_strerror(r));
> +        error_report("%s: Node %s does not have a 'phandle'", __func__,
> +                     path);
> +        exit(1);
> +    }
> +    if (r == -1) {
> +        error_report("%s: Couldn't get phandle for %s", __func__, path);
>          exit(1);
>      }

Could you explain in what situation this is needed? The documentation
for fdt_get_phandle() says
 * returns:
 *      the phandle of the node at nodeoffset, on success (!= 0, != -1)
 *      0, if the node has no phandle, or another error occurs

which I interpret to mean that it is not possible for it to return -1.

thanks
-- PMM
