Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B29C33CA1
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 09:41:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EC9E207E0
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 09:41:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hb/GR34R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EC9E207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itTYo-0000p5-QW
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 04:41:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57997)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1itTXt-0000Gz-1p
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 04:40:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1itTXn-0007Dt-N9
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 04:40:32 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57154
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>) id 1itTXn-0007CJ-Fx
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 04:40:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579513224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RpnQ6glcOAHFYOHgm0OzjRxP2VYfw7bPy9yfW4KiEOs=;
 b=hb/GR34RdBiWgTfvcSwhoTq4w8PRAktpxzl03H6SzUMlKpMxyTc/UdJPdgM9pOzFRl0BvF
 3AwqNJGrPU9kVN22/ve0A99pH17pVM1nZnRbVjj+L0ZWmyK1QaqSOMEttJpeKPncj7MjgD
 LvPcJdWTLEdTKSMcoJq5v07T8VsAxBA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-S82e4SpNN0SdX3f_0WM3iQ-1; Mon, 20 Jan 2020 04:40:20 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CD8CBDBB2;
 Mon, 20 Jan 2020 09:40:18 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E2CEA60C18;
 Mon, 20 Jan 2020 09:40:16 +0000 (UTC)
Date: Mon, 20 Jan 2020 10:40:14 +0100
From: Andrew Jones <drjones@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [RFC PATCH v2 3/5] target/arm/kvm: Implement virtual time
 adjustment
Message-ID: <20200120094014.yvqucqj6q2weh2pc@kamzik.brq.redhat.com>
References: <20191212173320.11610-1-drjones@redhat.com>
 <20191212173320.11610-4-drjones@redhat.com>
 <CAFEAcA_u94O8WYLgB8DF=pu-3V7LrNWpiQFV5mDYeeqLj1Ee2Q@mail.gmail.com>
 <CAFEAcA9ZoOZt6Jh42hi6q91=kRM9T9z436J99NF+Ns5KVKUYow@mail.gmail.com>
 <20191216164355.i5rpfuqlfqv2z7m7@kamzik.brq.redhat.com>
 <CAFEAcA8NzQ8QYE2NMnviPPnmBn1Dwm4W_KvhMbwCNwFzkurK-Q@mail.gmail.com>
 <20191219143005.gw43k2hug2n5nvto@kamzik.brq.redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191219143005.gw43k2hug2n5nvto@kamzik.brq.redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: S82e4SpNN0SdX3f_0WM3iQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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

On Thu, Dec 19, 2019 at 03:30:12PM +0100, Andrew Jones wrote:
> On Mon, Dec 16, 2019 at 06:06:30PM +0000, Peter Maydell wrote:
> > Your approach in this patchset reads and writes on vm-paused,
> > so it won't have the pre-2015 problems.
> >=20
> > It still feels odd that we're storing this bit of guest state
> > in two places now though -- in kvm_vtime, and also in its usual
> > place in the cpreg_array data structures (we write back the
> > value from kvm_vtime when the VM starts running, and we write
> > back the value from the cpreg_array for a PUT_FULL_STATE, which
> > the comments claim is only on startup or when we just loaded
> > migration state (and also undocumentedly but reasonably on
> > cpu-hotplug, which arm doesn't have yet).

I tried to get rid of the extra state location (kvm_vtime), but we still
need it because kvm_arch_get_registers() doesn't take 'level', like
kvm_arch_put_registers() does. Maybe it should? Without being able to
filter out TIMER_CNT at get time too, then if we migrate a paused guest
we'll resume with vtime including the ticks between the pause and the
start of the migration. Adding the additional state (kvm_vtime) and a
cpu_pre_save() hook to fixup the cpreg value is a possible way to resolve
that. That's what I've done for v3, which I'll post shortly.

> >=20
> > I've just spent a little while digging through code, and
> > haven't been able to satisfy myself on the ordering of which
> > writeback wins: for a loadvm I think we first do a
> > cpu_synchronize_all_post_init() (writing back the counter
> > value from the migration data) and then after than we will
> > unpause the VM -- why doesn't this overwrite the correct
> > value with the wrong value from kvm_vtime ?

It wasn't overwriting because we weren't detecting a runstate
transition from paused to running. However, for v3, I've dropped
the explicit running/pause transition checking and now ensured
we get the right value with a cpu_post_load() hook.

>=20
> > I just noticed also that the logic used in this patch
> > doesn't match what other architectures do in their vm_state_change
> > function -- eg cpu_ppc_clock_vm_state_change() has an
> > "if (running) { load } else { save }", and kvmclock_vm_state_change()
> > for i386 also has "if (running) { ... } else { ... }", though
> > it has an extra wrinkle where it captures "are we PAUSED?"
> > to use in the pre_save function; the comment above
> > kvmclock_pre_save() suggests maybe that would be useful for other
> > than x86, too. kvm_s390_tod_vm_state_change() has
> > logic that's a slightly more complicated variation on just
> > testing the 'running' flag, but it doesn't look at the
> > specific new state.

I think I've mimicked this logic now for arm in v3.

Thanks,
drew


