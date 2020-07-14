Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A882BC433E6
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 13:31:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7605A22280
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 13:31:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gL7MG1bQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7605A22280
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvL2L-0007be-JI
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 09:31:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56578)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jvL1I-0006Ke-W9
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 09:30:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37144
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jvL1F-0008Fb-TR
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 09:30:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594733447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=t2s3H4MUlfJ7pXU9myQHqTW2oiBv3x3ywhvNALLdwys=;
 b=gL7MG1bQucwL0K7fkxixjirMtTNwZN3ab3/vRXUzIUxicixVkZUSCwvliq0Uf53rlgdC5d
 0Lzkw/0V+1n3nlNw+xgnEbHUg+6HgziB4O6MEZlp68L6nxe9zepFkRY4p5vAELc0iJ660B
 Z1axemLfu2jSZLfrdULFoKwGZOGEk+s=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-121-uS2txdngPwSgH02dCnNokQ-1; Tue, 14 Jul 2020 09:30:46 -0400
X-MC-Unique: uS2txdngPwSgH02dCnNokQ-1
Received: by mail-wm1-f71.google.com with SMTP id g6so3976795wmk.4
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 06:30:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=t2s3H4MUlfJ7pXU9myQHqTW2oiBv3x3ywhvNALLdwys=;
 b=YzJkzggIfT0DGY17WFLfjFG9lQGmWXU172+Y/o/LHLUGlJnnWIjT0zgGs4WTXuGiMa
 dRE9JlPzVHn3gaiWjw82qvfBoHceSJ+4YL7NRKqHNulX836590NBod9DQNduvlCjO/lI
 qYm3UPPQtxJNU6wAMlKTA+csy/EsgiJIo23YHInjPn8/a9XMySKV5GBJbljvx0k8SgzN
 xQjzbQ6lZL4V81Eg5L42wEnc4EuFUdSiyaqZqbfMdA35jJTV1RzxQihI8L4on/D34lCs
 hitWgkWfNRP44HMlFpnkHhpoMT/bPopawx591m1C74VSNp0nW0ILN0HtiGwUVDqJvwAx
 Hj8g==
X-Gm-Message-State: AOAM532fo+pcQISmrAfxWuAYxzlJNXGrCtfLi2X/q5KsuoSXNY+u49V8
 rC0XjRzvsrvGMZAb9D3tBkpG1ylCMq0fA1ePRa+rWllpjr8ceeqQG+kl9FaIQuVMgz9JL8cCa8x
 qnHHGWRgP04dOO7I=
X-Received: by 2002:a05:600c:21ca:: with SMTP id
 x10mr4510966wmj.63.1594733444624; 
 Tue, 14 Jul 2020 06:30:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwmOdezkEFEY6RXVg8umqbNz8pTrtCiJmmSoUkYJAe1jVD06Lgz7tipTkbnwcqcZ1QMU9GQBg==
X-Received: by 2002:a05:600c:241:: with SMTP id
 1mr4352549wmj.119.1594731899845; 
 Tue, 14 Jul 2020 06:04:59 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id g82sm4413798wma.37.2020.07.14.06.04.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jul 2020 06:04:59 -0700 (PDT)
Subject: Re: [PULL 3/5] softmmu/vl: Let -fw_cfg option take a 'gen_id' argument
To: Laszlo Ersek <lersek@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
References: <20200704163927.28188-1-philmd@redhat.com>
 <20200704163927.28188-4-philmd@redhat.com>
 <CAFEAcA8v2rEC0T_=D1Bat9DQJ=YS57fRUDDQyFdxJsEB=OEPMw@mail.gmail.com>
 <17fd7aea-cc7e-c17a-5748-88dd0d106317@redhat.com>
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
Message-ID: <675df09e-7776-79da-926c-b5e6cce3255c@redhat.com>
Date: Tue, 14 Jul 2020 15:04:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <17fd7aea-cc7e-c17a-5748-88dd0d106317@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 21:44:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/13/20 4:50 PM, Laszlo Ersek wrote:
> On 07/13/20 15:13, Peter Maydell wrote:
>> On Sat, 4 Jul 2020 at 17:41, Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
>>>
>>> The 'gen_id' argument refers to a QOM object able to produce
>>> data consumable by the fw_cfg device. The producer object must
>>> implement the FW_CFG_DATA_GENERATOR interface.
>>>
>>> Reviewed-by: Laszlo Ersek <lersek@redhat.com>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>>> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
>>> Message-Id: <20200623172726.21040-4-philmd@redhat.com>
>>
>> Coverity points out (CID 1430396) an issue with the error handling
>> in this patch:
>>
>>
>>> @@ -2052,6 +2056,15 @@ static int parse_fw_cfg(void *opaque, QemuOpts *opts, Error **errp)
>>>      if (nonempty_str(str)) {
>>>          size = strlen(str); /* NUL terminator NOT included in fw_cfg blob */
>>>          buf = g_memdup(str, size);
>>> +    } else if (nonempty_str(gen_id)) {
>>> +        Error *local_err = NULL;
>>
>> We set local_err to NULL here...
>>
>>> +
>>> +        fw_cfg_add_from_generator(fw_cfg, name, gen_id, errp);
>>
>> ...but we don't pass it to the function here...
> 
> Ugh, I should have noticed that in review. I'm sorry.

You reviewed v9 which was OK, I added it while addressing
Daniel comment for v10, while keeping your R-b tag from v9.
Since you already had reviewed 9 different versions, I didn't
want to overload you for a trivial change, but I should have
dropped your tag to be certain.

Also this has been merged at the same time Markus was doing
a big rework on the Error API, so I was very confused between
reviews of the new API.

So don't be sorry, Daniel/Myself let that in ;)

I'll send a patch, hoping it can be queued via qemu-trivial.

Regards,

Phil.

> Laszlo
> 
>>
>>> +        if (local_err) {
>>
>> ...so this condition is always false and the body of the if is dead code.
>>
>>> +            error_propagate(errp, local_err);
>>> +            return -1;
>>> +        }
>>> +        return 0;
>>>      } else {
>>>          GError *err = NULL;
>>>          if (!g_file_get_contents(file, &buf, &size, &err)) {
>>
>> thanks
>> -- PMM
>>
> 


