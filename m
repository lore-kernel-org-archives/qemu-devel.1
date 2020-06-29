Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 794FDC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 14:21:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41B6623372
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 14:21:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IGFF2XbZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41B6623372
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpuey-0008QD-JC
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 10:21:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41814)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jpuca-0006GD-OP
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 10:18:57 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:42868
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jpucY-0005mY-L7
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 10:18:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593440332;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=psB7wiQIFCJCyYfYQqFWBqPaXNNm1dPPXU6s7FqbWZc=;
 b=IGFF2XbZm4F4cvnZIbYxzJ0zCHnjQgljR5DTSkIfB0n6heWcQNnVybDP4kf9pyqGf2lzg+
 9zkYuU/kiFy2r3v14OxlcA1+uilQ+thbP9ZZY0xVm/BnMa6mSlKzisXovt/4tVNvQU/cIU
 8CAo9vpq1eMR6z9wgT2Wq4Y/NY+JUiM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-LOekeCBcN_aC6Q0rw-iX2A-1; Mon, 29 Jun 2020 10:18:50 -0400
X-MC-Unique: LOekeCBcN_aC6Q0rw-iX2A-1
Received: by mail-wr1-f70.google.com with SMTP id b14so16691999wrp.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2020 07:18:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=psB7wiQIFCJCyYfYQqFWBqPaXNNm1dPPXU6s7FqbWZc=;
 b=huU+UknuIzteFA6xkvVixVELVAzm2jJ2S68gJN5bdsuSTgmAoChFm2p9n6+bXP3q8d
 Lw0xwYcGLCOBwlMMF6Z/Q8L6g4K2Hyvw46DCkmH5IMhBCAqv14OWmXjWyJNYMTvSgdls
 zqwYhJhWXV8rd689SWXTEL7FIXieq4v6rlonVtGFMjYqG+8b8140ajBUk7UNECwYH2yj
 LlB5bo95ZLJv6TFOCSvLbBsLz05ygID6cHuUuwYSyybixKl8SGTL8/NUeoDJHtK1ww9o
 Jy3yl9vuSTyXUnx0wlRbcYchuRLjprQeWpj9yZOfJCeV78KtqTHQoF2AcTWIaTX39Bs9
 npXw==
X-Gm-Message-State: AOAM531ewYNuXk/5BYP/kAqkhv8mzvqNc71hOJa/Y2ycjYQU7FGu4mD/
 FyHJ0RyvjhpGiifQPCCRINiMVPpeK1NjiBfRZAatw5du818+MDG+3jmje570rSr1bZnij/2f8JG
 zysgfac2hyTY9FcY=
X-Received: by 2002:a05:600c:2152:: with SMTP id
 v18mr17784336wml.5.1593440329217; 
 Mon, 29 Jun 2020 07:18:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyHUuQHQOgCz+yLU+QCCC4/LOkexSZ/BTKxZSbK+fm4igrgtGW8tnZUnazpuVVpqqn2mxZ/iQ==
X-Received: by 2002:a05:600c:2152:: with SMTP id
 v18mr17784266wml.5.1593440328044; 
 Mon, 29 Jun 2020 07:18:48 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:b0e5:c632:a580:8b9a?
 ([2001:b07:6468:f312:b0e5:c632:a580:8b9a])
 by smtp.gmail.com with ESMTPSA id x5sm29640025wmg.2.2020.06.29.07.18.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jun 2020 07:18:47 -0700 (PDT)
Subject: Re: [PATCH 4/8] i386: hvf: Implement CPU kick
To: Roman Bolshakov <r.bolshakov@yadro.com>
References: <20200624225850.16982-1-r.bolshakov@yadro.com>
 <20200624225850.16982-5-r.bolshakov@yadro.com>
 <9d63db4e-25a7-9c77-6f05-e5f808b8b33c@redhat.com>
 <20200625155712.GI25104@SPB-NB-133.local>
 <6508d40b-0142-1b42-2f48-fcd2da66ea4b@redhat.com>
 <20200629113107.GL25104@SPB-NB-133.local>
 <d1d7cf19-d56c-c095-a3b8-45e2be0752ea@redhat.com>
 <20200629132911.GN25104@SPB-NB-133.local>
 <0c8d14fa-e2cf-00e7-135f-d88fda38f31d@redhat.com>
 <20200629140433.GO25104@SPB-NB-133.local>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <cb4a42b2-5bb7-5f69-64d1-cad6f4bb05df@redhat.com>
Date: Mon, 29 Jun 2020 16:18:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200629140433.GO25104@SPB-NB-133.local>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 01:06:01
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

On 29/06/20 16:04, Roman Bolshakov wrote:
> My approach is based
> hv_vcpu_run() and should hopefully work almost anywhere where
> Hypervisor.framework is available because Hypervisor framework exposes
> timer value
> (https://developer.apple.com/documentation/hypervisor/vmcs_guest_vmx_timer_value)
> since macOS 10.10.3+.

There are a few other constants for which it would be unwise to write
from userspace, so that's not a big consolation. :)

> I can also test how hv_vcpu_run_until() performs with HV_DEADLINE_FOREVER
> on the Beta. And if the performance issues with VMX-preemption timer and
> hv_vcpu_run_until() are fixed there.

Thanks!  The main thing to test on Big Sur would be: 1) whether the
preemption timer bit in the pin controls "sticks" to 0 after setting it
2) whether the bit reads back as zero after
hv_vcpu_run_until(HV_DEADLINE_FOREVER).

Thanks,

Paolo


