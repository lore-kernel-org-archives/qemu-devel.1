Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4593FC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 13:32:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E99920781
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 13:32:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FIGCaV8e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E99920781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joRz3-0008Qf-BS
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 09:32:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33692)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1joRxt-0007Yg-Ad
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 09:30:54 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:47641
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1joRxn-0005UT-SK
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 09:30:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593091846;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UWktvWNnP3KEVex2NV2wpzebZPheOzBVRlCRWcxkWY8=;
 b=FIGCaV8e1c0Waj/K7e1xAeawoc35RW6OnMiBPFGemUvhhwmEnCVeiRuZ1EHvT5VG478sHe
 W59GAVJuzQlx+SlYGJnSG0QK+eqzzoBFQUrbQPQgKTrXrYxRu46NeozxbMwKBPOLnpm8T5
 PB3tiZWTooxRni7Xk1VMBi97KPIJtls=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-LvBdVrCsMUSLKDDeTp7Kgg-1; Thu, 25 Jun 2020 09:30:42 -0400
X-MC-Unique: LvBdVrCsMUSLKDDeTp7Kgg-1
Received: by mail-wm1-f72.google.com with SMTP id g187so6829906wme.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 06:30:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=UWktvWNnP3KEVex2NV2wpzebZPheOzBVRlCRWcxkWY8=;
 b=mbO6a4GLQywPvOLLaLkG2olx7Z3IsReVXSzCdq4ZcVX8PgaLdqnH/Ddzwrhj5Gua9B
 9sa/eG5C2TnN8UkKBoPSzA8NT9p3NJrghqUzM0BuPYHGE3Ahlg1fpuJPhqgFNfyVmcUq
 8MWmnrp6BTfQ53e7YkPTDP8cYhSQ2gYwYh9fLjGeQQyEs7rNhOnJXFcWtcZdkderMClj
 xRkREpd6f0MFvVPmyc3scOREidUppz2P2VUHyI8zAuczHrop0lYXEgKxT3gM1FTNBLDt
 82BEvG2aqGd37v0pwNdexxs8ee2R64d6TazIaIHXOEBw7+iHIDCiNC+pQbNVP5vUDtB9
 OTQw==
X-Gm-Message-State: AOAM533RKipjt7GwOLY/DFA02UHRir79B6RXR+peT3KuWyRqn5WMzjwT
 olw48LleOOZMxwirKQRyPv2+V9XZnSfvIwhAv7q6ZMG7v726O+vCywX21eYw3oss6h4A+zgHhFZ
 FOhVfDwDWCCSwST4=
X-Received: by 2002:adf:c707:: with SMTP id k7mr35405526wrg.382.1593091841275; 
 Thu, 25 Jun 2020 06:30:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzSTVkVz+TvP7vJeMUV/eHG27VjVXUO4RKYDS1oWJghPkE05uNy+VS/TnAuf6/seK5VOKSIRA==
X-Received: by 2002:adf:c707:: with SMTP id k7mr35405514wrg.382.1593091841076; 
 Thu, 25 Jun 2020 06:30:41 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:91d0:a5f0:9f34:4d80?
 ([2001:b07:6468:f312:91d0:a5f0:9f34:4d80])
 by smtp.gmail.com with ESMTPSA id b18sm2293269wmb.18.2020.06.25.06.30.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jun 2020 06:30:40 -0700 (PDT)
Subject: Re: [PATCH 6/8] i386: hvf: Drop hvf_reset_vcpu()
To: Roman Bolshakov <r.bolshakov@yadro.com>
References: <20200624225850.16982-1-r.bolshakov@yadro.com>
 <20200624225850.16982-7-r.bolshakov@yadro.com>
 <ac800efc-c51d-e44c-de5c-cdef81d24dec@redhat.com>
 <20200625123637.GG25104@SPB-NB-133.local>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <34821aae-e8f5-adc6-eab5-0a6f6b2835e8@redhat.com>
Date: Thu, 25 Jun 2020 15:30:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200625123637.GG25104@SPB-NB-133.local>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 00:45:15
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>,
 qemu-devel@nongnu.org, Cameron Esfahani <dirty@apple.com>,
 Claudio Fontana <cfontana@suse.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25/06/20 14:36, Roman Bolshakov wrote:
> 
> Yes, there's such a place. post-init and post-reset invoke
> hvf_put_registers() and the latter one calls hvf_put_segments().
> hvf_put_segments() sets CR4 and CR0 via macvm_set_cr0/macvm_set_cr4
> using the CR0/CR4 from env. So, the reset is relying on generic QEMU
> CPUX86State now. LMA in EFER is reset there as well.

Ok, do you want to send a follow-up or a v2 of this?

> I don't know any alternative for PDPTE and VMCS Entry Controls in
> CPUX86State, that's why I left explicit reset of the VMCS fields in
> post-reset.

VMCS entry controls should be handled by macvm_set_cr0 as well, because
QEMU does not use any except for the LMA bit.  They are initialized zero

    wvmcs(cpu->hvf_fd, VMCS_ENTRY_CTLS,
	  cap2ctrl(hvf_state->hvf_caps->vmx_cap_entry, 0));

but in practice the last argument ends up being zero all the time.

PDPTEs are not a problem, because they are not used after reset (only if
CR4.PAE=CR4.PG=1 and EFER.LME=0).

Thanks,

Paolo


