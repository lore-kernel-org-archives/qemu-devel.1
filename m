Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 662DAC433E1
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 06:09:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 340BB2072E
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 06:09:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EWSYwyXX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 340BB2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgj4T-0006dz-B2
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 02:09:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36956)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jgj2q-0005ll-Dt
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 02:08:04 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:53764
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jgj2o-0001ra-De
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 02:08:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591250880;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=wojn8eITTgy1cuO3BUYuxJeW0pjtVSY/eL3hBpA0tns=;
 b=EWSYwyXXUzWl0ByWYIrBl9TAw4qUr9rmthYr/1WS6pFTBFOg/xT0YuSi8lHWQOLNfUy2Ip
 mXyLcAcMVqh188Zyt2d3ErpbHbtpuJG6N1cqx53+1IGLAAN3MRZcMMghnP/mJBU1XgL0AC
 JkTZgq97F2+6Wj4+yY18YiYVHzU+M1I=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-422-kBBW8EGwPUeQxIkkoWKC7A-1; Thu, 04 Jun 2020 02:07:56 -0400
X-MC-Unique: kBBW8EGwPUeQxIkkoWKC7A-1
Received: by mail-wr1-f70.google.com with SMTP id l18so1996080wrm.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2020 23:07:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=wojn8eITTgy1cuO3BUYuxJeW0pjtVSY/eL3hBpA0tns=;
 b=k8aVrqY8nm1RL2dXAVk/yXXjKJvcha3oA9GYYI/csoDXeAyAtdJOSZjRyxjo5eHAPL
 vGBz/oQnRmpV+8nqknXIx8UtsFyN8Ss47RDsQOhR8QBTr4prfu/HNEKHt1az3ghk49l1
 pwjl3ktTlVArMYXU9WsqEK6538mX4Si2Yo+gJK3l2HAFxq4nIA/Yq/UAVVYUNuo51qum
 UbutPYoaurE5JmgpsqRoof7LANYBCsVyIjLk1bCSNkv6aAWTk13o6lKmAujg6vGJyL40
 7ABKWqZjG3lFJ2QgsAY+0XkbB81dhoK0605SkmshqIV/LmUP7/Edgfbmb+gAHJ3vFZcD
 bJjg==
X-Gm-Message-State: AOAM5320W+HqttQxqaE0CoW5FBAIeedN9p5RX6kXxFfcP6OnXTvY8bDN
 QgMw/qJ0lv6N6/By0iJfFMTQ5uYi1AIYDnx8n8W/Yscdldlv3Ykb1DSy/OsrhOamEGsAJEsLJko
 xcicUToA81eRFP3M=
X-Received: by 2002:adf:ed51:: with SMTP id u17mr2532737wro.285.1591250875394; 
 Wed, 03 Jun 2020 23:07:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzqj2W5+u+tCO6rsF6aicuyXSIz5maz9cNiiW0kI4sG0VMGXlzXR+2eet317oQwpHVFvkoKrw==
X-Received: by 2002:adf:ed51:: with SMTP id u17mr2532714wro.285.1591250875083; 
 Wed, 03 Jun 2020 23:07:55 -0700 (PDT)
Received: from [192.168.1.43] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id e15sm6025145wme.9.2020.06.03.23.07.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jun 2020 23:07:54 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] pci: ensure configuration access is within bounds
To: BALATON Zoltan <balaton@eik.bme.hu>, P J P <ppandit@redhat.com>
References: <20200603202251.1199170-1-ppandit@redhat.com>
 <20200603202251.1199170-3-ppandit@redhat.com>
 <alpine.BSF.2.22.395.2006040006520.56892@zero.eik.bme.hu>
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
Message-ID: <e1ccdf71-5069-fa95-3c90-de4f875b2706@redhat.com>
Date: Thu, 4 Jun 2020 08:07:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.22.395.2006040006520.56892@zero.eik.bme.hu>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 01:08:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Prasad J Pandit <pjp@fedoraproject.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Yi Ren <c4tren@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Ren Ding <rding@gatech.edu>, Hanqing Zhao <hanqing@gatech.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/4/20 12:13 AM, BALATON Zoltan wrote:
> On Thu, 4 Jun 2020, P J P wrote:
>> From: Prasad J Pandit <pjp@fedoraproject.org>
>>
>> While reading PCI configuration bytes, a guest may send an
>> address towards the end of the configuration space. It may lead
>> to an OOB access issue. Assert that 'address + len' is within
>> PCI configuration space.
>>
>> Suggested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
>> ---
>> hw/pci/pci.c | 2 ++
>> 1 file changed, 2 insertions(+)
>>
>> Update v2: assert PCI configuration access is within bounds
>>  -> https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg00711.html
>>
>> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>> index 70c66965f5..173bec4fd5 100644
>> --- a/hw/pci/pci.c
>> +++ b/hw/pci/pci.c
>> @@ -1381,6 +1381,8 @@ uint32_t pci_default_read_config(PCIDevice *d,
>> {
>>     uint32_t val = 0;
>>
>> +    assert(address + len <= pci_config_size(d));
> 
> Does this allow guest now to crash QEMU? I think it was suggested that
> assert should only be used for cases that can only arise from a
> programming error and not from values set by the guest. If this is
> considered to be an error now to call this function with wrong
> parameters did you check other callers? I've found a few such as:
> 
> hw/scsi/esp-pci.c
> hw/watchdog/wdt_i6300esb.c
> hw/ide/cmd646.c
> hw/vfio/pci.c
> 
> and maybe others. Would it be better to not crash just log invalid
> access and either fix up parameters or return some garbage like 0?

Yes, maybe I was not clear while reviewing v1, we need to audit the
callers and fix them first, then we can safely add the assert here.

> 
> Regards,
> BALATON Zoltan
> 
>> +
>>     if (pci_is_express_downstream_port(d) &&
>>         ranges_overlap(address, len, d->exp.exp_cap + PCI_EXP_LNKSTA,
>> 2)) {
>>         pcie_sync_bridge_lnk(d);
>>


