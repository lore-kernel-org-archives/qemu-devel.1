Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5DFDC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 17:44:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BED4320739
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 17:44:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BED4320739
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkt9m-0000I3-31
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 13:44:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54754)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jkt97-0008Gd-6F
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 13:43:45 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:12870)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jkt93-000514-Um
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 13:43:44 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id D069474632B;
 Mon, 15 Jun 2020 19:43:35 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 4F3D5746307; Mon, 15 Jun 2020 19:43:35 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 4DBCC7456F8;
 Mon, 15 Jun 2020 19:43:35 +0200 (CEST)
Date: Mon, 15 Jun 2020 19:43:35 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 1/4] sm501: Fix bounds checks
In-Reply-To: <CAFEAcA8ktxFzcj61GydqarczXWh_gkzJ4aa5ZFKqs6s2BCQaPw@mail.gmail.com>
Message-ID: <alpine.BSF.2.22.395.2006151901070.51837@zero.eik.bme.hu>
References: <cover.1591471056.git.balaton@eik.bme.hu>
 <acb431de2d9c7a497d54a548dfc7592eb2b9fe1c.1591471056.git.balaton@eik.bme.hu>
 <CAFEAcA_WemGUp0YTitXvChsFPzZjOts04zTp2-aPgmFxTC5NXA@mail.gmail.com>
 <alpine.BSF.2.22.395.2006151832190.51837@zero.eik.bme.hu>
 <CAFEAcA8ktxFzcj61GydqarczXWh_gkzJ4aa5ZFKqs6s2BCQaPw@mail.gmail.com>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Sebastian Bauer <mail@sebastianbauer.info>,
 Magnus Damm <magnus.damm@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 15 Jun 2020, Peter Maydell wrote:
> On Mon, 15 Jun 2020 at 17:40, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>>
>> On Mon, 15 Jun 2020, Peter Maydell wrote:
>>> The calculations for sb/se/db/de all have a term which
>>> multiplies by (width + pitch), which makes me suspect
>>> they also need a similar fix ?
>>
>> Maybe. I'll have to check again. Actually is there a simpler way to check
>> if two rectangles overlap when they are given with base, x, y, w, h, pitch
>> where base is the first byte of the screen, pitch is length of one line
>> and x,y is coordinates of top left corner and w,h is dimensions of the
>> rect. Now that I think about it we also need to take into accounf the
>> bytes per pixel value (1 << format) because base is given in bytes while
>> others are in pixels so these formulae likely need some fixes. Pixman has
>> some functions for these but those assume common base so to use those we
>> would need to bring the two rectangles to common base which I could not
>> find out how to do. Probably this is really simple for someone who already
>> did a lot of these before.
>
> I think the thing that makes it particularly awkward is that
> the source and dest can have different pitches. That means it's

Yes, different bases and different pitches make it difficult to compare 
and also to transform them to a common base to be able to do rectangle 
overlap test (I haven't checked but maybe the pitches could be relative 
prime so it's possible there's no common pitch to transform them to a 
single view).

> not a simple "do two rectangles overlap" test because the dest
> area might not be a rectangle at all when looked at from the
> POV of the source.
>
> Do guests usually set src and dst pitch identical? If so it
> might be worth having a more accurate rectangle-overlap test
> for the common case and a looser check for the hard-to-handle
> case.

Quick test (just booted AmigaOS, opened some windows and moved them around 
a bit) shows same pitch is common but not always:

    7610 sm501 2d engine regs : write addr=10, val=200020
    4249 sm501 2d engine regs : write addr=10, val=4000400
    2340 sm501 2d engine regs : write addr=10, val=4000080
     462 sm501 2d engine regs : write addr=10, val=40000a0
     453 sm501 2d engine regs : write addr=10, val=800080
     434 sm501 2d engine regs : write addr=10, val=1200120
     233 sm501 2d engine regs : write addr=10, val=4000020
     162 sm501 2d engine regs : write addr=10, val=400040
     144 sm501 2d engine regs : write addr=10, val=200080
     141 sm501 2d engine regs : write addr=10, val=2000a0
      75 sm501 2d engine regs : write addr=10, val=600060
      62 sm501 2d engine regs : write addr=10, val=a000a0
      62 sm501 2d engine regs : write addr=10, val=200400
      38 sm501 2d engine regs : write addr=10, val=e000e0
      38 sm501 2d engine regs : write addr=10, val=1000100
      38 sm501 2d engine regs : write addr=10, val=10000a0
      37 sm501 2d engine regs : write addr=10, val=4000040
      36 sm501 2d engine regs : write addr=10, val=40000e0
      34 sm501 2d engine regs : write addr=10, val=a00080
      34 sm501 2d engine regs : write addr=10, val=4000120
      33 sm501 2d engine regs : write addr=10, val=400080
      25 sm501 2d engine regs : write addr=10, val=600080
      23 sm501 2d engine regs : write addr=10, val=4000060
      22 sm501 2d engine regs : write addr=10, val=1a001a0

and may depend on what the guest is doing so not sure it's worth the 
effort. (Probably same pitch is used when moving window and different when 
drawing something like text or icons but different pitch likely uses 
off-screen bitmap as source so overlap is not likely for those.)

> I might have a think about this and draw some diagrams tomorrow :-)

I'll wait for that to see if you can come up with something clever. I've 
tried to find a solution but could not come up with anything simpler than 
a loop checking lines which is probably as much effort as doing the blit 
itself and then doing blit with a temporary is probably the same so I went 
for just checking the obviously far apart blits (and even that seems to be 
easy to miss). So I'm happy if we can just fix the checks we have but if 
there are better suggestions please tell me.

Regards,
BALATON Zoltan

