Received: from eggs.gnu.org ([209.51.188.92]:48056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gpjHb-0007PM-6i
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 19:35:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gpjHR-00023K-8D
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 19:35:37 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:42693)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gpjHJ-0001xh-JK
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 19:35:27 -0500
Date: Fri, 1 Feb 2019 19:35:19 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20190202003519.GA29706@flamenco>
References: <20181106112829.1948-1-kraxel@redhat.com>
	<20181106112829.1948-2-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181106112829.1948-2-kraxel@redhat.com>
Subject: Re: [Qemu-devel] [PULL 1/1] update seabios to master snapshot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org

Hi Gerd,

On Tue, Nov 06, 2018 at 12:28:29 +0100, Gerd Hoffmann wrote:
> seabios 1.12 release is planned for november.
> 
> update seabios to a master branch snapshot so it gets more testing
> and to make the delta smaller when updating to -final during freeze.

I just bisected a performance regression for TCG-based x86 emulation
to this commit.

The issue is that after this patch, tlb_flush() gets called *way*
more often -- e.g. ~90,000 instead of ~400 times in the first second
or so when booting.

Steps to reproduce:

1. Add this debug print:

--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -183,6 +183,12 @@ void tlb_flush_by_mmuidx(CPUState *cpu, uint16_td)

 void tlb_flush(CPUState *cpu)
 {
+    static int count;
+
+    count++;
+    if (!(count % 100)) {
+        printf("%s: %d\n", __func__, count);
+    }
     tlb_flush_by_mmuidx(cpu, ALL_MMUIDX_BITS);
 }

2. build QEMU

3. invoke with:
  $ x86_64-softmmu/qemu-system-x86_64 -nographic

You should then see many "tlb_flush: N" lines, with N
reaching ~90,000 before the SeaBIOS banner comes out.

Note that before this patch, you should only see N == ~400
before reaching the banner.

How can I bisect seabios? I can't find a recipe to generate
the .bin files included in this commit.

Thanks,

		Emilio
