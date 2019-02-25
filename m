Received: from eggs.gnu.org ([209.51.188.92]:34114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gyFjw-0001A4-Ld
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 07:52:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gyFjv-00072J-RH
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 07:52:12 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:34679)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gyFjv-0006xx-JA
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 07:52:11 -0500
Received: by mail-ot1-x343.google.com with SMTP id 98so7729488oty.1
	for <qemu-devel@nongnu.org>; Mon, 25 Feb 2019 04:52:09 -0800 (PST)
MIME-Version: 1.0
References: <1551095970-14645-1-git-send-email-thuth@redhat.com>
In-Reply-To: <1551095970-14645-1-git-send-email-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 25 Feb 2019 12:51:57 +0000
Message-ID: <CAFEAcA-YP_S36ZtmC-1LtuJN95Y5J1h5wmRgxLZFKwDrEmuvtA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] block/nvme: Remove QEMU_PACKED from
 naturally aligned NVMeRegs struct
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Fam Zheng <fam@euphon.net>, Qemu-block <qemu-block@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>

On Mon, 25 Feb 2019 at 11:59, Thomas Huth <thuth@redhat.com> wrote:
>
> The QEMU_PACKED is causing a compiler warning/error with GCC 9:
>
>   CC      block/nvme.o
> block/nvme.c: In function =E2=80=98nvme_create_queue_pair=E2=80=99:
> block/nvme.c:209:22: error: taking address of packed member of
>  =E2=80=98struct <anonymous>=E2=80=99 may result in an unaligned pointer =
value
>  [-Werror=3Daddress-of-packed-member]
>   209 |     q->sq.doorbell =3D &s->regs->doorbells[idx * 2 * s->doorbell_=
scale];
>
> All members of the struct are naturally aligned, so there should
> not be the need for QEMU_PACKED here, and the following QEMU_BUILD_BUG_ON
> also ensures that there is no padding. Thus simply remove the QEMU_PACKED
> here.
>
> Buglink: https://bugs.launchpad.net/qemu/+bug/1817525
> Reported-by: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  block/nvme.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/block/nvme.c b/block/nvme.c
> index b5952c9..6c2ce7d 100644
> --- a/block/nvme.c
> +++ b/block/nvme.c
> @@ -82,7 +82,7 @@ typedef volatile struct {
>      uint8_t  reserved1[0xec0];
>      uint8_t  cmd_set_specfic[0x100];
>      uint32_t doorbells[];
> -} QEMU_PACKED NVMeRegs;
> +} NVMeRegs;
>
>  QEMU_BUILD_BUG_ON(offsetof(NVMeRegs, doorbells) !=3D 0x1000);
>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
