Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E12CC54EEB
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 15:29:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D18E20753
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 15:29:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HKcl46Hj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D18E20753
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGP0r-000717-BJ
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 11:29:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52019)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jGP00-0005oK-9G
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 11:28:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jGOzz-00070A-16
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 11:28:20 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:34194)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jGOzy-0006zz-RW
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 11:28:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584977298;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BntG3GWR9ZyH5ldrAwnb5UCluP5O51/lpae053bzMC8=;
 b=HKcl46HjBEjNTrQC3QAhvpvv5CaR1C6aW7qxf4LVUilQmhHiggxz8yaOME7WEKAVnSJVUz
 1pug6qFf993/a9GIdB1hX2j1/eT587EZvHXsqlR1mWqfD/Mp3WbpfPAPVf/XR+2NrjJMDX
 gYGqrhyWDjeTo8EY9zdW0WO+yjuwofg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-rXK0qMnrPQezd64CZ1W1Cg-1; Mon, 23 Mar 2020 11:28:16 -0400
X-MC-Unique: rXK0qMnrPQezd64CZ1W1Cg-1
Received: by mail-wm1-f69.google.com with SMTP id f207so3685244wme.6
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2020 08:28:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BntG3GWR9ZyH5ldrAwnb5UCluP5O51/lpae053bzMC8=;
 b=PoBvQDqd0sHvmjBohQsv7ANEPpUfUPIozosODodhlLexNHq82dAV4urHYi1pubLoHs
 1zYDz6u3T52sLGXr26cvI0FVfiXyjFJCpM0Md8BMUWmltqBqX61eF61U5xRzLdrSkfWI
 E1pp8nrBz5GTmvzgfkPdTnyg98JBkcgUi5q55YCAHVXXjz4H/2d5dEs5Z/eTBUIjPeQE
 RZNI/zgTl157wpIFIdAjDO9O1u76GkFES3gF/ziLdVt+T6hZ9FRYSUz//lu5tTnQYBN/
 OV5GEfGRkd77yoDxgSIpZRw3jAU3xwHzY5NG5bR7LuYl877dec+0RlHkMeaeusfRwxfO
 hCpg==
X-Gm-Message-State: ANhLgQ1hogb4qeR8BcqgnyMoJ+mgyulQ/89w9IJdxCxbQbEaj/ZYz/m3
 BI4I4gCmqhWsUt2PEqxcpf3dP0g/80Gl2og3UZYhHXQ1KeMA7Qe8UmsXycxND8SNLl6b/rTM7ap
 7TTuGom8ppKUuXYM=
X-Received: by 2002:a5d:640a:: with SMTP id z10mr32453578wru.301.1584977295628; 
 Mon, 23 Mar 2020 08:28:15 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtcXTdFPtLfyD42y8rSIKXj8HzRDpukcNpnIYG0ApE3sCxyghBd38DaURCtrVzo5K7bpAYQmA==
X-Received: by 2002:a5d:640a:: with SMTP id z10mr32453542wru.301.1584977295424; 
 Mon, 23 Mar 2020 08:28:15 -0700 (PDT)
Received: from [192.168.1.35] (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id f22sm418786wmf.2.2020.03.23.08.28.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Mar 2020 08:28:14 -0700 (PDT)
Subject: Re: Coverity CID 1421984
To: Peter Maydell <peter.maydell@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>
References: <d9b7d8d8-1640-7d69-cd16-66e6d9cef3d1@redhat.com>
 <88618db3-cb48-12bd-6152-b642b25a0287@redhat.com>
 <alpine.BSF.2.22.395.2003231359420.14974@zero.eik.bme.hu>
 <CAFEAcA9+WPxGYqk5_-v=oXPK=UcvngXGaOLY3njM5iNN2CFh2g@mail.gmail.com>
 <alpine.BSF.2.22.395.2003231459410.34482@zero.eik.bme.hu>
 <CAFEAcA9Ubue9Lk2jXJyZ+OUmk0j58ZKKnER1RxMi0b05FaN4QQ@mail.gmail.com>
 <alpine.BSF.2.22.395.2003231539160.47226@zero.eik.bme.hu>
 <CAFEAcA_R1i2L5Vgmq1frGbQQxggLtEfMwHa8V=+K2Wje2mkVVA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b78b7d6d-de20-6997-7d2a-ba19b850f30e@redhat.com>
Date: Mon, 23 Mar 2020 16:28:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_R1i2L5Vgmq1frGbQQxggLtEfMwHa8V=+K2Wje2mkVVA@mail.gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Qemu-block <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 qemu-ppc <qemu-ppc@nongnu.org>, John Snow <jsnow@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/23/20 3:46 PM, Peter Maydell wrote:
> On Mon, 23 Mar 2020 at 14:43, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>>
>> On Mon, 23 Mar 2020, Peter Maydell wrote:
>>> On Mon, 23 Mar 2020 at 14:06, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>>>> On Mon, 23 Mar 2020, Peter Maydell wrote:
>>>>> Coverity has flagged up a lot of leaks involving qemu_allocate_irqs();
>>>>> most of them I've for the moment just set as "insignificant, fix
>>>>> required" because they're in called-once functions like board init.
>>>>> If this device can't be hot-unplugged and so we will only ever call
>>>>> realize once, it would fall in that category too. Otherwise I'd
>>>>> suggest conversion to qdev_init_gpio_in(). (This allocates arrays
>>>>> of IRQs under the hood too, but the device_finalize() function will
>>>>> automatically free them for you, so it's easier to use non-leakily.)
>>>>
>>>> I think I can't do that in sii3112 becuase I need to pass irq to this func:
>>>>
>>>> void ide_init2(IDEBus *bus, qemu_irq irq);
>>>
>>> ide_init2(bus, qdev_get_gpio_in(DEVICE(dev), i);
>>>
>>> should do what you want, I think.
>>
>> I don't understand what you mean.
> 
> I mean that if you allocate the IRQs with qdev_init_gpio_in()
> then the way to get a qemu_irq from within them to pass
> to another function is to call qdev_get_gpio_in(). So you
> just want to make your call to ide_init2() be the line I
> suggest above.

I understand Zoltan can have hard time understanding qdev_get_gpio_in() 
because it has no documentation. What would be the best example to follow?

> 
>> Sent a patch that I think might fix this
>> warning for now. I'd leave qdevifying ide code to someone else.
> 
> There's no need to qdevify IDE for this.
> 
> thanks
> -- PMM
> 


