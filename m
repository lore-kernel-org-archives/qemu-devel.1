Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D05C4363C
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 06:57:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C6622087D
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 06:57:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g10GjPSc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C6622087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQPs8-0005oF-Mo
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 02:57:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52774)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kQPqq-0005FN-9f
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 02:56:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33995)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kQPqo-00023D-Nj
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 02:56:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602140187;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Knzyk4WI/UuS965rVOwx7edfDVSiZEvMd9Jnqw2zp7M=;
 b=g10GjPSc1gzAwXEoZx/fNkJM5F8JtsGCvJzoKt/IAE3u1XVV2MZQ/3KS0JhkWMBc7GV4gf
 Ucms9LmtzC2OQs3GzCjFGw7KVhvxzgEMTnb99zOgzBy/j6uuq6aMC1cyXPppTa+2zu5Qb1
 F1E0JZjMAiObwGiH8BYywYUvT7ngotY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-WYjcmaadOmysCOcjj6kePA-1; Thu, 08 Oct 2020 02:56:25 -0400
X-MC-Unique: WYjcmaadOmysCOcjj6kePA-1
Received: by mail-wr1-f71.google.com with SMTP id x16so3144807wrg.7
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2020 23:56:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Knzyk4WI/UuS965rVOwx7edfDVSiZEvMd9Jnqw2zp7M=;
 b=TccpVbg4VbUCH+gRyHZn9kr1b++thN4sxfuzjPVkQeCEN45atTsV/ZppRQdXG/KLxV
 tZDI0+vWioOE/6ee+w9TecCWUN2ELV5eKbxE5zsFOZDRDNSburtl6b2pK4O+m1PU2alZ
 88NIcuY+02Md360hEBcllVx93xijjRHZlbsbPNIqEl86lh+Bgb3JHPA8Bk5a6vYBBp+P
 OAHEduhbczmmqpaYkPWxXywitfl3KkyJ1TsjJBsfVQKxjm4nwk2uEJPKzETndjfwEXYu
 vM++CVuObC4UWhLbHIBDPjVltkl4HSNFRKkz7xM07mp1VJZ4UjuezhNEx4q4sJFN+8P4
 o3yA==
X-Gm-Message-State: AOAM533FqBEpvceYDMol470s9EFWYxIL2UmNpzE9BvVmBRvgKQlXmc4w
 ya3yQS2f5tXn+JyD4177xzqU+u2ExbeRPRPq7DM7QH8OV9Qdm9DQEprSLxwbfGKX6R0Hmi+g1Fa
 AqqJTdj1DI2gjBsU=
X-Received: by 2002:a1c:e444:: with SMTP id b65mr6662998wmh.147.1602140184434; 
 Wed, 07 Oct 2020 23:56:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyB+WHlDZnVcehp7G/TprfzAJExRwHcGmZshjkG98JqbC6UZlYcAeA0r6WGFdMrD2u5joQ0bQ==
X-Received: by 2002:a1c:e444:: with SMTP id b65mr6662980wmh.147.1602140184145; 
 Wed, 07 Oct 2020 23:56:24 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:bb8c:429c:6de1:f4ec?
 ([2001:b07:6468:f312:bb8c:429c:6de1:f4ec])
 by smtp.gmail.com with ESMTPSA id f14sm5668229wme.22.2020.10.07.23.56.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Oct 2020 23:56:23 -0700 (PDT)
Subject: Re: [PATCH] target/i386: Support up to 32768 CPUs without IRQ
 remapping
To: David Woodhouse <dwmw2@infradead.org>, qemu-devel <qemu-devel@nongnu.org>
References: <78097f9218300e63e751e077a0a5ca029b56ba46.camel@infradead.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6f8704bf-f832-9fcc-5d98-d8e8b562fe2f@redhat.com>
Date: Thu, 8 Oct 2020 08:56:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <78097f9218300e63e751e077a0a5ca029b56ba46.camel@infradead.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/08 02:56:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.742,
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

On 05/10/20 16:18, David Woodhouse wrote:
> +        if (kvm_irqchip_is_split()) {
> +            ret |= 1U << KVM_FEATURE_MSI_EXT_DEST_ID;
> +        }

IIUC this is because in-kernel IOAPIC still doesn't work; and when it
does, KVM will advertise the feature itself so no other QEMU changes
will be needed.

I queued this, though of course it has to wait for the corresponding
kernel patches to be accepted (or separated into doc and non-KVM parts;
we'll see).

Paolo


