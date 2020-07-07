Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B99C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 09:30:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 522CF206CD
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 09:30:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eR7nMMdF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 522CF206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsjvY-0006uN-K0
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 05:30:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46586)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jsjuo-00064F-TJ
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 05:29:26 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:50756
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jsjum-0002bS-Qt
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 05:29:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594114163;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uyvKlxBSq8rpYvRRSSVIqlv5agU9RIqNBq58+5IqbKE=;
 b=eR7nMMdFG7QqTaerrjhHj8twXA+BRqy89LoFz1NPFsrvt+3PRSA3xWBkuAmnjTc5s+XcON
 sALWosmu6pu8igqQq1wHWtM5t6LorXca+S1dMKPt1eE1eK3fscdrJFVUtUtRhw3EWrCuzu
 nDumb62iXeaNku90RS7fFr9RDP15npk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-393-4aCqygiLMZ2wlKWdeQjgYQ-1; Tue, 07 Jul 2020 05:29:19 -0400
X-MC-Unique: 4aCqygiLMZ2wlKWdeQjgYQ-1
Received: by mail-wm1-f70.google.com with SMTP id g6so46144622wmk.4
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 02:29:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=uyvKlxBSq8rpYvRRSSVIqlv5agU9RIqNBq58+5IqbKE=;
 b=Q5RHt0DrxlZh52ocRO7iYG71WK7GUWPM1uxjbNIfAlTHfVO0T3kjNBwx6D4mFy/8VU
 9nhfOe2CO8AWuv1gmAuVq033ZGCW8K9XkzO/jM6mgpBOAcBNKdgXO9vhJEv9IfITQN/3
 0GjWrx0vttvH1vk8aQLVhw0DhY9Q1Uh6Pa7xmJa9kApqqeehGX54fKU0a+lkJ9EX5Md2
 TIp37ibyzYKeBgCn+UJToXZWLdcZlHjPNWxVe54uy45MgBEZU5eZ/nGKkzYBF0p+SFpS
 OJdJCh+KJU7NeW913+68GZX8Rzd0x6foIi7epwVOHMqcsk7XcYlfvL6Rr8zrCpCrlZnn
 AZow==
X-Gm-Message-State: AOAM532ORKQBpGL/9RQUuaTTpeSgVuq6I6G3sc5fQ9oW1nmVcfKjr6Sc
 XVqCAY6GFSA2SlNnn9AiWMzfrmbNB+6g+vhg8uPk4zjMEbH+qbHpw644haiIV3MBvH4fbdgOWlX
 OXLbH54ItP22nLWk=
X-Received: by 2002:a5d:4e81:: with SMTP id e1mr50182974wru.22.1594114158578; 
 Tue, 07 Jul 2020 02:29:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyyMyyCRMFI9uQQyNqFjLSNnCmkN9C76MnIKlLb68ds9Q4phI1Efji/p637OrePykX35uZ0LQ==
X-Received: by 2002:a5d:4e81:: with SMTP id e1mr50182954wru.22.1594114158350; 
 Tue, 07 Jul 2020 02:29:18 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e95f:9718:ec18:4c46?
 ([2001:b07:6468:f312:e95f:9718:ec18:4c46])
 by smtp.gmail.com with ESMTPSA id z8sm281174wmg.39.2020.07.07.02.29.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jul 2020 02:29:17 -0700 (PDT)
Subject: Re: [PATCH] tests/qtest/libqtest: Do not overwrite child coredump
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <f4bug@amsat.org>, qemu-devel@nongnu.org
References: <20200707031920.17428-1-f4bug@amsat.org>
 <9a16d2d9-405c-2110-debe-c92b8dbece33@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2e62e2a9-6fd0-fe6a-6122-2e10aab265e1@redhat.com>
Date: Tue, 7 Jul 2020 11:29:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <9a16d2d9-405c-2110-debe-c92b8dbece33@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 00:20:54
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
Cc: Laurent Vivier <lvivier@redhat.com>, Yury Kotov <yury-kotov@yandex-team.ru>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/07/20 11:03, Thomas Huth wrote:
>> +++ b/tests/qtest/libqtest.c
>> @@ -173,7 +173,12 @@ static void kill_qemu(QTestState *s)
>>          fprintf(stderr, "%s:%d: kill_qemu() detected QEMU death "
>>                  "from signal %d (%s)%s\n",
>>                  __FILE__, __LINE__, sig, signame, dump);
>> -        abort();
>> +        if (WCOREDUMP(wstatus)) {
>> +            /* Preserve child coredump */
>> +            exit(1);
>> +        } else {
>> +            abort();
>> +        }
>>      }
>>  }
> Would it maybe rather make sense to always use exit(1) unconditionally here?

But why is it a problem to overwrite the child core dump?  Aren't both
stashed away if you use the core.PID name as is common?

Paolo


