Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E62C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 16:23:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 860A720870
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 16:23:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gcpyqPcT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 860A720870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrOTh-00061d-Hs
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 12:23:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34702)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jrOGx-0008DO-4H
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 12:10:43 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:22315
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jrOGv-0002GZ-AI
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 12:10:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593792640;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iEErfAAUmSWz7XxBKfMjIbETjeIrgJHwvgsvYUQtikY=;
 b=gcpyqPcTDKC53fDM5e0ssYMriPlcvtU9MDqGBWjKDanyrcVMgIR9lvE+QeCfQ03vkAuqFC
 PDNaQBA3K+mIqxl71nYLfGihdsehhGm2hu4kUL/RgDLO0yK4aikER/70kehNh4et3M2Z/z
 jUW/t2ghNLIKtl0zGpvWWVOJmcSYwyk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-s7FVdhplOguMxRezv524rA-1; Fri, 03 Jul 2020 12:10:39 -0400
X-MC-Unique: s7FVdhplOguMxRezv524rA-1
Received: by mail-wr1-f72.google.com with SMTP id j16so26768216wrw.3
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 09:10:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=iEErfAAUmSWz7XxBKfMjIbETjeIrgJHwvgsvYUQtikY=;
 b=Fg6THf7hRIl5JYrma2X1+voXsSeecrnk4AvtgBj7/xxHXvFIX33Cx/G4knSf8RPCfY
 JLllyp8ex+5sLKU4/XtfL34L0OPKbfUiTlcE/JqsfLRFKab+acAn8qSTHBFOa7F0xJC5
 vrm+V129bC5NUZtuL35wWZnEOVLtDbEa5obc35681AVvV4IZZpYcwQSeNpdl5kSTz8Nm
 Ja+u6ZTmXZpo7dL06sGL3sPOd84MFQYabptAXliG0ro3Czy5R6S1u4pwUJnzTovh9PQT
 Hbo5MRgG/PDUd8s28KbjJe/rcERx97sdLeFV5Afo2w0BnINUAUedGycUOZuihK9HAxbL
 Ukag==
X-Gm-Message-State: AOAM533FU8ozy45P3HDlR8u6WZOO5WIOBGGJ+8dCIge0lPOYHlpBK5w1
 BjxXjD7Lurx8a/sy1VdQT+M6tqUScLCsvHIgNeTzzgSN9dUKCHtHrF1mLVoRT0b77sSxnts3yDI
 bJwm4KZDUuYs1oc4=
X-Received: by 2002:adf:afc3:: with SMTP id y3mr39681190wrd.277.1593792637814; 
 Fri, 03 Jul 2020 09:10:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxAsHS28gtPjF7hu4kzjD3hdCBuvWM2/67JaTaA2T591inLvcv28B39mbGeRwVNu/VRE3ik6A==
X-Received: by 2002:adf:afc3:: with SMTP id y3mr39681177wrd.277.1593792637637; 
 Fri, 03 Jul 2020 09:10:37 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5cf9:fc14:deb7:51fc?
 ([2001:b07:6468:f312:5cf9:fc14:deb7:51fc])
 by smtp.gmail.com with ESMTPSA id h23sm10070wmb.3.2020.07.03.09.10.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jul 2020 09:10:37 -0700 (PDT)
Subject: Re: [PATCH 2/2] target-i386: sev: fail query-sev-capabilities if QEMU
 cannot use SEV
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <20200630154521.552874-1-pbonzini@redhat.com>
 <20200630154521.552874-3-pbonzini@redhat.com> <20200703160841.GA6680@work-vm>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d009abf4-6a78-bef2-5789-e51b7ec815e2@redhat.com>
Date: Fri, 3 Jul 2020 18:10:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200703160841.GA6680@work-vm>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 01:34:15
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/07/20 18:08, Dr. David Alan Gilbert wrote:
>> +        error_setg(errp, "KVM not enabled\n");
>> +        return NULL;
>> +    }
>> +    if (kvm_vm_ioctl(kvm_state, KVM_MEMORY_ENCRYPT_OP, NULL) < 0) {
>> +        error_setg(errp, "SEV is not enabled\n");
> Can you make that 'SEV is not enabled in KVM' so it's obvious
> that it's the KVM side and not the qemu side (like you've
> done in the previous patch).


Sure.

Paolo


