Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE97CC433E7
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 21:14:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E51F922203
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 21:14:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tr5T0g0C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E51F922203
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQdF4-0000MH-Su
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 17:14:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50826)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1kQdDt-0008D9-1G
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 17:13:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41409)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1kQdDq-0003Rb-3t
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 17:13:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602191584;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6VdFhlJc8TU7Vq5uGZRsBNTyQN4fCKJTTZ+eyEy8gXk=;
 b=Tr5T0g0CQPHY2QK1xr9Bh1vCbMH6CRbYhTi1XISZ1EF7oFFQR6uLvRJOUqey3wEAxL+Kax
 C+egndm9Ao/+K4EVcJUY9lthjCqa6S5tiQBBBBFAOJqT+9dlgww4tZKSI3klmWe+PFVf6O
 M4JCw6xWHxIX9IlBIA/tpaKceLuMGuo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-335-c8N2hFP3OMGnWxstIt1CHg-1; Thu, 08 Oct 2020 17:13:02 -0400
X-MC-Unique: c8N2hFP3OMGnWxstIt1CHg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3B41A64145;
 Thu,  8 Oct 2020 21:13:01 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.192.139])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 77CC35D9E8;
 Thu,  8 Oct 2020 21:12:57 +0000 (UTC)
Date: Thu, 8 Oct 2020 23:12:54 +0200
From: Andrew Jones <drjones@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v4 6/6] hw/arm/virt: Implement kvm-steal-time
Message-ID: <20201008211254.pnbmwfanbor3pgv6@kamzik.brq.redhat.com>
References: <20201001061718.101915-1-drjones@redhat.com>
 <20201001061718.101915-7-drjones@redhat.com>
 <CAFEAcA-ZwwzrjPjsaGJbwW-y0g+j-usk25f1hiFVadaS74Nv+w@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-ZwwzrjPjsaGJbwW-y0g+j-usk25f1hiFVadaS74Nv+w@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=drjones@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=drjones@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/08 02:56:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Eric Auger <eric.auger@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,

Thanks for fixing this up and applying!

drew

On Thu, Oct 08, 2020 at 09:39:59PM +0100, Peter Maydell wrote:
> On Thu, 1 Oct 2020 at 07:17, Andrew Jones <drjones@redhat.com> wrote:
> >
> > We add the kvm-steal-time CPU property and implement it for machvirt.
> > A tiny bit of refactoring was also done to allow pmu and pvtime to
> > use the same vcpu device helper functions.
> 
> > +            if (pvtime_size > pvtime_reg_size) {
> > +                error_report("pvtime requires a %ld byte memory region for "
> > +                             "%d CPUs, but only %ld has been reserved",
> > +                             pvtime_size, max_cpus, pvtime_reg_size);
> > +                exit(1);
> > +            }
> 
> This turns out not to compile on Windows:
> 
> ../../hw/arm/virt.c:1693:30: error: format '%ld' expects argument of
> type 'long int', but argument 2 has type 'hwaddr {aka long long
> unsigned int}' [-Werror=format=]
>                  error_report("pvtime requires a %ld byte memory region for "
>                               ^
> 
> I'm going to squash this fix into the pullreq:
> 
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -1690,8 +1690,9 @@ static void virt_cpu_post_init(VirtMachineState
> *vms, int max_cpus,
>              pvtime_size = REAL_HOST_PAGE_ALIGN(pvtime_size);
> 
>              if (pvtime_size > pvtime_reg_size) {
> -                error_report("pvtime requires a %ld byte memory region for "
> -                             "%d CPUs, but only %ld has been reserved",
> +                error_report("pvtime requires a %" HWADDR_PRId
> +                             " byte memory region for %d CPUs,"
> +                             " but only %" HWADDR_PRId " has been reserved",
>                               pvtime_size, max_cpus, pvtime_reg_size);
>                  exit(1);
>              }
> 
> thanks
> -- PMM
>


