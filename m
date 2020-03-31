Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D78E6C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 11:17:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6280120772
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 11:17:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hyloNP6S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6280120772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJEtn-0004JD-Ht
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 07:17:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55839)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jJEsw-0003eQ-ER
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 07:16:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jJEsu-0008US-RK
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 07:16:46 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:29570)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jJEsS-00089N-T4
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 07:16:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585653376;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4r0EFvc2FgJvXtdQ3jfwJ4GHZxeAjgZkmvPaf6mo11A=;
 b=hyloNP6Sncs8nRVZ0eBoMACF/53i1AOnnnsswobSEcO3QFyFX+gQ9/UIF9HTQxK5+2pe9L
 rMQATN2bKxRVrfmx4UW4H3aeVxrWvtsNi6s1IQsH6Ch3LLfDjAkjFpX0OnARz0AAOrFWgF
 1F9qjMDw+NBsESMLOi5yg4xPVFIp1UU=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-Pfy1gsRfNcO8R-HYOTw-RQ-1; Tue, 31 Mar 2020 07:15:53 -0400
X-MC-Unique: Pfy1gsRfNcO8R-HYOTw-RQ-1
Received: by mail-ed1-f69.google.com with SMTP id q29so7710980edc.1
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2020 04:15:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4r0EFvc2FgJvXtdQ3jfwJ4GHZxeAjgZkmvPaf6mo11A=;
 b=hhbT8fIYEhxLZrMmmAqxYqa7C8D99nkBVfkG3Fi3Rt1nGeaWHSrouJC7kfZ6RiOo5V
 /MAdzEZj/nGQgpYrnHiTuaCHXvgNpQ4IBCWluCv09aLgY/BrmBMhnJiznj2IobdNotV5
 2/THewlHipVPU71sp972PIwZ7P+T1Xg58qA3AiY8fCto9m4pyQ79aZ2mRhfhIJSCkgmT
 ISrogPeLhrJcYZJcqaULHJAci0nSNhNBY2QT6qlssSnPgTi2kYKOWVqrLconvgxUcWHT
 JgGanDN6xoyCWELO3U7hzAW5OYZacOabGSJjVFy9DQd6WP7JqhLXaY74iMTB6344j93d
 O6nQ==
X-Gm-Message-State: ANhLgQ0uHfUlT9Q+EX+6gYMgvKf9DmMX6RmrOrBfSw1AqNHH6uUzKRtc
 xnL+I+zYGCnwik3yqVnVVCdhWd48vzMk9/N9Th2NRr40H6+bJvJESsnkWCGZ/wfGfs3xz92l4od
 K9nV3saj+j8m+hh8=
X-Received: by 2002:aa7:c681:: with SMTP id n1mr15821788edq.83.1585653352307; 
 Tue, 31 Mar 2020 04:15:52 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvDntgm1WmozWqr2NvQu5d3ljOcaxQ3XukVVrRWTYlRwM1hV5YJ+Lk4pFZ9Lau8bMBwWi6E6A==
X-Received: by 2002:aa7:c681:: with SMTP id n1mr15821767edq.83.1585653352104; 
 Tue, 31 Mar 2020 04:15:52 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id z22sm2229828edl.6.2020.03.31.04.15.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Mar 2020 04:15:51 -0700 (PDT)
Subject: Re: [PATCH v2 0/6] dwc-hsotg (aka dwc2) USB host controller emulation
To: Gerd Hoffmann <kraxel@redhat.com>, Paul Zimmerman <pauldzim@gmail.com>
References: <20200329001705.15966-1-pauldzim@gmail.com>
 <20200331092831.4s2smc4wtbslzirw@sirius.home.kraxel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8e9e419c-9249-1070-bbc7-d927ca69fda5@redhat.com>
Date: Tue, 31 Mar 2020 13:15:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200331092831.4s2smc4wtbslzirw@sirius.home.kraxel.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/31/20 11:28 AM, Gerd Hoffmann wrote:
> On Sat, Mar 28, 2020 at 05:16:59PM -0700, Paul Zimmerman wrote:
>> This patch series adds emulation for the dwc-hsotg USB controller,
>> which is used on the Raspberry Pi 3 and earlier, as well as a number
>> of other development boards. The main benefit for Raspberry Pi is that
>> this enables networking on these boards, since the network adapter is
>> attached via USB.
>>
>> The emulation is working quite well, I have tested with USB network,
>> mass storage, mouse, keyboard, and tablet. I have tested with the dwc2
>> driver in the upstream Linux kernel, and with the dwc-otg driver in the
>> Raspbian kernel. One remaining issue is that USB redirection does not
>> work, I tried connecting to a USB stick on the host, but the device
>> generates babble errors and does not work. I will continue to work on
>> this issue.
>>
>> The patch series also includes a very basic emulation of the MPHI
>> device on the Raspberry Pi SOC, which provides the FIQ interrupt that
>> is used by the dwc-otg driver in the Raspbian kernel. But that driver
>> still does not work in full FIQ mode, so it is necessary to add a
>> parameter to the kernel command line ("dwc_otg.fiq_fsm_enable=0") to
>> make it work.
>>
>> I have used some on-line sources of information while developing
>> this emulation, including:
>>
>> http://www.capital-micro.com/PDF/CME-M7_Family_User_Guide_EN.pdf
>> has a pretty complete description of the controller starting on
>> page 370.
>>
>> https://sourceforge.net/p/wive-ng/wive-ng-mt/ci/master/tree/docs/DataSheets/RT3050_5x_V2.0_081408_0902.pdf
>> has a description of the controller registers starting on page
>> 130.
>>
>> Changes from v1:
>>    - Fixed checkpatch errors/warnings, except for dwc2-regs.h since
>>      that is a direct import from the Linux kernel.
>>    - Switched from debug printfs to tracepoints in hcd-dwc2.c, on the
>>      advice of Gerd. I just dropped the debug prints in bcm2835_mphi.c,
>>      since I didn't consider them very useful.
>>    - Updated a couple of the commit messages with more info.
>>
>> Thanks for your time,
>> Paul
> 
> Looks good to me.  We are in 5.0 freeze now though, so this has to wait
> until the tree is open for 5.1 development.

Plenty of time to complete this series with an acceptance test using 
your device :)

As a starting point you can look at do_test_arm_raspi2() in 
tests/acceptance/boot_linux_console.py.

Regards,

Phil.


