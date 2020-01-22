Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7604EC32771
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 23:29:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A56D24655
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 23:29:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SDrNlOFT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A56D24655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuPR4-0003kb-BE
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 18:29:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49692)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iuPQT-0003JN-MR
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 18:28:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iuPQR-0001Bx-Mq
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 18:28:44 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27338
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iuPQR-0001BF-Fs
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 18:28:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579735722;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tAL/NYp36LhOZuHZIGYxG6F/UGpw5zX58J0lKHxSjPs=;
 b=SDrNlOFTYx6u3zIhmb5RCLT7ZBukS5Tvi3tM5r/TahDKk8jqCtxFmWDAP1nijZWG0R4JyC
 PW8C5upqQmUw7NPO/v+zIzmOr57/aygjjzrbkJrxTvYglvNi8dKhEOM+nwc9eCtgXhTjR6
 SwBe3yO2IB08uhViTgXNEhqjyfUhu/8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-429-cTM0WH-wMPiUSRFhvrrMHA-1; Wed, 22 Jan 2020 18:28:40 -0500
Received: by mail-wr1-f70.google.com with SMTP id c6so830804wrm.18
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2020 15:28:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tAL/NYp36LhOZuHZIGYxG6F/UGpw5zX58J0lKHxSjPs=;
 b=No1IoB70JsBHTzo9f0XlMeUcTuDViZAa5EGZpYgtS2dO745jtq1UmB6GkH0tZIsdwH
 0WlXOKetpqJBiO8DfBkpkc8PsasHu8YZ63Tf33OBp31bJ2weisEO714TqJdhtkXRtQXK
 d3EMmAXyY9ciA3DgjwJUYhsRZ62IlJVBhp+g84v48GlQCHZauz/Jr3JcymtYWmW55i7j
 qDdUggkMx7EtKejjqb8nOPWlfk/bOleHu0uuVRHO9s45cCwZYXN/qD9JOYQwE2znUwxc
 4ylAoRxhRaxNXCEJPA9QdTnUaWSEHa/ch05CzeeLy4ZcdMj0mG5vXoSFc/u+29AU9qI9
 5MmA==
X-Gm-Message-State: APjAAAXcSezMubuPu01TjgpZzaQeDTD6v5sVBLR6qmUQByQOHhci6DCc
 SZ12Ogoc419TJFCx5BstzqhwlITS9NXdyClq11dJAdk3v1BkrgzxEmT9NOHVtMBs+FD6KjyYMwp
 gbFSpUxFGbD6U7a4=
X-Received: by 2002:a7b:c08d:: with SMTP id r13mr605903wmh.104.1579735719746; 
 Wed, 22 Jan 2020 15:28:39 -0800 (PST)
X-Google-Smtp-Source: APXvYqy/scKYg31dmqbA1i3IdkqJDWoPu6OpjuFMRA7tSzXtHzD/kYhm7YkvjmzeA01qF55eSneA0Q==
X-Received: by 2002:a7b:c08d:: with SMTP id r13mr605885wmh.104.1579735719439; 
 Wed, 22 Jan 2020 15:28:39 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id p17sm506412wrx.20.2020.01.22.15.28.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jan 2020 15:28:38 -0800 (PST)
Subject: Re: [PULL 00/11] target/hppa patch queue
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Sven Schnelle <svens@stackframe.org>, Helge Deller <deller@gmx.de>
References: <20200122023256.27556-1-richard.henderson@linaro.org>
 <b7c91905-f1bb-a3ea-e39c-08a27b2ff36e@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <da98d952-80e6-750a-3324-32723037b94f@redhat.com>
Date: Thu, 23 Jan 2020 00:28:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <b7c91905-f1bb-a3ea-e39c-08a27b2ff36e@linaro.org>
Content-Language: en-US
X-MC-Unique: cTM0WH-wMPiUSRFhvrrMHA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/22/20 3:47 AM, Richard Henderson wrote:
> On 1/21/20 4:32 PM, Richard Henderson wrote:
>> The following changes since commit 3e08b2b9cb64bff2b73fa9128c0e49bfcde0dd40:
>>
>>    Merge remote-tracking branch 'remotes/philmd-gitlab/tags/edk2-next-20200121' into staging (2020-01-21 15:29:25 +0000)
>>
>> are available in the Git repository at:
>>
>>    https://github.com/rth7680/qemu.git tags/pull-pa-20200121
>>
>> for you to fetch changes up to a66cfb7306b7cf7a023e11536fdd942f3f9276b9:
>>
>>    target/hppa: Allow, but diagnose, LDCW aligned only mod 4 (2020-01-21 15:51:54 -1000)
>>
>> ----------------------------------------------------------------
>> Improve LASI emulation
>> Add Artist graphics
>> Fix main memory allocation
>> Improve LDCW emulation wrt real hw
> 
> Ho hum.  Cancel this.  It breaks the hppa boot-serial test.

This is due to patch #7 "Add emulation of Artist graphics":

130     /* Graphics setup. */
131     if (machine->enable_graphics && vga_interface_type != VGA_NONE) {
132         dev = qdev_create(NULL, "artist");
133         qdev_init_nofail(dev);
134         s = SYS_BUS_DEVICE(dev);
135         sysbus_mmio_map(s, 0, LASI_GFX_HPA);
136         sysbus_mmio_map(s, 1, ARTIST_FB_ADDR);
137     }

The hppa boot-serial test use the default options, so the Artist chipset 
is mapped, and the firmware test/use it.

We can test like the 40p, using VGA_NONE:

-- >8 --
diff --git a/tests/qtest/boot-serial-test.c b/tests/qtest/boot-serial-test.c
index 05c7f44457..971254ae62 100644
--- a/tests/qtest/boot-serial-test.c
+++ b/tests/qtest/boot-serial-test.c
@@ -135,7 +135,7 @@ static testdef_t tests[] = {
        sizeof(kernel_plml605), kernel_plml605 },
      { "moxie", "moxiesim", "", "TT", sizeof(bios_moxiesim), 0, 
bios_moxiesim },
      { "arm", "raspi2", "", "TT", sizeof(bios_raspi2), 0, bios_raspi2 },
-    { "hppa", "hppa", "", "SeaBIOS wants SYSTEM HALT" },
+    { "hppa", "hppa", "-vga none", "SeaBIOS wants SYSTEM HALT" },
      { "aarch64", "virt", "-cpu cortex-a57", "TT", sizeof(kernel_aarch64),
        kernel_aarch64 },
      { "arm", "microbit", "", "T", sizeof(kernel_nrf51), kernel_nrf51 },
---

You should squash this change in patch #7 (because it belongs there) but 
please add a comment, because it is not obvious.

Thanks,

Phil.


