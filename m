Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F684C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 09:38:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E765205CB
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 09:38:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iICiQqEQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E765205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgPqy-0005qR-CE
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 05:38:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49442)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1jgPqP-0004zI-A8
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 05:37:57 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:25458
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1jgPqO-0000G3-K4
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 05:37:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591177075;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Bw0cU2/dYCtI4rEMGijgJJUH235fLxtwfm6Pb5ZuLS8=;
 b=iICiQqEQViXbpbzLXQMyRBsihsaZU6jI3+hNTFfL5Fei+DH4ZMsA93cXP8EvuqlSsAOoSy
 yvUofImJPrYmJW7wDsLxWWEJfzAmubZ6EF9A/+7ion9iud1MIpnI4n2IXA8QtYoJeJBGkz
 hTqImg0NkyGTMrFa56wRia8jYSlkLSc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-CjLntQqDOJ-PrmIQisRKTA-1; Wed, 03 Jun 2020 05:37:54 -0400
X-MC-Unique: CjLntQqDOJ-PrmIQisRKTA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0695F461;
 Wed,  3 Jun 2020 09:37:53 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.192.141])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 474B4579A3;
 Wed,  3 Jun 2020 09:37:48 +0000 (UTC)
Date: Wed, 3 Jun 2020 11:37:45 +0200
From: Andrew Jones <drjones@redhat.com>
To: Salil Mehta <salil.mehta@huawei.com>
Subject: Re: [Question] Regarding PMU initialization within the QEMU for ARM
 VCPUs
Message-ID: <20200603093745.dwfb55ny34az7rez@kamzik.brq.redhat.com>
References: <b2e401cd17fe49d792d09b31bd726e35@huawei.com>
MIME-Version: 1.0
In-Reply-To: <b2e401cd17fe49d792d09b31bd726e35@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=drjones@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/03 01:04:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "mst@redhat.com" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 01, 2020 at 03:04:33PM +0000, Salil Mehta wrote:
> Hello,
> I could see below within function fdt_add_pmu_nodes() part of
> hw/arm/virt.c during virt machine initialization time:
> 
> Observation:
> In below function, support of PMU feature is being checked for
> each vcpu and if the PMU is found part of the features then PMU
> is initialized with in the host/KVM. But if there is even one
> vcpu which is found to not support the PMU then loop is exited
> and PMU is not initialized for the rest of the vcpus as well.
> 
> Questions:
> Q1. Not sure what is the logic of the premature exit and not
>     continuing with further checks and initialization of other
>     VCPU PMUs?

KVM requires all VCPUs to have a PMU if one does. If the ARM ARM
says it's possible to have PMUs for only some CPUs, then, for TCG,
the restriction could be relaxed. I expect it will take more than
just removing the check for things to work though.

> Q2. Does it even makes sense to have PMUs initialized for some
>     vcpus and not for others unless we have heterogeneous system? 

I don't know, but it doesn't sound like a configuration I'd like
to see.

> Q3. Also, there is a per virt machine knob of vcc->no_pmu.
>     This is something which user could specify at the init time
>     and perhaps only once but we don't use it for ARM. Perhaps
>     should have been used even before entering this function
>     to enable or disable the support as per user config?

It's purpose is to keep users from doing 'pmu=on' on 2.6 machine
types. On 2.7 and later machine types if you don't want a PMU
you should use 'pmu=off'.

> Q4. This function  fdt_* looks to be wrongly named. The info
>     being initialized here shall be used even when ACPI is
>     being used. Initialization part and FDT info looked
>     mixed up here if I am right?

Agreed. The function has the wrong name. mach-virt has many functions that
mix the initialization and fdt building together, but those functions are
named something like create_foo(). Patches welcome.

Thanks,
drew


