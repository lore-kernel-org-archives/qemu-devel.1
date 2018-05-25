Received: from eggs.gnu.org ([2001:4830:134:3::10]:37844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fMDE4-00045r-Pv
	for qemu-devel@nongnu.org; Fri, 25 May 2018 09:57:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fMDE3-00068C-QJ
	for qemu-devel@nongnu.org; Fri, 25 May 2018 09:57:48 -0400
Received: from mail-oi0-x229.google.com ([2607:f8b0:4003:c06::229]:42518)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fMDE3-00067y-Lf
	for qemu-devel@nongnu.org; Fri, 25 May 2018 09:57:47 -0400
Received: by mail-oi0-x229.google.com with SMTP id t27-v6so4643746oij.9
	for <qemu-devel@nongnu.org>; Fri, 25 May 2018 06:57:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180518172009.14416-5-peter.maydell@linaro.org>
References: <20180518172009.14416-1-peter.maydell@linaro.org>
	<20180518172009.14416-5-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 25 May 2018 14:57:26 +0100
Message-ID: <CAFEAcA_sVbb1v3JXqJGKAaOi9mapAkm8kmBMmwk_fCHb-D1-Jg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 04/32] xlnx-zdma: Add a model of the Xilinx
 ZynqMP generic DMA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

On 18 May 2018 at 18:19, Peter Maydell <peter.maydell@linaro.org> wrote:
> From: Francisco Iglesias <frasse.iglesias@gmail.com>
>
> Add a model of the generic DMA found on Xilinx ZynqMP.

> +static bool zdma_load_descriptor(XlnxZDMA *s, uint64_t addr, void *buf)
> +{
> +    /* ZDMA descriptors must be aligned to their own size.  */
> +    if (addr % sizeof(XlnxZDMADescr)) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "zdma: unaligned descriptor at %" PRIx64,
> +                      addr);
> +        memset(buf, 0xdeadbeef, sizeof(XlnxZDMADescr));

Another Coverity issue (CID 1391286). memset() doesn't work like this:
its second argument is a byte, so passing anything larger than 255
doesn't make sense.

+        s->error = true;
+        return false;
+    }

thanks
-- PMM
