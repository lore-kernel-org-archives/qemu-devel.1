Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25246C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 15:33:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0E382087C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 15:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KS7PdaaN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0E382087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGOa7-0002A8-QW
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 11:33:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42818)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kGOZD-0000iR-8t
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 11:32:55 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:37251
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kGOZB-0000vm-Cw
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 11:32:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599751972;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ovMzkSZ8GYa2UjSWvOJcwGaJYgGSbpWePFzCLZ1yo7I=;
 b=KS7PdaaNHqEr3OB6ARQNylH5Vi1Qnzir41rw8lBtoPGOAD9/CJPquxL/3ut/OTV9dEIzAq
 zio1QDHRv4Z+9ZTBD+8kH6Jrsqb3nUgyIB+fHf2IQo56eUVd2mwAZrU9aQBJ4JvmZGn9QR
 bwvjwg5m2j8I/ga6V3u78Tn7t19Dyjc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-qjvGd9rEMw2HnqBd36IvVg-1; Thu, 10 Sep 2020 11:32:47 -0400
X-MC-Unique: qjvGd9rEMw2HnqBd36IvVg-1
Received: by mail-wr1-f70.google.com with SMTP id y3so2381032wrl.21
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2020 08:32:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ovMzkSZ8GYa2UjSWvOJcwGaJYgGSbpWePFzCLZ1yo7I=;
 b=YgYAdHHjYVJwGRLG1q9ago32f+yofQ7oKz/WZyQi4tqzuMcViIhGOluv6GNhje2kjR
 Stq3lW7MGzJ1JalTngymu/TvAsxVvJde2eFitr829NK3t2sR5wRlVox5Z4UAQ7jOBMAO
 xNwFv6UAzBo4J5uFOhglWFzMyyGAzlSgVdyaovDOZQQkdZWtmB5U9QxJ+iizIt9VdIJ5
 UxgrsRaOgfPp8U54wgxmfkvHdn5L5NvvIgDyb+A8aFNwjZx9LdfgEMbnILS6XaRH7D24
 glOe8AwUHrzCoFzgVzzgKT3b+P7KWiylG25BsYAvI0U9douXziAzh0WS74btEy+aDhVr
 2yBw==
X-Gm-Message-State: AOAM530n2cZN6YeooAFCgi/5wtC6zdLNf+Y1VbjsFQx9CNUPLApuxJkf
 Aj4/xsnBMSrmU+h/5lyU68iDKYyS8SghIV3RKndKqH9Z7JXpdULQndBWCBEjzRA/DQNfHR2aKFT
 qcD/gVgnwNt2KHQY=
X-Received: by 2002:a05:600c:2183:: with SMTP id
 e3mr585980wme.49.1599751966509; 
 Thu, 10 Sep 2020 08:32:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyneyhrdyYYHtVGQQb1CnEcFMmRPbwRuMGrjs8tfT1hZDAF/cfPaUfsEQGOhh7uZ8HESb0EPQ==
X-Received: by 2002:a05:600c:2183:: with SMTP id
 e3mr585948wme.49.1599751966228; 
 Thu, 10 Sep 2020 08:32:46 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id q192sm4130289wme.13.2020.09.10.08.32.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Sep 2020 08:32:45 -0700 (PDT)
Subject: Re: [PATCH 05/10] roms/edk2: update submodule from edk2-stable201905
 to edk2-stable202008
To: Laszlo Ersek <lersek@redhat.com>, qemu devel list <qemu-devel@nongnu.org>
References: <20200908072939.30178-1-lersek@redhat.com>
 <20200908072939.30178-6-lersek@redhat.com>
 <1356c404-517c-cf5c-bc04-04237c03f572@redhat.com>
 <2e0b207b-d902-f56c-18d7-50998c7de991@redhat.com>
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
Message-ID: <0309f104-854a-840b-8ec3-fb50960d7821@redhat.com>
Date: Thu, 10 Sep 2020 17:32:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <2e0b207b-d902-f56c-18d7-50998c7de991@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 08:38:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.576, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/8/20 2:08 PM, Laszlo Ersek wrote:
> On 09/08/20 10:22, Philippe Mathieu-Daudé wrote:
>> Hi Laszlo,
>>
>> On 9/8/20 9:29 AM, Laszlo Ersek wrote:
>>> Update the edk2 submodule from release edk2-stable201905 to
>>> edk2-stable202008. The release notes can be read at
>> [...]
>>>
>>> Cc: Philippe Mathieu-Daudé <philmd@redhat.com>
>>> Ref: https://bugs.launchpad.net/qemu/+bug/1852196
>>> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
>>> ---
>>>  roms/edk2 | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/roms/edk2 b/roms/edk2
>>> index 20d2e5a125e3..06dc822d045c 160000
>>> --- a/roms/edk2
>>> +++ b/roms/edk2
>>> @@ -1 +1 @@
>>> -Subproject commit 20d2e5a125e34fc8501026613a71549b2a1a3e54
>>> +Subproject commit 06dc822d045c2bb42e497487935485302486e151
>>
>> FYI applying this I got:
>>
>> Fetching submodule roms/edk2
>> Fetching submodule roms/edk2/CryptoPkg/Library/OpensslLib/openssl
>> From https://github.com/openssl/openssl
>> Could not access submodule 'krb5'
>> Errors during submodule fetch:
>>         CryptoPkg/Library/OpensslLib/openssl
>> Errors during submodule fetch:
>>         roms/edk2
>>
>> Probably harmless, as if one care about this submodule,
>> will run "make edk2-basetools" which runs 'git submodule
>> update --init --force' and silently fixes the submodules.
>>
> 
> Did you pass the "--recursive" option to the "git submodule" perhaps?

No I didn't used it.

> 
> (Because, krb5 is a submodule of edk2's openssl submodule.)
> 
> "--recursive" should not be used. See "ReadMe.rst" in edk2:
> 
> """
> Note: When cloning submodule repos, '--recursive' option is not
> recommended. EDK II itself will not use any code/feature from
> submodules in above submodules. So using '--recursive' adds a
> dependency on being able to reach servers we do not actually want
> any code from, as well as needlessly downloading code we will not
> use.
> """
> 
> QEMU's current submodules do not require the usage of "--recursive".
> 
> Thanks
> Laszlo
> 


