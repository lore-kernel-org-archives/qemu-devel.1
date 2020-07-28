Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 514BDC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 11:36:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D7462065C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 11:36:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UGihNlXl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D7462065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0Nu9-0006Hv-Df
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 07:36:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39642)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k0NtA-0005DR-13
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 07:35:20 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:44440
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k0Nt8-00028h-Ec
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 07:35:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595936117;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rxIc+7btc1XJa0qTJXglzo89/XsH25QIkT4sTaX2T64=;
 b=UGihNlXl7tqaNbW35n2rCMxJ6wBNX6sLxrlEDVI/29wwteauVuuS8rwziY3fv3wuxODrjm
 Ak53XcLzv3K+TTci2l+x6gm5qvUWilFf0qW1ORtbyiV5kL/YNzkhkcdopwFm+zrHKFyBZY
 6dzRuuk1342mZpxy1y2t097sVoLTbfo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-38-7c-HZZ1fPBGhBN6PAODWkQ-1; Tue, 28 Jul 2020 07:35:15 -0400
X-MC-Unique: 7c-HZZ1fPBGhBN6PAODWkQ-1
Received: by mail-wr1-f69.google.com with SMTP id j2so2576380wrr.14
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2020 04:35:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rxIc+7btc1XJa0qTJXglzo89/XsH25QIkT4sTaX2T64=;
 b=lbH+H9O8aHD5pEgqY7L6Y/TLVR288bXODar90LEtdF6xK5yRKT5YfUAYu94z2ZQ4h/
 4jwTei8uxSoEpMhXxOoR4pffTpxLEmGBSAliIasS1Ii3RT3yFoQX2vWsMW+QdogZTEaU
 WtEe9uMM+rntlMdBhlujT3ODSQXGt9MzR+nU0Pclukks7PyUzXs8MrmhhJ6enkbdNIwX
 9XaZXOqZ7T7ykZOGnjDGzAMb4nTGGNTGqqqxU76UQR+lc3ZmNaLGfICmDyjHyu4puWDH
 hqKUOB5c7SOUTO8sI6JrcJJAZU7cN2n24zBW9cv3ncEIMCrrNvYwH72Rw024N8X4reO9
 jq3w==
X-Gm-Message-State: AOAM532Qaf0C+yFNBvSY1HmCINsdYFZzbiQMiECGVZWd3edCOivVG58X
 BmgefuWhGWox3tq0cifSPCGFtmvtHh/PrvBcfa2eMeBS5iSvrFiPeEiX+6dDzY56iaHh82VnLVb
 /E5uQUxADL7KFK2o=
X-Received: by 2002:a7b:c8d3:: with SMTP id f19mr1629347wml.163.1595936114336; 
 Tue, 28 Jul 2020 04:35:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx5SA8hvx0Ks+pvO9GUvHDBvDBp203q9UyhTy5GxDmMXNcLlWH7+Sc5ag60y8RPrch0nmW3Ag==
X-Received: by 2002:a7b:c8d3:: with SMTP id f19mr1629330wml.163.1595936114076; 
 Tue, 28 Jul 2020 04:35:14 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:80b0:f446:bb61:1dbb?
 ([2001:b07:6468:f312:80b0:f446:bb61:1dbb])
 by smtp.gmail.com with ESMTPSA id x11sm16709155wrl.28.2020.07.28.04.35.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jul 2020 04:35:13 -0700 (PDT)
Subject: Re: migration: broken snapshot saves appear on s390 when small fields
 in migration stream removed
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Max Reitz <mreitz@redhat.com>, Bruce Rogers <brogers@suse.com>,
 Claudio Fontana <cfontana@suse.de>, Thomas Huth <thuth@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Kevin Wolf <kwolf@redhat.com>
References: <8bbafdec-836d-b7de-cab8-7a325b6e238d@suse.de>
 <55c406cd-b9ca-4e9b-0acd-d33cfe2a70e3@redhat.com>
 <bf074240-8cc3-96ff-e95e-bd301822b756@suse.de>
 <ea3b617f-c2ea-534c-06ba-f5f9f43828a7@suse.de>
 <8125b1ff-373a-aadc-eccf-27c567007a27@redhat.com>
 <8ff7eeab-bef1-0957-a95c-72819680c431@suse.de>
 <1db6d502-73d1-5e3d-10d1-796d80ab8f07@suse.de>
 <13728e69-75a5-2edc-9ed3-6e08d94c722d@suse.de>
 <636bb3c4-2242-284b-30cd-299f447117c2@suse.de>
 <5f455e82e0a4f3662918dcdc85d1cfc5a3187896.camel@suse.com>
 <72ff33d4-653f-5702-fc04-9090653ab782@redhat.com>
 <ee1fa866-6d7d-bb7c-e811-4d94d9aa3459@virtuozzo.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <dc30924a-11f8-f452-837e-ae5ee7ec9cc1@redhat.com>
Date: Tue, 28 Jul 2020 13:35:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <ee1fa866-6d7d-bb7c-e811-4d94d9aa3459@virtuozzo.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 06:02:02
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
Cc: "Jason J. Herne" <jjherne@linux.ibm.com>, Fam Zheng <fam@euphon.net>,
 Liang Yan <lyan@suse.com>, Peter Maydell <peter.maydell@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 28/07/20 13:33, Vladimir Sementsov-Ogievskiy wrote:
>> Thanks for both your investigation.  Does the attached patch help?
> 
> For me, the reproducer is fixed with your patch.

Is it possible to make a quick testcase using qemu-io?

Paolo


