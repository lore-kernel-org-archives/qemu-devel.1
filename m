Return-Path: <SRS0=be0Y=DK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A07C4363D
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2020 09:00:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EEC9206F8
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2020 09:00:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nu1/mpOX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EEC9206F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOdPQ-0006jW-7I
	for qemu-devel@archiver.kernel.org; Sat, 03 Oct 2020 05:00:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60352)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kOdOQ-00064e-Gi
 for qemu-devel@nongnu.org; Sat, 03 Oct 2020 04:59:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41148)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kOdOO-0004uK-Kn
 for qemu-devel@nongnu.org; Sat, 03 Oct 2020 04:59:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601715587;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qynjoDCjx4m/g6+5llcltwdWNR+I4aaGp8YR7oQ4JZo=;
 b=Nu1/mpOXJQ9Z5EFJoNMg0FYSOBt4Avj80mqTg+slxCP69D8ALGu7iQEfy7mSxEkuylDUzL
 HtMgH4Au8Jd52KxSQunQFwSiyj2UiiA8kMAf7kls+q5jQM+PZmQ2mPlNtoqZ1NGdz8sVyv
 XdKXLaVW/jvE2Cv7JrDQWv7/huluDIw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-510-qtXHZNw3MgKaSCfJYXeUlQ-1; Sat, 03 Oct 2020 04:59:45 -0400
X-MC-Unique: qtXHZNw3MgKaSCfJYXeUlQ-1
Received: by mail-wr1-f72.google.com with SMTP id a10so1576250wrw.22
 for <qemu-devel@nongnu.org>; Sat, 03 Oct 2020 01:59:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qynjoDCjx4m/g6+5llcltwdWNR+I4aaGp8YR7oQ4JZo=;
 b=gI6URaDMVdC+60r/kqDy7u68+u6/ui+ybYTa56PsE1MuJSW0muRnBSrsGlConcyjP5
 EsgIJuOzEnHiA3Lj9K/lZrOeMmztGqBVjJ7XXxo2Of8mfTBUS8eiiDVqza39L0itfmAf
 beokz7pvgbeHdsbDAGNs3Iqrm9u9utrId382VSJAD/+s4253Z0gkFgpAk9wZGGa6kv50
 Vg1i/b53Gu5faezt0ElmayBlgdYQKoCIN7K0u9dXBqYMsluBzvhUKdBCwSa5kRgjvbxJ
 lo0I9wjh8pKzhQzVk+K3K5jHY0P8yose6zyVCp6Emf3Tn+yGVn1ohfrtLwfNuiS+rclF
 WPrg==
X-Gm-Message-State: AOAM533K5Tq+9zKchP8B6mps7wNuXghJhOx73jXk9AGKpEVqrNuMxMId
 tDVB4/2oqOpXmPFmhd/9oOdrG9TXt7r1d8OOBQWAC1QpBXPyfq1Zhq/2+M0c8rs1OK3/7VPHrjk
 xRSGdcsYpMqMDq3w=
X-Received: by 2002:adf:f7d0:: with SMTP id a16mr6930237wrq.381.1601715583944; 
 Sat, 03 Oct 2020 01:59:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyQOqsZimNsfNfvJdMHTjX1QMjvfbVUAapU11O3CaQpflnpJR9YkTp8D0YLj0090jxHSg95bQ==
X-Received: by 2002:adf:f7d0:: with SMTP id a16mr6930224wrq.381.1601715583727; 
 Sat, 03 Oct 2020 01:59:43 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:f6ef:6259:374d:b794?
 ([2001:b07:6468:f312:f6ef:6259:374d:b794])
 by smtp.gmail.com with ESMTPSA id n6sm4475244wmd.22.2020.10.03.01.59.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 03 Oct 2020 01:59:43 -0700 (PDT)
Subject: Re: [PATCH 0/5] kernel-doc ixes
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
References: <20201003024123.193840-1-ehabkost@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0955d463-1e86-09a2-4326-61c0eac9d0d3@redhat.com>
Date: Sat, 3 Oct 2020 10:59:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201003024123.193840-1-ehabkost@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/03 02:43:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.256, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/10/20 04:41, Eduardo Habkost wrote:
> Among other fixes in kernel-doc, this series get rid of
> QEMU-specific $decl_type='type name' hack in kernel-doc, because
> it made it impossible to document macros with names starting with
> uppercase letters (like most of the macros at qom/object.h).

Thanks, it seemed like a good idea but... it wasn't. :)

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

Paolo

> Eduardo Habkost (5):
>   kernel-doc: Handle function typedefs that return pointers
>   kernel-doc: Handle function typedefs without asterisks
>   qom: Explicitly tag doc comments for typedefs and structs
>   memory: Explicitly tag doc comments for structs
>   kernel-doc: Remove $decl_type='type name' hack
> 
>  include/exec/memory.h |  6 +++---
>  include/qom/object.h  | 22 +++++++++++-----------
>  scripts/kernel-doc    | 16 +++-------------
>  3 files changed, 17 insertions(+), 27 deletions(-)
> 


