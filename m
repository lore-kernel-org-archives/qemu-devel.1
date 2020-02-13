Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABADEC352A3
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 23:44:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B2DF222C2
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 23:44:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rp+T1fk2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B2DF222C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2O9m-0003ty-H8
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 18:44:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57361)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j2O7I-00086u-CU
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 18:41:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j2O7G-0002tV-UB
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 18:41:56 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:36572)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j2O7G-0002sn-N1
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 18:41:54 -0500
Received: by mail-wm1-x341.google.com with SMTP id p17so8711082wma.1
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 15:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=p+fZQCjb1hbct71LIEEtkNrCEMO2FOGV6oj8x/rd5ec=;
 b=Rp+T1fk2ar45Lox5hxBgRY8s8RJdnbx6qLrZmBqdOuc5+LjY8TgsW/jH1TiHj7NYnS
 4Y4Uu91+wuG0XPi4stINYFz2Vni/1pNEDrRLGEL3kfIjxRCnraewJfxtyTnX863OHKaI
 DEjamTVDKb0Y/SvyAMnIDavSpCdBB+ssFQ34bqYkAizbPlZwNU7XoMVjdOb1PBv4YlkS
 Vho/kqW4du+ps+aopVw7/BV1tHi5Tgifa9zDhfWpmg235/PFaoTNv9S6QLscppnbT0Iu
 kmaDPRBb0V/fuHZtGc2hV+MX0b+DKdUGnS86GA4BNsBVK8PrJ7MJzUxWPHeITsmO94/8
 3c8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=p+fZQCjb1hbct71LIEEtkNrCEMO2FOGV6oj8x/rd5ec=;
 b=uAllIbIjFRCj/xjMuvat9RHYlj5v6YoScXUep9/4WiZpYFlsYI/F5GBMCaBXmC+J3d
 TCOI9KDxQAKqmZ2VNdzir5fVM0//lZ2JNl8RRzqF7wvtSRpyN7rTbUxyexGJZMxAYOuS
 U65pa3FDDHI6K1rAuAcxtWFc7lcGg7tStZhCovTLpiilZ0ZbXpRZ8BgOZ90vTTCEyGMJ
 tLB1KKMCR29tZUDjRkukgwiP32TC6DePsW3gvpYKrPrQ8d+D3Geeg/6PN7TuzSnACOF1
 Onlzj2pT7ozu1OEinNUwr/WYlK1rUvnUQmT1lrkwdYBCd4lQSKRRDOWd0p+rvOpo01Pp
 bBrQ==
X-Gm-Message-State: APjAAAXc2Nw7nEcxU+74vYJ9IaZG9QY3iMBb4AE0P4GaCJXhSPlfc6z/
 CRvSJNy7tARxIMv4QB8TBqo=
X-Google-Smtp-Source: APXvYqw2/k2tOQFJZUxSddH4FUQ3B3yI4+J3AQqu86+jktT183OdndTjUrHLTVknxPzNbVCbLL5GJQ==
X-Received: by 2002:a1c:960c:: with SMTP id y12mr482260wmd.9.1581637313731;
 Thu, 13 Feb 2020 15:41:53 -0800 (PST)
Received: from x1w.redhat.com (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id d4sm1521065wra.14.2020.02.13.15.41.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 15:41:53 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Sven Schnelle <svens@stackframe.org>, qemu-devel@nongnu.org,
 Helge Deller <deller@gmx.de>
Subject: [PATCH 2/4] hw/hppa/dino: Fix reg800_keep_bits[] overrun (CID 1419393
 & 1419394)
Date: Fri, 14 Feb 2020 00:41:46 +0100
Message-Id: <20200213234148.8434-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200213234148.8434-1-f4bug@amsat.org>
References: <20200213234148.8434-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Coverity reports:

  *** CID 1419393:  Memory - corruptions  (OVERRUN)
  /hw/hppa/dino.c: 363 in dino_chip_write_with_attrs()
  357             /* These registers are read-only.  */
  358             break;
  359
  360         case DINO_GMASK ... DINO_TLTIM:
  361             i = (addr - DINO_GMASK) / 4;
  362             val &= reg800_keep_bits[i];
  >>>     CID 1419393:  Memory - corruptions  (OVERRUN)
  >>>     Overrunning array "s->reg800" of 12 4-byte elements at element index 12 (byte offset 48) using index "i" (which evaluates to 12).
  363             s->reg800[i] = val;
  364             break;
  365
  366         default:
  367             /* Controlled by dino_chip_mem_valid above.  */
  368             g_assert_not_reached();

and:

  *** CID 1419394:  Memory - illegal accesses  (OVERRUN)
  /hw/hppa/dino.c: 362 in dino_chip_write_with_attrs()
  356         case DINO_IRR1:
  357             /* These registers are read-only.  */
  358             break;
  359
  360         case DINO_GMASK ... DINO_TLTIM:
  361             i = (addr - DINO_GMASK) / 4;
  >>>     CID 1419394:  Memory - illegal accesses  (OVERRUN)
  >>>     Overrunning array "reg800_keep_bits" of 12 4-byte elements at element index 12 (byte offset 48) using index "i" (which evaluates to 12).
  362             val &= reg800_keep_bits[i];
  363             s->reg800[i] = val;
  364             break;
  365
  366         default:
  367             /* Controlled by dino_chip_mem_valid above.  */

Indeed the array should contain 13 entries, the undocumented
register 0x82c is missing. Fix by increasing the array size
and adding the missing register.

CID 1419393 can be verified with:

  $ echo x 0xfff80830 | hppa-softmmu/qemu-system-hppa -S -monitor stdio -display none
  QEMU 4.2.50 monitor - type 'help' for more information
  (qemu) x 0xfff80830
  qemu/hw/hppa/dino.c:267:15: runtime error: index 12 out of bounds for type 'uint32_t [12]'
  SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior /home/phil/source/qemu/hw/hppa/dino.c:267:15 in
  00000000fff80830: 0x00000000

and CID 1419394 with:

  $ echo writeb 0xfff80830 0x69 \
    | hppa-softmmu/qemu-system-hppa -S -accel qtest -qtest stdio -display none
  [I 1581634452.654113] OPENED
  [R +4.105415] writeb 0xfff80830 0x69
  qemu/hw/hppa/dino.c:362:16: runtime error: index 12 out of bounds for type 'const uint32_t [12]'
  SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior qemu/hw/hppa/dino.c:362:16 in
  =================================================================
  ==29607==ERROR: AddressSanitizer: global-buffer-overflow on address 0x5577dae32f30 at pc 0x5577d93f2463 bp 0x7ffd97ea11b0 sp 0x7ffd97ea11a8
  READ of size 4 at 0x5577dae32f30 thread T0
      #0 0x5577d93f2462 in dino_chip_write_with_attrs qemu/hw/hppa/dino.c:362:16
      #1 0x5577d9025664 in memory_region_write_with_attrs_accessor qemu/memory.c:503:12
      #2 0x5577d9024920 in access_with_adjusted_size qemu/memory.c:539:18
      #3 0x5577d9023608 in memory_region_dispatch_write qemu/memory.c:1482:13
      #4 0x5577d8e3177a in flatview_write_continue qemu/exec.c:3166:23
      #5 0x5577d8e20357 in flatview_write qemu/exec.c:3206:14
      #6 0x5577d8e1fef4 in address_space_write qemu/exec.c:3296:18
      #7 0x5577d8e20693 in address_space_rw qemu/exec.c:3306:16
      #8 0x5577d9011595 in qtest_process_command qemu/qtest.c:432:13
      #9 0x5577d900d19f in qtest_process_inbuf qemu/qtest.c:705:9
      #10 0x5577d900ca22 in qtest_read qemu/qtest.c:717:5
      #11 0x5577da8c4254 in qemu_chr_be_write_impl qemu/chardev/char.c:183:9
      #12 0x5577da8c430c in qemu_chr_be_write qemu/chardev/char.c:195:9
      #13 0x5577da8cf587 in fd_chr_read qemu/chardev/char-fd.c:68:9
      #14 0x5577da9836cd in qio_channel_fd_source_dispatch qemu/io/channel-watch.c:84:12
      #15 0x7faf44509ecc in g_main_context_dispatch (/lib64/libglib-2.0.so.0+0x4fecc)
      #16 0x5577dab75f96 in glib_pollfds_poll qemu/util/main-loop.c:219:9
      #17 0x5577dab74797 in os_host_main_loop_wait qemu/util/main-loop.c:242:5
      #18 0x5577dab7435a in main_loop_wait qemu/util/main-loop.c:518:11
      #19 0x5577d9514eb3 in main_loop qemu/vl.c:1682:9
      #20 0x5577d950699d in main qemu/vl.c:4450:5
      #21 0x7faf41a87f42 in __libc_start_main (/lib64/libc.so.6+0x23f42)
      #22 0x5577d8cd4d4d in _start (qemu/build/sanitizer/hppa-softmmu/qemu-system-hppa+0x1256d4d)

  0x5577dae32f30 is located 0 bytes to the right of global variable 'reg800_keep_bits' defined in 'qemu/hw/hppa/dino.c:87:23' (0x5577dae32f00) of size 48
  SUMMARY: AddressSanitizer: global-buffer-overflow qemu/hw/hppa/dino.c:362:16 in dino_chip_write_with_attrs
  Shadow bytes around the buggy address:
    0x0aaf7b5be590: 00 f9 f9 f9 f9 f9 f9 f9 00 02 f9 f9 f9 f9 f9 f9
    0x0aaf7b5be5a0: 07 f9 f9 f9 f9 f9 f9 f9 07 f9 f9 f9 f9 f9 f9 f9
    0x0aaf7b5be5b0: 07 f9 f9 f9 f9 f9 f9 f9 00 00 00 00 00 00 00 00
    0x0aaf7b5be5c0: 00 00 00 02 f9 f9 f9 f9 00 00 00 00 00 00 00 00
    0x0aaf7b5be5d0: 00 00 00 00 00 00 00 00 00 00 00 03 f9 f9 f9 f9
  =>0x0aaf7b5be5e0: 00 00 00 00 00 00[f9]f9 f9 f9 f9 f9 00 00 00 00
    0x0aaf7b5be5f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
    0x0aaf7b5be600: 00 00 01 f9 f9 f9 f9 f9 00 00 00 00 07 f9 f9 f9
    0x0aaf7b5be610: f9 f9 f9 f9 00 00 00 00 00 00 00 00 00 00 00 00
    0x0aaf7b5be620: 00 00 00 05 f9 f9 f9 f9 00 00 00 00 07 f9 f9 f9
    0x0aaf7b5be630: f9 f9 f9 f9 00 00 f9 f9 f9 f9 f9 f9 07 f9 f9 f9
  Shadow byte legend (one shadow byte represents 8 application bytes):
    Addressable:           00
    Partially addressable: 01 02 03 04 05 06 07
    Heap left redzone:       fa
    Freed heap region:       fd
    Stack left redzone:      f1
    Stack mid redzone:       f2
    Stack right redzone:     f3
    Stack after return:      f5
    Stack use after scope:   f8
    Global redzone:          f9
    Global init order:       f6
    Poisoned by user:        f7
    Container overflow:      fc
    Array cookie:            ac
    Intra object redzone:    bb
    ASan internal:           fe
    Left alloca redzone:     ca
    Right alloca redzone:    cb
    Shadow gap:              cc
  ==29607==ABORTING

Fixes: Covertiy CID 1419393 and 1419394 (commit 18092598a5)
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/hppa/dino.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/hppa/dino.c b/hw/hppa/dino.c
index c237ad3b1b..8868e31793 100644
--- a/hw/hppa/dino.c
+++ b/hw/hppa/dino.c
@@ -83,7 +83,7 @@
 #define DINO_PCI_HOST_BRIDGE(obj) \
     OBJECT_CHECK(DinoState, (obj), TYPE_DINO_PCI_HOST_BRIDGE)
 
-#define DINO800_REGS ((DINO_TLTIM - DINO_GMASK) / 4)
+#define DINO800_REGS (1 + (DINO_TLTIM - DINO_GMASK) / 4)
 static const uint32_t reg800_keep_bits[DINO800_REGS] = {
     MAKE_64BIT_MASK(0, 1),  /* GMASK */
     MAKE_64BIT_MASK(0, 7),  /* PAMR */
@@ -96,6 +96,7 @@ static const uint32_t reg800_keep_bits[DINO800_REGS] = {
     MAKE_64BIT_MASK(0, 30), /* BRDG_FEAT */
     MAKE_64BIT_MASK(0, 25), /* PCIROR */
     MAKE_64BIT_MASK(0, 22), /* PCIWOR */
+    MAKE_64BIT_MASK(0, 32), /* Undocumented */
     MAKE_64BIT_MASK(0, 9),  /* TLTIM */
 };
 
-- 
2.21.1


