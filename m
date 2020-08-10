Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D5F7C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 10:30:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 450D6206C3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 10:30:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fg6mnpTp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 450D6206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k554J-0007BU-H0
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 06:30:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57880)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1k553b-0006Xl-Oc
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 06:29:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28486
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1k553Z-00026A-NY
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 06:29:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597055367;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FHUfhpQhwyb0I1ZlBeS2Grmm1hIPB3mkmWg+QqlOrS8=;
 b=fg6mnpTp51SoTH5Ae1mtPnpLAwvgmu/siI42riKkXCP44sPhECCGoC/SYXN1S74TJRhOJy
 dDRGcSo6nJzUhRebok2zXHyQn1IsTcB5pGiViH7TbrjVKo6Sl+c/kW13BJtJnyJR8vHuMf
 bllUpoWILFpUe50w4X7jVzSAYGtm/XU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-379-oz64s7J1Pk-iTwDV__NXxA-1; Mon, 10 Aug 2020 06:29:24 -0400
X-MC-Unique: oz64s7J1Pk-iTwDV__NXxA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D658D8017FB;
 Mon, 10 Aug 2020 10:29:22 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.194.63])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2C4395D9CC;
 Mon, 10 Aug 2020 10:29:20 +0000 (UTC)
Date: Mon, 10 Aug 2020 12:29:18 +0200
From: Andrew Jones <drjones@redhat.com>
To: Haibo Xu <haibo.xu@linaro.org>
Subject: Re: [PATCH 4/7] target/arm/kvm: spe: Unify device attr operatioin
 helper
Message-ID: <20200810102918.jjzqt4awirszsen4@kamzik.brq.redhat.com>
References: <cover.1596768588.git.haibo.xu@linaro.org>
 <3cc31df5191ae6b03e060ccd8e82df74416a3ef5.1596768588.git.haibo.xu@linaro.org>
 <b4790af9-38b7-f74a-4ebc-a7e9d3684ae0@amsat.org>
 <CAJc+Z1HzoREjCfbwct4ARmOZjszuLQEw9vqidChWjVGo19FngQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJc+Z1HzoREjCfbwct4ARmOZjszuLQEw9vqidChWjVGo19FngQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=drjones@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=drjones@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 03:31:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 10, 2020 at 10:48:41AM +0800, Haibo Xu wrote:
> On Fri, 7 Aug 2020 at 16:19, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
> >
> > On 8/7/20 10:10 AM, Haibo Xu wrote:
> > > Rename kvm_arm_pmu_set_attr() to kvm_arm_dev_set_attr(),
> >
> > Maybe rename kvm_arm_device_set_attr() to match the structure
> > name?
> >
> 
> Thanks for the review! I will update it in the next version.

I've already renamed it to kvm_arm_set_device_attr() in [1]. Also, it's
not enough to just rename the function. The error messages the function
may generate have "PMU" embedded in them.

[1] https://www.mail-archive.com/qemu-devel@nongnu.org/msg727590.html

Thanks,
drew

> 
> > > So both the vPMU and vSPE device can share the same API.
> > >
> > > Signed-off-by: Haibo Xu <haibo.xu@linaro.org>
> >
> > Regardless, with the typo "operation" in patch subject fixed:
> > Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> >
> > > ---
> > >  target/arm/kvm64.c | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
> > > index 1169237905..75a417d65c 100644
> > > --- a/target/arm/kvm64.c
> > > +++ b/target/arm/kvm64.c
> > > @@ -398,7 +398,7 @@ static CPUWatchpoint *find_hw_watchpoint(CPUState *cpu, target_ulong addr)
> > >      return NULL;
> > >  }
> > >
> > > -static bool kvm_arm_pmu_set_attr(CPUState *cs, struct kvm_device_attr *attr)
> > > +static bool kvm_arm_dev_set_attr(CPUState *cs, struct kvm_device_attr *attr)
> > >  {
> > >      int err;
> > >
> > > @@ -427,7 +427,7 @@ void kvm_arm_pmu_init(CPUState *cs)
> > >      if (!ARM_CPU(cs)->has_pmu) {
> > >          return;
> > >      }
> > > -    if (!kvm_arm_pmu_set_attr(cs, &attr)) {
> > > +    if (!kvm_arm_dev_set_attr(cs, &attr)) {
> > >          error_report("failed to init PMU");
> > >          abort();
> > >      }
> > > @@ -444,7 +444,7 @@ void kvm_arm_pmu_set_irq(CPUState *cs, int irq)
> > >      if (!ARM_CPU(cs)->has_pmu) {
> > >          return;
> > >      }
> > > -    if (!kvm_arm_pmu_set_attr(cs, &attr)) {
> > > +    if (!kvm_arm_dev_set_attr(cs, &attr)) {
> > >          error_report("failed to set irq for PMU");
> > >          abort();
> > >      }
> > >
> >
> 


