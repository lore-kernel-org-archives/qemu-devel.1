Received: from eggs.gnu.org ([2001:4830:134:3::10]:40889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1cbBBj-0006Xb-HA
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 14:12:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1cbBBe-0008DP-Jp
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 14:12:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56472)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1cbBBe-0008Cy-En
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 14:12:22 -0500
Date: Wed, 8 Feb 2017 00:42:13 +0530 (IST)
From: P J P <ppandit@redhat.com>
In-Reply-To: <CAFEAcA_GoD3h2tfM7R5mBQPV9V4bCkA5oKL9EYXiaGq2Gbd3DQ@mail.gmail.com>
Message-ID: <alpine.LFD.2.20.1702080036340.11236@wniryva>
References: <20170131122416.10284-1-ppandit@redhat.com>
	<CAFEAcA_GoD3h2tfM7R5mBQPV9V4bCkA5oKL9EYXiaGq2Gbd3DQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH 0/2] sd: sdhci: correct transfer mode
 register usage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Qemu Developers <qemu-devel@nongnu.org>, Wjjzhang <wjjzhang@tencent.com>, Jiang Xin <jiangxin1@huawei.com>, Alistair Francis <alistair.francis@xilinx.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>

+-- On Tue, 7 Feb 2017, Peter Maydell wrote --+
| On 31 January 2017 at 12:24, P J P <ppandit@redhat.com> wrote:
| > In SDHCI emulation, the 'Block Count Enable' bit of the Transfer Mode
| > register is used to control 's->blkcnt' value. One, this bit is not
| > relevant in single block transfers. Second, Transfer Mode register
| > value could be set such that 's->blkcnt' would not see an update
| > during multi block transfers. Thus leading to an infinite loop.
| >
| > This patch set attempts to correct 'Block Count Enable' bit usage.
| 
| Edgar, Alistair: the zynq models are our major SDHCI user -- would
| you like to have a look at this patchset, please?

I suspect following patch would also be required along with the two in this 
series, not sure.

===
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index d921423..7f3d547 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1019,7 +1019,11 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t val, 
unsigned size)
         /* Writing to last byte of sdmasysad might trigger transfer */
         if (!(mask & 0xFF000000) && TRANSFERRING_DATA(s->prnsts) && s->blkcnt 
&&
                 s->blksize && SDHC_DMA_TYPE(s->hostctl) == SDHC_CTRL_SDMA) {
-            sdhci_sdma_transfer_multi_blocks(s);
+            if (!(s->trnmod & SDHC_TRNS_MULTI)) {
+                sdhci_sdma_transfer_single_block(s);
+            } else {
+                sdhci_sdma_transfer_multi_blocks(s);
+            }
         }
         break;
     case SDHC_BLKSIZE:
===

Could you please have a look this one too?

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
