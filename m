Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89EA8C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 19:45:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54FC920767
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 19:45:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L8gcVz+3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54FC920767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDvAR-0007dY-Fe
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 15:45:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60778)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kDv9I-0006m5-3v
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 15:43:56 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:42429
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kDv9F-0003FD-SE
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 15:43:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599162232;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=xSlJnMbTA/2XIvNl4myitKv5MRtFCHdjY8aZlcskhAc=;
 b=L8gcVz+3863iORVp4Cq54RJRr0edm9HKAx3DqzTt9DPhXgVNlji3KX/kt2bbDP1Ir8WZvB
 vetK8sBA90rCqHXYGo9PHFiWqSpg4G5ZfzsYG2M6uDbjYsGaa2hWWm0SkmC7l9s7gJGSpd
 KjCrZzXiHssgbLiXFmYVgzq/+Tt3SJU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-509-ltBtfzwHO7G7iUL24E3vrg-1; Thu, 03 Sep 2020 15:43:48 -0400
X-MC-Unique: ltBtfzwHO7G7iUL24E3vrg-1
Received: by mail-wm1-f69.google.com with SMTP id x6so1325977wmb.6
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 12:43:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=xSlJnMbTA/2XIvNl4myitKv5MRtFCHdjY8aZlcskhAc=;
 b=FnkBYHBPAfXadXHVFcG8Vb9Skwrqb2bbqIKSDyMTnLjpV9ms/8nYA0Qev0Ha/8f7P/
 xVpJx9nwLkXx0o8f+rsg8EIl7SaY+pDhdsdgwDwo0ANeQUeh+Fib/VcTYs1Z33LaDDJP
 DNcHjlY23NuyXY4aOljIk9pKCbHGzetzw9OXZBedP894pZBwUOiWMheOSRvz8glmM8b2
 /Y/OY+0LDh6kJdYJlY5nR+C8G4JnvxesYiYfTbAdMIFJVBhq3pYcr/QJ3eflXTB4agbm
 v4okGKu96U/xSWaIWlu2I4Yr94L0l61dMs/h5DYDKlpoTUVjurTxlFn04VCeY1WS9kth
 8/3w==
X-Gm-Message-State: AOAM533wiEKhlF3BJVYgwOhQfXnrVWVub1yCO/FuGDBWqFNtmulB5x9S
 vih4m7N0wjAWVpcQDAr51IK8wOEhIElbhl9ClxI29tHq2MWT+BUIzyyf6pKqNYuF4Db+7NdhN2g
 66qmWl61bTVHcMD4=
X-Received: by 2002:adf:ec92:: with SMTP id z18mr4325914wrn.53.1599162227269; 
 Thu, 03 Sep 2020 12:43:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyxOMMOc3Cd0DC2d87+PfGfR0g1AaEoHe/FGmvEYl+Pa8KZWsuUPfjlNjKWPKnLv1/kOHwbAA==
X-Received: by 2002:adf:ec92:: with SMTP id z18mr4325890wrn.53.1599162227032; 
 Thu, 03 Sep 2020 12:43:47 -0700 (PDT)
Received: from [192.168.1.36] (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id r14sm6636195wrc.41.2020.09.03.12.43.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2020 12:43:46 -0700 (PDT)
Subject: Re: [PATCH v1 8/8] migration: use pstrcpy to copy run state
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>
References: <20200903112107.27367-1-alex.bennee@linaro.org>
 <20200903112107.27367-9-alex.bennee@linaro.org>
 <CABgObfZCiQZ2RhriWj+xmCuYfAXVkXmAAJFKpNA7VS0avo4qUA@mail.gmail.com>
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
Message-ID: <8cddf56b-4115-579d-d4eb-524d2cad1385@redhat.com>
Date: Thu, 3 Sep 2020 21:43:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CABgObfZCiQZ2RhriWj+xmCuYfAXVkXmAAJFKpNA7VS0avo4qUA@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 04:23:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.403, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: fam@euphon.net, berrange@redhat.com, Juan Quintela <quintela@redhat.com>,
 stefanb@linux.vnet.ibm.com, richard.henderson@linaro.org,
 qemu-devel <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 "Emilio G. Cota" <cota@braap.org>, stefanha@redhat.com,
 marcandre.lureau@redhat.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/3/20 2:13 PM, Paolo Bonzini wrote:
> Il gio 3 set 2020, 13:21 Alex Bennée <alex.bennee@linaro.org
> <mailto:alex.bennee@linaro.org>> ha scritto:
> 
>     The gcov build triggered:
> 
>       ../../migration/global_state.c:47:5: error: ‘strncpy’ specified
>           bound 100 equals destination size [-Werror=stringop-truncation]
>           strncpy((char *)global_state.runstate
> 
>     As we shouldn't be using strncpy anyway lets use the suggested
>     pstrcpy.
> 
> 
> This is wrong, we want the all-zeros behavior of strncpy that pstrcpy lacks.

FWIW links to previous discussions:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg584216.html

> 
> Paolo


