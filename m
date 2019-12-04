Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95DDEC2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 15:36:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D87F206DF
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 15:36:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U8xbtYu4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D87F206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icWhd-0001Xe-Ek
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 10:36:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53503)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1icWg1-0000PQ-3U
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 10:34:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1icWfz-0000NL-Sv
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 10:34:53 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:43070
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1icWfz-0000KZ-NY
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 10:34:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575473689;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ohr+K9Wr9L1SwB4XbeQinW5OsnRUbekzuVwYWSF3DGY=;
 b=U8xbtYu4hl9nLHUcZWrbnMQWIbi12Rb2pfuB9OMDx//m1L6Urb8evIpi3rQbAZJrmu+QM7
 ttXCSFIv92Xw+ljs/mCp1pm7yRZG5usFnsLmoKP5n/MsMg6m/sJXEeV+JLC9bhBzf4LNfU
 jW2w1gE+pAxpHOZpkW8hNhFzII0Huw4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-zNs7vzLqMJ-ZhjB-Zgxkyg-1; Wed, 04 Dec 2019 10:34:48 -0500
Received: by mail-wm1-f69.google.com with SMTP id p5so2230161wmc.4
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2019 07:34:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ohr+K9Wr9L1SwB4XbeQinW5OsnRUbekzuVwYWSF3DGY=;
 b=SvcnJrpGLGeEKfUKuaF8OsgWQlnE0NyRYIZ3R8ieA2A+ygjmK2JWRzQ6487eTJUHF/
 lpslsiVmfn1mDE+YTQUT1qfkHixoakxgNIrWSNdqO83XbsjiCnC+9GUIGUZHTsY7E0Iw
 FwBT2mm6cb/dyEMwzFFHGDWeerq5WZm18IuWGfqAx91UfcTibC3ZUNt9rQ5ymj1jg/c/
 mZb7cgvDoR5oYG1DGA2h79rbwhtRZQ/oyfY9TIdryT/LL01FwuIyIMhRWsW9N6QAw4uv
 eb7/0ZHM42J7HSVCUK53ZM4CxDXxDAbl0IgmEWEl7RvGzj09q87TnMqRMdjbQt+E0yui
 IAgA==
X-Gm-Message-State: APjAAAU+Yep+0gLdH3Q3MZgJCDXW2B9lROQAeXLEuBNzP22Bmqj2gJ0e
 +HXQ/F/WV/DIWENRdYtD6ZlPIlIpTvYdczDZp1ps88//pHTgkQX3ZlMvtZpgPAdzBxDZj61EJXT
 Ej9W0YnwcX844deI=
X-Received: by 2002:a5d:4ed0:: with SMTP id s16mr4615822wrv.144.1575473687107; 
 Wed, 04 Dec 2019 07:34:47 -0800 (PST)
X-Google-Smtp-Source: APXvYqzCwDAGc25fHrVIgk3hM96SB/lE+J0Sx+odhAXM45pVbtAz8iw4flzaRpnlM2iJmSz78wu3Ng==
X-Received: by 2002:a5d:4ed0:: with SMTP id s16mr4615796wrv.144.1575473686830; 
 Wed, 04 Dec 2019 07:34:46 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:8dc6:5dd5:2c0a:6a9a?
 ([2001:b07:6468:f312:8dc6:5dd5:2c0a:6a9a])
 by smtp.gmail.com with ESMTPSA id c6sm6959402wmb.9.2019.12.04.07.34.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Dec 2019 07:34:46 -0800 (PST)
Subject: Re: [PATCH] target/i386: relax assert when old host kernels don't
 include msrs
To: Catherine Ho <catherine.hecx@gmail.com>
References: <1575449430-23366-1-git-send-email-catherine.hecx@gmail.com>
 <2ac1a83c-6958-1b49-295f-92149749fa7c@redhat.com>
 <CAEn6zmFex9WJ9jr5-0br7YzQZ=jA5bQn314OM+U=Q6ZGPiCRAg@mail.gmail.com>
 <714a0a86-4301-e756-654f-7765d4eb73db@redhat.com>
 <CAEn6zmHnTLZxa6Qv=8oDUPYpRD=rvGxJOLjd8Qb15k9-3U+CKw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3a1c97b2-789f-dd21-59ba-f780cf3bad92@redhat.com>
Date: Wed, 4 Dec 2019 16:34:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAEn6zmHnTLZxa6Qv=8oDUPYpRD=rvGxJOLjd8Qb15k9-3U+CKw@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: zNs7vzLqMJ-ZhjB-Zgxkyg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: kvm@vger.kernel.org, Marcelo Tosatti <mtosatti@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 04/12/19 16:07, Catherine Ho wrote:
>> Ok, so the problem is that some MSR didn't exist in that version.  Which
> I thought in my platform, the only MSR didn't exist is MSR_IA32_VMX_BASIC
> (0x480). If I remove this kvm_msr_entry_add(), everything is ok, the guest can
> be boot up successfully.
> 

MSR_IA32_VMX_BASIC was added in kvm-4.10.  Maybe the issue is the
_value_ that is being written to the VM is not valid?  Can you check
what's happening in vmx_restore_vmx_basic?

Paolo


