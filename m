Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD6C3C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 12:52:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A730C206A2
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 12:52:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jV9qahLp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A730C206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhBpo-0001OO-Le
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 08:52:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35940)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jhBpF-0000xK-He
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 08:51:57 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:46513
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jhBpE-0005XR-4l
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 08:51:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591361515;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=f2rgThw6cq13zd2krZ1q+VSNkrRzDVBHiMGYR1K2/CI=;
 b=jV9qahLpTaN/7xvCQhiULknNC5zauoC7lVnm8gb12qXJQA9Eg9KYqM56Pr3kiwWS9eTIUw
 MQcfZDC+rNCZGd4T8gSWrS3/1w9J9lPxb26aMJxfK2r/Gi+uzvfMNLwpfVQVW0I0iWLN+L
 QVrib60gAiEE3LYcUA6wyoaIpBBzko0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-s--ArcKvOdGtZd6RJ93JzA-1; Fri, 05 Jun 2020 08:51:46 -0400
X-MC-Unique: s--ArcKvOdGtZd6RJ93JzA-1
Received: by mail-wm1-f72.google.com with SMTP id l26so2991031wmh.3
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 05:51:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=f2rgThw6cq13zd2krZ1q+VSNkrRzDVBHiMGYR1K2/CI=;
 b=Lqc24kIYm/PpdVS86wSNDlktSbYKQ5+B6iBj51/pd4FkyrBBK+Czdo3zAnpK9zn69q
 pE9xgP/6x8wlKwFwmQ9vcVzpk1MQQ3JDREKYoNZvjxHKwSBcswFhdQeioSveTTHPNpdZ
 7IDsX4O380YqcWTpaRdL0sTfyXgpiIy71BwSQQ+u3WjwEz/MS4SuqV6JSOgGXocBYLaZ
 PbINbJfecvHX+KEnpPZulC5GUgY0CuOr9+oZN0UoNPtC1oHRFL0C0gcwJlwPiSbW7i+5
 pW1WYJABKidw4n2ALJnOX394MjOcGjyBGltTRm9M1+JFzXjEa53Vf9qLGYI5tpCEsXZq
 qErQ==
X-Gm-Message-State: AOAM530/BD84Xv9C/L++6fHG9tKRYwZvoIxiJNzJpyjVOnDU1t8XFgUW
 AWE6YMuDV0Flj20EmOuJTdbO0/VSaGnBp9vOX41HcYEOxb1PFpgKXQBNpNHy3p/apAL3n94eFRM
 jIC7bXI3P8oW1l1I=
X-Received: by 2002:adf:e751:: with SMTP id c17mr9000288wrn.134.1591361505864; 
 Fri, 05 Jun 2020 05:51:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxl/+52DM7q8YwoQyd+Bp8mMgq9KIeuUA2sjJ3pxSFuNfqzEanOO45tSz7ojqMIbqt5yEBuWA==
X-Received: by 2002:adf:e751:: with SMTP id c17mr9000276wrn.134.1591361505653; 
 Fri, 05 Jun 2020 05:51:45 -0700 (PDT)
Received: from [192.168.1.43] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id b201sm11151802wmb.36.2020.06.05.05.51.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Jun 2020 05:51:45 -0700 (PDT)
Subject: Re: [PATCH] configure: Disable -Wtautological-type-limit-compare
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200604034513.75103-1-richard.henderson@linaro.org>
 <f5bc0532-e731-b56f-df7f-55da2585e955@redhat.com>
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
Message-ID: <8bee167c-098c-a298-cd05-ffd753dbd934@redhat.com>
Date: Fri, 5 Jun 2020 14:51:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <f5bc0532-e731-b56f-df7f-55da2585e955@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 03:40:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, thuth@redhat.com,
 Cornelia Huck <cohuck@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/4/20 8:11 AM, Philippe Mathieu-Daudé wrote:
> On 6/4/20 5:45 AM, Richard Henderson wrote:
>> Clang 10 enables this by default with -Wtype-limit.
>>
>> All of the instances flagged by this Werror so far have been
>> cases in which we really do want the compiler to optimize away
>> the test completely.  Disabling the warning will avoid having
>> to add ifdefs to work around this.
>>
> 
> Fixes: https://bugs.launchpad.net/qemu/+bug/1878628
> 
> Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Clarifying: I tested with clang-10, but Alex/Cornelia reported on IRC
the failure persist with clang-9 until using --disabler-werror.

> 
> I dare to add:
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> 
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  configure | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/configure b/configure
>> index f087d2bcd1..693f01327f 100755
>> --- a/configure
>> +++ b/configure
>> @@ -2009,6 +2009,8 @@ gcc_flags="-Wno-missing-include-dirs -Wempty-body -Wnested-externs $gcc_flags"
>>  gcc_flags="-Wendif-labels -Wno-shift-negative-value $gcc_flags"
>>  gcc_flags="-Wno-initializer-overrides -Wexpansion-to-defined $gcc_flags"
>>  gcc_flags="-Wno-string-plus-int -Wno-typedef-redefinition $gcc_flags"
>> +gcc_flags="$gcc_flags -Wno-tautological-type-limit-compare"
>> +
>>  # Note that we do not add -Werror to gcc_flags here, because that would
>>  # enable it for all configure tests. If a configure test failed due
>>  # to -Werror this would just silently disable some features,
>>
> 


