Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B62C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 17:05:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACD6A206CD
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 17:05:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HnajCwxF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACD6A206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsr1s-0002Qd-S3
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 13:05:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45998)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jsqyX-0006dv-Fl
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 13:01:45 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:53725
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jsqyV-0008Th-Lx
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 13:01:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594141302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fwoFFyYES2jVUcw8FL7dVAFToPCyQpYRsvJuuRIb2Ms=;
 b=HnajCwxFyAZev5IaZHiaqsflgM88bjxJDUTFlGrHZ4lnlJUktCaXS6y3s1Regy1x+KxCvZ
 DEy/Hi/CSGDX6a5v+ThHH01JbApnqpRrsgk+paUgwye4GkLCRuaLGSaLAu6eq7qxhLYa0R
 JQ+xEsAy/TaiimKjTui6sZlPI+ZjaHg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-KUk0Cy6KMgKcUbYxde_q1w-1; Tue, 07 Jul 2020 13:01:40 -0400
X-MC-Unique: KUk0Cy6KMgKcUbYxde_q1w-1
Received: by mail-wr1-f71.google.com with SMTP id v3so19419891wrq.10
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 10:01:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fwoFFyYES2jVUcw8FL7dVAFToPCyQpYRsvJuuRIb2Ms=;
 b=rXex+PcfWYbDF10fsJ9S/mMUuGc+rtrfMog8mdFN1F/4KKrNv8IxDV/IniA3qV4pXj
 5XJfYxfNFq1CKuEVoqKxalYix7jRGXwJPz8SpmxKFqlYBKVDCVqmU/3XufeLCsRIQv1c
 ZFG+hDvSfCHBoFikOqrctohe7jRpuGXpQBP1IyGPS1SDkXWMbWwp7osdzyS2oqHgSjHL
 TJC3lBOQ83UPKgBG1CtVb89sAOoJWopXg7WbyrHTKIZrMbxzJ2WFBkJ3BT8bHYhS5e6Y
 E1AZigT5I3l5qft1j5FU9a2bh98lhBxjVvBGOPtiVPoQbNobbE7+tGVAfh0aW//J9Pfk
 iBQg==
X-Gm-Message-State: AOAM532vd5WuaNsAjxdfT8JrVab7G51cQ5tXdsZagExleHxVCe6YXkzg
 XFmozmcA6UzjZnbbnWVwNvPvzv3XMZy0/TLO+Dit/Opda6VJodvuGu9Hro9WRRrt+vAb5Rw9l85
 5z9V5PB2emFHM6DI=
X-Received: by 2002:a7b:cb47:: with SMTP id v7mr4904256wmj.57.1594141299681;
 Tue, 07 Jul 2020 10:01:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzpUib9KEnte/YYTkfdrl5jBf31G616OGQ0vBvaxxDDUxvan/jj/HrujlP2mBOmheK7oSQl/g==
X-Received: by 2002:a7b:cb47:: with SMTP id v7mr4904239wmj.57.1594141299476;
 Tue, 07 Jul 2020 10:01:39 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e95f:9718:ec18:4c46?
 ([2001:b07:6468:f312:e95f:9718:ec18:4c46])
 by smtp.gmail.com with ESMTPSA id f16sm1806937wmf.17.2020.07.07.10.01.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jul 2020 10:01:38 -0700 (PDT)
Subject: Re: [RFC v2 3/6] cpus: extract out kvm-specific code to accel/kvm
To: Claudio Fontana <cfontana@suse.de>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20200707135808.9241-1-cfontana@suse.de>
 <20200707135808.9241-4-cfontana@suse.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <dc01dc35-c053-656c-72f5-87cad56706fb@redhat.com>
Date: Tue, 7 Jul 2020 19:01:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200707135808.9241-4-cfontana@suse.de>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 00:20:54
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 haxm-team@intel.com, Wenchao Wang <wenchao.wang@intel.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, Richard Henderson <rth@twiddle.net>,
 Colin Xu <colin.xu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/07/20 15:58, Claudio Fontana wrote:
> +static void kvm_kick_vcpu_thread(CPUState *cpu)
> +{
> +    cpus_kick_thread(cpu);
> +}
> +

I would just use cpus_kick_thread instead of wrapping it (and likewise
would provide a global function for noop synchronization).

start_vcpu_thread is also a candidate for abstraction, so that
kvm_start_vcpu_thread(CPUState *cpu) would be just

	qemu_start_vcpu_thread(cpu, "KVM", kvm_vcpu_thread_fn);

Paolo


