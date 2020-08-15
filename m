Return-Path: <SRS0=PlQC=BZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C3CFC433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 15:23:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C943B23355
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 15:23:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jPxlmqPZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C943B23355
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6y1n-0003MV-21
	for qemu-devel@archiver.kernel.org; Sat, 15 Aug 2020 11:23:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60086)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1k6xy0-0005S1-HW
 for qemu-devel@nongnu.org; Sat, 15 Aug 2020 11:19:32 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:26700
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1k6xxx-00022w-Gj
 for qemu-devel@nongnu.org; Sat, 15 Aug 2020 11:19:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597504768;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=q1imAkULvth5PHCHqSf2NcPALwbxgjmMgsRZwc6yxT8=;
 b=jPxlmqPZ22YLaEaWUaabN1o+0WOalB21EpAAWAnRicQnhq/QXmnfeuSIm3RlBeM4EiTHAy
 KaEzG4Mp8kuW6Mk/BQ72SSXInt8AsojdseOBwyAm60F75vMRonnCrwaZSFfpubUphcgRMs
 EWzpnVsH/yaU2hS/ch++pTvF+Y+Tzxw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-FwaL-3rnMdiyjDiQmmSEfQ-1; Sat, 15 Aug 2020 03:17:43 -0400
X-MC-Unique: FwaL-3rnMdiyjDiQmmSEfQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A1B9C801AC3;
 Sat, 15 Aug 2020 07:17:42 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.192.23])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C304B5C1BD;
 Sat, 15 Aug 2020 07:17:40 +0000 (UTC)
Date: Sat, 15 Aug 2020 09:17:37 +0200
From: Andrew Jones <drjones@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 7/7] target/arm/cpu: spe: Enable spe to work with host cpu
Message-ID: <20200815071737.4eql77uemlw2nddx@kamzik.brq.redhat.com>
References: <cover.1596768588.git.haibo.xu@linaro.org>
 <bf909c1f4904a22be0804cae9fd6f38ba4862563.1596768588.git.haibo.xu@linaro.org>
 <20200810111640.ykejphmuyirncjwv@kamzik.brq.redhat.com>
 <CAJc+Z1F_vFdJuy2kZnj0gZSOd_8-=rSfWFHjQSPU5XEKQ2KZkg@mail.gmail.com>
 <20200811164954.s2sdjzpqpdh2orks@kamzik.brq.redhat.com>
 <13da2df2-7d90-9512-d1b1-8d7c5f43971c@linaro.org>
MIME-Version: 1.0
In-Reply-To: <13da2df2-7d90-9512-d1b1-8d7c5f43971c@linaro.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=drjones@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=drjones@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/14 17:09:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 philmd@redhat.com, qemu-devel@nongnu.org, Haibo Xu <haibo.xu@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Aug 14, 2020 at 12:28:25PM -0700, Richard Henderson wrote:
> On 8/11/20 9:49 AM, Andrew Jones wrote:
> > Yes, except you need to drop the ARM_FEATURE_SPE define and use the ID
> > register bit instead like "sve_supported" does.
> 
> On a related note, I think we have a latent bug, or at least a mis-feature:
> 
>     sve_supported = ioctl(fdarray[0], KVM_CHECK_EXTENSION, KVM_CAP_ARM_SVE) > 0;
> ...
>     /* Add feature bits that can't appear until after VCPU init. */
>     if (sve_supported) {
>         t = ahcf->isar.id_aa64pfr0;
>         t = FIELD_DP64(t, ID_AA64PFR0, SVE, 1);
>         ahcf->isar.id_aa64pfr0 = t;
>     }
> 
> 
> Should it in fact be
> 
>     if (!sve_supported) {
>         t = ahcf->isar.id_aa64pfr0;
>         t = FIELD_DP64(t, ID_AA64PFR0, SVE, 0);
>         ahcf->isar.id_aa64pfr0 = t;
>     }
> 
> ?
> 
> Forcing the value to 1 here is going to be wrong the moment we have an SVE2
> enabled cpu.

Indeed. I think KVM should add a KVM_CAP_ARM_SVE2 cap. Then, we keep the
code similar to the way it is now, but set ID_AA64PFR0 appropriately
based on which CAPs are present. I think we probably need that CAP anyway
in order to ensure a guest that is using SVE2 cannot be migrated to a host
that only has SVE.

> 
> Similarly, SPE has more than one "enabled" value for PMSVer.
>

I'll take a look at the KVM series for SPE next week to see if
the UAPI will allow us to determine what values are possible.

Thanks for the heads up about this.

drew


