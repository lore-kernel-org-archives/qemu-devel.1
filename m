Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC8AC43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 13:01:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 501BC2068E
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 13:01:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AOOZCFGy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 501BC2068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJG0u-0007bQ-8H
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 09:01:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38568)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kJFyb-00065r-QN
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 08:58:57 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:35284
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kJFya-0006wI-6N
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 08:58:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600433935;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z5c+ylU03clNmUQ0Oc0KvH0pzpJvkbd6G/k2xEstVvA=;
 b=AOOZCFGyMkiGpff8zWIpCOSPeYUX065JX4BKf+YsMkmyMU3ufciPXJJ/7RLEUGYG+yDe8L
 pJjl9MbsX7yNMrNzSHAlL9uo/rSWC5QvhtypBhIzT7qGJghcSG+6Ln2k4K6hvoTrd0bY+m
 +q88ny18ul+guZKt1uMqdHdaPUx5oJU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-171-BX8izdZLMi-I8HTtkAbpsQ-1; Fri, 18 Sep 2020 08:58:53 -0400
X-MC-Unique: BX8izdZLMi-I8HTtkAbpsQ-1
Received: by mail-wm1-f70.google.com with SMTP id l26so1443672wmg.7
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 05:58:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=z5c+ylU03clNmUQ0Oc0KvH0pzpJvkbd6G/k2xEstVvA=;
 b=peNeBg+bhJ3j6DSsa3KpyUhDhPJeg9fkIWUQwGKoeQoFEBDEId3BoupLVU6xLdyCYb
 c0HMEmOXWhZOX5tudLp63uJ4zK8bUalqMyTybVZrfQzQDYX7iuCza7l3v2NSwf8eSBbv
 hq3oLNG9D5gC45hA1Ue/zwUxVaT14GZ2whcARbAfe4eluwJkHwn5c4qKJGh0TKxDD3Q7
 7EDtdYqSOH48luRZ2AfqLhO86cI12fn1iVdVwDuIzFXMAM3BOQcZosR0TRRqdnQJrYDp
 ayJ0yEmiqXDm5DDCV4CEDV1DhSDjvuTse7UAJ05swuwehS+jn7jqeXGWmqs/Hp0TP9AW
 USRA==
X-Gm-Message-State: AOAM533zK3nXSPjO+AfHGjZVmL2Np9caSU7hcALXBdBGFgHFvAGcXbuM
 2ijTGD44d5dBgxkzNyiSTG+ybmkNVa6fZXfR9I9QEfkhjjYgtAdGr89G8ucS0s+ASCfP+zk6/zx
 iwgzhpGtAels087I=
X-Received: by 2002:adf:f885:: with SMTP id u5mr36432363wrp.382.1600433931669; 
 Fri, 18 Sep 2020 05:58:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw2VW+sEa+1SCnLYe157azz3EsCtezgv0LHZWp7pg8buiQYiyXUX1tT6IdXtzFAVNhRdFl0LA==
X-Received: by 2002:adf:f885:: with SMTP id u5mr36432350wrp.382.1600433931422; 
 Fri, 18 Sep 2020 05:58:51 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:69b4:4715:609f:385f?
 ([2001:b07:6468:f312:69b4:4715:609f:385f])
 by smtp.gmail.com with ESMTPSA id a11sm4962593wmm.18.2020.09.18.05.58.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Sep 2020 05:58:50 -0700 (PDT)
Subject: Re: [PATCH v3 01/10] capstone: Convert Makefile bits to meson bits
To: luoyonggang@gmail.com
References: <20200917235720.2685978-1-richard.henderson@linaro.org>
 <20200917235720.2685978-2-richard.henderson@linaro.org>
 <047ad15d-e847-a53d-d0ef-443196085e10@redhat.com>
 <CAE2XoE_Dk-h1hyZSBDuf-TZS1i+p2fMtsk5P9ugHpQPARSvmdA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b10357f4-3d0c-9c8a-5f3a-dda3a7706399@redhat.com>
Date: Fri, 18 Sep 2020 14:58:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAE2XoE_Dk-h1hyZSBDuf-TZS1i+p2fMtsk5P9ugHpQPARSvmdA@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 07:01:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -69
X-Spam_score: -7.0
X-Spam_bar: -------
X-Spam_report: (-7.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.869, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 qemu-level <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 18/09/20 10:42, 罗勇刚(Yonggang Luo) wrote:
> I also have a question that how about convert
>   --disable-capstone) capstone="no"
>   ;;
>   --enable-capstone) capstone="yes"
>   ;;
> to 
>     --disable-capstone) capstone="disabled"
>   ;;
>   --enable-capstone) capstone="enabled"
>   ;;
> 
> for consistence with meson

We can do it but it need not hold this series IMHO.

Paolo


