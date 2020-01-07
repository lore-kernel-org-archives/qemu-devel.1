Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56953C33C99
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 10:20:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21C5520678
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 10:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kamfqs3Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21C5520678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioly8-00047N-70
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 05:20:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59893)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iok9t-0005HP-8m
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 03:24:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iok9r-0000Xa-TD
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 03:24:12 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:40548
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iok9r-0000X5-PO
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 03:24:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578385450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CM0NmqjTi8gmRSaeBjpftgOYl01ZQR8UWdmQNj9nAoo=;
 b=Kamfqs3YWM8qM3UILU4xaO7HVx9swMK741MDmh8dShklER0j1HnXPH0/jZLDDixAYuSbYi
 3QMnAHR3N4Og1EIHZLMpRm1cvzddY2vf1xM0CjHvReNqBHAi2dN2YobT10uGwMKYb6xGQ1
 qLx1A86fI7D7hXmxeJfHF4NrcwfxN9E=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-2NGNvbXcPzK3aTluRUB-DA-1; Tue, 07 Jan 2020 03:24:09 -0500
Received: by mail-wm1-f70.google.com with SMTP id s25so1690602wmj.3
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 00:24:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=CM0NmqjTi8gmRSaeBjpftgOYl01ZQR8UWdmQNj9nAoo=;
 b=p4pn2QokMsWV0fUJMIBzw58hyGQb9ARZT1RHtIVX0L7cW6anzumpQ2TS/DfH7uM3a2
 tNFFJ4izRgOT2lUwRvEnHmntJVgY/B1KOtX26+FzpOkV4kTp7IxHrBeCcL/2/jeEWiRA
 UlFqCCJwBBZM9CMSbK+h+mcAAwxdT1huy0JO+5BiWBBeyQB9EDLEemVoZVW+w6T/lTPD
 bUreMdRE7QjLe9kh+v78S+cdC/4OavuwSnh/TJHO+WTfxRQN2V1+i8RL6ouoAPKl7GpH
 f3rYdBpYtJXXte4uhYlhp+VNH++1XFKdqDtFLZry43bBP9AZLH9p3Mqem/Byn3eetbIn
 CUXg==
X-Gm-Message-State: APjAAAUVeDoFIcKX8MtrlzKwjqpSQJnX1MWOM0fIyWVDQTE2q5TanCmz
 YOshf8h2beT3uaEoYHxwdFpEZad7rp2cj1ylLVvPei+yp09w1YSAQerv9cLE5G33JG07Zm6FHUv
 GsfU0t6Z5n4tnejw=
X-Received: by 2002:a1c:20d3:: with SMTP id
 g202mr39446959wmg.169.1578385448649; 
 Tue, 07 Jan 2020 00:24:08 -0800 (PST)
X-Google-Smtp-Source: APXvYqxzvRSMWicz2n84wqgAD9ppqGMNJf34qmYf0v7JM9ZAlEY+39+DtXR8tccj5w1bS0DD2MSERw==
X-Received: by 2002:a1c:20d3:: with SMTP id
 g202mr39446924wmg.169.1578385448355; 
 Tue, 07 Jan 2020 00:24:08 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c6d:4079:b74c:e329?
 ([2001:b07:6468:f312:c6d:4079:b74c:e329])
 by smtp.gmail.com with ESMTPSA id c9sm25141287wmc.47.2020.01.07.00.24.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jan 2020 00:24:07 -0800 (PST)
Subject: Re: [PATCH] target/i386: kvm: print info when the kernel doesn't
 support ioctl(KVM_CAP_GET_MSR_FEATURES)
To: Li Qiang <liq3ea@163.com>, mtosatti@redhat.com, rth@twiddle.net,
 ehabkost@redhat.com
References: <20200103143224.49187-1-liq3ea@163.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f47bbe07-9ba2-4440-f74c-ff15a2acb816@redhat.com>
Date: Tue, 7 Jan 2020 09:24:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200103143224.49187-1-liq3ea@163.com>
Content-Language: en-US
X-MC-Unique: 2NGNvbXcPzK3aTluRUB-DA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=windows-1252
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/01/20 15:32, Li Qiang wrote:
> The ioctl(KVM_CAP_GET_MSR_FEATURES) is quite new. In old platform that
> doesn't support this ioctl will sometimes make the user confusion. For
> example, when we do nested virtualiztion using host-passthrough model
> the VM will has quite different cpu feature with the host.
> 
> Signed-off-by: Li Qiang <liq3ea@163.com>
> ---
>  target/i386/kvm.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index 0b511906e3..9688f7a167 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -1916,6 +1916,8 @@ static int kvm_get_supported_feature_msrs(KVMState *s)
>      }
>  
>      if (!kvm_check_extension(s, KVM_CAP_GET_MSR_FEATURES)) {
> +        info_report("ioctl(KVM_CAP_GET_MSR_FEATURES) is "
> +                    "not supported by this kernel.");
>          return 0;
>      }

Does this matter with host-passthrough?  As long as "-cpu host,+vmx"
works with an old kernel, there's no reason to warn---and even then the
warning should:

1) be restricted to the nested case;

2) be emitted even if MSR features are supported but VMX MSRs are not.

Paolo


