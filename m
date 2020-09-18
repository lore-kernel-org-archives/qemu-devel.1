Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B142FC43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 22:24:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4516D206A1
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 22:24:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kh/KZ45c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4516D206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJOo9-0000Iu-FJ
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 18:24:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38270)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kJOlU-0006aA-Ga
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 18:22:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58606)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kJOlS-0000Uy-Ne
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 18:22:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600467717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8iBW8Qiq4fTKnxzsQlhqlJzMjZsLNAbPc1NJbsmqEs4=;
 b=Kh/KZ45cpEYBZuIvp9A2IurJCEQw57CvQ1Cz8VKpQgVsBkVp2Dh8PLGVJ17AkWLsBjdz+u
 tTRnwIZBCYeTDNLCThzbEz0jG55tYfzFCiCKZ+tifdETz482mgoP7D5psecUgPgSPAVd1F
 Y3q1oRI62lOCvbFzEyHkr+86iLRysV0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-121-vPpEJsYkMM2SBKYM5IibIQ-1; Fri, 18 Sep 2020 18:21:55 -0400
X-MC-Unique: vPpEJsYkMM2SBKYM5IibIQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E1AEE57052
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 22:21:54 +0000 (UTC)
Received: from localhost (unknown [10.10.67.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 788FB78803;
 Fri, 18 Sep 2020 22:21:54 +0000 (UTC)
Date: Fri, 18 Sep 2020 18:21:53 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH RFC 07/22] i386: fill in FEAT_HYPERV_EDX from edx instead
 of eax
Message-ID: <20200918222153.GG57321@habkost.net>
References: <20200904145431.196885-1-vkuznets@redhat.com>
 <20200904145431.196885-8-vkuznets@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200904145431.196885-8-vkuznets@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 01:32:10
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

On Fri, Sep 04, 2020 at 04:54:16PM +0200, Vitaly Kuznetsov wrote:
> There was a typo which went unnoticed.
> 
> Fixes: e48ddcc6ce13 ("i386/kvm: implement 'hv-passthrough' mode")
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>

Similar fix had been submitted at:
https://lore.kernel.org/qemu-devel/20190820103030.12515-1-zhenyuw@linux.intel.com/

> ---
>  target/i386/kvm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index 720c30e9df17..1cb5592d4f7d 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -1251,7 +1251,7 @@ static int hyperv_handle_properties(CPUState *cs,
>          if (c) {
>              env->features[FEAT_HYPERV_EAX] = c->eax;
>              env->features[FEAT_HYPERV_EBX] = c->ebx;
> -            env->features[FEAT_HYPERV_EDX] = c->eax;
> +            env->features[FEAT_HYPERV_EDX] = c->edx;
>          }
>  
>          c = cpuid_find_entry(cpuid, HV_CPUID_IMPLEMENT_LIMITS, 0);
> -- 
> 2.25.4
> 

-- 
Eduardo


