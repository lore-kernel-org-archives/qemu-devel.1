Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D876BC433E7
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 08:02:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FBC422243
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 08:02:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dv6Gm/PN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FBC422243
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSyDQ-0005xG-Pg
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 04:02:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43352)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1kSyAQ-0004B3-9H
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 03:59:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26128)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1kSyAO-0002cL-60
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 03:59:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602748755;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q90dOnDtuGlLKMitWRAnide2Q1s8O9XlaVDz2pAFfts=;
 b=Dv6Gm/PNNRq4ocAYSvmXri/nywbe6nYWfSDChjQnTpzv0mN9hjdEKCjL+H9CuWo2bIIPzy
 ubUl888XPce6MR+RS3vWg24CKm2YZurFRhXscdrbcoTjERTLxqS707lSIDLJZa6zx4q8gf
 CF04Hs5YS5LocV+Z8q7tatR0S7TysiM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-549-DtxOuOK0NQKm15f8bBouQg-1; Thu, 15 Oct 2020 03:59:11 -0400
X-MC-Unique: DtxOuOK0NQKm15f8bBouQg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 756D2D6880;
 Thu, 15 Oct 2020 07:59:09 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.194.132])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A59215D9CD;
 Thu, 15 Oct 2020 07:59:03 +0000 (UTC)
Date: Thu, 15 Oct 2020 09:59:00 +0200
From: Andrew Jones <drjones@redhat.com>
To: Ying Fang <fangying1@huawei.com>
Subject: Re: [RFC PATCH 00/12] hw/arm/virt: Introduce cpu and cache topology
 support
Message-ID: <20201015075900.ukz3y6cl2vhwmctx@kamzik.brq.redhat.com>
References: <20200917032033.2020-1-fangying1@huawei.com>
 <678F3D1BB717D949B966B68EAEB446ED49E0BB94@dggemm526-mbx.china.huawei.com>
 <20201013180840.yzkncsw34xvwtoll@kamzik.brq.redhat.com>
 <7491ca46-92b2-09e0-67a8-55a90203b9cc@huawei.com>
MIME-Version: 1.0
In-Reply-To: <7491ca46-92b2-09e0-67a8-55a90203b9cc@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=drjones@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=drjones@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 02:38:26
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "Chenzhendong \(alex\)" <alex.chen@huawei.com>,
 "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "alistair.francis@wdc.com" <alistair.francis@wdc.com>,
 "Zengtao \(B\)" <prime.zeng@hisilicon.com>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "valentin.schneider@arm.com" <valentin.schneider@arm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 15, 2020 at 10:07:16AM +0800, Ying Fang wrote:
> 
> 
> On 10/14/2020 2:08 AM, Andrew Jones wrote:
> > On Tue, Oct 13, 2020 at 12:11:20PM +0000, Zengtao (B) wrote:
> > > Cc valentin
> > > 
> > > > -----Original Message-----
> > > > From: Qemu-devel
> > > > [mailto:qemu-devel-bounces+prime.zeng=hisilicon.com@nongnu.org]
> > > > On Behalf Of Ying Fang
> > > > Sent: Thursday, September 17, 2020 11:20 AM
> > > > To: qemu-devel@nongnu.org
> > > > Cc: peter.maydell@linaro.org; drjones@redhat.com; Zhanghailiang;
> > > > Chenzhendong (alex); shannon.zhaosl@gmail.com;
> > > > qemu-arm@nongnu.org; alistair.francis@wdc.com; fangying;
> > > > imammedo@redhat.com
> > > > Subject: [RFC PATCH 00/12] hw/arm/virt: Introduce cpu and cache
> > > > topology support
> > > > 
> > > > An accurate cpu topology may help improve the cpu scheduler's
> > > > decision
> > > > making when dealing with multi-core system. So cpu topology
> > > > description
> > > > is helpful to provide guest with the right view. Cpu cache information
> > > > may
> > > > also have slight impact on the sched domain, and even userspace
> > > > software
> > > > may check the cpu cache information to do some optimizations. Thus
> > > > this patch
> > > > series is posted to provide cpu and cache topology support for arm.
> > > > 
> > > > To make the cpu topology consistent with MPIDR, an vcpu ioctl
> > > 
> > > For aarch64, the cpu topology don't depends on the MPDIR.
> > > See https://patchwork.kernel.org/patch/11744387/
> > > 
> > 
> > The topology should not be inferred from the MPIDR Aff fields,
> 
> MPIDR is abused by ARM OEM manufactures. It is only used as a
> identifer for a specific cpu, not representation of the topology.

Right, which is why I stated topology should not be inferred from
it.

> 
> > but MPIDR is the CPU identifier. When describing a topology
> > with ACPI or DT the CPU elements in the topology description
> > must map to actual CPUs. MPIDR is that mapping link. KVM
> > currently determines what the MPIDR of a VCPU is. If KVM
> 
> KVM currently assigns MPIDR with vcpu->vcpu_id which mapped
> into affinity levels. See reset_mpidr in sys_regs.c

I know, but how KVM assigns MPIDRs today is not really important
to KVM userspace. KVM userspace shouldn't depend on a KVM
algorithm, as it could change.

> 
> > userspace is going to determine the VCPU topology, then it
> > also needs control over the MPIDR values, otherwise it
> > becomes quite messy trying to get the mapping right.
> If we are going to control MPIDR, shall we assign MPIDR with
> vcpu_id or map topology hierarchy into affinity levels or any
> other link schema ?
>

We can assign them to whatever we want, as long as they're
unique and as long as Aff0 is assigned per the GIC requirements,
e.g. GICv3 requires that Aff0 be from 0 to 0xf. Also, when
pinning VCPUs to PCPUs we should ensure that MPIDRs with matching
Aff3,Aff2,Aff1 fields should actually be peers with respect to
the GIC.

We shouldn't try to encode topology in the MPIDR in any way,
so we might as well simply increment a counter to assign them,
which could possibly be the same as the VCPU ID.

Thanks,
drew


