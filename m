Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F3EC433EC
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 14:16:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67776207BC
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 14:16:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="HtcNoalz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67776207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw4gZ-0005Y1-Mu
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 10:16:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40582)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1jw4fn-0004iN-JA
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 10:15:43 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:33221)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1jw4fl-0003j8-MW
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 10:15:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=7/yF/94CKyobaC57Qp08e69c7hjkDHO60dDCDUK0PM0=; b=HtcNoalzWKGlhJkyJsfVc0vY4m
 wJXbVn5pENv8t/XfY3YNJnFxJAZZ0ukA2bwn5R+h/Hw82+tJlQLOgkkr1znvPpW2A411HY1mE73rl
 FcIywB/Z8fKClqn9hSRl0z0qRv3MJ0clqtTaN7woYBqEkVkRLXZsrZwIa48/Ynb6g5dbSwqXOGOXQ
 oNWHzbt5fu/dV8ai8hu2HY3aR8lrxDDKBWgqAMmEEVYRmERmcfDzZbDquk80GbOSeBWX81EhZH4GS
 UKAH7t5qDvNMpK1rb/Rg38EuvYBxBJCEjC8Xgvu4gDYifOQD4/UlPjy91eQRzAidDyLd1pq2L9rar
 3J9QValA==;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, peter.maydell@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Subject: Re: [RFC PATCH] configure: Fix atomic64 test for --enable-werror on
 macOS
Date: Thu, 16 Jul 2020 16:15:36 +0200
Message-ID: <2922420.RJvhEBMbDd@silver>
In-Reply-To: <20200716131101.18462-1-thuth@redhat.com>
References: <20200716131101.18462-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=91.194.90.13; envelope-from=qemu_oss@crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 08:22:19
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Donnerstag, 16. Juli 2020 15:11:01 CEST Thomas Huth wrote:
> When using --enable-werror for the macOS builders in the Cirrus-CI,
> the atomic64 test is currently failing, and config.log shows a bunch
> of error messages like this:
> 
>  config-temp/qemu-conf.c:6:7: error: implicit declaration of function
>  '__atomic_load_8' is invalid in C99
> [-Werror,-Wimplicit-function-declaration] y = __atomic_load_8(&x, 0);
>       ^
>  config-temp/qemu-conf.c:6:7: error: this function declaration is not a
>  prototype [-Werror,-Wstrict-prototypes]

Well, __atomic_*_8() functions do exist on macOS, but it does not look like 
they are supposed to be 'officially' used.

You can compile sources with these functions, and yes they are linking fine 
despite the warning, but IMO not a good idea to use them, as AFAICS they are 
not defined by any public header file.

> Suppress the warnings to make it pass.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  Not sure whether this is the best way to fix this issue ... thus marked
>  as RFC.

Probably it is better to switch to their official C11 counterpart functions 
for this test, like e.g. __atomic_load() instead of __atomic_load_8(), etc.
That's what the actual qemu code base is using actually anyway.

Best regards,
Christian Schoenebeck



