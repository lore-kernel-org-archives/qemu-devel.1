Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB69C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 16:32:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E015B2076B
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 16:32:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P0vPTgm2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E015B2076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5tfh-0001aV-4L
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 12:32:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42924)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1k5teq-0001AJ-Gy
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 12:31:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20165
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1k5ten-0002tE-QQ
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 12:31:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597249876;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nL042blPnbkxGPrh7SiGRT0k9DUl7O4qmBx3Bk6UxDQ=;
 b=P0vPTgm2am14ppq4/tgLACHxURQmkmkIWDcU0uvdM0C/CWRpOgIwnkvmrKB4c5X6i9VIW4
 cISkZopvY8Qe6mYE5g8VG96XOQbKTn3mXEIOfcqreiDRFCgpeD0yNJvgx5oxhrloV8rOxJ
 wj1mEJ5JSy49S1II+kP465UJ7HM4Sco=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-7jfL6D9oMm6l4MiIFNKJXg-1; Wed, 12 Aug 2020 12:31:12 -0400
X-MC-Unique: 7jfL6D9oMm6l4MiIFNKJXg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6E224E931;
 Wed, 12 Aug 2020 16:31:11 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.192.8])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F082F60CC8;
 Wed, 12 Aug 2020 16:31:09 +0000 (UTC)
Date: Wed, 12 Aug 2020 18:31:07 +0200
From: Andrew Jones <drjones@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 1/2] target/arm: Add cpu property to control pauth
Message-ID: <20200812163107.lbubi6c7ei7i5hmw@kamzik.brq.redhat.com>
References: <20200812065339.2030527-1-richard.henderson@linaro.org>
 <20200812065339.2030527-2-richard.henderson@linaro.org>
 <20200812110049.ghtvl7dmtspkfdor@kamzik.brq.redhat.com>
 <2219f3f9-7894-f898-0cad-43eccaa2a70d@linaro.org>
MIME-Version: 1.0
In-Reply-To: <2219f3f9-7894-f898-0cad-43eccaa2a70d@linaro.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=drjones@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=drjones@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 10:32:11
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
Cc: mark.rutland@arm.com, peter.maydell@linaro.org, alex.bennee@linaro.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 12, 2020 at 08:10:47AM -0700, Richard Henderson wrote:
> On 8/12/20 4:00 AM, Andrew Jones wrote:
> > On Tue, Aug 11, 2020 at 11:53:38PM -0700, Richard Henderson wrote:
> >> The crypto overhead of emulating pauth can be significant for
> >> some workloads.  Add an enumeration property that allows the
> >> feature to be turned off, on with the architected algorithm,
> >> or on with an implementation defined algorithm.
> >>
> >> The architected algorithm is quite expensive to emulate;
> >> using another algorithm may allow hardware acceleration.
> >>
> >> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> >> ---
> >>  target/arm/cpu64.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++
> >>  1 file changed, 64 insertions(+)
> >>
> >> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> >> index dd696183df..3181d0e2f8 100644
> >> --- a/target/arm/cpu64.c
> >> +++ b/target/arm/cpu64.c
> >> @@ -572,6 +572,69 @@ void aarch64_add_sve_properties(Object *obj)
> >>      }
> >>  }
> >>  
> >> +static const char * const pauth_names[] = {
> >> +    "off", "impdef", "arch"
> >> +};
> > 
> > Hi Richard,
> > 
> > Please add three boolean properties, rather than one enum:
> > 
> > pauth:            enable support of the pauth feature
> > pauth-fast:       enable QEMU's fast non-cryptographic hash for pauth
> >                   (pauth must be enabled)
> > pauth-arch:       enable the architected algorithm for pauth
> >                   (pauth must be enabled)
> > 
> > These booleans can then be added to the cpu feature probing list used by
> > qmp_query_cpu_model_expansion()
> 
> Why are 3 booleans better than one enum?
> 
> I'd forgotten about qmp_query_cpu_model_expansion(); can it not take anything
> but booleans?

Right. The probing works by getting a list of possible CPU features, which
are all boolean properties. That way the prober can try enabling/disabling
them without having to know about each property's set of valid values. We
could implement each as an enum and a second level of probing, but that
would complicate the probing, and I'm not sure enums gain us much over
multiple properties.

In this case, since pauth-fast and pauth-arch are mutually exclusive and
we want a pauth=on/off too, then we'll need a finalize function like SVE
has in order to support the following selections:

 # Default (pauth-arch), explicitly selected or not
 -cpu max[,pauth=on]
 -cpu max[,pauth=on][,pauth-fast=off],pauth-arch=on

 # Select pauth-fast
 -cpu max[,pauth=on][,pauth-arch=off],pauth-fast=on

 # Disable
 -cpu max,pauth=off
 -cpu max[,pauth=off],pauth-arch=off,pauth-fast=off

 # Mutual exclusion errors
 -cpu max,pauth=off,pauth-{arch,fast}=on
 -cpu max,pauth=on,pauth-arch=off,pauth-fast=off
 -cpu max[,pauth=on],pauth-arch=on,pauth-fast=on

 # Errors because we don't want to guess what the user means
 -cpu max[,pauth=on],pauth-arch=off
 -cpu max[,pauth=on],pauth-fast=off
 

Thanks,
drew


