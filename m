Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC119C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 17:01:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5B492078E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 17:01:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SNcFoKu8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5B492078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jksTw-0004Qr-Vn
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 13:01:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43356)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jksSu-0003Wt-BY
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 13:00:08 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:46017
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jksSs-0005JI-1u
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 13:00:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592240404;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=10u7Yso4tdSWn9I0ZXrfDQrcu7OeT3LpiK4JAy9+lWw=;
 b=SNcFoKu85DfmjvE4MOhLPC81pwyMKIHJwc2LP8bXTDunxROLUkYkJfaZzFEv+2XUwNFP3h
 6nNqEawRjq97nQbtdNh7Av5bMdy9kR2sG1Juz1TYFn/LBOSv+G549wSGvev8FZAK+fWTGM
 Ik5P5TbUR4pSb9yZwyfyL2ftY1FBIsQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-134-k23zbRsaMFaimGqU6kreSA-1; Mon, 15 Jun 2020 13:00:01 -0400
X-MC-Unique: k23zbRsaMFaimGqU6kreSA-1
Received: by mail-wm1-f72.google.com with SMTP id a18so46780wmm.3
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2020 10:00:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=10u7Yso4tdSWn9I0ZXrfDQrcu7OeT3LpiK4JAy9+lWw=;
 b=C7BvM/jzwSKIPdnEBwdidmShpCv51dUSneSCtCpWuW9DihC3RT16zkB1BeZtnePTYY
 PBJ2+Q3KLHuzRLHY6es6qGtwlaRxEGTbkxY/3hXv5ynyp2IGeL2OWQKqONs5VlUwqIaM
 BOcn7J3rpYSwbg192dlZH02F0cjuB718njgRr0bGZEOcHCAJ5fqNKX6QF7CxShAhfawq
 WK/eKekuIDbwz6salsaOuNZiMFDuhNN+Jc+DnHLEgFqxbQm0QEtfP1tUPPcZQuSVp6bt
 r2AOjT5iJB39MGSvpPjbXhuE5tekYQ65wTGygpDhchZclsj1+fzXzJi1qttMeWi2QXjG
 uYUQ==
X-Gm-Message-State: AOAM5309Fy000986jkOx3mHKQcOreypB09DHJ6VFmu3RB6vFnOg83OCY
 jW8i4SMaQywRLp6ZgmXrISdVDqqmTLpVVNtRdAfUbP6oi1So4fqeh8R2Zow2Mvnzi8+/+FEKStN
 xg72h/mCCMlKlfls=
X-Received: by 2002:adf:f512:: with SMTP id q18mr32148928wro.38.1592240400279; 
 Mon, 15 Jun 2020 10:00:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyiXdtfU2ldZ4uhu6+kNqs0vhMDnVevCsyLSUBfR6TdlRJsYjUrLyY06RM5Z39PrOvNNdW4Cg==
X-Received: by 2002:adf:f512:: with SMTP id q18mr32148896wro.38.1592240399975; 
 Mon, 15 Jun 2020 09:59:59 -0700 (PDT)
Received: from [192.168.178.58] ([151.48.99.33])
 by smtp.gmail.com with ESMTPSA id b132sm237068wmh.3.2020.06.15.09.59.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jun 2020 09:59:59 -0700 (PDT)
Subject: Re: [PATCH] Makefile: Install qemu-[qmp/ga]-ref.* into the directory
 "interop"
To: Peter Maydell <peter.maydell@linaro.org>
References: <1591663670-47712-1-git-send-email-wang.yi59@zte.com.cn>
 <94e456a8-0b4f-e1fd-7baa-8f81f36c6872@redhat.com>
 <31290c21-01bb-e191-a166-1595f4fc8549@redhat.com>
 <CAFEAcA-D440Z4-cPdmpMXJcfkxjrHTOvwO2PG5BhyXMzRCQN+w@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <eb11ce18-f1db-1d60-6b8e-3b0ba6ce6993@redhat.com>
Date: Mon, 15 Jun 2020 18:59:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-D440Z4-cPdmpMXJcfkxjrHTOvwO2PG5BhyXMzRCQN+w@mail.gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 01:12:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Yi Wang <wang.yi59@zte.com.cn>, wang.liang82@zte.com.cn,
 QEMU Trivial <qemu-trivial@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, xue.zhihong@zte.com.cn,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Liao Pingfang <liao.pingfang@zte.com.cn>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 15/06/20 18:32, Peter Maydell wrote:
>> Queued, thanks.
> I guess this works, but it's kind of odd because it's installing
> a non-Sphinx document into the Sphinx manual directory.
> 
> I'm hoping we'll be able to land the conversion of the qapigen
> stuff to rst this cycle, which will make this change moot;
> so I suppose it's the most expedient fix for the moment.

I can keep the patch in the queue and not submit it unless really necessary.

Paolo


