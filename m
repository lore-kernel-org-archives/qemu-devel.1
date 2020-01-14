Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5905C33CB1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 12:40:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3B532072B
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 12:40:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O0F0JVxO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3B532072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irLVC-0006nE-Na
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 07:40:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37699)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1irLU1-0005sY-E1
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 07:39:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1irLTw-0005Lq-9k
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 07:39:43 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51661
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1irLTv-0005LR-MP
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 07:39:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579005578;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WHxsSZ7FPz3Cp10bTW+jzFzXUqkgWE3Dz8eyyBWHPg8=;
 b=O0F0JVxOqsGBDjrHZW4/NkenebZZXVtNgnp3uUq5WaUGH1XhbHgDKTNXoGOCP6PEhGMXG0
 R//ycj9kNayJkfQn3XS/X/d1K+egKSCwQ52IORz4f2OeJddK8RBXBGSeuMq0+g550YaFa9
 y3hQyGvwgddPFXRun0rO2hKTJjuy5NY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-375-relHUCy-PV2R6tNgk4HXEg-1; Tue, 14 Jan 2020 07:39:37 -0500
Received: by mail-wr1-f72.google.com with SMTP id y7so6452389wrm.3
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2020 04:39:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WHxsSZ7FPz3Cp10bTW+jzFzXUqkgWE3Dz8eyyBWHPg8=;
 b=CbNCXPmpvKf3idof883e22sjBRnRdVjMVv0mAktXnB5MueJljGBlAqa9cctpf2GR2t
 RzoaXGBXKuugOdfZ2BwDAeGigsEhfTUR1hiC+IRpmbgYolJ2ws2HyaI5F2G8i5qayo+X
 TGmJXiiQwRCU02Nty/FAXGGjS4kDwZf9mPDQMWmiK6fsgL5Tkj9wDQ+ur/4K3TfuvMvD
 2JLBHAH99PxvTX03+vSmIaqlr/XP2ORPKCdYP3wbQz6+knQqrFg9gCrmAzr5Dcgl9JLG
 Qtkzh6orqoCBh3uVGWu0OUPZkrQkDR395G4UGzHSKU3hsb/yVyOqgVW8+4Q3DzEiZNE+
 2Gwg==
X-Gm-Message-State: APjAAAXFZDpuyBR8J1gE9RMj1ItSUZTjmVY+ySRWGNPk78wUrr+1VyBe
 24mpoAJ2LYa4IWklbQyhWnYTLmaCCvWN8WzWkuH+WpRUumUuFzEwg/Dtl4hh8ziKWuTs22kyFhX
 fGDy45S3mfm6yiYI=
X-Received: by 2002:adf:fac1:: with SMTP id a1mr24054414wrs.376.1579005575645; 
 Tue, 14 Jan 2020 04:39:35 -0800 (PST)
X-Google-Smtp-Source: APXvYqzje165lC6AIzDNSjUyzfre24VskqFQfrJ1bzkMc/VjMS7Q8FIMAkAR5AwSAz/tyrCrNdmH6g==
X-Received: by 2002:adf:fac1:: with SMTP id a1mr24054386wrs.376.1579005575234; 
 Tue, 14 Jan 2020 04:39:35 -0800 (PST)
Received: from [10.0.1.197] (lfbn-mon-1-1103-34.w90-48.abo.wanadoo.fr.
 [90.48.206.34])
 by smtp.gmail.com with ESMTPSA id l6sm19252494wmf.21.2020.01.14.04.39.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jan 2020 04:39:34 -0800 (PST)
Subject: Re: [PATCH 00/12] linux-user: Add support for real time clock and
To: Filip Bozuta <Filip.Bozuta@rt-rk.com>, qemu-devel@nongnu.org
References: <1578574763-8327-1-git-send-email-Filip.Bozuta@rt-rk.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <399810c6-e1a8-463b-b762-afc8837517d4@redhat.com>
Date: Tue, 14 Jan 2020 13:39:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1578574763-8327-1-git-send-email-Filip.Bozuta@rt-rk.com>
Content-Language: en-US
X-MC-Unique: relHUCy-PV2R6tNgk4HXEg-1
X-Mimecast-Spam-Score: 0
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
Cc: riku.voipio@iki.fi, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Filip,

This is v5.

On 1/9/20 1:59 PM, Filip Bozuta wrote:
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> This series covers following RTC and sound timer ioctls:
> 
>    RTC ioctls(22):
> 
>      * RTC_AIE_ON          * RTC_ALM_SET         * RTC_WKALM_SET
>      * RTC_AIE_OFF         * RTC_ALM_READ        * RTC_WKALM_RD
>      * RTC_UIE_ON          * RTC_RD_TIME         * RTC_PLL_GET
>      * RTC_UIE_OFF         * RTC_SET_TIME        * RTC_PLL_SET
>      * RTC_PIE_ON          * RTC_IRQP_READ       * RTC_VL_READ
>      * RTC_PIE_OFF         * RTC_IRQP_SET        * RTC_VL_CLR
>      * RTC_WIE_ON          * RTC_EPOCH_READ
>      * RTC_WIE_OFF         * RTC_EPOCH_SET
> 
>    Sound timer ioctls(14):
> 
>      * SNDRV_TIMER_IOCTL_PVERSION          * SNDRV_TIMER_IOCTL_INFO
>      * SNDRV_TIMER_IOCTL_NEXT_DEVICE       * SNDRV_TIMER_IOCTL_PARAMS
>      * SNDRV_TIMER_IOCTL_TREAD             * SNDRV_TIMER_IOCTL_STATUS
>      * SNDRV_TIMER_IOCTL_GINFO             * SNDRV_TIMER_IOCTL_START
>      * SNDRV_TIMER_IOCTL_GPARAMS           * SNDRV_TIMER_IOCTL_STOP
>      * SNDRV_TIMER_IOCTL_GSTATUS           * SNDRV_TIMER_IOCTL_CONTINUE
>      * SNDRV_TIMER_IOCTL_SELECT            * SNDRV_TIMER_IOCTL_PAUSE
> 
> The functionalities of individual ioctls were described in this series
> patch commit messages.
> 
> Testing method for RTC ioctls:
> 
>      Mini test programs were written for each ioctl. Those programs were
>      compiled (sometimes using cross-compilers) for the following
>      architectures:
> 
>          * Intel 64-bit (little endian)
>          * Power pc 32-bit (big endian)
>          * Power pc 64-bit (big endian)
> 
>      The corresponding native programs were executed without using
>      QEMU on following hosts:
> 
>          * Intel Core i7-4790K (x86_64 host)
>          * Power 7447A (ppc32 host)
> 
>      All applicable compiled programs were in turn executed through QEMU
>      and the results obtained were the same ones gotten for native
>      execution.
> 
>      Example of a test program:
> 
>          For ioctl RTC_RD_TIME the following test program was used:
> 
>          #include <stdio.h>
>          #include <stdlib.h>
>          #include <linux/rtc.h>
>          #include <fcntl.h>
>          #include <linux/input.h>
>          #include <sys/types.h>
>          #include <unistd.h>
> 
>          #define ERROR -1
> 
>          int main()
>          {
> 
>              int fd = open("/dev/rtc", O_RDWR | O_NONBLOCK);
> 
>              if(fd == ERROR)
>              {
>                  perror("open");
>                  return -1;
>              }
> 
>              struct rtc_time cur_time;
> 
>              if(ioctl(fd, RTC_RD_TIME, &cur_time) < 0)
>              {
>                  perror("ioctl");
>                  return -1;
>              }
> 
>              printf("Second: %d, Minute: %d, Hour: %d, Day: %d, Month: %d, Year: %d,",
>                  cur_time.tm_sec, cur_time.tm_min, cur_time.tm_hour,
>                  cur_time.tm_mday, cur_time.tm_mon, cur_time.tm_year);
> 
>              return 0;
>          }
> 
>      Limitations of testing:
> 
>          The test host pc that was used for testing (intel pc) has RTC
>          that doesn't support all RTC features that are accessible
>          through ioctls. This means that testing can't discover
>          functionality errors related to the third argument of ioctls
>          that are used for features which are not supported. For example,
>          running the test program for ioctl RTC_EPOCH_READ gives
>          the error output: inappropriate ioctl for device. As expected,
>          the same output was obtained through QEMU which means that this
>          ioctl is recognized in QEMU but doesn't really do anything
>          because it is not supported in the host computer's RTC.
> 
>          Conclusion: Some RTC ioctls need to be tested on computers
>          that support their functionalities so that it can be inferred
>          that they are really supported in QEMU. In absence of such
>          test hosts, the specifications of those ioctls need to be
>          carefully checked manually and the implementations should be
>          updated accordingly.

We should be able to check if the host supports these features and run 
your different tests.
Can you add them in the repository? Maybe under tests/tcg/multiarch/.

> Testing method for sound timer ioctls:
> 
>      The alsa ioctl test suite, that can be found on github
>      ("https://github.com/alsa-project/alsa-utils"), was used the test
>      the implemented ioctls. The file "timer.c", located in this test
>      suite, contains test functions that are used to test alsa timer
>      ioctls. This file was compiled (sometimes using cross-compilers)
>      for the following architectures:
> 
>          * Intel 64-bit (little endian)
>          * Power pc 32-bit (big endian)
>          * Power pc 64-bit (big endian)
> 
>      The corresponding compiled test files were executed without using
>      QEMU on following hosts:
> 
>          * Intel Core i7-4790K (x86_64 host)
>          * Power 7447A (ppc32 host)
> 
>      The corresponding native compiled test files were executed without using
>      QEMU on following hosts:
> 
>          * Intel Core i7-4790K (x86_64 host)
>          * Power 7447A (ppc32 host)
> 
>      All compiled test files were in turn executed through QEMU
>      and the results obtained were the same ones gotten for native
>      execution.
> 
>      Also, mini test programs were written to test further functionalities
>      of individual ioctls. Those programs were, like the file "timer.c",
>      compiled for different architectures and were executed both natively
>      and thgrough QEMU to compare the results.
> 
>      Example of a test program:
> 
>          For ioctl SNDRV_TIMER_IOCTL_GINFO the following test program was used:
> 
>          #include <stdio.h>
>          #include <stdlib.h>
>          #include <sys/types.h>
>          #include <fcntl.h>
>          #include <sys/ioctl.h>
>          #include <sound/asound.h>
> 
>          #define ERROR -1
> 
>          int main()
>          {
>              int fd = open("/dev/snd/timer", O_RDWR);
> 
>              if(fd == ERROR)
>              {
>                  perror("open");
>                  return -1;
>              }
> 
>              struct snd_timer_id id = {SNDRV_TIMER_CLASS_GLOBAL,
>                                        SNDRV_TIMER_SCLASS_NONE, -1,
>                                        SNDRV_TIMER_GLOBAL_SYSTEM, 0};
> 
>              struct snd_timer_ginfo ginfo;
>              ginfo.tid = id;
> 
>              if(ioctl(fd, SNDRV_TIMER_IOCTL_GINFO, &ginfo) == ERROR)
>              {
>                  perror("ioctl");
>                  return -1;
>              }
> 
>              printf("flags: %u\n", ginfo.flags);
>              printf("card: %d\n", ginfo.card);
>              printf("id: %s\n", ginfo.id);
>              printf("name: %s\n", ginfo.name);
>              printf("reserved0: %lu\n", ginfo.reserved0);
>              printf("resolution: %lu\n", ginfo.resolution);
>              printf("resolution_min: %lu\n", ginfo.resolution_min);
>              printf("reolution_max: %lu\n", ginfo.resolution_max);
>              printf("clients: %u\n", ginfo.clients);
>              printf("reserved: %s\n", ginfo.reserved);
> 
>              return 0;
>          }
> 
> v5:
> 
>      * added support for alsa sound timer ioctls
> 
> v4:
> 
>      * changed patch descriptions so that they are better
>        formatted and more cemprehensible
> 
> v3:
> 
>      * changed two instances of MK_PTR(TYPE_ULONG) to TYPE_ULONG
> 
> v2:
> 
>      * added description of each ioctl in patches
>      * wrote a more detailed cover letter with description of testing
>      * changed one instance of TYPE_INT to MK_PTR(TYPE_INT)
> 
> 
> Filip Bozuta (12):
>    linux-user: Add support for enabling/disabling RTC features using
>      ioctls
>    linux-user: Add support for getting/setting RTC time and alarm using
>      ioctls
>    linux-user: Add support for getting/setting RTC periodic interrupt and
>      epoch using ioctls
>    linux-user: Add support for getting/setting RTC wakeup alarm using
>      ioctls
>    linux-user: Add support for getting/setting RTC PLL correction using
>      ioctls
>    linux-user: Add support for read/clear RTC voltage low detector using
>      ioctls
>    linux-user: Add support for getting alsa timer version and id
>    linux-user: Add support for setting alsa timer enhanced read using
>      ioctl
>    linux-user: Add support for getting/setting specified alsa timer
>      parameters using ioctls
>    linux-user: Add support for selecting alsa timer using ioctl
>    linux-user: Add support for getting/setting selected alsa timer
>      parameters using ioctls
>    linux-user: Add support for selected alsa timer instructions using
>      ioctls
> 
>   linux-user/ioctls.h        |  45 +++++++++++++++++
>   linux-user/syscall.c       |   2 +
>   linux-user/syscall_defs.h  | 121 +++++++++++++++++++++++++++++++++++++++++++++
>   linux-user/syscall_types.h |  91 ++++++++++++++++++++++++++++++++++
>   4 files changed, 259 insertions(+)
> 


