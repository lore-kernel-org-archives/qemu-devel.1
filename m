Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA0CBC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 09:26:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95BC520760
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 09:26:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PbHMVYAj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95BC520760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjJTV-0003u3-ME
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 05:26:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56794)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jjJSt-0003PM-B7
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 05:25:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51845
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jjJSs-0003JU-Gr
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 05:25:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591867537;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=l10SqljaXAAMQT5lEHzOl+8v9x+wTsFdqRvQ9/C//es=;
 b=PbHMVYAjsWb90TafFQUhpy4Ox4zdE+Su/bW5rtGVI7BtvjDLTGaqag3jur2o0KYhNxuY6P
 zeM+l6z7rqvdY7XeDKViEwLPmoAxXOgP6HSkBzK+B2a4xR6pMcA2/K4o7Iibz99OMbY7E1
 xHAsJ1mH6/9N7o5gP+4au7z57bbxz4M=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-335-N_MDQ0-tOcyuOrs_hnCHxQ-1; Thu, 11 Jun 2020 05:25:35 -0400
X-MC-Unique: N_MDQ0-tOcyuOrs_hnCHxQ-1
Received: by mail-wr1-f70.google.com with SMTP id x15so958325wru.21
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2020 02:25:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=l10SqljaXAAMQT5lEHzOl+8v9x+wTsFdqRvQ9/C//es=;
 b=T+ML4Ss5jSXDyy+F7g4BmLrUC/afiLGlb5vGQw84gcjAjRQBARakwBAm7rZg2+Iwxn
 7hNL60wYVJzmsQlMp56+7rxeIwy5Vte1dpDab/yTIz8RsAwu4cvu/1muBqtnWof+hVOY
 SD4DEUSlWndXARmZDwVlIsm1SE8VzF0otIyeBNDpuW6aU7/YFoWjW9jrcwyrNSVrbqKP
 srTU+nSuKVZ+OEH+tCLndE5ZUMDJO/weXQ/nGR5OkcSuMLN5NU0ndvq8Q6nKG814ac0S
 iffeU2/oTzcUGsCK7FlRUj5BZWoBKCdjLeWJXjGLchkl3/HsELu9LGmCZubjLPAont80
 3jLQ==
X-Gm-Message-State: AOAM530Fc+GHpEjHVpEnusi3281CDke5AJ9hIFXtpWfJCfuQcDfjD4Ap
 zkP3Gdq78cIX7NEzORgU1bq8tlgRxodplKhobPq5vQieE2u77gXIjPzTR3/4FM7cnIE5/AiFBNW
 bJ+nAEb3ZXw7+6vs=
X-Received: by 2002:a1c:3987:: with SMTP id g129mr7222006wma.139.1591867531645; 
 Thu, 11 Jun 2020 02:25:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz8VvcsTk5qbrTxRJBpbTpdqX7EeDo5oHy8tvRkwHesX9NupyByV9/0q4vRRzJOxfp8Jewj0A==
X-Received: by 2002:a1c:3987:: with SMTP id g129mr7221981wma.139.1591867531403; 
 Thu, 11 Jun 2020 02:25:31 -0700 (PDT)
Received: from [192.168.1.38] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id n189sm3274839wmb.43.2020.06.11.02.25.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jun 2020 02:25:30 -0700 (PDT)
Subject: Re: [PATCH v8 10/10] acpi: q35: drop _SB.PCI0.ISA.LPCD opregion.
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20200611072919.16638-1-kraxel@redhat.com>
 <20200611072919.16638-11-kraxel@redhat.com>
 <49164120-0186-5ae2-0690-98e27a82c5ab@redhat.com>
 <0d74324f-47a1-203a-9623-1cacb948a6d5@redhat.com>
 <20200611051228-mutt-send-email-mst@kernel.org>
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
Message-ID: <e2a0c5ea-c4ca-1d23-8c96-a5d5c87afe96@redhat.com>
Date: Thu, 11 Jun 2020 11:25:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200611051228-mutt-send-email-mst@kernel.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 03:29:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/11/20 11:12 AM, Michael S. Tsirkin wrote:
> On Thu, Jun 11, 2020 at 10:31:01AM +0200, Philippe Mathieu-DaudÃƒÂ© wrote:
>> On 6/11/20 10:27 AM, Philippe Mathieu-DaudÃƒÂ© wrote:
>>> Hi Gerd,
>>>
>>> On 6/11/20 9:29 AM, Gerd Hoffmann wrote:
>>>> Seems to be unused.
>>>>
>>>> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>>>> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
>>>> ---
>>>>  hw/i386/acpi-build.c | 11 -----------
>>>>  1 file changed, 11 deletions(-)
>>>>
>>>> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
>>>> index 02cf4199c2e9..d93ea40c58b9 100644
>>>> --- a/hw/i386/acpi-build.c
>>>> +++ b/hw/i386/acpi-build.c
>>>> @@ -1296,7 +1296,6 @@ static void build_q35_isa_bridge(Aml *table)
>>>>  {
>>>>      Aml *dev;
>>>>      Aml *scope;
>>>> -    Aml *field;
>>>>  
>>>>      scope =  aml_scope("_SB.PCI0");
>>>>      dev = aml_device("ISA");
>>>> @@ -1306,16 +1305,6 @@ static void build_q35_isa_bridge(Aml *table)
>>>>      aml_append(dev, aml_operation_region("PIRQ", AML_PCI_CONFIG,
>>>>                                           aml_int(0x60), 0x0C));
>>>>  
>>>> -    aml_append(dev, aml_operation_region("LPCD", AML_PCI_CONFIG,
>>>> -                                         aml_int(0x80), 0x02));
>>>> -    field = aml_field("LPCD", AML_ANY_ACC, AML_NOLOCK, AML_PRESERVE);
>>>> -    aml_append(field, aml_named_field("COMA", 3));
>>>> -    aml_append(field, aml_reserved_field(1));
>>>> -    aml_append(field, aml_named_field("COMB", 3));
>>>> -    aml_append(field, aml_reserved_field(1));
>>>> -    aml_append(field, aml_named_field("LPTD", 2));
>>>> -    aml_append(dev, field);
>>>> -
>>>>      aml_append(scope, dev);
>>>>      aml_append(table, scope);
>>>>  }
>>>>
>>>
>>> I'm a bit confused, isn't it use to describe these
>>> devices?
>>>
>>> (qemu) info qtree
>>> bus: main-system-bus
>>>   type System
>>>   dev: q35-pcihost, id ""
>>>     bus: pcie.0
>>>       type PCIE
>>>       dev: ICH9-LPC, id ""
>>>         gpio-out "gsi" 24
>>>         class ISA bridge, addr 00:1f.0, pci id 8086:2918 (sub 1af4:1100)
>>>         bus: isa.0
>>>           type ISA
>>>           dev: port92, id ""
>>>             gpio-out "a20" 1
>>>           dev: vmmouse, id ""
>>>           dev: vmport, id ""
>>>           dev: isa-parallel, id ""
>>>             index = 0 (0x0)
>>>             iobase = 888 (0x378)
>>>             irq = 7 (0x7)
>>>             chardev = "parallel0"
>>>             isa irq 7
>>>           dev: isa-serial, id ""
>>>             index = 1 (0x1)
>>>             iobase = 760 (0x2f8)
>>>             irq = 3 (0x3)
>>>             chardev = "serial1"
>>>             wakeup = 0 (0x0)
>>>             isa irq 3
>>>           dev: isa-serial, id ""
>>>             index = 0 (0x0)
>>>             iobase = 1016 (0x3f8)
>>>             irq = 4 (0x4)
>>>             chardev = "serial0"
>>>             wakeup = 0 (0x0)
>>>             isa irq 4
>>>
>>
>> Ah, this patch complements the previous "acpi: drop serial/parallel
>> enable bits from dsdt", right? Maybe better to include this change
>> with the build_q35_isa_bridge() part. Like in a single patch:
>> "acpi: q35: drop lpc/serial/parallel enable bits from dsdt"
>>
>> Then keep the PIIX part of the patches.
> 
> Don't see why really.

OK, no problem on my side. Series fully reviewed!


