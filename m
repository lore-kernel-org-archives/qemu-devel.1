Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC0DC3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 22:44:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B1F8217F5
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 22:44:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sEk79d4H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B1F8217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2kCa-0005Hf-LZ
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 18:44:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45198)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1i2kBw-0004t0-6A
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 18:43:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1i2kBv-00043h-8X
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 18:43:56 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:34496)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1i2kBv-00043E-36
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 18:43:55 -0400
Received: by mail-wr1-x442.google.com with SMTP id s18so445433wrn.1
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2019 15:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:subject:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=tN8peeRYUIY6/kQQFzlEev2cnk/Uv44UaKhVfbgE340=;
 b=sEk79d4HsggkTrTylY+Oizu5gccajSxrpaHoeJYT4bkbA3AOHIFqxAb6okDb7i+RIj
 dO+3w9r85Xkw1iixzxonJaiQirs0T7uPFe4m84clG2vlsM7eqD4y/pzA5+GT9djoQXtp
 frCPxbVx7qfxFHx3w3pJg2hxv06WUcZI1I0iNWohHgZctpaTyGruzocq6NXMpwfaWMRK
 1VkeaKccOhEyPrr2hPzdtSwgVk434iCwiMMv1R8lOM5argIJEpPXBeWHGiVdC58fVqg4
 SjE4qkCKMAByYXuQm+rLiI/ZVCw8aHb4nIGXTst/oD1Hs2bL3NxDCaRkQQkISYOZyBB6
 RElA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:subject:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tN8peeRYUIY6/kQQFzlEev2cnk/Uv44UaKhVfbgE340=;
 b=azmvN39joVr/nIWMsWrqXJufe/YO8chV6mMRVHqnEYbpZIMcC/3X6mcyrKRD13+z9h
 HzA0oM0pfdb/qE9NHGubFGjNWPq9YQshzdkr8KJLi17i7GE0J1Y0V1yuLxEGBk1GN1WI
 3Nxcu48OVHFvjYpLVmYEIx2iQTeFziajCHpTAfvisFQ6SZYYJAEGZ+c4PfeoFVjzIPfr
 ILi6Cjza167+s4o6yQ4VtU9lOb8DRNMbos49lW57aUqiyj4k6LK035SUs/R48ZgmXyXf
 B5q/v83/bFZDgKyijinsmWicIwi81KswRN8Q1HJ4q804cXbYhco5e2xnVpsrOYT99ecB
 rlUQ==
X-Gm-Message-State: APjAAAVQBNC9QzISgZs9vJa9BCW4GJI0A+bz19Wo2XhC8KdajInct6Jp
 vWrNVFLf5CXd2Pud2+YjiJA=
X-Google-Smtp-Source: APXvYqxKkkain7rVZpae9KtTf+D2sPajNM3i8DDGu9J04MyfoszrRONASu/zRTgrlo6QPflp3+cK6g==
X-Received: by 2002:a5d:55cf:: with SMTP id i15mr438274wrw.151.1566945833097; 
 Tue, 27 Aug 2019 15:43:53 -0700 (PDT)
Received: from ?IPv6:fd00:835b:d940:d4fc:1::d3?
 (2a01-036c-0113-61b1-0001-0000-0000-00d3.pool6.digikabel.hu.
 [2a01:36c:113:61b1:1::d3])
 by smtp.gmail.com with ESMTPSA id y23sm406323wma.22.2019.08.27.15.43.51
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 27 Aug 2019 15:43:52 -0700 (PDT)
From: "=?UTF-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?=" <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?=
 <DirtY.iCE.hu@gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
References: <cover.1566847960.git.DirtY.iCE.hu@gmail.com>
 <43076a2afeb0439b607b0631e0bfff77d55bc0cc.1566847960.git.DirtY.iCE.hu@gmail.com>
 <20190827054223.nuiz7fz27tld3hpt@sirius.home.kraxel.org>
Message-ID: <2fdc616c-0690-a898-0247-765f90153903@gmail.com>
Date: Wed, 28 Aug 2019 00:43:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190827054223.nuiz7fz27tld3hpt@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: Re: [Qemu-devel] [PATCH v2 4/4] audio: paaudio: ability to specify
 stream name
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
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2019-08-27 07:42, Gerd Hoffmann wrote:
> On Mon, Aug 26, 2019 at 09:59:04PM +0200, Kővágó, Zoltán wrote:
>> This can be used to identify stream in tools like pavucontrol when one
>> creates multiple -audiodevs or runs multiple qemu instances.
> 
> Hmm, can we create an useful name automatically, without yet another
> config option?
> 
> Useful choices could be the device name (usb-audio, ...) or the device
> id (whatever -device id=xxx was specified on the command line).

I'm afraid this is not going to work with the current architecture: due
to mixeng even if you have multiple devices, they'll be mixed to a
single stream and the audio backend will only see this one mixed stream.
 As a workaround we could do something like concat all device names or
ids, but I don't like that idea.

Alternatively we could use the id of the audiodev instead, and no more
problems with mixeng.  However, with mixeng off (implemented in my next
patch series) suddenly soundcards will have suddenly end up as different
streams.  (This can be worked around by creating multiple audiodevs,
like what you have to use now to get multiple streams from pa, so this
is probably a smaller problem.)

Currently I'm leaning for the audiodev's id option, unless someone
proposes something better.

Regards,
Zoltan

