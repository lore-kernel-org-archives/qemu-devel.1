Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 502C7C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 16:43:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 196342067B
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 16:43:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 196342067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jksCK-00033S-7A
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 12:43:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36840)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jksAP-0001IH-Mn
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 12:41:01 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:22950)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jksAM-0001h7-98
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 12:41:00 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id CD9C4746307;
 Mon, 15 Jun 2020 18:40:55 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id AD569745702; Mon, 15 Jun 2020 18:40:55 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id ABB767456F8;
 Mon, 15 Jun 2020 18:40:55 +0200 (CEST)
Date: Mon, 15 Jun 2020 18:40:55 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 1/4] sm501: Fix bounds checks
In-Reply-To: <CAFEAcA_WemGUp0YTitXvChsFPzZjOts04zTp2-aPgmFxTC5NXA@mail.gmail.com>
Message-ID: <alpine.BSF.2.22.395.2006151832190.51837@zero.eik.bme.hu>
References: <cover.1591471056.git.balaton@eik.bme.hu>
 <acb431de2d9c7a497d54a548dfc7592eb2b9fe1c.1591471056.git.balaton@eik.bme.hu>
 <CAFEAcA_WemGUp0YTitXvChsFPzZjOts04zTp2-aPgmFxTC5NXA@mail.gmail.com>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 11:14:38
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
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
> On Sat, 6 Jun 2020 at 20:22, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>>
>> We don't need to add width to pitch when calculating last point, that
>> would reject valid ops within the card's local_mem.
>>
>> Fixes: b15a22bbcbe6a78dc3d88fe3134985e4cdd87de4
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>>  hw/display/sm501.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>
> The calculations for sb/se/db/de all have a term which
> multiplies by (width + pitch), which makes me suspect
> they also need a similar fix ?

Maybe. I'll have to check again. Actually is there a simpler way to check 
if two rectangles overlap when they are given with base, x, y, w, h, pitch 
where base is the first byte of the screen, pitch is length of one line 
and x,y is coordinates of top left corner and w,h is dimensions of the 
rect. Now that I think about it we also need to take into accounf the 
bytes per pixel value (1 << format) because base is given in bytes while 
others are in pixels so these formulae likely need some fixes. Pixman has 
some functions for these but those assume common base so to use those we 
would need to bring the two rectangles to common base which I could not 
find out how to do. Probably this is really simple for someone who already 
did a lot of these before.

Regards,
BALATON Zoltan

