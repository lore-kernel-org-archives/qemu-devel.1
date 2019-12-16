Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DDA6C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 17:27:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA713206E0
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 17:27:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EOBc1hYI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA713206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igu9V-0003sF-AF
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 12:27:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46187)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1igtia-0001ix-BU
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:59:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1igtiZ-0008EV-6e
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:59:36 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:46456
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>) id 1igtiZ-00087J-0q
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:59:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576515573;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tOQM1/Rz4ycyGW1DEvNcWUzz5svT6E2Jm6LD2YWykoQ=;
 b=EOBc1hYIQsdkTlNL0/6PsKNKaZKuUHqdRVJCibsuqrtjVsSl6xCwMwjsS2LiF3E/d9Mk3X
 s5n2H68cxTXOUdL8ljyOQwFL3YyVWO+zwJ+aeKwIsRGlQq5woZ/gqLtTBwqduMwhLb6I1x
 LTiUJCwkPZU29gmsrjb6LyjrAFxV+z4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-sYxEI4vzMTC5hBXrq0lGtA-1; Mon, 16 Dec 2019 11:59:29 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EA39E802561;
 Mon, 16 Dec 2019 16:59:27 +0000 (UTC)
Received: from kamzik.brq.redhat.com (ovpn-116-122.ams2.redhat.com
 [10.36.116.122])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E19715D9D6;
 Mon, 16 Dec 2019 16:59:23 +0000 (UTC)
Date: Mon, 16 Dec 2019 17:59:20 +0100
From: Andrew Jones <drjones@redhat.com>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [RFC PATCH v2 0/5] target/arm/kvm: Adjust virtual time
Message-ID: <20191216165920.qsx7ufviir74tbkl@kamzik.brq.redhat.com>
References: <20191212173320.11610-1-drjones@redhat.com>
 <CAFEAcA9FprSotg11rS0fM94QiciysZ6kgKhyU4eQfZg7YYaL5Q@mail.gmail.com>
 <4cb9bcfd47dff57c9ae6bb92bae87589@www.loen.fr>
MIME-Version: 1.0
In-Reply-To: <4cb9bcfd47dff57c9ae6bb92bae87589@www.loen.fr>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: sYxEI4vzMTC5hBXrq0lGtA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Peter Maydell <peter.maydell@linaro.org>, bijan.mottahedeh@oracle.com,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Heyi Guo <guoheyi@huawei.com>, msys.mizuma@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Dec 16, 2019 at 04:18:23PM +0000, Marc Zyngier wrote:
> On 2019-12-16 15:33, Peter Maydell wrote:
> > On Thu, 12 Dec 2019 at 17:33, Andrew Jones <drjones@redhat.com> wrote:
> >=20
> > > Userspace that wants to set KVM_REG_ARM_TIMER_CNT should beware that
> > > the KVM register ID is not correct.  This cannot be fixed because
> > > it's
> > > UAPI and if the UAPI headers are used then it can't be a problem.
> > > However, if a userspace attempts to create the ID themselves from
> > > the
> > > register's specification, then they will get KVM_REG_ARM_TIMER_CVAL
> > > instead, as the _CNT and _CVAL definitions have their register
> > > parameters swapped.
> >=20
> > So, to be clear, you mean that:
> >=20
> > (1) the kernel headers say:
> >=20
> > /* EL0 Virtual Timer Registers */
> > #define KVM_REG_ARM_TIMER_CTL           ARM64_SYS_REG(3, 3, 14, 3, 1)
> > #define KVM_REG_ARM_TIMER_CNT           ARM64_SYS_REG(3, 3, 14, 3, 2)
> > #define KVM_REG_ARM_TIMER_CVAL          ARM64_SYS_REG(3, 3, 14, 0, 2)
> >=20
> > (2) some of the RHSes of these are wrong
> >=20
> > (3) but the kernel internally is using the same 'wrong' value, so
> > userspace also needs to use that value, ie trust the #defined name
> > rather than manufacturing one ?
> >=20
> > That's awkward. I think it would be worth at least having a kernel
> > patch to add a comment clearly documenting this bug.
> >=20
> > (This error seems to only be in the 64-bit ABI, not 32-bit.)
>=20
> Yeah, this is pretty bad. I wonder how we managed not to notice
> this for so long... :-(.
>=20
> Andrew, could you please write a patch documenting this (both in
> the UAPI headers and in the documentation)?
>

Will do. I'll try to get to it this week.

Thanks,
drew


