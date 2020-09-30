Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF29C4727F
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 11:29:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA7E320708
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 11:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fQnBgEBH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA7E320708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNaIN-0002FQ-Og
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 07:29:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32780)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1kNaGH-0000S3-A8
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 07:27:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28444)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1kNaGD-0003Y6-Mf
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 07:27:04 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601465221;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nuwo6wTqmKPM/+6VKyIEOOZ+mB+9GUOk5BUu6NSDWD4=;
 b=fQnBgEBHCPVA0SF4YeIl/TTQmlurLLJC3swLKk+7K4rvQkfU4PfdrEBXrdDo4qoEYXlMol
 nw6snrRPE4LDixoedoRbd/RjlZRaiYyCOcE0HcbsOk2O0V97hDQDPM86Kb+sY1Vgp3uszp
 zQm+bTDQ9Gpko7GVrsiNQea0fZXg/Eo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-191-X0uurgzANA-wOhnoIUAVmw-1; Wed, 30 Sep 2020 07:26:57 -0400
X-MC-Unique: X0uurgzANA-wOhnoIUAVmw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D233E10059AA;
 Wed, 30 Sep 2020 11:26:55 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.193.24])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C227B5D9D2;
 Wed, 30 Sep 2020 11:26:50 +0000 (UTC)
Date: Wed, 30 Sep 2020 13:26:48 +0200
From: Andrew Jones <drjones@redhat.com>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: Re: [PATCH v3 0/5] hw/arm/virt: Introduce kvm-steal-time
Message-ID: <20200930112648.e4teztyiqbweyzh4@kamzik.brq.redhat.com>
References: <20200916092620.19161-1-drjones@redhat.com>
 <20200929144733.2ukomccx5in5r346@kamzik.brq.redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200929144733.2ukomccx5in5r346@kamzik.brq.redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=drjones@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=drjones@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:26:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.469,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: peter.maydell@linaro.org, eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 29, 2020 at 04:47:33PM +0200, Andrew Jones wrote:
> 
> Hi Peter, Eric, and other interested parties,
> 
> Here's a gentle ping for reviewers.

Thanks for the review Eric! I'll send a Linux header update patch and a
rebase of this series with R-b's.

drew

> 
> Thanks,
> drew
> 
> On Wed, Sep 16, 2020 at 11:26:15AM +0200, Andrew Jones wrote:
> > Previous posting:
> > https://www.mail-archive.com/qemu-devel@nongnu.org/msg727588.html
> > 
> > v3:
> >   - Rebased: 5.2 machine type and kvm32 drop now included
> >   - Switched to using new KVM cap that has been merged upstream
> >   - Picked up some r-b's and some of Eric's comments from v2
> > 
> > KVM supports the ability to publish the amount of time that VCPUs
> > were runnable, but not running due to other host threads running
> > instead, to the guest. The guest scheduler may use that information
> > when making decisions and the guest may expose it to its userspace
> > (Linux publishes this information in /proc/stat). This feature is
> > called "steal time" as it represents the amount of time stolen from
> > a guest by scheduling out its VCPUs. To enable this feature KVM
> > userspace must provide a memory region that will be used to publish
> > the information to the guest. The memory region is typical migratable
> > region. The GPA of the region is given to KVM through a VCPU device
> > ioctl interface. This feature is only available for 64-bit guests
> > per the Arm PVTIME specification (DEN0057A).
> > 
> > This series provides the QEMU support of this feature. It will
> > be enabled by default for 5.2 machine types and later, but may
> > be disabled with a new CPU property "kvm-steal-time".
> > 
> > Thanks,
> > drew
> > 
> > 
> > Andrew Jones (5):
> >   target/arm/kvm: Make uncalled stubs explicitly unreachable
> >   hw/arm/virt: Move post cpu realize check into its own function
> >   hw/arm/virt: Move kvm pmu setup to virt_cpu_post_init
> >   DO NOT MERGE: HACK: Add steal time KVM cap to kvm.h
> >   hw/arm/virt: Implement kvm-steal-time
> > 
> >  docs/system/arm/cpu-features.rst |  11 ++++
> >  hw/arm/virt.c                    | 110 ++++++++++++++++++++++---------
> >  include/hw/arm/virt.h            |   5 ++
> >  linux-headers/linux/kvm.h        |   1 +
> >  target/arm/cpu.c                 |   8 +++
> >  target/arm/cpu.h                 |   4 ++
> >  target/arm/kvm.c                 |  16 +++++
> >  target/arm/kvm64.c               |  64 ++++++++++++++++--
> >  target/arm/kvm_arm.h             |  94 ++++++++++++++++++++------
> >  target/arm/monitor.c             |   2 +-
> >  tests/qtest/arm-cpu-features.c   |  25 +++++--
> >  11 files changed, 281 insertions(+), 59 deletions(-)
> > 
> > -- 
> > 2.26.2
> > 
> 
> 


