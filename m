Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54332C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 09:03:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2152C20723
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 09:03:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TB9FNvCN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2152C20723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnepX-0004kb-Cq
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 05:02:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42502)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1jnenv-0003V3-3N
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 05:01:19 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:42395
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1jnens-0008BR-Hu
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 05:01:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592902875;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DWqDZq0v4LXkIn+biD2SU+252DF5UrweAVupAlT/kV4=;
 b=TB9FNvCN2yjVx4v+Fpkc5LsVkjKtTObq/dl1YaXAN9wA3Hce68iVrOnB4kmVQuy/4ivk3B
 a355R+cOEu+h9ddB8RXjHQgxee0eHVh1MFkLcvuQLnH/2F9xNkhNV3FUaBTOfeMDlt/iDq
 DqY445wTWYB1WgTufTdKlU4xAAMxVY8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-bg8d4tNyNRqauV5cnE7Veg-1; Tue, 23 Jun 2020 05:01:02 -0400
X-MC-Unique: bg8d4tNyNRqauV5cnE7Veg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AC5AF804001;
 Tue, 23 Jun 2020 09:00:59 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.193.84])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0D5B019D7F;
 Tue, 23 Jun 2020 09:00:45 +0000 (UTC)
Date: Tue, 23 Jun 2020 11:00:43 +0200
From: Andrew Jones <drjones@redhat.com>
To: Salil Mehta <salil.mehta@huawei.com>
Subject: Re: [PATCH RFC 07/22] arm/cpuhp: Init PMU at host for all possible
 vcpus
Message-ID: <20200623090043.fwf7h6zmprc3oug4@kamzik.brq.redhat.com>
References: <20200613213629.21984-1-salil.mehta@huawei.com>
 <20200613213629.21984-8-salil.mehta@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20200613213629.21984-8-salil.mehta@huawei.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=drjones@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 01:55:08
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
Cc: peter.maydell@linaro.org, mehta.salil.lnk@gmail.com, gshan@redhat.com,
 pbonzini@redhat.com, mst@redhat.com, jiakernel2@gmail.com, maz@kernel.org,
 david@redhat.com, richard.henderson@linaro.org, qemu-devel@nongnu.org,
 linuxarm@huawei.com, eric.auger@redhat.com, will@kernel.org,
 qemu-arm@nongnu.org, james.morse@arm.com, catalin.marinas@arm.com,
 sudeep.holla@arm.com, imammedo@redhat.com, maran.wilson@oracle.com,
 zhukeqian1@huawei.com, wangxiongfeng2@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Jun 13, 2020 at 10:36:14PM +0100, Salil Mehta wrote:
> PMU for all possible vcpus must be initialized at the virt machine
> initialization time. This patch refactors existing code to accomodate possible
> vcpus. This also assumes that all processor being used are identical at least
> for now but does not affect the normal scanarios where they might not be in
> future. This assumption only affects the future hotplug scenarios if ever there
> exists any hetergenous processors. In such a case PMU might not be enabled on
> some vcpus. Is it acceptable and doable tradeoff for now?
> 
> This perhaps needs more discussion. please check below link,
> Link: https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg00131.html
> 
> Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> ---
>  hw/arm/virt.c         | 51 ++++++++++++++++++++++++++++++-------------
>  include/hw/arm/virt.h |  1 +
>  2 files changed, 37 insertions(+), 15 deletions(-)
>

I have a similar patch to this one in my steal-time dev branch that I just
started last week. I'm creating a new function that must be called after
cpu realization and gic creation that completes cpu setup. There's a few
things that will end up there (including steal-time stuff).

Thanks,
drew


