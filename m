Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E776C4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 07:39:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5956022249
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 07:39:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E4l+Foir"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5956022249
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kV8iV-0006vF-D8
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 03:39:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59406)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kV8hD-0005o7-3g
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 03:38:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55974)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kV8h9-0005hy-OK
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 03:38:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603265878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tsBvKrF9yFaxeg5LaqOccXuiuNBlghcD9UOQytUvFRI=;
 b=E4l+FoirhaqmvoGIOYRIcEF4lqyxtstGFqQJWK0htRcQpHw6mT85vfi+6Hbbmtg8UJqNpE
 4HiUVqjbu+NeqSAEumprAbRF2DBJJuZahKzYfx6fdnXuFoVVD6T5eqEGk9x/YmIJJfm3l+
 M9gYeoMpQNAJXVJj+o9rsJeuiiwdJU0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-536-m4HK_4nbO5-vFdep9OGlPQ-1; Wed, 21 Oct 2020 03:37:56 -0400
X-MC-Unique: m4HK_4nbO5-vFdep9OGlPQ-1
Received: by mail-wr1-f72.google.com with SMTP id 47so1109269wrc.19
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 00:37:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tsBvKrF9yFaxeg5LaqOccXuiuNBlghcD9UOQytUvFRI=;
 b=fQb93xC5e6/lb7t+09R9uQ6/AqBsYB2Y2Mnua/hK/tx3JD8pN6mQND80zE4CYTFlCi
 webe1T6JjIfNLmsWhi7yY6WDcgjLGQwrbEodwQBnhNghjXq9BPeT/FiH+sbzdDPHkS3z
 nO/NAyNq2++FvoLSr/06bZ/zSn1m3Nd6xpYXvwhp1V66V68rewSt1v1NuptZsHU0FljD
 byBmEDKx2VgSI+9DeDxCvSkU3Lnae1JsBoR+CXuXD43gYfO/VYeeTIFV/5S2BZMal51x
 dbr4ZZxrfqXcnbhatXBHA+e9o6sjl4hlGX8kG2PBqmQRXTf9Umj572mskN3c1zaDdNd0
 vD2w==
X-Gm-Message-State: AOAM530MN3wJSCBgsNqM4vnRRravtlAUXO2brCtC1J0y0OevX3yuIect
 7XwflXdbv+uoXsJjam5bHLnzZUOjubuyef/CcIPdtIiivsPlbEQTb9seJa9VARdLIskfM8vg4r8
 YGc8FKu1log13d3E=
X-Received: by 2002:a5d:6341:: with SMTP id b1mr2921367wrw.373.1603265875359; 
 Wed, 21 Oct 2020 00:37:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxA7Hx2bRRw4PE5VdLC8wBQ0TD5+wp/HrJC4gzZrbI7Jboj80gHvwfNgwQLqr/9UnemkgpqTg==
X-Received: by 2002:a5d:6341:: with SMTP id b1mr2921342wrw.373.1603265875102; 
 Wed, 21 Oct 2020 00:37:55 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id y7sm1863687wmg.40.2020.10.21.00.37.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Oct 2020 00:37:54 -0700 (PDT)
Subject: Re: [PATCH 1/1] Skip flatview_simplify() for cpu vendor zhaoxin
To: Alex Williamson <alex.williamson@redhat.com>
References: <20201016112933.14856-1-FelixCui-oc@zhaoxin.com>
 <20201016112933.14856-2-FelixCui-oc@zhaoxin.com>
 <a971c9db-469f-ddc0-1a27-3e21958f6ff7@redhat.com>
 <20201019130206.1d3baffc@w520.home>
 <4d2b96cb-8f7f-2598-39e6-4cf0f61d567b@redhat.com>
 <20201020164437.5e3cb4ce@w520.home>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <783b5ef0-277c-363d-f342-7c0351f9ac16@redhat.com>
Date: Wed, 21 Oct 2020 09:37:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201020164437.5e3cb4ce@w520.home>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 22:12:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: FelixCuioc <FelixCui-oc@zhaoxin.com>, Eduardo Habkost <ehabkost@redhat.com>,
 CobeChen-oc@zhaoxin.com, qemu-devel@nongnu.org, TonyWWang-oc@zhaoxin.com,
 RockCui-oc@zhaoxin.com, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/10/20 00:44, Alex Williamson wrote:
> Do we necessarily need a memory map ioctl for this or could it be the
> QEMU code that compares the old and new maps to trigger map and unmap
> ioctls?  For example (aiui) our race is that if we have contiguous
> memory regions A and B and flatview_simplify() tries to expand A and
> delete B we'll see a series of listener notifications deleting A and B
> and adding A'.  But the vfio QEMU code could parse the memory map to
> determine that old A + B is functionally equivalent to A' and do
> nothing.

I think the issue is a bit different, and in fact there are two sides of
the same issue.  Say you have A (large) and it is replaced by A'
(smaller) + B, then:

* the first part of A disappears for a moment before A' appears.  This
is something that QEMU can work around, by not doing anything

* the second part of A disappears for a moment before B appears.  This
is the root API issue and not something that QEMU can work around; and
in fact it is not even fixed by removing flatview_simplify.

Felix, did you identify the regions whose simplification causes the bug?
 Is this RAM (for example due to the PAM registers) or something else?

Paolo


