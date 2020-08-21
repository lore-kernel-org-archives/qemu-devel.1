Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,HK_RANDOM_FROM,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39079C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 13:57:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA88720720
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 13:57:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA88720720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k97XO-00038s-78
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 09:56:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51356)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1k97Wg-0002T1-EV
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 09:56:14 -0400
Received: from relay64.bu.edu ([128.197.228.104]:54988)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1k97We-0002xx-Mo
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 09:56:14 -0400
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay64.bu.edu (8.14.3/8.14.3) with ESMTP id 07LDtTfx017024
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 21 Aug 2020 09:55:33 -0400
Date: Fri, 21 Aug 2020 09:55:29 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH] cirrus: handle wraparound in cirrus_invalidate_region
Message-ID: <20200821135529.gazdztnu367tygdn@mozz.bu.edu>
References: <20200821082622.7169-1-kraxel@redhat.com>
 <0fb2b10e-320f-9b33-6812-f1c5d06b0563@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0fb2b10e-320f-9b33-6812-f1c5d06b0563@redhat.com>
Received-SPF: pass client-ip=128.197.228.104; envelope-from=alxndr@bu.edu;
 helo=relay64.bu.edu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 09:56:10
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
Cc: Prasad J Pandit <pjp@redhat.com>, Li Qiang <liq3ea@163.com>,
 Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 200821 1251, Philippe Mathieu-Daudé wrote:
> On 8/21/20 10:26 AM, Gerd Hoffmann wrote:
> > Code simply asserts that there is no wraparound instead of handling
> > it properly.  The assert() can be triggered by the guest (must be
> > privilidged inside the guest though).  Fix it.
> 
> Thanks for fixing this!
> 
> > Buglink: https://bugs.launchpad.net/qemu/+bug/1880189
> > Cc: Li Qiang <liq3ea@163.com>
> > Reported-by: Alexander Bulekov <alxndr@bu.edu>
> 
> Well, I reported this one 3 months ago to secalert, not Alex.

Nice. In fact, I don't think I've come across this one yet, even with
fairly good coverage over the cirrus. Maybe its just a matter of
increasing the maximum input length. I think with my parser each out
instruction weighs in at 15 bytes + 4 byte separator, so it would take
900-1000 bytes to generate your reproducer, whereas I temporarily set
the limit at 400.

> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> 
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > ---
> >  hw/display/cirrus_vga.c | 11 ++++++++---
> >  1 file changed, 8 insertions(+), 3 deletions(-)
> > 
> > diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
> > index 212d6f5e6145..b91b64347473 100644
> > --- a/hw/display/cirrus_vga.c
> > +++ b/hw/display/cirrus_vga.c
> > @@ -640,10 +640,15 @@ static void cirrus_invalidate_region(CirrusVGAState * s, int off_begin,
> >      }
> >  
> >      for (y = 0; y < lines; y++) {
> > -        off_cur = off_begin;
> > +        off_cur = off_begin & s->cirrus_addr_mask;
> >          off_cur_end = ((off_cur + bytesperline - 1) & s->cirrus_addr_mask) + 1;
> > -        assert(off_cur_end >= off_cur);
> > -        memory_region_set_dirty(&s->vga.vram, off_cur, off_cur_end - off_cur);
> > +        if (off_cur_end >= off_cur) {
> > +            memory_region_set_dirty(&s->vga.vram, off_cur, off_cur_end - off_cur);
> > +        } else {
> > +            /* wraparound */
> > +            memory_region_set_dirty(&s->vga.vram, off_cur, s->cirrus_addr_mask - off_cur);
> > +            memory_region_set_dirty(&s->vga.vram, 0, off_cur_end);
> > +        }
> >          off_begin += off_pitch;
> >      }
> >  }
> > 
> 

