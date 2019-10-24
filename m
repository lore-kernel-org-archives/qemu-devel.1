Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EDEECA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 11:18:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 245722084C
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 11:18:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HWgkSaHL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 245722084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNb8f-0004ig-C7
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 07:18:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45489)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <estebanbosse@gmail.com>) id 1iNZHY-0005Fm-I4
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:19:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <estebanbosse@gmail.com>) id 1iNZHX-0000Ik-72
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:19:48 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:51872)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <estebanbosse@gmail.com>)
 id 1iNZHW-0000Gx-Uc; Thu, 24 Oct 2019 05:19:47 -0400
Received: by mail-wm1-x344.google.com with SMTP id q70so1952739wme.1;
 Thu, 24 Oct 2019 02:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=MtRiJQgfJ9ZnkixG1KDBOu+rrd/k/A5pzUFTb4qm5p0=;
 b=HWgkSaHLaM4KT2a0iNnpJVNdZUAKQxKNvzIj5Z9o+o53prOV01jRgmPf1DMzsVo4iv
 kxckSCehtsshUTI1VKlHo7W/EtaINb/4TyEztSvKLzO+lMDA6jMk/d09NeK5e0m+BBHJ
 l8ywn6JAXGUx4sHRgwMe3s0CAJV+xtur1DJGCURfqkTXBypl5uxu8Vs7BNYmTOM5jOI8
 LxNBGEBL9pJvr+q8ZLOPgAtAFf9eYo5UytM9mXOENCSrrxoBFQFzJvz8ZQvLuHYUuMbq
 Z2frsHjlvPJsSB1FhH5cms6zfJK0ES26NlzLLf058x6B9Y2kkXVRd0QsqvevZG+1shb7
 MwLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=MtRiJQgfJ9ZnkixG1KDBOu+rrd/k/A5pzUFTb4qm5p0=;
 b=iYYnaXDNBSQBZEs6RYHiRCUSeue5qel61liM05BItbDsTaO/xwQOx/DqemBVITjwuc
 0ZpYP5xiLSsmAvhYnjRUDa1t+9VFkcMlo3uH+7n2zF7A2Mnk+XVeDZZCkKXGfKIi96b/
 VjqiN+TTyecxebKbSmAJCHdVS4ZPPgMQdjNj+pRxswoTfSntc8u2bliEeiONqWiJBRmV
 dhoOOUNFKq1RXOaE6Gyar1H/i4ejoZs5O5p8YMvyi2Igt2rkBpMIiqG5SOJlOEnwMwvS
 UFBWHsFjEZJHYdSfkBWHBIn91DW4IGfU1km7pEogxLIpyBxEJRCmY49aDSkekyPZhaH0
 mCBw==
X-Gm-Message-State: APjAAAVXW3tz099tkB682NjTAYpK1Rj9YuhH7LZRxbe1b/WRYURHcI5y
 VpyFDgOp/wVStbYSenYnKrA=
X-Google-Smtp-Source: APXvYqygb8LalNQ9Md4VTnLJftVwW84EHPEIBxAwaFKBTMV1aPfo4WAWySUbDAqBIrr3RhGaFJ9O7Q==
X-Received: by 2002:a1c:64d4:: with SMTP id y203mr3976343wmb.27.1571908784275; 
 Thu, 24 Oct 2019 02:19:44 -0700 (PDT)
Received: from ?IPv6:2a01:c22:b04f:9c00:d5b4:db5f:bfb4:fdb?
 ([2a01:c22:b04f:9c00:d5b4:db5f:bfb4:fdb])
 by smtp.gmail.com with ESMTPSA id f8sm1926360wmb.37.2019.10.24.02.19.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 02:19:43 -0700 (PDT)
Message-ID: <f623a5e67cec8934b136cf8ae68ba70dd58a6f84.camel@gmail.com>
Subject: Re: [RFC PATCH 03/14] hw/misc/bcm2835_property: Handle the 'domain
 state' property
From: Esteban Bosse <estebanbosse@gmail.com>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Peter
 Maydell <peter.maydell@linaro.org>, Andrew Baumann
 <Andrew.Baumann@microsoft.com>,  qemu-devel@nongnu.org, Pekka Enberg
 <penberg@iki.fi>,  =?ISO-8859-1?Q?Zolt=E1n?= Baldaszti <bztemail@gmail.com>
Date: Thu, 24 Oct 2019 11:15:33 +0200
In-Reply-To: <7023ba2c-edfa-8313-8138-0556f4a03023@amsat.org>
References: <20190904171315.8354-1-f4bug@amsat.org>
 <20190904171315.8354-4-f4bug@amsat.org>
 <d02a29663183b8963bc34a0d1b031442d997ab62.camel@gmail.com>
 <7023ba2c-edfa-8313-8138-0556f4a03023@amsat.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: qemu-arm@nongnu.org, Clement Deschamps <clement.deschamps@antfield.fr>,
 =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

El mar, 08-10-2019 a las 11:32 +0200, Philippe Mathieu-Daudé escribió:
> On 9/29/19 9:01 AM, Esteban Bosse wrote:
> > El mié, 04-09-2019 a las 19:13 +0200, Philippe Mathieu-Daudé
> > escribió:
> > > The kernel is happy with this change, so we don't need
> > > to do anything more sophisticated.
> > > 
> > > Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> > > Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> > > ---
> > >   hw/misc/bcm2835_property.c | 8 ++++++++
> > >   1 file changed, 8 insertions(+)
> > > 
> > > diff --git a/hw/misc/bcm2835_property.c
> > > b/hw/misc/bcm2835_property.c
> > > index 399f0d9dd5..d8eb28f267 100644
> > > --- a/hw/misc/bcm2835_property.c
> > > +++ b/hw/misc/bcm2835_property.c
> > > @@ -127,6 +127,14 @@ static void
> > > bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t
> > > value)
> > >               resplen = 8;
> > >               break;
> > >   
> > > +        case 0x00030030: /* Get domain state */
> > > +            qemu_log_mask(LOG_UNIMP,
> > > +                          "bcm2835_property: 0x%08x get domain
> > > state
> > > NYI\n",
> > > +                          tag);
> > > +            /* FIXME returning uninitialized memory */
> > > +            resplen = 8;
> > > +            break;
> > > +
> > >           case 0x00038002: /* Set clock rate */
> > >           case 0x00038004: /* Set max clock rate */
> > >           case 0x00038007: /* Set min clock rate */
> > 
> > Searching this property in the kernel, I found a lot of properties
> > not
> > implemented.
> > https://github.com/raspberrypi/linux/blob/rpi-4.19.y/include/soc/bcm2835/raspberrypi-firmware.h#L41
> > Are the properties only added when they are necessaries for the
> > standard kernel use?
> 
> Yes, the idea is to emulate the bare minimum required to run your
> guest 
> code. To test this series I used the closed source kernel provided
> by 
> the Raspberry Pi foundation [1] which the one that does the most of 
> UNIMP accesses, the Debian trunk one and I build one from [2].
> 
> The problem is old kernels don't support the raspi4, and recent
> kernels 
> do a lot of property calls to use recent features.
> 
> A "property call" is a call from the ARM core to the VideoCore
> firmware, 
> like a Remote Procedure Call. The ARM core write some 
> arguments/structure to a memory space shared with the VideoCore, use
> a 
> MailBox to send a 'property' key to the VideoCore and wait/poll for
> a 
> response from the VC. The VC handles the 'property' call, if
> required 
> fills the structure in the same memory space the ARM used, then
> reply 
> via another MailBox channel to notify the ARM core.
> 
> QEMU does not model the VideoCore. Instead we directly fill the
> memory 
> from the ARM property call. We fake the VC firmware.
> 
> [1] 
> https://github.com/raspberrypi/firmware/blob/master/boot/kernel8.img
> [2] https://github.com/raspberrypi/linux/tree/rpi-5.3.y
Thank you very much for all the data Phil.

Now I understood "the idea is to support the bare minimum for the
guest", I thought that the idea was a full HW support, but make sense
it's a lot of work to give full HW support.


