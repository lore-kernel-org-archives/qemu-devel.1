Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC8FC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 18:31:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2107C20772
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 18:31:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HB9xh4TT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2107C20772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrQTS-0003Nk-D8
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 14:31:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44484)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jrQSR-0002x8-3O
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 14:30:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21654
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jrQSO-0003xu-1k
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 14:30:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593801038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=B/0j/aUmETXEudlaicLtIofOb5VBdn56eddJ5jdQAQE=;
 b=HB9xh4TTAugL9HjWrSYPaDaX0NxiaeiR+WaGMzA/PpGzIxvnzhNFiAqWrIQm322mKJ6cct
 Dwph5Q2JDJP133fqCTw++L2hTEX9oAFJsQAU+lKNuFyLBe7OoNH+oSCnHbbUkeMSQLlTeI
 GldqHETsuiEX07oF1Bvo/CRmHEYHAFY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-53-BTcHYCmaO-etCPbWz-w0vA-1; Fri, 03 Jul 2020 14:30:34 -0400
X-MC-Unique: BTcHYCmaO-etCPbWz-w0vA-1
Received: by mail-wr1-f70.google.com with SMTP id b14so32690249wrp.0
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 11:30:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=B/0j/aUmETXEudlaicLtIofOb5VBdn56eddJ5jdQAQE=;
 b=IxM6STB6jnQpqqJuUXBq0XekyMgHVbVCzPHlbhk59eI+NhhMe1ZzlMrxl6ZVF30GtK
 mqPvxTh2HEAiUKDAe7ZuBfoiy0rYiUXL5HCKVsbuNrdXKKFJxdNEZUzkkkVi7x9nl2fP
 hwaiB6UDjPHdJJs4RQ76AMBnC3wHGJi/8CHF0NvXXO+JLwPSFSjd2ELpg/SeClJVOASU
 f0H6S98vAYusE+qmO9h5jYNzBoXrn5bDuN+6Uit9+N08zIn79dYnmoEhDrsZK6guVY4k
 ewGlnFb83u47g3OxYP26A6F2opWDFLf0w4ZsM4SAyDbfiparRNrYY6Un7IgZ0Ys/1jVW
 cMYg==
X-Gm-Message-State: AOAM5304c/5sTqD7+xNMEKxVsqPcRAuPzj+pbB9zMJPnt0xOUkggJs9N
 n0L3CBFId5/4a2nCRMcYt49u+ebdLbQ2HCaKk3WxUywoj60gX6h3weznFxbEAdnS/cLe2gc633N
 lSAwWrt2tpoVGsro=
X-Received: by 2002:adf:f504:: with SMTP id q4mr37359036wro.163.1593801033806; 
 Fri, 03 Jul 2020 11:30:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwF6IRNrNjj6fuexyhJqJe4UxeGqkxAt82IcmS3NN+rg9j8Ju1xa118jAswNTiB8aBnd8mD5w==
X-Received: by 2002:adf:f504:: with SMTP id q4mr37359025wro.163.1593801033610; 
 Fri, 03 Jul 2020 11:30:33 -0700 (PDT)
Received: from [192.168.1.39] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id m4sm14414069wmi.48.2020.07.03.11.30.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jul 2020 11:30:33 -0700 (PDT)
Subject: Re: [RFC PATCH] MAINTAINERS: Cover the firmware JSON schema
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>
References: <20200703161453.8406-1-philmd@redhat.com>
 <20200703161858.GO2213227@redhat.com>
 <d3b8e3f2-c565-a38e-8af6-87fd579e9045@redhat.com>
 <20200703170659.GQ2213227@redhat.com>
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
Message-ID: <0c3c51ac-ee58-9cbb-2c84-c0e1757ba126@redhat.com>
Date: Fri, 3 Jul 2020 20:30:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200703170659.GQ2213227@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 02:53:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kashyap Chamarthy <kchamart@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/3/20 7:06 PM, Daniel P. Berrangé wrote:
> On Fri, Jul 03, 2020 at 06:58:45PM +0200, Laszlo Ersek wrote:
>> On 07/03/20 18:18, Daniel P. Berrangé wrote:
>>> On Fri, Jul 03, 2020 at 06:14:53PM +0200, Philippe Mathieu-Daudé wrote:
>>>> Add an entry to cover firmware.json (see commit 3a0adfc9bf:
>>>> schema that describes the different uses and properties of
>>>> virtual machine firmware).
>>>> Cc the libvirt maintainers if it ever changes.
>>>>
>>>> Cc: Laszlo Ersek <lersek@redhat.com>
>>>> Cc: Daniel P. Berrange <berrange@redhat.com>
>>>> Cc: Gerd Hoffmann <kraxel@redhat.com>
>>>> Cc: Kashyap Chamarthy <kchamart@redhat.com>
>>>> Cc: Michael S. Tsirkin <mst@redhat.com>
>>>> Suggested-by: Laszlo Ersek <lersek@redhat.com>
>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>>>> ---
>>>> Based on a comment from Laszlo:
>>>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg604925.html
>>>>
>>>> I don't think Laszlo should be the sole maintainer, not sure
>>>> who else should be listed. Gerd and Kashyap? :)
>>>> Can we add it 'maintained' without specific maintainer?
>>>> ---
>>>>  MAINTAINERS | 6 ++++++
>>>>  1 file changed, 6 insertions(+)
>>>>
>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>> index dec252f38b..57c90201df 100644
>>>> --- a/MAINTAINERS
>>>> +++ b/MAINTAINERS
>>>> @@ -2601,6 +2601,12 @@ F: include/hw/i2c/smbus_master.h
>>>>  F: include/hw/i2c/smbus_slave.h
>>>>  F: include/hw/i2c/smbus_eeprom.h
>>>>  
>>>> +Firmware schema specifications
>>>> +M: Laszlo Ersek <lersek@redhat.com>
>>>> +R: libvir-list@redhat.com
>>>
>>> FWIW, I don't think libvirt needs to review this. Our firmware handling
>>> code doesn't really care what specific files exist - it just follows the
>>> declared logic to pick amongst whatever exists.
>>
>> I request that
>>
>> - Phil be listed please as another maintainer (so there are two people
>> that can send pull requests, if a 3rd person needs to patch this file
>> for whatever reason),
>>
>> - Dan be listed please *at least* as an "R" person; the business logic
>> written up under the @Firmware element, and lots of the initial review
>> comments (in particular the suggestion to mention specific QEMU command
>> line switches in the schema), had come from him.
>>
>> If Dan is willing to be an "M", then we can collapse both of my above
>> requests into one, and Phil wouldn't have to be listed (Dan could both
>> review suggested changes and submit pull requests). However, I'm raising
>> this only as a technical possibility; what really matters to me is that
>> Dan be CC'd on suggested changes, and that someone other than me can
>> submit PRs if necessary.
> 
> I'm fine with "R", but don't want to be "M" as I don't want to be
> responsible for queueing patches, etc on more parts of QEMU.

Thanks all! I'm queuing this patch as:

Firmware schema specifications
M: Laszlo Ersek <lersek@redhat.com>
M: Philippe Mathieu-Daudé <philmd@redhat.com>
R: Daniel P. Berrange <berrange@redhat.com>
R: Kashyap Chamarthy <kchamart@redhat.com>
S: Maintained
F: docs/interop/firmware.json

Regards,

Phil.


