Return-Path: <SRS0=GetT=XK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3873BC4CEC9
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2019 01:09:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 030E020692
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2019 01:09:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RE6TiMdk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 030E020692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9J2t-0004Zr-6j
	for qemu-devel@archiver.kernel.org; Sat, 14 Sep 2019 21:09:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41340)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1i9J1i-000455-C1
 for qemu-devel@nongnu.org; Sat, 14 Sep 2019 21:08:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1i9J1h-00020Z-BU
 for qemu-devel@nongnu.org; Sat, 14 Sep 2019 21:08:30 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:35001)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1i9J1h-000201-3i
 for qemu-devel@nongnu.org; Sat, 14 Sep 2019 21:08:29 -0400
Received: by mail-wm1-x343.google.com with SMTP id y21so2172009wmi.0
 for <qemu-devel@nongnu.org>; Sat, 14 Sep 2019 18:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:subject:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ULX0MdgX0xQ/UKsZFHLH/K7OmuoKXLlpEINrguyyphs=;
 b=RE6TiMdkriXwkEouq40DGGKh1UaqSLN2k5KVxRRa9Ztgg8no3WcYgUfI1W4FOs+WQe
 hzyADq1iAT3y60N0lisSB8bll1tQWNSO3OXeTeA5eFHN5glEh/k4Z1laVDxnSzLOmdZT
 Jv8RQVldBLeZwnePgK/JWNK4NLKeoEs3MYufkxXwR+0ZtZKcHhes49or0LIroFSLTO2W
 JI9SHNBQiGik0au5o3Mx63qaFavggmsrY/3VH+1eOSTPwCeo3BtyhCg43fBvp6o3e+cW
 q28sLbW5wsQELuMTI0NcZhljA7Y0e7bpmYhSaKfH5M84ejTpxZKXv9JvP5okYNmtIXIX
 ZEuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:subject:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ULX0MdgX0xQ/UKsZFHLH/K7OmuoKXLlpEINrguyyphs=;
 b=R6FRtk/wnCJSd6bU6BeZ3bmDZxQu6gLj2P8TJRz/WQVHi56UmIz0B0BAx8ml5k3lV5
 PRW6/S0ou1pD1mGzINtSNlWOrhXzGUASTwmEHrB0VKRG076wauHOI/3rWV+yiCgCsRV+
 pm2xCuxLXib6in5YFdMDWxxdlYFtrz0gGE2kAiQY8DmHGjBX7whfwfdgPPzDy7OKERzy
 NINPjXPtOwxE9j31mUB5S450/w+JCfahfdHHmdWHlUs7wPdD66ssPIka1y3o7Dz0W3nd
 pJoHEnX7e9PtDIp591VuWl6y2GQpae2qKl2etB4bR50bjUrsAgmSJ7KFQneCW3bzfpOE
 116A==
X-Gm-Message-State: APjAAAWeXSyP+YSIJqUPba5NSXRyxGAY56B5avR9isYsZM7zxBEEca5N
 qNJS4MSP256JGjTWzfhRSzthvQ6B
X-Google-Smtp-Source: APXvYqzGrjEXtLJbkHmqNtdZLYL5Kg/JjEEqXCA5cypkNTq2HZ213R1LU98S/h/VAtk+sgKKjaHmpw==
X-Received: by 2002:a1c:e008:: with SMTP id x8mr8462275wmg.85.1568509706674;
 Sat, 14 Sep 2019 18:08:26 -0700 (PDT)
Received: from ?IPv6:fd00:835b:d940:d4fc:1::d3?
 (2a01-036c-0113-74ef-0001-0000-0000-00d3.pool6.digikabel.hu.
 [2a01:36c:113:74ef:1::d3])
 by smtp.gmail.com with ESMTPSA id a10sm6861033wrm.52.2019.09.14.18.08.25
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 14 Sep 2019 18:08:26 -0700 (PDT)
From: "=?UTF-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?=" <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?=
 <DirtY.iCE.hu@gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
References: <cover.1567965065.git.DirtY.iCE.hu@gmail.com>
 <20190912102007.73bch4avvmx3ugpe@sirius.home.kraxel.org>
Message-ID: <9e32e611-ccf3-7cce-8a08-3d05bac65f0c@gmail.com>
Date: Sun, 15 Sep 2019 03:08:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190912102007.73bch4avvmx3ugpe@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: Re: [Qemu-devel] [PATCH v2 00/24] Audio: Mixeng-free 5.1/7.1 audio
 support
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2019-09-12 12:20, Gerd Hoffmann wrote:
> On Sun, Sep 08, 2019 at 11:22:00PM +0200, Kővágó, Zoltán wrote:
>> Hi,
>>
>> This is the v2 of my patch series that makes mixeng optional and enables
>> more than two audio channels.
>>
>> Changes from v1:
>>
>> * renamed "mixeng" option to "mixing-engine"
>> * dropped patch "audio: remove hw->samples, buffer_size_in/out pcm_ops"
> 
> What is the testing status of this?

I've ran some very simple audio playback tests, here are my results:
* alsa - works
* pa - works
* oss - works, but it looks like I have to specify both in.dev and 
out.dev if the default /dev/dsp does not exist, otherwise I just get a 
generic "Could not init `oss' audio driver".  We need a better error 
message here IMHO.
* sdl - works
* spice - yes, it's broken now, I'll fix it in the next update.  I've 
also found a second bug (SIGSEGV if the guest starts playing while no 
client is connected).

> What about windows+macos?

No idea, I don't have a windows or mac computer.  I could try it in a 
windows VM though, if I figure out how to compile qemu on windows.

Regards,
Zoltan

