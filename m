Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F06C33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 12:50:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70DE2207E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 12:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F4d0JZB9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70DE2207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iooJ5-00083K-L7
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 07:49:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56025)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ionvT-0000e5-B3
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 07:25:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ionvS-0000IK-4V
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 07:25:35 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59773
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ionvR-0000Gq-NF
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 07:25:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578399933;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/rhLvWplWE7F6PPHzZQL12AXzNtOnd8yYBRfECcHnVQ=;
 b=F4d0JZB9bShnOBgbG0f0qr+y+Ln826l/H2Yvl5avwsYNRpoo5mobhjtlSqaE7QZJmPhhNb
 l9EDtUYY0Ou+qPnjkj1i5SnilC+F4h/ehh920uJbMi3BRhlSw4mRvfR9JStcj0iL6GFTum
 wJYx86/kFXvQcdIhbytENdY0LIt5QpE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-RZZyHPMKPueydl1nvPbe2g-1; Tue, 07 Jan 2020 07:25:30 -0500
Received: by mail-wm1-f69.google.com with SMTP id m133so1897503wmf.2
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 04:25:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/rhLvWplWE7F6PPHzZQL12AXzNtOnd8yYBRfECcHnVQ=;
 b=dapSN9a7W8OIh4cs9Gd2yjTsPmjzmAjgDnGQNnUxp+uwfFeQGndQtm/g1XFuPnEBho
 Zuz8GanHI5UNalCeLK9EM48eV3ib/CA7sn65zjx2E0yh8yuKijOqjQP6aacjwf3n0pOg
 9NjS7RQw33fOonrZUy2FiCT0S8KHjXoWBw5N2nOsfOMe4buucbBmoXax4tnMkE3fqm80
 VKwKswOspv+2aL6RrzjHF16i/bS870jxxsJhpZwKIe5pMl9cCpg0ki37HoiB1tslZ+26
 o9vBAPFwaSVs7OAK6z1xvLOraiAkpzkmcBaSC3SJ/PY5TQ0DC8AU885ZgheYpwKGTbol
 4hmQ==
X-Gm-Message-State: APjAAAVrd/hJImWwQ4aaVViNQ2/nnCoQfeRtb1Ptc2RAuAqMdeeCD2ww
 ferPggugYU6mWkxTjyndT35FSGYsOKnBTPvWvBGlBPBriIdlTTIEk6jdvJbv2n4ciqkoMDwNpak
 Eux7MmJEsi1vvYh4=
X-Received: by 2002:adf:c54e:: with SMTP id
 s14mr114685164wrf.385.1578399929100; 
 Tue, 07 Jan 2020 04:25:29 -0800 (PST)
X-Google-Smtp-Source: APXvYqwNY7BQ79OOtlCgt3uOshSXlS0hHB96UqsQeVj8QvloU9WbOKgMeV93oscyC4CZTeXsN+/zsg==
X-Received: by 2002:adf:c54e:: with SMTP id
 s14mr114685145wrf.385.1578399928900; 
 Tue, 07 Jan 2020 04:25:28 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c6d:4079:b74c:e329?
 ([2001:b07:6468:f312:c6d:4079:b74c:e329])
 by smtp.gmail.com with ESMTPSA id a184sm27055593wmf.29.2020.01.07.04.25.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jan 2020 04:25:28 -0800 (PST)
Subject: Re: [PATCH RFC] i386/kvm: fix enlightened VMCS with fine-grained VMX
 feature enablement
To: Vitaly Kuznetsov <vkuznets@redhat.com>, qemu-devel@nongnu.org
References: <20200102203926.1179743-1-vkuznets@redhat.com>
 <21556857-3d6a-ad66-5cf5-060b1ab67381@redhat.com>
 <87zhezsc30.fsf@vitty.brq.redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7c4dcca1-a1e6-a00c-56fd-bcc6c8bcc474@redhat.com>
Date: Tue, 7 Jan 2020 13:25:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <87zhezsc30.fsf@vitty.brq.redhat.com>
Content-Language: en-US
X-MC-Unique: RZZyHPMKPueydl1nvPbe2g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Roman Kagan <rkagan@virtuozzo.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Liran Alon <liran.alon@oracle.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/01/20 13:08, Vitaly Kuznetsov wrote:
> Honestly I forgot the story why we filtered out these features upon
> eVMCS enablement in KVM. As there are no corresponding eVMCS fields,
> there's no way a guest can actually use them.

Well, mostly because we mimicked what Hyper-V was doing I guess.

> I'm going to check that nothing breaks if we remove the filter. I'll go
> and test Hyper-V 2016 and 2019.

KVM would break, right?  But we can mark that patch as stable material.

Paolo

>> If so, we should teach guest-side KVM about this, not QEMU.
> 
> This is not required when enabling eVMCS on a genuine Hyper-V because it
> correctly filters out unsupported features, however, to not break
> KVM-on-KVM-using-eVMCS case we'll have to move the filter from host to
> guest.
> 
> Thanks!
> 


