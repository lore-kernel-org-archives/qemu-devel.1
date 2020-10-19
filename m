Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EAD4C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 13:56:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F46E2223C
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 13:56:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xk6We0Ti"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F46E2223C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUVeO-0005d7-Ev
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 09:56:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49798)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kUVdT-00052q-1p
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 09:55:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32166)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kUVdQ-0000Wv-MI
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 09:55:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603115735;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aA0jzX7tNzrOCsglzpY68FA44pdLyDgBMIHShZjPs74=;
 b=Xk6We0TiSrGq+Uwl4IMsnlabjNnyl0GuSVgvFw8WiPWYXoAIELkzuU9tnf8CTVFcbVVmvT
 Axyxe7RP7K5cerY9SDzmcXAm7a/lqJr0jELIb64EbeR45Le5M1m6Gq5vbGVwQ4WRjva2B8
 Hj/VIWVd1YzTe3PKNuubZPIT9mB/rE0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-nAmvPo6bM0-KGqhQEKAxUQ-1; Mon, 19 Oct 2020 09:55:33 -0400
X-MC-Unique: nAmvPo6bM0-KGqhQEKAxUQ-1
Received: by mail-wm1-f71.google.com with SMTP id f2so4440206wml.6
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 06:55:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=aA0jzX7tNzrOCsglzpY68FA44pdLyDgBMIHShZjPs74=;
 b=sWKf0XrkFQuXmA+UogWyQD8N0kbvzbwi4IzzKC3fmTKT/F46LPap1jICzy3xIeRFge
 xMd2W8lTisR+d+vR2Rhv+6s9ISYSm4dSFgVLJyPecoHp1PIDd0YsQv41rvRsMCK7Gn8v
 pNlecj93saap7d5/u5iqawNg2HGPF9jQqw8soKfZH7QPRcf0zpsFw16cPsJ0GlxZEGiC
 uk6acjoWp/A9zN2NC5ZYzBdqJ6/hsk2FHRbj4CTGL4J+Ou3p8iG87jQ4dSq5xCvLNRpq
 JJIhI7l+7RAvMAIKX8/LslxIzza7++A/6C0/vBDszturgV4/5CAibB2SpKO1ZI71zlym
 1Jjw==
X-Gm-Message-State: AOAM530+H9nnBLX8uduBR3RSogq8mxvXmhJHxQdCey1hocctZzmSGaiA
 RoAYxbfA+GgQgGWAmn1hKNkIWpyo2ouVZ40skqmrH73Wb8NWOBDn9tZSQn3nDDVYjRnxH02Zenk
 MPaHkojRuWR99Au8=
X-Received: by 2002:adf:f10e:: with SMTP id r14mr18970889wro.337.1603115732135; 
 Mon, 19 Oct 2020 06:55:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxThESsJoi239e9/wo4+PpzQyWs7tEmNFUk8fsE0BzcnY7xEuDvrNLTIUXfAXGRSux2+9+wJg==
X-Received: by 2002:adf:f10e:: with SMTP id r14mr18970872wro.337.1603115731912; 
 Mon, 19 Oct 2020 06:55:31 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id e11sm13243853wrj.75.2020.10.19.06.55.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2020 06:55:31 -0700 (PDT)
Subject: Re: [PATCH] target/i386: Support up to 32768 CPUs without IRQ
 remapping
To: David Woodhouse <dwmw2@infradead.org>, qemu-devel <qemu-devel@nongnu.org>
References: <78097f9218300e63e751e077a0a5ca029b56ba46.camel@infradead.org>
 <6f8704bf-f832-9fcc-5d98-d8e8b562fe2f@redhat.com>
 <698c8ab6783a3113d90d8435d07a2dce6a2e2ec9.camel@infradead.org>
 <7b9c8ca4-e89e-e140-d591-76dcb2cad485@redhat.com>
 <c337e15dec18e291399b294823dccbdb63976a38.camel@infradead.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4d820db0-be0d-d47d-7a8a-874fb481a2ce@redhat.com>
Date: Mon, 19 Oct 2020 15:55:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <c337e15dec18e291399b294823dccbdb63976a38.camel@infradead.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 01:44:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: x86 <x86@kernel.org>, kvm <kvm@vger.kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19/10/20 14:21, David Woodhouse wrote:
> On Thu, 2020-10-08 at 09:53 +0200, Paolo Bonzini wrote:
>> I think you're not
>> handling that correctly for CPUs >255, so after all we _do_ need some
>> kernel support.
> 
> I think that works out OK.
> 
> In QEMU's ioapic_update_kvm_routes() it calls ioapic_entry_parse()
> which generates the actual "bus" MSI with the extended dest ID in bits
> 11-5 of the address.
> 
> That MSI message is passed to kvm_irqchip_update_msi_route() which
> passes it through translation —  which does interrupt remapping and
> shifting the ext bits up into ->address_hi as the KVM X2APIC API
> expects.
> 
> So when the kernel's kvm_scan_ioapic_routes() goes looking,
> kvm_set_msi_irq() fills 'irq' in with the correct dest_id, and
> kvm_apic_match_dest() does the right thing.
> 
> No?

Yeah, that seems fine.

> As far as I can tell, we *do* have a QEMU bug — not related to the ext
> dest ID — because for MSIs of assigned devices we don't update the KVM
> IRQ routing table when the Interrupt Remapping IEC cache is flushed.

> So... it'll hit the tip.git tree and thus linux-next as soon as Linus
> releases 5.10-rc1, and it'll then get merged into 5.11-rc1 and be in
> the 5.11 release.
> 
> At which of those three points in time would you be happy to merge it
> to QEMU? If it's either of the latter two, maybe it *is* worth doing a
> patch which *only* reserves the feature bit, and trying to slip it into
> 5.10?

It would be 5.11-rc1 because of the KVM_FEATURE_MSI_EXT_DEST_ID
definition which would not be in your patch but rather synchronized from
the Linux tree by scripts/update-linux-headers.sh.

If you send me the doc patch any time before 5.10-rc7, it will be in 5.10.

Paolo


