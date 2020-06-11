Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC0DAC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 08:32:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75F5D2072F
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 08:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eKSefXk8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75F5D2072F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjIdB-0001E4-Mk
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 04:32:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40308)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jjIcA-0000db-0a
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 04:31:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26873
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jjIc9-0000TO-7Q
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 04:31:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591864268;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=JgjtVZdKKV1lGhYEIl0h5y7fqrPpk+nlovsRBA6vlc0=;
 b=eKSefXk8XL/VomJfNW0Z55gVtl8o4e35vXAMjjUCgDWvfP4DJtQMrxd0Q5mxNf484rXDx0
 k/rEkHT8tPAHjrUTH5njTwfsRjIJo0PyhbMSH7huvvXQUNXXTgZg9AtIfeVEdVPdY7Q+OO
 rODoRa5lbZeHJsrl8+B3Un9bEv6RDKE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-LKZyivQeOjyFv3ZAQNKSeg-1; Thu, 11 Jun 2020 04:31:04 -0400
X-MC-Unique: LKZyivQeOjyFv3ZAQNKSeg-1
Received: by mail-wr1-f70.google.com with SMTP id a4so2274822wrp.5
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2020 01:31:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=JgjtVZdKKV1lGhYEIl0h5y7fqrPpk+nlovsRBA6vlc0=;
 b=t1z9hil1imk7PZLN012ZQycwwVgUwbocG2Q2mhlh/qVNKa/asPZFdB6GjQQiDCnCYB
 OZj2NgJYNgDKHJX85P+BUlA9BrjUCZWjS9ud6lq7UP7NQtJmyLMxziPXotcUUIuUWgbh
 uf0uhRYI+271WoNS8WFHvU1rfQPfum8I5ihZW5tPF605Y3POEngmft9l2fob7oeh/RBp
 gNwPEOLLCfQ+A+t1Px+Ya7qPN7CKqxmXiKMlNYyWmsmouevhCeWJZeYGjZOwEfzQqtLV
 7upzJdR5ugLfvac883wssqRXWtvMSAKoY5O9fx76m1CXjzDErCCoyuRo4qaAeZP8sY/7
 tkUQ==
X-Gm-Message-State: AOAM530mAmQawkImIKqULKOrKHF+w7ScucL/G741e2Xi9Iad0lwP+PlU
 6BDqAlnDX+KtRdwyXooCJEzrD3Y+9T9xUNvsNgJpFlW1Wxe5WVi5Elu3gm9a5WntS6O33rZRNkb
 EazPmB+cWVCyWA/0=
X-Received: by 2002:a5d:40d0:: with SMTP id b16mr8098271wrq.218.1591864263380; 
 Thu, 11 Jun 2020 01:31:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwj4nI21T78XdL9HJiT7xM12dFD/qSKK8O4w/2c0tLLpCkF2DX48jjhkE4WElimVv5hmkJa5g==
X-Received: by 2002:a5d:40d0:: with SMTP id b16mr8098241wrq.218.1591864263146; 
 Thu, 11 Jun 2020 01:31:03 -0700 (PDT)
Received: from [192.168.1.38] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id a7sm3204898wmh.14.2020.06.11.01.31.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jun 2020 01:31:02 -0700 (PDT)
Subject: Re: [PATCH v8 10/10] acpi: q35: drop _SB.PCI0.ISA.LPCD opregion.
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20200611072919.16638-1-kraxel@redhat.com>
 <20200611072919.16638-11-kraxel@redhat.com>
 <49164120-0186-5ae2-0690-98e27a82c5ab@redhat.com>
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
Message-ID: <0d74324f-47a1-203a-9623-1cacb948a6d5@redhat.com>
Date: Thu, 11 Jun 2020 10:31:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <49164120-0186-5ae2-0690-98e27a82c5ab@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 03:29:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/11/20 10:27 AM, Philippe Mathieu-Daudé wrote:
> Hi Gerd,
> 
> On 6/11/20 9:29 AM, Gerd Hoffmann wrote:
>> Seems to be unused.
>>
>> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
>> ---
>>  hw/i386/acpi-build.c | 11 -----------
>>  1 file changed, 11 deletions(-)
>>
>> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
>> index 02cf4199c2e9..d93ea40c58b9 100644
>> --- a/hw/i386/acpi-build.c
>> +++ b/hw/i386/acpi-build.c
>> @@ -1296,7 +1296,6 @@ static void build_q35_isa_bridge(Aml *table)
>>  {
>>      Aml *dev;
>>      Aml *scope;
>> -    Aml *field;
>>  
>>      scope =  aml_scope("_SB.PCI0");
>>      dev = aml_device("ISA");
>> @@ -1306,16 +1305,6 @@ static void build_q35_isa_bridge(Aml *table)
>>      aml_append(dev, aml_operation_region("PIRQ", AML_PCI_CONFIG,
>>                                           aml_int(0x60), 0x0C));
>>  
>> -    aml_append(dev, aml_operation_region("LPCD", AML_PCI_CONFIG,
>> -                                         aml_int(0x80), 0x02));
>> -    field = aml_field("LPCD", AML_ANY_ACC, AML_NOLOCK, AML_PRESERVE);
>> -    aml_append(field, aml_named_field("COMA", 3));
>> -    aml_append(field, aml_reserved_field(1));
>> -    aml_append(field, aml_named_field("COMB", 3));
>> -    aml_append(field, aml_reserved_field(1));
>> -    aml_append(field, aml_named_field("LPTD", 2));
>> -    aml_append(dev, field);
>> -
>>      aml_append(scope, dev);
>>      aml_append(table, scope);
>>  }
>>
> 
> I'm a bit confused, isn't it use to describe these
> devices?
> 
> (qemu) info qtree
> bus: main-system-bus
>   type System
>   dev: q35-pcihost, id ""
>     bus: pcie.0
>       type PCIE
>       dev: ICH9-LPC, id ""
>         gpio-out "gsi" 24
>         class ISA bridge, addr 00:1f.0, pci id 8086:2918 (sub 1af4:1100)
>         bus: isa.0
>           type ISA
>           dev: port92, id ""
>             gpio-out "a20" 1
>           dev: vmmouse, id ""
>           dev: vmport, id ""
>           dev: isa-parallel, id ""
>             index = 0 (0x0)
>             iobase = 888 (0x378)
>             irq = 7 (0x7)
>             chardev = "parallel0"
>             isa irq 7
>           dev: isa-serial, id ""
>             index = 1 (0x1)
>             iobase = 760 (0x2f8)
>             irq = 3 (0x3)
>             chardev = "serial1"
>             wakeup = 0 (0x0)
>             isa irq 3
>           dev: isa-serial, id ""
>             index = 0 (0x0)
>             iobase = 1016 (0x3f8)
>             irq = 4 (0x4)
>             chardev = "serial0"
>             wakeup = 0 (0x0)
>             isa irq 4
> 

Ah, this patch complements the previous "acpi: drop serial/parallel
enable bits from dsdt", right? Maybe better to include this change
with the build_q35_isa_bridge() part. Like in a single patch:
"acpi: q35: drop lpc/serial/parallel enable bits from dsdt"

Then keep the PIIX part of the patches.


