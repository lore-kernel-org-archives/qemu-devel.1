Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A87C388F7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 07:46:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 554922417F
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 07:46:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WrqycG+F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 554922417F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXg9u-0006oU-08
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 03:46:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57874)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kXg8q-0006HW-9g
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 03:45:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37742)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kXg8o-0006O1-GQ
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 03:45:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603871105;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IT/EThefC3oSO/BW+27Fa6cj0opkp2OAAvr9i7UvIII=;
 b=WrqycG+FzHaWx6KwhN9LH0oGVpwlqgv4naYPh5ydzC/ZKDQKJ2KqAYaV5RlSRMpgRZ1m94
 StCVe3ndbPVOJdgF3mHTEQ1L7SIRdwd0x3hDWHmJ1+pJchVcMW6TEBstradViEsDVBB9gR
 lOBL/AI7lpPIe65ZJWPaGiA+GdPI/4Q=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-z6P-DXzGPdeh1qMbCSkycg-1; Wed, 28 Oct 2020 03:45:03 -0400
X-MC-Unique: z6P-DXzGPdeh1qMbCSkycg-1
Received: by mail-wr1-f71.google.com with SMTP id j13so1436337wrn.4
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2020 00:45:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IT/EThefC3oSO/BW+27Fa6cj0opkp2OAAvr9i7UvIII=;
 b=UuuvBpSxM3ywj8MC/olGtKxRzdyyuw78PLzwHCq6apQwz2DeHtR2bkpc46W0HnLRdO
 6xZZmcVw1IAFjdHh+ZUZgy05WeTQ+y9o+jfRCpgtEcs7Iqx2IKccMsmFFx6HOguaVfen
 CnCFGCw9MCYSDiOewhp3jwrfYlbPt2KAG/HJvTy+3yQYHHrD9+PhmVUDaozpIQM0W0Sq
 dznwCjy0+V0KMcyj0bPBFux/gdCk058YxIqgUmzhSdwPbMwx3CgGglhLKDry6HiEI0zt
 +a5RjDT/ucCVHzXUl6JTyETjkaCWC+72vumu5dTx3hLPg6jPVI/T8oUuCI+yK+oFN0xb
 Z9Nw==
X-Gm-Message-State: AOAM533QZCK/WmxPy0uaBrfSIsSv+RozYoT6CZ2d2987B79QzHzzSjDl
 qnZguTzO86QiPFtX2M/ZAdA/hOp92dCC4oGqeTR7gPijNksd4iP3IUXaDCK80kUCPx/7EiGeXWJ
 gatq6ehE7szokVQY=
X-Received: by 2002:a1c:7f95:: with SMTP id a143mr6367162wmd.167.1603871102625; 
 Wed, 28 Oct 2020 00:45:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxXP6hBNa4ddKsUSErcQcq4TcuG91nufkWLxAmGUkxfPMp4IVoxgSQqj+h6pX9jcaScm9ztXA==
X-Received: by 2002:a1c:7f95:: with SMTP id a143mr6367139wmd.167.1603871102319; 
 Wed, 28 Oct 2020 00:45:02 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id u6sm4885576wmj.40.2020.10.28.00.45.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2020 00:45:01 -0700 (PDT)
Subject: Re: [PATCH 0/4] kvm: Add a --enable-debug-kvm option to configure
To: AlexChen <alex.chen@huawei.com>, chenhc@lemote.com, pasic@linux.ibm.com,
 borntraeger@de.ibm.com, mtosatti@redhat.com, cohuck@redhat.com
References: <5F97FD61.4060804@huawei.com> <5F991998.2020108@huawei.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <404f58a5-180d-f3d7-dbcc-b533a29e6a94@redhat.com>
Date: Wed, 28 Oct 2020 08:44:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <5F991998.2020108@huawei.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 01:50:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.167, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: zhengchuan@huawei.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 28/10/20 08:11, AlexChen wrote:
> The current 'DEBUG_KVM' macro is defined in many files, and turning on
> the debug switch requires code modification, which is very inconvenient,
> so this series add an option to configure to support the definition of
> the 'DEBUG_KVM' macro.
> In addition, patches 3 and 4 also make printf always compile in debug output
> which will prevent bitrot of the format strings by referring to the
> commit(08564ecd: s390x/kvm: make printf always compile in debug output).

Mostly we should use tracepoints, but the usefulness of these printf
statements is often limited (except for s390 that maybe could make them
unconditional error_reports).  I would leave this as is, maintainers can
decide which tracepoints they like to have.

Paolo


