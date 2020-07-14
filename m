Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8955DC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 17:17:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5477522574
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 17:17:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A75fANeI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5477522574
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvOYa-0002E5-In
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 13:17:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59516)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jvOXp-0001OU-Ud; Tue, 14 Jul 2020 13:16:42 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:55897)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jvOXo-00047V-5Q; Tue, 14 Jul 2020 13:16:41 -0400
Received: by mail-wm1-x343.google.com with SMTP id g75so7185424wme.5;
 Tue, 14 Jul 2020 10:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=G06bz0G+0zTOMITxITjIWonCFrTFaS1DYVQC/CsPT3g=;
 b=A75fANeIgiij9mKlNG56ZzZnxnFQggXZ5wUopP/5cVMCyC5pUEpqbhxguNXWtxNBr2
 nPHs6X0D4ImX/u862g/07bvbCK8HbUMPJiPQzdaLnCaUKJVJO1Uvm2s4f61huSTd0G3J
 f3q4Hkw2LFqyoc3hnNLhUPyN+vpOUK6UbuDDLf/Isq5PZTqhiDM3C7pr3h7W0/asII1e
 c0bt0jX5vAYxpH3lMYahE2lXQmxwBAvttvRCMDFtQp2+aB/S7BdhA29yCBYUZTLl9HbT
 wGZphBvmXqVr5r7PfjgBq6PqnPTCY69aD1JEEZckPxhx2k0PyTicBtmIeGAjIwycOdQO
 nFhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=G06bz0G+0zTOMITxITjIWonCFrTFaS1DYVQC/CsPT3g=;
 b=XP4+YPvc6oePl3u5G3Z4pRXbYn9bFtOwKBgcj0h/jID7dMtrPiNQ0bmUCQZRQRx47d
 qNqK/Qf/LgXxbAw5KNIcRAhPqhfO900NwIW5M6oZH8/nDqrqr2k62VTvsiAiFzqWY6Wx
 tq1MT9L8DvjMmRru8tZJkPi9zdo086jS1RAO36P6nvnMSSSLoCMWwrM0dYLXsd3Y8iKO
 BfQN9IvHtE8HbcoF31SBQo2kEcMkCiaUrnlbukkifnU37h5JX6+2s+ggNpS9tB0nuakp
 MH/VbUp6/Ihdl7zqhL5mBc+Y4lo+S/95pFDHErIsjZwV18aOg6gl5/xagSNmKnnhHTuw
 k0rQ==
X-Gm-Message-State: AOAM530ckh4wx2vSREstMj93UosG/rH0jMhy/TveIxJevk6j98oSC0IY
 oZ1ZDhL605ULxu/MHNnzSfw=
X-Google-Smtp-Source: ABdhPJzBvHNNxhmigsJbRhzG59qJA7qZVd1CDDQGyj03j6PwmL5d2H0Kw8E4K9+5xGlC3oLRWLELOQ==
X-Received: by 2002:a1c:81d3:: with SMTP id c202mr4893178wmd.54.1594746996796; 
 Tue, 14 Jul 2020 10:16:36 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id 1sm5212439wmf.21.2020.07.14.10.16.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jul 2020 10:16:36 -0700 (PDT)
Subject: Re: [PATCH v5 10/11] hw/arm: Wire up BMC boot flash for npcm750-evb
 and quanta-gsj
To: Markus Armbruster <armbru@redhat.com>
References: <20200709003608.3834629-1-hskinnemoen@google.com>
 <20200709003608.3834629-11-hskinnemoen@google.com>
 <109d52ed-65bf-0fcc-98f1-47b7a6671d0b@kaod.org>
 <CAFQmdRZcygskP3iwss01-Jz67yjAP_JENXjWM2Bp8U=DRzxR0Q@mail.gmail.com>
 <875zaq78xq.fsf@dusky.pond.sub.org>
 <19733456-a672-595d-e721-e0ef26d7f665@amsat.org>
 <87v9iq2hkv.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <e87663cf-7cb2-ca6c-a751-e5c1cebc5440@amsat.org>
Date: Tue, 14 Jul 2020 19:16:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <87v9iq2hkv.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Qemu-block <qemu-block@nongnu.org>, Havard Skinnemoen <hskinnemoen@google.com>,
 QEMU Developers <qemu-devel@nongnu.org>, CS20 KFTing <kfting@nuvoton.com>,
 qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 IS20 Avi Fishman <Avi.Fishman@nuvoton.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/14/20 6:21 PM, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <f4bug@amsat.org> writes:
> 
>> + qemu-block experts.
>>
>> On 7/14/20 11:16 AM, Markus Armbruster wrote:
>>> Havard Skinnemoen <hskinnemoen@google.com> writes:
>>>
>>>> On Mon, Jul 13, 2020 at 7:57 AM Cédric Le Goater <clg@kaod.org> wrote:
>>>>>
>>>>> On 7/9/20 2:36 AM, Havard Skinnemoen wrote:
>>>>>> This allows these NPCM7xx-based boards to boot from a flash image, e.g.
>>>>>> one built with OpenBMC. For example like this:
>>>>>>
>>>>>> IMAGE=${OPENBMC}/build/tmp/deploy/images/gsj/image-bmc
>>>>>> qemu-system-arm -machine quanta-gsj -nographic \
>>>>>>       -bios ~/qemu/bootrom/npcm7xx_bootrom.bin \
>>>>>>       -drive file=${IMAGE},if=mtd,bus=0,unit=0,format=raw,snapshot=on
>>>>>>
>>>>>> Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
>>>>>> Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
>>>>>
>>>>> May be we don't need to create the flash object if dinfo is NULL.
>>>>
>>>> It's soldered on the board, so you can't really boot the board without
>>>> it. But if you think it's better to remove it altogether if we don't
>>>> have an image to load into it, I can do that.
>>>
>>> If a device is a fixed part of the physical board, it should be a fixed
>>> part of the virtual board, too.
>>
>> We agree so far but ... how to do it?
>>
>> I never used this API, does that makes sense?
>>
>>     if (!dinfo) {
>>         QemuOpts *opts;
>>
>>         opts = qemu_opts_create(NULL, "spi-flash", 1, &error_abort);
>>         qdict_put_str(opts, "format", "null-co");
>>         qdict_put_int(opts, BLOCK_OPT_SIZE, 64 * MiB);
>>         qdict_put_bool(opts, NULL_OPT_ZEROES, false); // XXX
>>
>>         dinfo = drive_new(opts, IF_MTD, &error_abort);
>>         qemu_opts_del(opts);
>>     }
> 
> I believe existing code special-cases "no backend" instead of making one
> up.
> 
> Example: pflash_cfi0?.c
> 
> If ->blk is non-null, we read its contents into the memory buffer and
> write updates back, else we leave it blank and don't write updates back.
> 
> Making one up could be more elegant.  To find out, you have to try.

I'd rather avoid ad-hoc code in each device. I2C EEPROM do that too,
it is a source of head aches.

From the emulation PoV I'd prefer to always use a block backend,
regardless the user provide a drive.

> 
> We make up a few default drives (i.e. drives the user doesn't specify):
> floppy, CD-ROM and SD card.  Ancient part of the user interface, uses
> DriveInfo.  I doubt we should create more of them.
> 
> I believe block backends we make up for internal use should stay away
> from DriveInfo.  Kevin, what do you think?  How would you make up a
> null-co block backend for a device's internal use?

I read 'DriveInfo' is the legacy interface, but all the code base use it
so it is confusing, I don't understand what is the correct interface to
use.

> 
>> We should probably add a public helper for that.
> 
> If we decide we want to make up backends, then yes, we should do that in
> a helper, not in each device.
> 
>> 'XXX' because NOR flashes erase content is when hardware bit
>> is set, so it would be more useful to return -1/0xff... rather
>> than zeroes.
> 
> 

