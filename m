Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72190C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 17:22:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FED9206E0
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 17:22:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OR5Vzfu8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FED9206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igu4k-0004ts-Sw
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 12:22:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37804)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1igtTg-0007wg-Pl
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:44:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1igtTd-0005lj-TQ
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:44:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43560
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>) id 1igtTd-0005iv-P2
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:44:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576514649;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lB8rYaM4LIgsPJoAftgjG9mdXpweDU1tAotDnMpOJvo=;
 b=OR5Vzfu8dVlm7K5OPuVLHdvE/5wmuODT3Ie09mPmuaSxGKRRyvN0WEyPxI/xf2uAwNiTpb
 iDhqKNob5FVgvByCrKHJzDdTnD8trqdkpVHpcxsuvFJop50Xgxc+A9wyzk/evsyGaz0SoP
 Wn2hnhAVQGkqsNOWh7rb0fy8L7uMRxE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-383-C6LwDkwYNX-Ln7KBtyRl8w-1; Mon, 16 Dec 2019 11:44:05 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 122EA1005512;
 Mon, 16 Dec 2019 16:44:03 +0000 (UTC)
Received: from kamzik.brq.redhat.com (ovpn-116-122.ams2.redhat.com
 [10.36.116.122])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0D88210013D9;
 Mon, 16 Dec 2019 16:43:58 +0000 (UTC)
Date: Mon, 16 Dec 2019 17:43:55 +0100
From: Andrew Jones <drjones@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [RFC PATCH v2 3/5] target/arm/kvm: Implement virtual time
 adjustment
Message-ID: <20191216164355.i5rpfuqlfqv2z7m7@kamzik.brq.redhat.com>
References: <20191212173320.11610-1-drjones@redhat.com>
 <20191212173320.11610-4-drjones@redhat.com>
 <CAFEAcA_u94O8WYLgB8DF=pu-3V7LrNWpiQFV5mDYeeqLj1Ee2Q@mail.gmail.com>
 <CAFEAcA9ZoOZt6Jh42hi6q91=kRM9T9z436J99NF+Ns5KVKUYow@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9ZoOZt6Jh42hi6q91=kRM9T9z436J99NF+Ns5KVKUYow@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: C6LwDkwYNX-Ln7KBtyRl8w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: bijan.mottahedeh@oracle.com, Marc Zyngier <maz@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Heyi Guo <guoheyi@huawei.com>, msys.mizuma@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Dec 16, 2019 at 03:40:16PM +0000, Peter Maydell wrote:
> On Mon, 16 Dec 2019 at 15:14, Peter Maydell <peter.maydell@linaro.org> wr=
ote:
> > How does this interact with the usual register sync to/from
> > KVM (ie kvm_arch_get_registers(), which I think will do a
> > GET_ONE_REG read of the TIMER_CNT register the way it does
> > any other sysreg, inside write_kvmstate_to_list(), plus
> > kvm_arch_set_registers() which does the write back to the
> > kernel in write_list_to_kvmstate()) ? Presumably we want this
> > version to take precedence by the set_virtual_time call
> > happening after the kvm_arch_set_registers, but is this
> > guaranteed ?
>=20
> ...you might also want to look at the effects of simply
> removing the KVM_REG_ARM_TIMER_CNT entry from the
> 'non_runtime_cpregs[]' array -- in commit 4b7a6bf402bd064
> we explicitly stopped reading/writing this register's value
> to/from the kernel except for inbound migration, and it
> feels like this patchset is now rolling back that approach,
> so maybe we should also be (configurably) rolling back some
> of its implementation rather than just leaving it in place.

I feel like I already considered that, maybe even tried it, a few months
ago when I first looked at this. I must have decided against it for some
reason at the time, but I don't recall what. Now I can say the reason is
because we only do this save/restore when we transition to/from paused
state, though.

>=20
> I note also that the commit message there had a remark
> about inconsistencies between VCPUs -- is the right thing
> to handle this per-VM rather than per-VCPU somehow?

per-VM would make sense, because the counters should be synchronized
among the VCPUs. KVM does that for us, though, so whichever VCPU last
restores its counter is the one that will determine the final value.

Maybe we should have a VM ioctl instead, but ATM we only have VCPU ioctls.

Thanks,
drew


