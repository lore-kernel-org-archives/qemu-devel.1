Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44CF5C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 14:41:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08E05221E2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 14:41:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gw/1DjFQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08E05221E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k43Z0-0003HW-AB
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 10:41:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41088)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k43YP-0002mY-Sq
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 10:41:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39037)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k43YN-0006er-SN
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 10:41:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596811262;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=1elIRhKEpcqY9cGxSCxtMDTmYwawbY3AXjAxI7k2Zh4=;
 b=gw/1DjFQ0Ff/RwUKE36nXFEselOFsEqcwpOBda+snuQcyyyb8SiujdcQG3VINzbUMJgGV4
 9dcXDJ4qUFBLwFtyXj8GdFLS+M2UagGTwqVpfFaVzXo8RTq/EywYO5LjEZTk9UNisUZvYu
 vp7Dln6HnDmfyqSaNvEZc0HG6k8x6mc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-193-XhM8N7TQOiiId9cCKW8CNw-1; Fri, 07 Aug 2020 10:41:00 -0400
X-MC-Unique: XhM8N7TQOiiId9cCKW8CNw-1
Received: by mail-wm1-f69.google.com with SMTP id a207so747503wme.9
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2020 07:41:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=1elIRhKEpcqY9cGxSCxtMDTmYwawbY3AXjAxI7k2Zh4=;
 b=hfBKX9Xz+r3htebRCfUyzicS3eW9slQIegGKOBp6GAsnfTSDbaJIYFmtWbs+MD0L/T
 Y7t2M3uyriUYIsXa4ELnAsOGzP/Bf7ouxg5YAtfIAzBCLKc1fEf1TQepqR3I0TvJ2AEN
 LpNXMcHMLCcu12E/48zrLTEQ0J3sUX7simnY/ITjgwaJeZnWA2wj2RGTK7+qtyV7A6jw
 KXFTYUoyr9cCEP5qIu63on/GApbAU6KU3MfsmL+h9n4upDW5Wp0SdjJajd8MfjmxhDGJ
 ZZa0xBBrYhoXHCo9jCzckSn61J1qFt7gEmgX72+tQOLLHoNQ1n1XeTy626UYs6j68pAp
 u7hQ==
X-Gm-Message-State: AOAM530txpC7SlYEnz3D8fgS7fmT2M9hJ9fiPyLP9FUVU8liABB1YR6E
 A/LSiMggYaoCvENBBGgbFjnSOGhBh20Rnzz72rP+ylSksIuqzXOxrW3kGDrIfYW8CaejXqFdYPw
 We9EfkTaGaLdSuzo=
X-Received: by 2002:a5d:67d2:: with SMTP id n18mr12091040wrw.214.1596811259615; 
 Fri, 07 Aug 2020 07:40:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxrSwxbD4bgcb7nE8G8N/9R+cjLroZSMnGEfOigxHkTWFzfhnVfpE1GxoZerANA2/UbWiZlmQ==
X-Received: by 2002:a5d:67d2:: with SMTP id n18mr12091028wrw.214.1596811259406; 
 Fri, 07 Aug 2020 07:40:59 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id b137sm11506998wmb.9.2020.08.07.07.40.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Aug 2020 07:40:58 -0700 (PDT)
Subject: Re: [PATCH 037/143] meson: add qemu-bridge-helper
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
 <1596741379-12902-38-git-send-email-pbonzini@redhat.com>
 <503aefcc-7b7b-2558-1355-cb443c32d3e2@redhat.com>
 <47bb9ff6-4162-6c56-5b21-74993ffae81e@redhat.com>
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
Message-ID: <fb05a921-852a-dcd6-36c4-bd3b20ccaea5@redhat.com>
Date: Fri, 7 Aug 2020 16:40:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <47bb9ff6-4162-6c56-5b21-74993ffae81e@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 10:41:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/7/20 4:26 PM, Paolo Bonzini wrote:
> On 07/08/20 15:20, Philippe Mathieu-Daudé wrote:
>>>    endif
>>>  
>>> +  if host_machine.system() == 'linux'
>>> +    executable('qemu-bridge-helper', files('qemu-bridge-helper.c'),
>>> +               dependencies: [qemuutil, libcap_ng],
>> Is libcap_ng still optional?
>>
> 
> Yes, if a dependency is absent it is simply left out.  See
> contrib/vhost-user-scsi for an example where the executable is disabled.
> 
> Instead, if you want a dependency to be mandatory you have two choices:
> 
> - to break the build you use "required: true", see the SDL conversion
> for an example

OK, good :)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> 
> - to disable executables there is a thing called disabler but we're not
> using it because it's confusing.  I was thinking of adding an
> "or_disable()" method to dependency objects, but I have never
> contributed it.
> 
> Paolo
> 


