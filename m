Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81FC9C4321A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 10:21:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09CE6205F4
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 10:21:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ezn4nXgO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09CE6205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55804 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hadtq-0008R5-1x
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 06:21:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58445)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <marcel.apfelbaum@gmail.com>) id 1hadsH-0007Yu-3L
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 06:19:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcel.apfelbaum@gmail.com>) id 1hadsG-0002zS-4r
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 06:19:29 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:33962)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
 id 1hadsF-0002yB-Ry
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 06:19:28 -0400
Received: by mail-wr1-x441.google.com with SMTP id e16so12400314wrn.1
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2019 03:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=snyIExSKOjN/1+I17Cy0DqLU67RsH6ImvYuPuDqWBmA=;
 b=Ezn4nXgONt325TIvT/Iwk0ayYj9KHTVIj0I1jX/OQVnnkg7FhSa4GDbMWbKYHf7f0n
 XJlQkLz2cvHLRQa045DMXz7Crc0c94nhfvUxAjDieONMQYUL1RdS0cCuEBAAUAr1oXI5
 Wk9Z7+66+KIs+mB4Fw1Hf6ko4FldybaweZ0zncENzDEgd9wrJMChHvb4LzmkxgF/LpHR
 9CJiRxVYYluh586lj1eMQSSz3qPj+WuD/ocy6GEL2SmmFrqc6QMoJ8BT6lSN2kOP4hga
 GdYm+AIL3gi9lujEem3ZxF/OEGGFNHIO2F/9mNWj4bxW3zG+Dj+a5vEgNbbDkVDnPbI1
 u9cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=snyIExSKOjN/1+I17Cy0DqLU67RsH6ImvYuPuDqWBmA=;
 b=qvsL4OPb8jwrTJBn7W+QBpQ+em9wJCOPOQET0YWib7IwZksCMsTW3QfxBWHjqEs4xW
 XvN7rXL2UxL/qicMkgaFoGd9UxdxZwBjPm95eH6fu8BPeDGMBd313SuXRD/e1nvI8vA8
 DHwKaf8yEaC1KcXpCBrxayIxO80LJGMfJn++O+DFRrpKzo3ohyN0H9e1+khnaauw/Vzv
 g0nT9+qQF85Q7Y5AxlmKncOv8Tz+REUfYjKQzAx+Xw0Tz3qrl0nxlWtejjFPB2uCHm1Q
 ubDkUsRvlLoO0iC0TgyTPnB226YjmyM6/8RcvbNQScnAgIK9fqM3SzfYt+co9H7pL7wB
 QBiw==
X-Gm-Message-State: APjAAAWOCCSBvrcd4OlQcrm5YSxNugQl70gUbdLMNGAhDoEw5LLcoIfs
 gPduTksRt+/f7EuBF3c+RFID3PIV
X-Google-Smtp-Source: APXvYqxzcHh+A1f48oZQrzhp31K6fRwaftwhdL3veeeiCvQqcdQAnGuVzUB0CKy58rND/RGGnz2dMw==
X-Received: by 2002:a5d:5702:: with SMTP id a2mr4521203wrv.89.1560248366118;
 Tue, 11 Jun 2019 03:19:26 -0700 (PDT)
Received: from localhost.localdomain ([37.142.144.27])
 by smtp.gmail.com with ESMTPSA id t15sm5442368wrx.84.2019.06.11.03.19.25
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 11 Jun 2019 03:19:25 -0700 (PDT)
To: Kashyap Chamarthy <kchamart@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20190606161943.GA9657@paraplu>
 <20190606141904-mutt-send-email-mst@kernel.org>
 <20190611072100.GM2725@paraplu>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <199bd9e0-86c6-4ee3-7f00-1a2fe3ff7501@gmail.com>
Date: Tue, 11 Jun 2019 13:19:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190611072100.GM2725@paraplu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: Re: [Qemu-devel] PCI(e): Documentation "io-reserve" and related
 properties?
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



On 6/11/19 10:21 AM, Kashyap Chamarthy wrote:
> On Thu, Jun 06, 2019 at 02:20:18PM -0400, Michael S. Tsirkin wrote:
>> On Thu, Jun 06, 2019 at 06:19:43PM +0200, Kashyap Chamarthy wrote:
>>> Hi folks,
>>>
>>> Today I learnt about some obscure PCIe-related properties, in context of
>>> the adding PCIe root ports to a guest, namely:
>>>
>>>      io-reserve
>>>      mem-reserve
>>>      bus-reserve
>>>      pref32-reserve
>>>      pref64-reserve
>>>
>>> Unfortunately, the commit[*] that added them provided no documentation
>>> whatsover.
>>>
>>> In my scenario, I was specifically wondering about what does
>>> "io-reserve" mean, in what context to use it, etc.  (But documentation
>>> about other properties is also welcome.)
>>>
>>> Anyone more well-versed in this area care to shed some light?
>>>
>>>
>>> [*] 6755e618d0 (hw/pci: add PCI resource reserve capability to legacy
>>>      PCI bridge, 2018-08-21)
>> So normally bios would reserve just enough io space to satisfy all
>> devices behind a bridge. What if you intend to hotplug more devices?
>> These properties allow you to ask bios to reserve extra space.
> Thanks.  Would be useful to have them documented in the official QEMU
> command-line documentation.  Otherwise, they will remain as arcane
> properties that barely anyone knows about.
>

There is some documentation under qemu/docs/pcie_pci_bridge.txt.
I agree there is always room for QEMU cmd-line improvement.

Thanks,
Marcel





