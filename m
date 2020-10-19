Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03282C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 15:24:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CD552231B
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 15:24:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cHU5VTk9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CD552231B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUX1q-0004Jk-AR
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 11:24:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44254)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1kUX0V-0002WK-Uz
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 11:23:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34101)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1kUX0P-0003yJ-FN
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 11:23:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603121002;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8qqe4i/Zi2sPJmvXzSJ7X87OrF4YFyucaDslDr3ii2k=;
 b=cHU5VTk9/jFqXNF7ktDFWhQwS7pl8PR+tphuUlxHuTWIu2tm4QCBorr+L9qohTrXlecTJp
 vPNzQoUM2XsMLmq3YrnuMFCkYcFQHRGyq9e+2k40FpWvhxwkOyB9OZI/cQGtdR3PH8S9Yd
 yi6miACOTWFdDFEbJ6iSSBlwhcLf0To=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-cXtUVPOHN9uPi8dHsLPXhg-1; Mon, 19 Oct 2020 11:23:17 -0400
X-MC-Unique: cXtUVPOHN9uPi8dHsLPXhg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C574A8049C1;
 Mon, 19 Oct 2020 15:23:15 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.193.206])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0F5F410013D0;
 Mon, 19 Oct 2020 15:23:13 +0000 (UTC)
Date: Mon, 19 Oct 2020 17:23:11 +0200
From: Andrew Jones <drjones@redhat.com>
To: Dave Martin <Dave.Martin@arm.com>
Subject: Re: Kernel patch cases qemu live migration failed.
Message-ID: <20201019152311.csxcz52sawia4imi@kamzik.brq.redhat.com>
References: <20201015133505.ubxvbrt6xyvl4362@kamzik.brq.redhat.com>
 <16400df4bdf79b8b22e824eb1a20e2b4@kernel.org>
 <20201015144104.ytwzpxjlsgyun3ob@kamzik.brq.redhat.com>
 <CAFEAcA-LBmbjp-Teb35f=O-1QtMLd8bAuq5XaCz9URdQZ1jxow@mail.gmail.com>
 <20201019092525.ekvgbcwwtm63pueu@kamzik.brq.redhat.com>
 <20201019113157.GN32292@arm.com>
 <CAFEAcA8oncKmGxKGEZBg9Pnm4hjSO8u9KSv4YxFWxX0+LJ5E2g@mail.gmail.com>
 <20201019134043.vqusmzhqp7owjt6x@kamzik.brq.redhat.com>
 <CAFEAcA8RB6MTnv0qavxWs28=pbT16i9dT1pd+0Dy9HxPVk+bZA@mail.gmail.com>
 <20201019145839.GO32292@arm.com>
MIME-Version: 1.0
In-Reply-To: <20201019145839.GO32292@arm.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=drjones@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=drjones@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 02:32:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>, xu910121@sina.com,
 kvmarm <kvmarm@lists.cs.columbia.edu>, Marc Zyngier <maz@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Oct 19, 2020 at 03:58:40PM +0100, Dave Martin wrote:
> On Mon, Oct 19, 2020 at 03:18:11PM +0100, Peter Maydell wrote:
> > On Mon, 19 Oct 2020 at 14:40, Andrew Jones <drjones@redhat.com> wrote:
> > >
> > > On Mon, Oct 19, 2020 at 12:43:33PM +0100, Peter Maydell wrote:
> > > > Well, ID regs are special in the architecture -- they always exist
> > > > and must RAZ/WI, even if they're not actually given any fields yet.
> > > > This is different from other "unused" parts of the system register
> > > > encoding space, which UNDEF.
> > >
> > > Table D12-2 confirms the register should be RAZ, as it says the register
> > > is "RO, but RAZ if SVE is not implemented". Does "RO" imply "WI", though?
> > > For the guest we inject an exception on writes, and for userspace we
> > > require the value to be preserved on write.
> > 
> > Sorry, I mis-spoke. They're RAZ, but not WI, just RO (which is to say
> > they'll UNDEF if you try to write to them).
> > 
> > > I think we should follow the spec, even for userspace access, and be RAZ
> > > for when the feature isn't implemented. As for writes, assuming the
> > > exception injection is what we want for the guest (not WI), then that's
> > > correct. For userspace, I think we should continue forcing preservation
> > > (which will force preservation of zero when it's RAZ).
> > 
> > Yes, that sounds right.
> 
> [...]
> 
> > > > The problem is that you've actually removed registers from
> > > > the list that were previously in it (because pre-SVE
> > > > kernels put this ID register in the list as a RAZ/WI register,
> > > > and now it's not in the list if SVE isn't supported).
> 
> Define "previously", though.  IIUC, the full enumeration was added in
> v4.15 (with ID_AA64ZFR0_EL1 still not supported at all):
> 
> v4.15-rc1~110^2~27
> 93390c0a1b20 ("arm64: KVM: Hide unsupported AArch64 CPU features from guests")
> 
> 
> And then ID_AA64FZR0_EL1 was removed from the enumeration, also in
> v4.15:
> 
> v4.15-rc1~110^2~5
> 07d79fe7c223 ("arm64/sve: KVM: Hide SVE from CPU features exposed to guests")
> 
> 
> So, are there really two upstram kernel tags that are mismatched on
> this, or is this just a bisectability issue in v4.14..v4.15?
> 
> It's a while since I looked at this, and I may have misunderstood the
> timeline.
> 
> 
> > > > > So, I think that instead of changing the ID_AA64ZFR0_EL1 behaviour,
> > > > > parhaps we should move all ID_UNALLOCATED() regs (and possibly
> > > > > ID_HIDDEN(), not sure about that) to have REG_HIDDEN_USER visibility.
> > > >
> > > > What does this do as far as the user-facing list-of-registers
> > > > is concerned? All these registers need to remain in the
> > > > KVM_GET_REG_LIST list, or you break migration from an old
> > > > kernel to a new one.
> 
> OK, I think I see where you are coming from, now.
> 
> It may make sense to get rid of the REG_HIDDEN_GUEST / REG_HIDDEN_USER
> distinction, and provide the same visibility for userspace as for MSR/
> MRS all the time.  This would restore ID_AA64ZFR0_EL1 into the userspace
> view, and may also allow a bit of simplification in the code.
> 
> Won't this will still break migration from the resulting kernel to a
> current kernel that hides ID_AA64ZFR0_EL1?  Or have I misunderstood
> something.
>

Yes, but, while neither direction old -> new nor new -> old is actually
something that people should do when using host cpu passthrough (they
should only ever migrate between identical hosts, both hardware and
host kernel version), migrating from old -> new makes more sense, as
that's the upgrade path, and it's more supportable - we can workaround
things on the new side. So, long story short, new -> old will fail due
to making this change, but it's still probably the right thing to do,
as we'll be defining a better pattern for ID registers going forward,
and we never claimed new -> old migrations would work anyway with host
passthrough.

Thanks,
drew


