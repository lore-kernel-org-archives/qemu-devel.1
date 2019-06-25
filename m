Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30CE1C48BD4
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 13:42:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 036372133F
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 13:42:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 036372133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60348 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hflie-0001UG-8q
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 09:42:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54582)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <balaton@eik.bme.hu>) id 1hflNf-0002fm-Mm
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 09:21:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1hflNe-0000U5-Fr
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 09:21:03 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:53108)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1hflNe-0000Ju-0S
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 09:21:02 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 6807C7462BD;
 Tue, 25 Jun 2019 15:20:26 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 52D577462B8; Tue, 25 Jun 2019 15:20:25 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 51C7A7462AF;
 Tue, 25 Jun 2019 15:20:25 +0200 (CEST)
Date: Tue, 25 Jun 2019 15:20:25 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Corey Minyard <cminyard@mvista.com>
In-Reply-To: <20190625125623.GF5565@minyard.net>
Message-ID: <alpine.BSF.2.21.9999.1906251500460.4039@zero.eik.bme.hu>
References: <cover.1561028123.git.balaton@eik.bme.hu>
 <046ddebb7ec8db48c4e877ee444ec1c41e385a74.1561028123.git.balaton@eik.bme.hu>
 <20190625125623.GF5565@minyard.net>
User-Agent: Alpine 2.21.9999 (BSF 287 2018-06-16)
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2001:738:2001:2001::2001
Subject: Re: [Qemu-devel] [PATCH v5 2/2] ati-vga: Implement DDC and EDID
 info from monitor
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
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 25 Jun 2019, Corey Minyard wrote:
> On Thu, Jun 20, 2019 at 12:55:23PM +0200, BALATON Zoltan wrote:
>> This adds DDC support to ati-vga and connects i2c-ddc to it. This
>> allows at least MacOS with an ATI ndrv, Linux radeonfb and MorphOS to
>> get monitor EDID info (although MorphOS splash screen is not displayed
>> and radeonfb needs additional tables from vgabios-rv100). Xorg needs
>> additional support from VESA vgabios, it's missing INT10 0x4F15
>> function (see
>> https://gitlab.freedesktop.org/xorg/xserver/blob/master/hw/xfree86/vbe/vbe.c)
>> without which no DDC is available that also prevents loading the
>> accelerated X driver.
>>
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>
> This patch also looks good, and thanks to Gerd for reviewing.
>
> I didn't see the followup documentation patch that Gerd suggested, did
> I miss that?
>
> Also, how would you like to handle these?

Gerd has already queued them (including the requested follow up to update 
comment which I think only cc'd to Gerd that's why you may have missed it, 
but another fix up I've sent adding reg names to ati_dbg.h may still be 
missing from Gerd's tree). I think Gerd can send these via his tree with 
your Acked-by on the i2c patch which should be OK if nobody disagrees.

There's still the issue with cleaning up bitbang_i2c that results in an 
ASan warning which we have discussed before:
https://lists.nongnu.org/archive/html/qemu-devel/2019-03/msg05966.html
but we could not find an easy fix so since it's preexisting problem it can 
be fixed later. Although, I don't have plans to fix that, only mentioning 
it here as a reminder.

Thank you,
BALATON Zoltan

