Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E45C43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 19:22:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9BE920645
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 19:22:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9BE920645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54122 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfUXa-0006Td-3V
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 15:22:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46027)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1hfUWi-0005nl-CJ
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 15:21:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1hfUWg-0005Dh-VO
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 15:21:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50680)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hfUWg-0005BF-Ev
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 15:21:14 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AF57A30860B3;
 Mon, 24 Jun 2019 19:21:10 +0000 (UTC)
Received: from localhost (ovpn-116-76.gru2.redhat.com [10.97.116.76])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 19C4E19693;
 Mon, 24 Jun 2019 19:21:09 +0000 (UTC)
Date: Mon, 24 Jun 2019 16:21:08 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Message-ID: <20190624192108.GL1862@habkost.net>
References: <20190624190214.14468-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190624190214.14468-1-mreitz@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Mon, 24 Jun 2019 19:21:10 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] i386/kvm: Fix build with -m32
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 24, 2019 at 09:02:14PM +0200, Max Reitz wrote:
> find_next_bit() takes a pointer of type "const unsigned long *", but the
> first argument passed here is a "uint64_t *".  These types are
> incompatible when compiling qemu with -m32.
> 
> Just cast it to "const void *", find_next_bit() works fine with any type
> on little-endian hosts (which x86 is).
> 
> Fixes: c686193072a47032d83cb4e131dc49ae30f9e5d
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Why not declare kvm_hyperv_properties.dependencies with the right
type for bitmaps, using
  unsigned long dependencies[BITS_TO_LONGS(64)]
?

> ---
>  target/i386/kvm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index e4b4f5756a..1b5f3b1c00 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -1050,7 +1050,7 @@ static int hv_cpuid_check_and_set(CPUState *cs, struct kvm_cpuid2 *cpuid,
>      }
>  
>      deps = kvm_hyperv_properties[feature].dependencies;
> -    while ((dep_feat = find_next_bit(&deps, 64, dep_feat)) < 64) {
> +    while ((dep_feat = find_next_bit((const void *)&deps, 64, dep_feat)) < 64) {
>          if (!(hyperv_feat_enabled(cpu, dep_feat))) {
>                  fprintf(stderr,
>                          "Hyper-V %s requires Hyper-V %s\n",
> -- 
> 2.21.0
> 

-- 
Eduardo

