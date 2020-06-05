Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C0EC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 15:25:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D06E206F0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 15:25:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GUUrsVYN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D06E206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhEDi-0000tG-N5
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 11:25:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54730)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jhECl-0000JT-FP
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 11:24:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47798
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jhECk-0006HC-29
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 11:24:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591370660;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1a4Lc9LJKRWBN97WMw3GxEXZ3GwuV+Hh2ZYz4jH+Czg=;
 b=GUUrsVYNHQ5OZZI4bfbsE4cFRM/8pFvcuqR7Soov7cpqiDw79aQZeCUEj3n2JFZfZ/yWlk
 y8leFnEBb4z9mcVElpfkAjPiCizSPE5kb8e3pLZYGY/42/nC99Ivnsp9MNicHtjcMau4TZ
 oWZwXeTApsbiQ1YuI08hEUvMTZ37kuk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-221-1e4UGJH1OFWt5bpWnLSZbw-1; Fri, 05 Jun 2020 11:24:18 -0400
X-MC-Unique: 1e4UGJH1OFWt5bpWnLSZbw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 991A21854C44;
 Fri,  5 Jun 2020 15:24:16 +0000 (UTC)
Received: from localhost (unknown [10.40.208.51])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3D91510013C0;
 Fri,  5 Jun 2020 15:24:09 +0000 (UTC)
Date: Fri, 5 Jun 2020 17:24:05 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Andrew Jones <drjones@redhat.com>
Subject: Re: [Question] Regarding PMU initialization within the QEMU for ARM
 VCPUs
Message-ID: <20200605172405.1626979b@redhat.com>
In-Reply-To: <20200603102116.hbo4kmaitvh2kofl@kamzik.brq.redhat.com>
References: <b2e401cd17fe49d792d09b31bd726e35@huawei.com>
 <20200603093745.dwfb55ny34az7rez@kamzik.brq.redhat.com>
 <fb9cf73c-e94b-b7f9-1d11-dc0353dd3996@redhat.com>
 <20200603102116.hbo4kmaitvh2kofl@kamzik.brq.redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=imammedo@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 03:07:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Salil Mehta <salil.mehta@huawei.com>, "mst@redhat.com" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Auger Eric <eric.auger@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 3 Jun 2020 12:21:16 +0200
Andrew Jones <drjones@redhat.com> wrote:

> On Wed, Jun 03, 2020 at 11:59:23AM +0200, Auger Eric wrote:
> > Hi Drew,
> > 
> > On 6/3/20 11:37 AM, Andrew Jones wrote:  
> > > On Mon, Jun 01, 2020 at 03:04:33PM +0000, Salil Mehta wrote:  
> > >> Hello,
> > >> I could see below within function fdt_add_pmu_nodes() part of
> > >> hw/arm/virt.c during virt machine initialization time:
> > >>
> > >> Observation:
> > >> In below function, support of PMU feature is being checked for
> > >> each vcpu and if the PMU is found part of the features then PMU
> > >> is initialized with in the host/KVM. But if there is even one
> > >> vcpu which is found to not support the PMU then loop is exited
> > >> and PMU is not initialized for the rest of the vcpus as well.
> > >>
> > >> Questions:
> > >> Q1. Not sure what is the logic of the premature exit and not
> > >>     continuing with further checks and initialization of other
> > >>     VCPU PMUs?  
> > > 
> > > KVM requires all VCPUs to have a PMU if one does.  
> > 
> > I fail to find where this is enforced? Do you know the place?  
> 
> kvm_vcpu_set_target(), called from KVM_ARM_VCPU_INIT. It ensures
> all VCPUs have identical features selected. The PMU requires a
> VCPU feature (KVM_ARM_VCPU_PMU_V3) to be set.

perhaps add a check at cpu_preplug time to ensure that it's so before cpu is create
instead of much later FDT initialization?

> 
> Thanks,
> drew


