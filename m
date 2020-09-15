Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB04C2D0E0
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 16:28:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9687206DC
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 16:28:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EGhkSO8J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9687206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIDoT-0003Na-DB
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 12:28:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33558)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kIDmk-0002XK-JU
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 12:26:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43175)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kIDmh-0004gX-12
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 12:26:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600187182;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=r3pKTNiG/hIB104/eWK87/flb3ks6tmWJmvz1BA+RxI=;
 b=EGhkSO8Jpeb0AiTnu1JqUy6ch6fzPzIAaID5fTDE5O4s6eAq/+9znfhrmTPZCMb/GhMRxA
 x88dXm9xCmhSq99w/yd4dP6d5Pd6BDTVgajN6658eUleKVMx2loz60zHo9UYwqR6yl7oZe
 /B4SLX1SPSN/CXiBv+sqDf7rn+clbMo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-451-RCsoJbTQN4qZuMpnrv2KzQ-1; Tue, 15 Sep 2020 12:26:17 -0400
X-MC-Unique: RCsoJbTQN4qZuMpnrv2KzQ-1
Received: by mail-wm1-f69.google.com with SMTP id b14so42289wmj.3
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2020 09:26:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=r3pKTNiG/hIB104/eWK87/flb3ks6tmWJmvz1BA+RxI=;
 b=jNYrrAI8khw2Os4lXuQ58HMU50ZtTav9QUDabP+A54c3E7mQLtak6X6Mpv9L0kbyrI
 zMYps6xZYqGkp+5Rp29y4dXxP/tnj0367KWamXvAhCaWwKL2G0Zzcson7GMwlrk1458P
 xT8gOcQyJZCDXBtSORF7ttLUmMDNGGWrExc/tGjsefyhcaoYX/a/KrljBoHk3WLh2laV
 AyGv2ivyhXHH9Y9Kr5btu+6eaqL3EeoTWfKrJNs8npldrzsSAEh7ECg2PK8j/UZkgZG4
 VApXRMmefA2+JoYJiRhBE1d2lFLkqaSe5Ny5cepUtWzlHPZmtij+WZz0VoVreBzjtdSl
 qNFA==
X-Gm-Message-State: AOAM530JPpPzPX5EkKwTjSZXRCVvJiqS862fBqznWH0M3lClzim8c58W
 OihmrfO8SyZA/CCQoFdEKhu1r1jqxNfhFpVCkIUiFZ+wCElBj6+wc1aRyUFLzX+ka8sSjBaJT0Z
 hKUhts+t2VF9Thw0=
X-Received: by 2002:a5d:4bc6:: with SMTP id l6mr23658074wrt.132.1600187175742; 
 Tue, 15 Sep 2020 09:26:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxG4SDEznm9PqBUHeCwtFOynWCoEnOENzYOeSRRjD4eCTObZTGJ+8o+uFcklMjFuVvyvfO4PA==
X-Received: by 2002:a5d:4bc6:: with SMTP id l6mr23658042wrt.132.1600187175446; 
 Tue, 15 Sep 2020 09:26:15 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id 189sm209472wmb.3.2020.09.15.09.26.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Sep 2020 09:26:14 -0700 (PDT)
Subject: Re: [PATCH] pci: check bus pointer before dereference
To: Li Qiang <liq3ea@gmail.com>, P J P <ppandit@redhat.com>
References: <20200827114917.1851111-1-ppandit@redhat.com>
 <CAKXe6SJNio2cy05ecr_DyB0Z6WjxHN_X8ZiOU5By0jwdRq12fg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <b0859f8a-1224-66d0-7e32-091caa5cfcbe@redhat.com>
Date: Tue, 15 Sep 2020 18:26:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAKXe6SJNio2cy05ecr_DyB0Z6WjxHN_X8ZiOU5By0jwdRq12fg@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 02:10:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Prasad J Pandit <pjp@fedoraproject.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Alexander Bulekov <alxndr@bu.edu>,
 Ruhr-University <bugs-syssec@rub.de>, Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+Igor

On 9/15/20 3:51 PM, Li Qiang wrote:
> P J P <ppandit@redhat.com> 于2020年8月27日周四 下午7:52写道：
>>
>> From: Prasad J Pandit <pjp@fedoraproject.org>
>>
>> While mapping IRQ level in pci_change_irq_level() routine,
>> it does not check if pci_get_bus() returned a valid pointer.
>> It may lead to a NULL pointer dereference issue. Add check to
>> avoid it.
>>
>>  -> https://ruhr-uni-bochum.sciebo.de/s/NNWP2GfwzYKeKwE?path=%2Flsi_nullptr1
>>     ==1183858==Hint: address points to the zero page.
>>     #0 pci_change_irq_level hw/pci/pci.c:259
>>     #1 pci_irq_handler hw/pci/pci.c:1445
>>     #2 pci_set_irq hw/pci/pci.c:1463
>>     #3 lsi_set_irq hw/scsi/lsi53c895a.c:488
>>     #4 lsi_update_irq hw/scsi/lsi53c895a.c:523
>>     #5 lsi_script_scsi_interrupt hw/scsi/lsi53c895a.c:554
>>     #6 lsi_execute_script hw/scsi/lsi53c895a.c:1149
>>     #7 lsi_reg_writeb hw/scsi/lsi53c895a.c:1984
>>     #8 lsi_io_write hw/scsi/lsi53c895a.c:2146
>>     ...
>>
>> Reported-by: Ruhr-University <bugs-syssec@rub.de>
>> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
>> ---
>>  hw/pci/pci.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>> index de0fae10ab..df5a2c3294 100644
>> --- a/hw/pci/pci.c
>> +++ b/hw/pci/pci.c
>> @@ -253,6 +253,9 @@ static void pci_change_irq_level(PCIDevice *pci_dev, int irq_num, int change)
>>      PCIBus *bus;
>>      for (;;) {
>>          bus = pci_get_bus(pci_dev);
>> +        if (!bus) {
> 
> Hi Prasad,
> 
> I think in normal this 'bus' will be not NULL.
> I have look at the link in the commit msg.
> I find it is another DMA to MMIO issue which we have discussed a lot
> but didn't come up with an
> satisfying solution.
> 
> Maybe we can try to the DMA to MMIO issue direction.
> CC: Peter, Jason and Alex
> 
> Thanks,
> Li Qiang
> 
> 
>> +            return;

Nack, this should be an abort().

As usual, question is how we got here.

As Li said, it is another DMA to MMIO bug class.

lsi_execute_script
 -> address_space_write
    -> acpi_pcihp_eject_slot
       -> bus_remove_child

So at this point the PCI device is still MMIO-mapped
but eject from the bus... ???
Then IRQ is triggered, which the device wants to
propagate via its PCI bus but it doesn't have any more
and b00m.

If a device is hotpluggable, who is responsible to
unmap its regions?

>> +        }
>>          irq_num = bus->map_irq(pci_dev, irq_num);
>>          if (bus->set_irq)
>>              break;
>> --
>> 2.26.2
>>
>>
> 


