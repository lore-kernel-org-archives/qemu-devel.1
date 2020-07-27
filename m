Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC22C433EA
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 08:34:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 962D520714
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 08:34:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LaCsJUF9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 962D520714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jzyas-0004OB-Uh
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 04:34:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49328)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1jzyaF-0003rm-PE
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 04:34:07 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:44959
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1jzyaD-0005Bs-Mm
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 04:34:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595838843;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vxAC7kiFS016cETpwk1rOgUT+R9geqEOY153JJ+pd38=;
 b=LaCsJUF9Dk5k0eenTZY3rihVA8Zs6u0GIlhm0hoGIq/FRlEWWYRh5Y9VV8bvOWPaqlrObs
 Vy9bUgKDeAFI//u1SsoxUbqeqk7VqwvEjALe7zlJJ51fhKPt6n3rtkQK8X+EiYwuMZudJN
 my1HETqiAHO4v6co4TztPNyd4HrXshs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-GZ56-Ia_NQGkn41QPapVmw-1; Mon, 27 Jul 2020 04:34:01 -0400
X-MC-Unique: GZ56-Ia_NQGkn41QPapVmw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 70B4B800468;
 Mon, 27 Jul 2020 08:34:00 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.194.132])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 32D3560BF4;
 Mon, 27 Jul 2020 08:33:59 +0000 (UTC)
Date: Mon, 27 Jul 2020 10:33:56 +0200
From: Andrew Jones <drjones@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 0/3] hw/arm/virt: Introduce kvm-steal-time
Message-ID: <20200727083356.6pr6f5ph5wh2aev6@kamzik.brq.redhat.com>
References: <20200711101033.47371-1-drjones@redhat.com>
 <CAFEAcA_F_zJESdsZbsQaD+SLN5HDuL1x9Z=YrxC9kXw1XGvrcg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_F_zJESdsZbsQaD+SLN5HDuL1x9Z=YrxC9kXw1XGvrcg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=drjones@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 03:37:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Beata Michalska <beata.michalska@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 20, 2020 at 11:16:41AM +0100, Peter Maydell wrote:
> On Sat, 11 Jul 2020 at 11:10, Andrew Jones <drjones@redhat.com> wrote:
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
> > ioctl interface. This feature is only available for 64-bit hosts
> > running 64-bit guests.
> >
> > This series provides the QEMU support of this feature. It will
> > be enabled by default for 5.1 machine types and later, but may
> > be disabled with a new CPU property "kvm-steal-time".
> 
> Just a note that this has missed 5.1, but I'll review it at
> some point for 5.2.
>

Yup. No problem. I was out on vacation all last week, so there wasn't
a chance for me to follow up until now anyway. Thanks for the review.
I'll get to the responses / respinning tomorrow after I dig out of my
email backlog.

drew


