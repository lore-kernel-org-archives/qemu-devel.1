Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 045A6C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 18:40:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81D2E207E8
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 18:40:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mqx0TWpS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81D2E207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joWnq-0002mK-Gv
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 14:40:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36882)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1joWhe-0006FW-6F
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 14:34:26 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:35939)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1joWhb-0004fb-UO
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 14:34:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593110063;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hU1F2XBnF4Qmnbnk3CNmQPOnbwbmDwMlwn4VJrjSZHk=;
 b=Mqx0TWpS7p/YZcQFn6y47Q6WuuSXnmS8ub6Tvu26pXYPnn1xlKgHxGuoTaUbMfsvm36j4j
 bj5Mj1lcbFf+EU2A4KNwFrlrfWYJ4KOMcPm4/C55QUYZJVQnUZ5nmWycymn2ANGQpt/1X4
 x83WkismM10lJ3cFlGKwv3Zq3bT22YI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-umrvyFiIOX6NNay9CSeZUQ-1; Thu, 25 Jun 2020 14:34:19 -0400
X-MC-Unique: umrvyFiIOX6NNay9CSeZUQ-1
Received: by mail-wm1-f70.google.com with SMTP id b13so5677665wme.9
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 11:34:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hU1F2XBnF4Qmnbnk3CNmQPOnbwbmDwMlwn4VJrjSZHk=;
 b=nuQ2QmymxdaY3/gkCxwBDAX0ThI75nPjO1i5S6Qna+gCk6UVsGpcwA8O760/NOcz/Z
 zG7qXODiGBPmoDj1Ahg4DjOwX3mD1V9285qRwBksikZn9syPLQgdWEGzsWSRxS8VxU9C
 n0icogV01YJbqQYpkBOXw2DvBdiIiKXgBypc4eDjowWs2J6gaMNlxkOgOH7Hssz5tAmA
 QmRGdxTA1lCaNUJvq6LLie/KhHPftEczgwUcLFQ9co1ILcQf8e3IsQaTOmDq/dpjzRDx
 xjGh+vN8PFjSBroYLOwMNLgOh8TIAqbyHjdLrDFBbDOqZHjN9Y0odEMthBf9zuENAJpT
 IRUw==
X-Gm-Message-State: AOAM532ffNe7Y1lJNmVZweZg/EWUXF/4PtZG29oO11YkX/LOJ2KvPeae
 61X/AIVmXBCF4KUJIPx5H+5snlcL1ZhNIBn+N5Zm64i4Nhvy2YBL4vTYPSZXWIfQlk6qdwHnskJ
 cLEQIkA08I8LM7VE=
X-Received: by 2002:adf:e811:: with SMTP id o17mr26142861wrm.53.1593110058107; 
 Thu, 25 Jun 2020 11:34:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzmxHRP736wNhEfRVjjMXrjnKntvJdyiXsCNVo3fuy06ozktj6SDOXetXJ2Z9Hv/5hgEhbTvA==
X-Received: by 2002:adf:e811:: with SMTP id o17mr26142845wrm.53.1593110057885; 
 Thu, 25 Jun 2020 11:34:17 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:91d0:a5f0:9f34:4d80?
 ([2001:b07:6468:f312:91d0:a5f0:9f34:4d80])
 by smtp.gmail.com with ESMTPSA id h142sm3608200wme.3.2020.06.25.11.34.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jun 2020 11:34:17 -0700 (PDT)
Subject: Re: [PATCH 4/8] i386: hvf: Implement CPU kick
To: Roman Bolshakov <r.bolshakov@yadro.com>
References: <20200624225850.16982-1-r.bolshakov@yadro.com>
 <20200624225850.16982-5-r.bolshakov@yadro.com>
 <9d63db4e-25a7-9c77-6f05-e5f808b8b33c@redhat.com>
 <20200625155712.GI25104@SPB-NB-133.local>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6508d40b-0142-1b42-2f48-fcd2da66ea4b@redhat.com>
Date: Thu, 25 Jun 2020 20:34:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200625155712.GI25104@SPB-NB-133.local>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 02:30:11
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
Cc: Claudio Fontana <cfontana@suse.de>, Richard Henderson <rth@twiddle.net>,
 Eduardo Habkost <ehabkost@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25/06/20 17:57, Roman Bolshakov wrote:
> So, the kick is not delivered to self and in case if destination cpu is
> not running. I think it can't interrupt subsequent hv_vcpu_run.

Yes.

>> If not, you can reduce a bit the race window by setting a variable in
>> cpu, like
>>
>> 	atomic_set(&cpu->deadline, 0);
>> 	hv_vcpu_interrupt(...)
>>
>> and in the vCPU thread
>>
>> 	hv_vcpu_run_until(..., atomic_read(&cpu->deadline));
>> 	atomic_set(&cpu->deadline, HV_DEADLINE_FOREVER);
>>
> 
> Sure, could you please explain who'll be racing? There's a race if a
> kick was sent after VMEXIT, right? So essentially we need a way to
> "requeue" a kick that was received outside of hv_vcpu_run to avoid loss
> of it?

Yes.  Note that this is not a new bug, it's pre-existing and it's common
to all hypervisors except KVM/WHPX.  I mean not the QEMU code, it's the
kernel APIs that are broken. :)

One way to do so is to keep the signal, and have the signal handler
enable the preemption timer (with a deadline of 0) in the pin-based
interrupt controls.  Hopefully macOS allows that, especially on 10.15+
where hv_vcpu_run_until probably uses the preemption timer.

> hv_vcpu_run_until is only available on macOS 10.15+ and we can't use yet
> because of three release support rule.
> (https://developer.apple.com/documentation/hypervisor/3181548-hv_vcpu_run_until?language=objc)
> 
> BTW, I'm totally okay to send v2 if kicks are lost and/or the patch
> needs improvements. (and I can address EFER to VMCS Entry Controls
> synchronization as well)
> 
> Paolo, do you know any particular test in kvm-unit-tests that can
> exhibit the issue?

No, it's a race and it's extremely rare, but I point it out because it's
a kernel issue that Apple might want to fix anyway.  It might also be
(depending on how the kernel side is written) that the next scheduler
tick will end up unblocking the vCPU and papering over it.

Paolo


