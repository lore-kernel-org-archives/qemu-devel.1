Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E6EC35657
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 16:19:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 182672073A
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 16:19:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ExUNYQAa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 182672073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5B18-0000mk-A5
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 11:19:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45822)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1j5B0T-0000KS-Gy
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 11:18:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1j5B0R-0001yr-S7
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 11:18:24 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:38379
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1j5B0R-0001yL-Io
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 11:18:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582301902;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q0xjK74zSUFCwt8OF3Yea/n1e7ICvhOOW+chIMMjhEc=;
 b=ExUNYQAahrpqkHRDb9LbkstA5RZCQ4U2v4nzp6MCi6lbKZ9WfQ79zQvbz77pyn3fU1/XNk
 BZvtwDYog3v1X3uu8U6+fn9sCWP4FrNcXlkmv05Smvla0A+sQLr58++4psMbU6Hp7R+kLm
 tbzmijs7Gy+k1OugfoovctVQIZYziQQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-383-Uz8d_7y6P9aSO_53mHT2Xg-1; Fri, 21 Feb 2020 11:18:20 -0500
X-MC-Unique: Uz8d_7y6P9aSO_53mHT2Xg-1
Received: by mail-wm1-f71.google.com with SMTP id g138so778648wmg.8
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 08:18:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=q0xjK74zSUFCwt8OF3Yea/n1e7ICvhOOW+chIMMjhEc=;
 b=UA/CWfPcCjxrj4Sa7l4afMqTqyMV8WdodhmAAzpGrV158BMO/khn7ixpmPoMaJ5Dtu
 PALeQWF5ERruwyvoa3X97+hVq4rqsf3cR8CXXbxaL4SVD0BDJoTRiSlZXmqjBBc0DVUn
 dwB5Yi9CbOv5yj/eK1fg51QyDX+L/NmejOV6mT/kNzr/5zcnO5z/Dy9756keKrJ29IBz
 vhN8eF3O82uJ5xtTGthA/Z8uRaQGxjSEVpPuJFAHQQoeKUt81IgRgvjKeCYfy01AUG6B
 yzIxSBAhT1xTLaEQ2h8cYZiwSHuwJ7/f5p3v7Q+H0XyGiEPhkEKAKbfMYjMgOHeUeYZQ
 ACAQ==
X-Gm-Message-State: APjAAAVoGrHmGcwbhfUKV50NttWMuDe9Glw4itPAVjVNrcdID2t44yFi
 HjeUvMfB8rI68ajw33ZOV9gmZFxjgfurZrfaw2TqnD7hdQHkiNnsSDq57UvQ7wa+HXTxU1IQko9
 F6k+RDa638tnc5Gk=
X-Received: by 2002:a1c:e28a:: with SMTP id z132mr4509410wmg.157.1582301899430; 
 Fri, 21 Feb 2020 08:18:19 -0800 (PST)
X-Google-Smtp-Source: APXvYqwalSJeIsujrCiSrroW52rvPnU7Y1jjcr44eQ5sxyID6MDwSNltrBO1Sf5fPBlPSESlmimAKQ==
X-Received: by 2002:a1c:e28a:: with SMTP id z132mr4509398wmg.157.1582301899200; 
 Fri, 21 Feb 2020 08:18:19 -0800 (PST)
Received: from [192.168.178.40] ([151.20.135.128])
 by smtp.gmail.com with ESMTPSA id c74sm4644627wmd.26.2020.02.21.08.18.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Feb 2020 08:18:18 -0800 (PST)
Subject: Re: [PATCH] target: i386: Check float overflow about register stack
To: Chen Gang <chengang@emindsoft.com.cn>
References: <20200221034547.5215-1-chengang@emindsoft.com.cn>
 <a5533719-7ef1-938b-e52c-20711e65417f@redhat.com>
 <900fd511-72f0-675d-4a7e-d228b2ade9c7@emindsoft.com.cn>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d893eac5-0b7a-ddfe-2acf-a6f27ab48ccf@redhat.com>
Date: Fri, 21 Feb 2020 17:18:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <900fd511-72f0-675d-4a7e-d228b2ade9c7@emindsoft.com.cn>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: qemu-devel@nongnu.org, Chen Gang <gang.chen.5i5j@gmail.com>,
 ehabkost@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/02/20 15:09, Chen Gang wrote:
>> -    /* XXX: test fptags too */
>> +    if (env->fptags[env->fpstt]) {
>> +        env->fpus |= 0x4100; /* Empty */
>> +        return;
>> +    }
>> +
> For fpop overflow, this fix is enough, but for me, we still need
> foverflow to check fpush/fld*_ST0 overflow.
> 
> Don't you think we need check fpush/f[i]ld*_ST0 overflow?

After fld/fild or any other push, FXAM ST0 should not return empty in my
opinion.

Paolo


