Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C85C31E40
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 09:02:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10540218A6
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 09:02:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10540218A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyBe2-0005pq-Uf
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 05:02:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41914)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1hyBcd-0004sw-Cg
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 05:00:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1hyBcc-00085X-BY
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 05:00:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52314)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>)
 id 1hyBcc-00085H-5T; Thu, 15 Aug 2019 05:00:38 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 77A392BF02;
 Thu, 15 Aug 2019 09:00:37 +0000 (UTC)
Received: from gondolin (ovpn-116-91.ams2.redhat.com [10.36.116.91])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D5E9317C38;
 Thu, 15 Aug 2019 09:00:33 +0000 (UTC)
Date: Thu, 15 Aug 2019 11:00:30 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: David Hildenbrand <david@redhat.com>
Message-ID: <20190815110030.2429e284.cohuck@redhat.com>
In-Reply-To: <20190814151242.27199-1-david@redhat.com>
References: <20190814151242.27199-1-david@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Thu, 15 Aug 2019 09:00:37 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v1] s390x/tcg: Fix VERIM with 32/64 bit
 elements
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
Cc: Thomas Huth <thuth@redhat.com>, Stefano Brivio <sbrivio@redhat.com>,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 14 Aug 2019 17:12:42 +0200
David Hildenbrand <david@redhat.com> wrote:

> Wrong order of operands. The constant always comes last. Makes QEMU crash
> reliably on specific git fetch invocations.
> 
> Reported-by: Stefano Brivio <sbrivio@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
> 
> I guess it is too late for 4.1 :(
> 
> ---
>  target/s390x/translate_vx.inc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.inc.c
> index 41d5cf869f..0caddb3958 100644
> --- a/target/s390x/translate_vx.inc.c
> +++ b/target/s390x/translate_vx.inc.c
> @@ -213,7 +213,7 @@ static void get_vec_element_ptr_i64(TCGv_ptr ptr, uint8_t reg, TCGv_i64 enr,
>                         vec_full_reg_offset(v3), ptr, 16, 16, data, fn)
>  #define gen_gvec_3i(v1, v2, v3, c, gen) \
>      tcg_gen_gvec_3i(vec_full_reg_offset(v1), vec_full_reg_offset(v2), \
> -                    vec_full_reg_offset(v3), c, 16, 16, gen)
> +                    vec_full_reg_offset(v3), 16, 16, c, gen)
>  #define gen_gvec_4(v1, v2, v3, v4, gen) \
>      tcg_gen_gvec_4(vec_full_reg_offset(v1), vec_full_reg_offset(v2), \
>                     vec_full_reg_offset(v3), vec_full_reg_offset(v4), \

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Fixes: 5c4b0ab460ef ("s390x/tcg: Implement VECTOR ELEMENT ROTATE AND INSERT UNDER MASK")
Cc: qemu-stable@nongnu.org

Thanks, applied.

