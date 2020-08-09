Return-Path: <SRS0=L55N=BT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,HK_RANDOM_FROM,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD2ADC433DF
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Aug 2020 17:19:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86A72206CD
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Aug 2020 17:19:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86A72206CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k4oya-0001l0-HD
	for qemu-devel@archiver.kernel.org; Sun, 09 Aug 2020 13:19:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43830)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1k4oxy-00018Q-8x
 for qemu-devel@nongnu.org; Sun, 09 Aug 2020 13:18:38 -0400
Received: from relay68.bu.edu ([128.197.228.73]:60287)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1k4oxv-0004Cr-N0
 for qemu-devel@nongnu.org; Sun, 09 Aug 2020 13:18:37 -0400
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay68.bu.edu (8.14.3/8.14.3) with ESMTP id 079HHE3R020520
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Sun, 9 Aug 2020 13:17:17 -0400
Date: Sun, 9 Aug 2020 13:17:14 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: Helge Deller <deller@gmx.de>
Subject: Re: [PATCH v3 7/8] hw/display/artist: Refactor artist_rop8() to
 avoid buffer over-run
Message-ID: <20200809171714.3qp72ubampclo4f2@mozz.bu.edu>
References: <20200804140056.7690-1-deller@gmx.de>
 <20200804140056.7690-8-deller@gmx.de>
 <20200804163954.4dzistybjwby7pzx@mozz.bu.edu>
 <20200804212019.GA876@ls3530.fritz.box>
 <20200804220145.yjq265pk363466hx@mozz.bu.edu>
 <20200805204459.GA23951@ls3530.fritz.box>
 <20200806154556.ksb2ja3hghxhukdd@mozz.bu.edu>
 <01f10f58-1b29-d7f9-e4d5-6092d69aa127@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01f10f58-1b29-d7f9-e4d5-6092d69aa127@gmx.de>
User-Agent: NeoMutt/20180716
Received-SPF: pass client-ip=128.197.228.73; envelope-from=alxndr@bu.edu;
 helo=relay68.bu.edu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/09 13:18:34
X-ACL-Warn: Detected OS   = Linux 2.6.x
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.001,
 HK_RANDOM_FROM=1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 200809 0717, Helge Deller wrote:
> Hello Alexander,
> 
> On 06.08.20 17:46, Alexander Bulekov wrote:
> > On 200805 2244, Helge Deller wrote:
> >> * Alexander Bulekov <alxndr@bu.edu>:
> >>> On 200804 2320, Helge Deller wrote:
> >>>> * Alexander Bulekov <alxndr@bu.edu>:
> >>>>> I applied this series and it fixes most of the problems I saw before.
> >>>>> I still see a few crashes - I made issues for them on launchpad:
> >>>>> https://bugs.launchpad.net/qemu/+bug/1890310
> >>>>> https://bugs.launchpad.net/qemu/+bug/1890311
> >>>>> https://bugs.launchpad.net/qemu/+bug/1890312
> >>> Hi Helge, I can still reproduce this one  ^^^
> >>> I'll fuzz it some more, but so far I am not finding anything else.
> >>
> >> I've now updated the patch which does address all issues you found
> >> so far. It's attached below.
> >>
> > I pulled from your repo, but I can still reproduce LP1890312
> > (I build with --enable-sanitizers). Maybe I am missing something? With
> > this cleared up, I'm happy to leave an Acked-by for the artist patches
> > in this series.
> >
> > git show --summary
> > commit 1657a7a95adc15552138c2b4d310a06128093892 (HEAD, hppa/target-hppa, target-hppa)
> > Author: Helge Deller <deller@gmx.de>
> > Date:   Tue Aug 4 15:35:38 2020 +0200
> 
> The current tree at
> https://github.com/hdeller/qemu-hppa/commits/target-hppa
> does survive all your tests and in addition fixes an artist bug which
> made the dtwm window manager rendering wrong on HP-UX.
> Please completely revert your tree before pulling again.
> I'll send out a complete patch series shortly.
> 

Hi Helge,
This still causes a segfault for me:

cat << EOF | ./hppa-softmmu/qemu-system-hppa -m 64 -display none \
-qtest stdio -accel qtest
writew 0xf8118001 0x105a
readq 0xf900f8ff
EOF

I think the problem is that there is a bounds check missing on the
artist_vram_read with s->cmap_bm_access path. The bounds check is
present for artist_vram_write, so I just copied it over, and that fixed
the issue (applied on top of the current qemu-hppa/target-hppa):

diff --git a/hw/display/artist.c b/hw/display/artist.c
index 720db179ab..678023bb3a 100644
--- a/hw/display/artist.c
+++ b/hw/display/artist.c
@@ -1216,8 +1216,10 @@ static uint64_t artist_vram_read(void *opaque, hwaddr addr, unsigned size)
 
     if (s->cmap_bm_access) {
         buf = &s->vram_buffer[ARTIST_BUFFER_CMAP];
-        val = *(uint32_t *)(buf->data + addr);
-        trace_artist_vram_read(size, addr, 0, 0, val);
+        if (addr + 3 < buf->size) {
+            val = *(uint32_t *)(buf->data + addr);
+            trace_artist_vram_read(size, addr, 0, 0, val);
+        }
         return 0;
     }
 

-Alex


> Thanks!
> Helge

