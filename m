Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97718C2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 14:09:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA0C1207DE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 14:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HojbH0hS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA0C1207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kb2QO-0008Ba-Il
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 09:09:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48718)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kb2Ph-0007eQ-6N
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 09:08:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59045)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kb2Pe-0006Ii-9d
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 09:08:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604671701;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1bS11JZvYuw8fQhIRHUl4jInVsxqktGVvq+Wt24XfiM=;
 b=HojbH0hSTiAZS4wE2bvVrpFXytWhof+RNjtvtdZ0sqyH/JNDRwcgkK1Qhkg6feCiX/8Bzc
 ikBaAslt7gv65WwDTFm+83+NYZmKVo5YMPvt5NaLImaJjZGPclzx6TFltEu4uqMk2QBv7Z
 mKYDvCu4D7csrxpjTLGNiuxCgTvvwtA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-537-RBrF3OozOKaad7mdgIasPw-1; Fri, 06 Nov 2020 09:08:17 -0500
X-MC-Unique: RBrF3OozOKaad7mdgIasPw-1
Received: by mail-wm1-f70.google.com with SMTP id z62so599219wmb.1
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2020 06:08:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1bS11JZvYuw8fQhIRHUl4jInVsxqktGVvq+Wt24XfiM=;
 b=C7DpMMDf/z8IGRnIMWSG+mHyxq5gIgG+asgVEFJtNZUsI+bUtu1HtSZXZKeavCH+JR
 u4cjKlmVJ7la0qVvPb2qVAyaeivwit6C5WKP/Ab7E31/NCuMRttrEMX66iG2D57BChf7
 Z4QMEGPFuNzJX8bAOrNkWA0PyQDRkeRKyRNVuu1cPQVdbqGnVofIhAZmdQdC95x+40n7
 WiDgdG2J5pvm2jGIr3HRdCndOkQnALkJiWyux9FWzbbO7Fg6DTeFznSEKLfli3EDluA+
 5FeBNpxChRQjynOWyU+SLeCmz4cmn3gHtB6xIMBW+0synfLAmed1gBMyjuhas/Tpva71
 8bnw==
X-Gm-Message-State: AOAM533dhDIEm2v3Zfe+zYzTbhPpQ27c8Lw0IqzCgzvEptly2kNSgKba
 WvvXR2yOx42P0xNl1XwP12zUO96dHJ3czkcSeW8y/DR2vErjVAD6MJ7t8JjSN5r3OrfLbMnNVLs
 dKuZ8gnrSzIFYjCs=
X-Received: by 2002:adf:fd0e:: with SMTP id e14mr2805875wrr.119.1604671696760; 
 Fri, 06 Nov 2020 06:08:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwissxLkze5VqyFHlFxuJVuw89BiHOEdrKz/Q4ezEp8nQiSA/7yuwGmpfFNsHUAOoH9EioDeQ==
X-Received: by 2002:adf:fd0e:: with SMTP id e14mr2805848wrr.119.1604671696582; 
 Fri, 06 Nov 2020 06:08:16 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id i33sm2274362wri.79.2020.11.06.06.08.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Nov 2020 06:08:15 -0800 (PST)
Subject: Re: [PATCH] scripts/checkpatch.pl: Modify the line length limit of
 the code
To: Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
References: <20201105154208.12442-1-ganqixin@huawei.com>
 <CAFEAcA9QMBqF0Bm44q4m1d=QaPVBJodH9rwuYhGx5H6zy6ULcg@mail.gmail.com>
 <87d00qk51l.fsf@dusky.pond.sub.org>
 <CAFEAcA-_5vRbsi5fFpyLV2OyDX5TVrpAx7_Z43wqvb1zhQO_8w@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <37c519e4-d72b-944c-ed70-038f9c606be9@redhat.com>
Date: Fri, 6 Nov 2020 15:08:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-_5vRbsi5fFpyLV2OyDX5TVrpAx7_Z43wqvb1zhQO_8w@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/06 07:11:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Gan Qixin <ganqixin@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Chenqun \(kuhn\)" <kuhn.chenqun@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/6/20 2:39 PM, Peter Maydell wrote:
> On Fri, 6 Nov 2020 at 13:07, Markus Armbruster <armbru@redhat.com> wrote:
>> The current "warn at 80, error at 90" is a compromise.  It's the result
>> of a lengthy argument.  Why reopen it?
> 
> There was some previous discussion under this thread:
> https://lists.gnu.org/archive/html/qemu-devel/2020-10/msg05653.html
> 
> which I think is what prompted this patch.

Can we keep the error please? Maybe 132 is the next display logical
limit once we increased the warning from 80 to 100.

I understand hardware evolved, we have larger displays with better
resolution and can fit more characters in a line.
I am a bit wary however functions become heavier (more code into
a single function). Maybe this checkpatch change should go with
a another one warning when a function has more than 80 lines,
excluding comments? (Even 80 is too much for my taste).

Regards,

Phil.


