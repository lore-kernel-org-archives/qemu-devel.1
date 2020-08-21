Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F216DC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 09:20:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFCC2207DA
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 09:20:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GymLTFzg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFCC2207DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k93DX-0006qD-Sr
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 05:20:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46944)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1k93Ci-00065i-TM
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 05:19:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60701)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1k93Ch-00027i-58
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 05:19:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598001558;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=myvedewLsiGoP4vD5UfnoFnQDdnCd66oynkthTZlP3Y=;
 b=GymLTFzg1cEA4fM+et1y1MRGB3jX2BeGAHrdaankDk7Oll6bCNoWzG2+9iULQasCB9An1Q
 6kRcyfGCOhPHW/d35T80YXfIO0bNScQNjLUdEzfjA4J3TFRx1J34wWqg0UfbWBmcCCM5r5
 wXyFdje9V6zgcYP9ZRquz1Lkr6dd7rY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149-V50PI8QDNi-APrNtOiXQKA-1; Fri, 21 Aug 2020 05:19:15 -0400
X-MC-Unique: V50PI8QDNi-APrNtOiXQKA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 646DC83DC20;
 Fri, 21 Aug 2020 09:19:14 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 936C610013C2;
 Fri, 21 Aug 2020 09:19:12 +0000 (UTC)
Date: Fri, 21 Aug 2020 10:19:09 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] configure: add support for psuedo-"in source tree" builds
Message-ID: <20200821091909.GE251583@redhat.com>
References: <20200820165543.215372-1-berrange@redhat.com>
 <CAFEAcA8Rk5yB-Cudx8abpxSEcR=87cWhg0Ywm9w6bvqa5nneGA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8Rk5yB-Cudx8abpxSEcR=87cWhg0Ywm9w6bvqa5nneGA@mail.gmail.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 04:26:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 20, 2020 at 07:15:03PM +0100, Peter Maydell wrote:
> On Thu, 20 Aug 2020 at 17:56, Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > Meson requires the build dir to be separate from the source tree. Many
> > people are used to just running "./configure && make" though and the
> > meson conversion breaks that.
> >
> > This introduces some backcompat support to make it appear as if an
> > "in source tree" build is being done, but with the the results in the
> > "build/" directory. This allows "./configure && make" to work as it
> > did historically, albeit with the output binaries staying under build/.
> >
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> 
> Oh, one more minor thing: 'make distclean' should remove
> the created GNUMakefile (and also build/ if configure
> created it? dunno).

Yes, I mistakenly put that logic for "make clean" in this v1. My v2
has fixed this, and in v3 i'll remove the "GNUMakefile" too.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


