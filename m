Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78034C43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 22:33:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B01F32151B
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 22:33:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KNhAmrDd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B01F32151B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJOwT-0004pA-J2
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 18:33:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40476)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kJOva-0004Ou-0W
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 18:32:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23856)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kJOvX-0002Yu-Rr
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 18:32:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600468341;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S5966vxxmqtSfQ8qMq6PhlD+3v3bWRk4iqAaU9KBr38=;
 b=KNhAmrDdpQ63MA/ZennRVgT1neUOz4x70shuuXxtmFNiE2Vue1E6p4O/Re06oZYdZ7aPpV
 X2lWeAn5hPod4tfsaMtxFbNLUtnfbppv8o1PzFAHkf1Pm1dsMBRvW8Pqb45M+8wNB5D7/j
 NTLaWSxo/vYG5Xl34dFem+AuPZ1mls8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-b-gXPXpyMimsXDoFKv0Kcw-1; Fri, 18 Sep 2020 18:32:19 -0400
X-MC-Unique: b-gXPXpyMimsXDoFKv0Kcw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 01F2881F026
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 22:32:19 +0000 (UTC)
Received: from localhost (unknown [10.10.67.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 95F8E5D9E4;
 Fri, 18 Sep 2020 22:32:18 +0000 (UTC)
Date: Fri, 18 Sep 2020 18:32:17 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH RFC 12/22] i386: always fill Hyper-V CPUID feature leaves
 from X86CPU data
Message-ID: <20200918223217.GJ57321@habkost.net>
References: <20200904145431.196885-1-vkuznets@redhat.com>
 <20200904145431.196885-13-vkuznets@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200904145431.196885-13-vkuznets@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 00:20:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 04, 2020 at 04:54:21PM +0200, Vitaly Kuznetsov wrote:
> We have all the required data in X86CPU already and as we are about to
> split hyperv_handle_properties() into hyperv_expand_features()/
> hyperv_fill_cpuids() we can remove the blind copy. The functional change
> is that QEMU won't pass CPUID leaves it doesn't currently know about
> to the guest but arguably this is a good change.

Is it, though?  Maybe we don't want it to be the default, but a
blind passthrough mode that copies all CPUID leaves would be
useful for testing new features.

> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  target/i386/kvm.c | 9 ---------
>  1 file changed, 9 deletions(-)
> 
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index 87b83a2aa2cb..b7f0e200a75f 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -1221,9 +1221,6 @@ static int hyperv_handle_properties(CPUState *cs,
>      }
>  
>      if (cpu->hyperv_passthrough) {
> -        memcpy(cpuid_ent, &cpuid->entries[0],
> -               cpuid->nent * sizeof(cpuid->entries[0]));
> -
>          c = cpuid_find_entry(cpuid, HV_CPUID_VENDOR_AND_MAX_FUNCTIONS, 0);
>          if (c) {
>              cpu->hyperv_vendor_id[0] = c->ebx;
> @@ -1325,12 +1322,6 @@ static int hyperv_handle_properties(CPUState *cs,
>          goto free;
>      }
>  
> -    if (cpu->hyperv_passthrough) {
> -        /* We already copied all feature words from KVM as is */
> -        r = cpuid->nent;
> -        goto free;
> -    }
> -
>      c = &cpuid_ent[cpuid_i++];
>      c->function = HV_CPUID_VENDOR_AND_MAX_FUNCTIONS;
>      c->eax = hyperv_feat_enabled(cpu, HYPERV_FEAT_EVMCS) ?
> -- 
> 2.25.4
> 

-- 
Eduardo


