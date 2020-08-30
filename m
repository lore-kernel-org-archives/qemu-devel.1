Return-Path: <SRS0=e36u=CI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A3DDC433E2
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 06:19:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEE6720757
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 06:19:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H+dq0xAe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEE6720757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCGh1-00072k-2A
	for qemu-devel@archiver.kernel.org; Sun, 30 Aug 2020 02:19:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52550)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kCGgI-0006Sa-R2
 for qemu-devel@nongnu.org; Sun, 30 Aug 2020 02:19:10 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:44166
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kCGgF-0008SI-SE
 for qemu-devel@nongnu.org; Sun, 30 Aug 2020 02:19:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598768346;
 h=from:from:sender:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qdueEY1/oWbqO+TNfreaWrPud9o32Z+0RhfvHMpp+90=;
 b=H+dq0xAe0eZfyZq2nBZebEXsaBVQfNhNO/TLVUtwEjagENJo/A5fqdbqFLuamOuDAG+7iq
 XcNls5EPosaqCMaUqcrIih3P+FYKDiPS8dI35jRvbMK1ngc9xi8ODoEep6Zgkz6ptCghQh
 9+eEcg1YV0nSjyXVfGEpsvIp6RCr2ig=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-B7dsRhxHOIq7hUSUgZnB2A-1; Sun, 30 Aug 2020 02:18:46 -0400
X-MC-Unique: B7dsRhxHOIq7hUSUgZnB2A-1
Received: by mail-wr1-f71.google.com with SMTP id i10so1711932wrq.5
 for <qemu-devel@nongnu.org>; Sat, 29 Aug 2020 23:18:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
 :references:mime-version:content-disposition
 :content-transfer-encoding:in-reply-to;
 bh=V2nCr2RPn1NrqT0tvAO1gfWK3iizlxVGfbl5BGyE7jU=;
 b=Czqft7qYHkXzbBhpPduHlP5bHdLLIs4PXa7Bi9JQSLbS0R8flGBXHmkwr88zrqGEOF
 SF3LTRoYYIWrCgkQO7bmeBqv7gQLbjz02vaxmF1Rkedu/6UfDGXlew7M14CXXyLmKlBN
 3LpUBVatUT4oyLy2WahS66OaS0ZxlJcOPKE1YokOSc1qqMjnimTRer81NWWi6P/aZlOI
 8W3iZtsazSQ4X/bRVAWA6wcZzUpsQgoJmHTlU76y8PKXQR0H6BHSbLtFSOTJj1hQvYpB
 lP06+FOoN+FRwHxi0shKz1yi+d0hzy+DbDgnDnTeNXXrmYQ4k+xn9O7T/+wmAy9WAVUH
 35fQ==
X-Gm-Message-State: AOAM532Gy22cIGxG2I0NXV65mVQQftynTGUvrn8VECBcdexhYMZehT00
 P14kA/1eCFRfYM/x+N+2TnPjChunChVRkx/h6W5Z7SHIDc+mV7HPw3dQO4UtlbVEDYAWJ6AUq+u
 WPgII3tVkBTIyNng=
X-Received: by 2002:adf:ebcf:: with SMTP id v15mr6592364wrn.372.1598768325149; 
 Sat, 29 Aug 2020 23:18:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyMdNUWHYDZ+ZN1B+yAZiYvgu/Qp49U3uXeyQ4EQlJCL6Y2267ynJAyLbzzzcVVUqLu0CZzUA==
X-Received: by 2002:adf:ebcf:: with SMTP id v15mr6592335wrn.372.1598768324811; 
 Sat, 29 Aug 2020 23:18:44 -0700 (PDT)
Received: from redhat.com (bzq-109-64-136-54.red.bezeqint.net. [109.64.136.54])
 by smtp.gmail.com with ESMTPSA id n8sm6215160wra.32.2020.08.29.23.18.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 29 Aug 2020 23:18:43 -0700 (PDT)
From: mst@redhat.com
X-Google-Original-From: "Michael S. Tsirkin" <mst@redhat.com>,
 Nathan Chancellor <natechancellor@gmail.com>
Date: Sun, 30 Aug 2020 02:18:39 -0400
To: Bug 1892540 <1892540@bugs.launchpad.net>,
 "Michael S. Tsirkin" <mst@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Subject: Re: [Bug 1892540] [RFC PATCH v2] hw/display/tcx: Allow 64-bit
 accesses to framebuffer stippler and blitter
Message-ID: <20200830021257-mutt-send-email-mst@kernel.org>
References: <159803735569.2614.10182276398047269277.malonedeb@chaenomeles.canonical.com>
 <20200822142127.1316231-1-f4bug@amsat.org>
MIME-Version: 1.0
In-Reply-To: <20200822142127.1316231-1-f4bug@amsat.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/30 02:19:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Aug 22, 2020 at 02:21:27PM -0000, Philippe Mathieu-Daudé wrote:
> The S24/TCX datasheet is listed as "Unable to locate" on [1].
> 
> However the NetBSD revision 1.32 of the driver introduced
> 64-bit accesses to the stippler and blitter [2]. It is safe
> to assume these memory regions are 64-bit accessible.
> QEMU implementation is 32-bit, so fill the 'impl' fields.
> 
> [1] http://web.archive.org/web/20111209011516/http://wikis.sun.com/display/FOSSdocs/Home
> [2] http://cvsweb.netbsd.org/bsdweb.cgi/src/sys/dev/sbus/tcx.c.diff?r1=1.31&r2=1.32
> 
> Reported-by: Andreas Gustafsson <gson@gson.org>
> Buglink: https://bugs.launchpad.net/bugs/1892540
> Fixes: 55d7bfe2293 ("tcx: Implement hardware acceleration")
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Philippe, did you submit the patch on the mailing list
normally too? I don't seem to see it there.

the patch seems to work for me:

Tested-by: Michael S. Tsirkin <mst@redhat.com>


CC Nathan who reported a similar failure.

Nathan, does the patch below fix the issue for you?

> ---
> Since v1:
> - added missing uncommitted staged changes... (tcx_blit_ops)
> ---
 hw/display/tcx.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/hw/display/tcx.c b/hw/display/tcx.c
index 1fb45b1aab8..96c6898b149 100644
--- a/hw/display/tcx.c
+++ b/hw/display/tcx.c
@@ -548,20 +548,28 @@ static const MemoryRegionOps tcx_stip_ops = {
     .read = tcx_stip_readl,
     .write = tcx_stip_writel,
     .endianness = DEVICE_NATIVE_ENDIAN,
-    .valid = {
+    .impl = {
         .min_access_size = 4,
         .max_access_size = 4,
     },
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 8,
+    },
 };
 
 static const MemoryRegionOps tcx_rstip_ops = {
     .read = tcx_stip_readl,
     .write = tcx_rstip_writel,
     .endianness = DEVICE_NATIVE_ENDIAN,
-    .valid = {
+    .impl = {
         .min_access_size = 4,
         .max_access_size = 4,
     },
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 8,
+    },
 };
 
 static uint64_t tcx_blit_readl(void *opaque, hwaddr addr,
@@ -650,10 +658,14 @@ static const MemoryRegionOps tcx_rblit_ops = {
     .read = tcx_blit_readl,
     .write = tcx_rblit_writel,
     .endianness = DEVICE_NATIVE_ENDIAN,
-    .valid = {
+    .impl = {
         .min_access_size = 4,
         .max_access_size = 4,
     },
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 8,
+    },
 };
 
 static void tcx_invalidate_cursor_position(TCXState *s)


-----------------------------------------------------------

I think you shouldn't specify .min_access_size in impl, since
that also allows 1 and 2 byte accesses from guest.



> -- 
> 2.26.2
> 
> -- 
> You received this bug notification because you are subscribed to the bug
> report.
> https://bugs.launchpad.net/bugs/1892540
> 
> Title:
>   qemu can no longer boot NetBSD/sparc
> 
> Status in QEMU:
>   New
> 
> Bug description:
>   Booting NetBSD/sparc in qemu no longer works.  It broke between qemu
>   version 5.0.0 and 5.1.0, and a bisection identified the following as
>   the offending commit:
> 
>     [5d971f9e672507210e77d020d89e0e89165c8fc9] memory: Revert "memory:
>   accept mismatching sizes in memory_region_access_valid"
> 
>   It's still broken as of 7fd51e68c34fcefdb4d6fd646ed3346f780f89f4.
> 
>   To reproduce, run
> 
>     wget http://ftp.netbsd.org/pub/NetBSD/NetBSD-9.0/images/NetBSD-9.0-sparc.iso
>     qemu-system-sparc -nographic -cdrom NetBSD-9.0-sparc.iso -boot d
> 
>   The expected behavior is that the guest boots to the prompt
> 
>     Installation medium to load the additional utilities from:
> 
>   The observed behavior is a panic:
> 
>     [   1.0000050] system[0]: trap 0x29: pc=0xf0046b14 sfsr=0xb6 sfva=0x54000000
>     [   1.0000050] cpu0: data fault: pc=0xf0046b14 addr=0x54000000 sfsr=0xb6<PERR=0x0,LVL=0x0,AT=0x5,FT=0x5,FAV,OW>
>     [   1.0000050] panic: kernel fault
>     [   1.0000050] halted
> 
> To manage notifications about this bug go to:
> https://bugs.launchpad.net/qemu/+bug/1892540/+subscriptions


