Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6956FC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 09:19:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3425720738
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 09:19:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aX8Vtor+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3425720738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnf5E-0002A0-Fs
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 05:19:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52276)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1jnf4S-00016o-0W
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 05:18:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31899
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1jnf4Q-0000lS-J3
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 05:18:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592903901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CfnLed3EmdqbWeg4skLqNDsC7ZqeohtA8a6yn0mbkZo=;
 b=aX8Vtor+ynrEMaT3/gNrLz7p6fSqyst5sxOfQ+PzqOSIcAkhCWK4XmxQWc8hUVJ7PXclOT
 XJdoXleSvuCPo+hTBAi9q90PaT3xjWJ/X/wGd4vXs9+4UwOHqoLGexBHVVxL4Y2nt8rWnz
 1CvIqHX1nN4qBX6vUYr0w6pZQiHvscw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-162-6TrjvSv5OmqkNy4Q1L1BvQ-1; Tue, 23 Jun 2020 05:18:19 -0400
X-MC-Unique: 6TrjvSv5OmqkNy4Q1L1BvQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BC6C5107ACCD;
 Tue, 23 Jun 2020 09:18:18 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.193.84])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EE73D11A9F2;
 Tue, 23 Jun 2020 09:18:14 +0000 (UTC)
Date: Tue, 23 Jun 2020 11:18:07 +0200
From: Andrew Jones <drjones@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v3 0/2] target/arm: Fix using pmu=on on KVM
Message-ID: <20200623091807.vlqy53ckagcrhoah@kamzik.brq.redhat.com>
References: <20200623090622.30365-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200623090622.30365-1-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Received-SPF: pass client-ip=205.139.110.120; envelope-from=drjones@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 01:53:54
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 kvm@vger.kernel.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 23, 2020 at 11:06:20AM +0200, Philippe Mathieu-Daudé wrote:
> Since v2:
> - include Drew test fix (addressed Peter review comments)
> - addressed Drew review comments
> - collected R-b/A-b
> 
> Andrew Jones (1):
>   tests/qtest/arm-cpu-features: Add feature setting tests
> 
> Philippe Mathieu-Daudé (1):
>   target/arm: Check supported KVM features globally (not per vCPU)
> 
>  target/arm/kvm_arm.h           | 21 ++++++++-----------
>  target/arm/cpu.c               |  2 +-
>  target/arm/cpu64.c             | 10 ++++-----
>  target/arm/kvm.c               |  4 ++--
>  target/arm/kvm64.c             | 14 +++++--------
>  tests/qtest/arm-cpu-features.c | 38 ++++++++++++++++++++++++++++++----
>  6 files changed, 56 insertions(+), 33 deletions(-)
> 
> -- 
> 2.21.3
> 
>

Hi Phil,

Thanks for including the test patch. To avoid breaking bisection, if one
were to use qtest to bisect something, then the order of patches should
be reversed. I guess Peter can apply them that way without a repost
though.

Thanks,
drew 


