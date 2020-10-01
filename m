Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A60DC4727E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 17:40:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 806B62054F
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 17:40:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ALEDcXul"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 806B62054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO2ZO-0004Lo-IK
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 13:40:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60376)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kO2NF-0007zQ-Lh
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 13:28:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50393)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kO2ND-0004bV-Iz
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 13:28:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601573286;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gKmsfsY5pnQvFiZORh5K9yfabUaatXtNZkEd8zVMxKY=;
 b=ALEDcXulbZTuOEmjvKeMikqKA/eytw8K0r/zozNPQmr0eMh6rxUlcKdSI+XRvnXf+8Xs6C
 RrY+7ItEIFzt6XisKe8JusXU0E1MU72Kvfwf+BDv66MeMNfMYD6ER/WmctGXzWh6D42G7Q
 OYP/5k+o4MfRlkXoD7aOM3YlZ3bcSJU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-256-nSADjhyiM9-Hn9_VKU6EcA-1; Thu, 01 Oct 2020 13:28:05 -0400
X-MC-Unique: nSADjhyiM9-Hn9_VKU6EcA-1
Received: by mail-wr1-f71.google.com with SMTP id l9so2307052wrq.20
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 10:28:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=gKmsfsY5pnQvFiZORh5K9yfabUaatXtNZkEd8zVMxKY=;
 b=aG3uVmx54fk+Gu+brMK1HWRDUJm2xVlxW/I4U8AKrAaEowPkFpm++ArZ2LhzvHUQPR
 u83faOMF2pQayo5nBy5llDvBPww5sXwo2C6yf1RNi/sucUqwz+1HvoPLT7tzXyZ61UQ2
 T6lTGVfZZnAQp9gv1XB6D2uHHDXRtV2n6Y9vvTiiIrHbrdiF1r3BAQVZTX6Dm0TmTGhN
 fE+2cyNnj5fBNV5nIeaou+rJYqVMylxHWlsL//4IiUxVYoCBm8XWvz+q1jAIkOCz00bO
 jzGxXgsEOkpgcljALfM/fMTMstvjQUwj7vfpGzJzX1+0BeYb4sTdbafHY785rNTbPl6e
 v+TA==
X-Gm-Message-State: AOAM531azvQEayOXy1U4IqqNS1F1lctXG3VcspYCtya1sLhq1+rVO/G0
 TtRK7RAyb6QXe8U5uqsyp/deQ7aILFC/ujFHs/QX2EWz/li5bNr6wYYc2HyyYEF2cOrB1UEha6m
 vtX2azAtq3yqgdHM=
X-Received: by 2002:a5d:470f:: with SMTP id y15mr10132552wrq.420.1601573283768; 
 Thu, 01 Oct 2020 10:28:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxBWMJvA4kiv0H6UUgNEypCEKZJTY5t+x8tMl0sRx1nr3rujJUriDUfAw8xVMEvimCdrd2jSA==
X-Received: by 2002:a5d:470f:: with SMTP id y15mr10132528wrq.420.1601573283479; 
 Thu, 01 Oct 2020 10:28:03 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:86de:492a:fae3:16f2?
 ([2001:b07:6468:f312:86de:492a:fae3:16f2])
 by smtp.gmail.com with ESMTPSA id p3sm773401wmm.40.2020.10.01.10.28.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2020 10:28:01 -0700 (PDT)
Subject: Re: [PATCH v3 0/3] add MEMORY_FAILURE event
To: zhenwei pi <pizhenwei@bytedance.com>, peter.maydell@linaro.org
References: <20200930100440.1060708-1-pizhenwei@bytedance.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e4d4d5c7-20e6-04b5-5483-2659ac65a14a@redhat.com>
Date: Thu, 1 Oct 2020 19:28:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200930100440.1060708-1-pizhenwei@bytedance.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 02:15:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.26, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 30/09/20 12:04, zhenwei pi wrote:
> v2->v3:
> Use g_strdup_printf instead of snprintf.
> Declear memory failure event as 3 parts: 'recipient', 'action', 'flags'.
> Wrapper function emit_guest_memory_failure&emit_hypervisor_memory_failure.

Queued, thanks.  I took the liberty of adding a fourth value to
MemoryFailureAction, "reset", since "fatal" was used for two different
actions.

Paolo

> v1->v2:
> Suggested by Peter Maydell, rename events to make them
> architecture-neutral:
> 'PC-RAM' -> 'guest-memory'
> 'guest-triple-fault' -> 'guest-mce-fatal'
> 
> Suggested by Paolo, add more fields in event:
> 'action-required': boolean type to distinguish a guest-mce is AR/AO.
> 'recursive': boolean type. set true if: previous MCE in processing
>              in guest, another AO MCE occurs.
> 
> v1:
> Although QEMU could catch signal BUS to handle hardware memory
> corrupted event, sadly, QEMU just prints a little log and try to fix
> it silently.
> 
> In these patches, introduce a 'MEMORY_FAILURE' event with 4 detailed
> actions of QEMU, then uplayer could know what situaction QEMU hit and
> did. And further step we can do: if a host server hits a 'hypervisor-ignore'
> or 'guest-mce', scheduler could migrate VM to another host; if hitting
> 'hypervisor-stop' or 'guest-triple-fault', scheduler could select other
> healthy servers to launch VM.
> 
> Zhenwei Pi (3):
>   target-i386: seperate MCIP & MCE_MASK error reason
>   qapi/run-state.json: introduce memory failure event
>   target-i386: post memory failure event to uplayer
> 
>  qapi/run-state.json  | 85 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  target/i386/helper.c | 47 ++++++++++++++++++++++-------
>  target/i386/kvm.c    | 13 +++++++-
>  3 files changed, 134 insertions(+), 11 deletions(-)
> 


