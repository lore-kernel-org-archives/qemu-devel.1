Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5497C4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 14:49:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCE3620757
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 14:49:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CmEA4hSV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCE3620757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNGwW-0001w4-BJ
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 10:49:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60618)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1kNGv7-0000mL-92
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 10:47:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30835)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1kNGv1-0002v8-BQ
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 10:47:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601390869;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8thcg0tIxW3aY4E98M4rEh06Wicxbv3Himw6vljZh1g=;
 b=CmEA4hSVdxsfQj78l4JxiVXCLKY8IXJRk20EFij70HCux2iWrJTdEhL81Tv8jf8+y3Dmhx
 FhENAMWFgjLnHc7oY3Z6vo3x4y/ekLH9e/+yN8+s2b4RGnlgP/24qCqJRVdYUA/s0452dl
 EQZPrDkzg1umPnK3igmx7rBAMuHk+cQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-10-6kDvBJYeMHKVe0bacwPVaQ-1; Tue, 29 Sep 2020 10:47:42 -0400
X-MC-Unique: 6kDvBJYeMHKVe0bacwPVaQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1FA44800C78;
 Tue, 29 Sep 2020 14:47:41 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.192.214])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 417F578807;
 Tue, 29 Sep 2020 14:47:35 +0000 (UTC)
Date: Tue, 29 Sep 2020 16:47:33 +0200
From: Andrew Jones <drjones@redhat.com>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: Re: [PATCH v3 0/5] hw/arm/virt: Introduce kvm-steal-time
Message-ID: <20200929144733.2ukomccx5in5r346@kamzik.brq.redhat.com>
References: <20200916092620.19161-1-drjones@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200916092620.19161-1-drjones@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=drjones@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=drjones@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 22:47:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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


Hi Peter, Eric, and other interested parties,

Here's a gentle ping for reviewers.

Thanks,
drew

On Wed, Sep 16, 2020 at 11:26:15AM +0200, Andrew Jones wrote:
> Previous posting:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg727588.html
> 
> v3:
>   - Rebased: 5.2 machine type and kvm32 drop now included
>   - Switched to using new KVM cap that has been merged upstream
>   - Picked up some r-b's and some of Eric's comments from v2
> 
> KVM supports the ability to publish the amount of time that VCPUs
> were runnable, but not running due to other host threads running
> instead, to the guest. The guest scheduler may use that information
> when making decisions and the guest may expose it to its userspace
> (Linux publishes this information in /proc/stat). This feature is
> called "steal time" as it represents the amount of time stolen from
> a guest by scheduling out its VCPUs. To enable this feature KVM
> userspace must provide a memory region that will be used to publish
> the information to the guest. The memory region is typical migratable
> region. The GPA of the region is given to KVM through a VCPU device
> ioctl interface. This feature is only available for 64-bit guests
> per the Arm PVTIME specification (DEN0057A).
> 
> This series provides the QEMU support of this feature. It will
> be enabled by default for 5.2 machine types and later, but may
> be disabled with a new CPU property "kvm-steal-time".
> 
> Thanks,
> drew
> 
> 
> Andrew Jones (5):
>   target/arm/kvm: Make uncalled stubs explicitly unreachable
>   hw/arm/virt: Move post cpu realize check into its own function
>   hw/arm/virt: Move kvm pmu setup to virt_cpu_post_init
>   DO NOT MERGE: HACK: Add steal time KVM cap to kvm.h
>   hw/arm/virt: Implement kvm-steal-time
> 
>  docs/system/arm/cpu-features.rst |  11 ++++
>  hw/arm/virt.c                    | 110 ++++++++++++++++++++++---------
>  include/hw/arm/virt.h            |   5 ++
>  linux-headers/linux/kvm.h        |   1 +
>  target/arm/cpu.c                 |   8 +++
>  target/arm/cpu.h                 |   4 ++
>  target/arm/kvm.c                 |  16 +++++
>  target/arm/kvm64.c               |  64 ++++++++++++++++--
>  target/arm/kvm_arm.h             |  94 ++++++++++++++++++++------
>  target/arm/monitor.c             |   2 +-
>  tests/qtest/arm-cpu-features.c   |  25 +++++--
>  11 files changed, 281 insertions(+), 59 deletions(-)
> 
> -- 
> 2.26.2
> 


