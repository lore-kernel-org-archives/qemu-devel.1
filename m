Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D535C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 21:43:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EED5A2078E
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 21:43:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fIK09Hrc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EED5A2078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnqhJ-0003rb-5H
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 17:43:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58654)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1jnqgd-0003RW-03
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 17:42:35 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24426
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1jnqga-00054n-EN
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 17:42:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592948550;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RuwyT2yy3v09MN9JddS/62etN99UXF6EPPF0TvGdMBU=;
 b=fIK09HrccGsbTTaS6FpaXxM1244HE1f8wqePca17T5N6OmRQ3hIL41J8hQXOWf2s4ssvry
 1C6kdtZT1YDgiP7q2XkTjozIGaBfI/jmGQDGtVnqDMaVna9kwTEYvX5J/1pMAhdavsiTL+
 uypwL99ImHf7LivK1m/41UVfJQpn2U4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26--6rnftU_OYOk-Xf--zL9Ow-1; Tue, 23 Jun 2020 17:42:28 -0400
X-MC-Unique: -6rnftU_OYOk-Xf--zL9Ow-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DCF6F107ACCA;
 Tue, 23 Jun 2020 21:42:27 +0000 (UTC)
Received: from localhost (ovpn-113-247.phx2.redhat.com [10.3.113.247])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9B1C27CAA3;
 Tue, 23 Jun 2020 21:42:27 +0000 (UTC)
Date: Tue, 23 Jun 2020 17:42:26 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Joseph Myers <joseph@codesourcery.com>
Subject: Re: [PATCH 1/5] target/i386: implement special cases for fxtract
Message-ID: <20200623214226.GH9925@habkost.net>
References: <alpine.DEB.2.21.2005070038550.18350@digraph.polyomino.org.uk>
 <alpine.DEB.2.21.2005070042360.18350@digraph.polyomino.org.uk>
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2005070042360.18350@digraph.polyomino.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 01:55:08
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
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, May 07, 2020 at 12:43:30AM +0000, Joseph Myers wrote:
> The implementation of the fxtract instruction treats all nonzero
> operands as normal numbers, so yielding incorrect results for invalid
> formats, infinities, NaNs and subnormal and pseudo-denormal operands.
> Implement appropriate handling of all those cases.
> 
> Signed-off-by: Joseph Myers <joseph@codesourcery.com>
> ---
>  target/i386/fpu_helper.c           |  25 +++++-
>  tests/tcg/i386/test-i386-fxtract.c | 120 +++++++++++++++++++++++++++++
>  2 files changed, 144 insertions(+), 1 deletion(-)
>  create mode 100644 tests/tcg/i386/test-i386-fxtract.c
> 
> diff --git a/target/i386/fpu_helper.c b/target/i386/fpu_helper.c
> index 792a128a6d..71a696a863 100644
> --- a/target/i386/fpu_helper.c
> +++ b/target/i386/fpu_helper.c
> @@ -767,10 +767,33 @@ void helper_fxtract(CPUX86State *env)
>                             &env->fp_status);
>          fpush(env);
>          ST0 = temp.d;
> +    } else if (floatx80_invalid_encoding(ST0)) {
> +        float_raise(float_flag_invalid, &env->fp_status);
> +        ST0 = floatx80_default_nan(&env->fp_status);
> +        fpush(env);
> +        ST0 = ST1;
> +    } else if (floatx80_is_any_nan(ST0)) {
> +        if (floatx80_is_signaling_nan(ST0, &env->fp_status)) {
> +            float_raise(float_flag_invalid, &env->fp_status);
> +            ST0 = floatx80_silence_nan(ST0, &env->fp_status);
> +        }
> +        fpush(env);
> +        ST0 = ST1;
> +    } else if (floatx80_is_infinity(ST0)) {
> +        fpush(env);
> +        ST0 = ST1;
> +        ST1 = floatx80_infinity;
>      } else {
>          int expdif;
>  
> -        expdif = EXPD(temp) - EXPBIAS;
> +        if (EXPD(temp) == 0) {
> +            int shift = clz64(temp.l.lower);
> +            temp.l.lower <<= shift;

Coverity reports the following.  It looks like a false positive
because floatx80_is_zero() would be true if both EXPD(temp) and
temp.l.lower were zero, but maybe I'm missing something.

________________________________________________________________________________________________________
*** CID 1429970:  Integer handling issues  (BAD_SHIFT)
/target/i386/fpu_helper.c: 922 in helper_fxtract()
916             ST1 = floatx80_infinity;
917         } else {
918             int expdif;
919
920             if (EXPD(temp) == 0) {
921                 int shift = clz64(temp.l.lower);
>>>     CID 1429970:  Integer handling issues  (BAD_SHIFT)
>>>     In expression "temp.l.lower <<= shift", left shifting by more than 63 bits has undefined behavior.  The shift amount, "shift", is 64.
922                 temp.l.lower <<= shift;
923                 expdif = 1 - EXPBIAS - shift;
924                 float_raise(float_flag_input_denormal, &env->fp_status);
925             } else {
926                 expdif = EXPD(temp) - EXPBIAS;
927             }



> +            expdif = 1 - EXPBIAS - shift;
> +            float_raise(float_flag_input_denormal, &env->fp_status);
> +        } else {
> +            expdif = EXPD(temp) - EXPBIAS;
> +        }
>          /* DP exponent bias */
>          ST0 = int32_to_floatx80(expdif, &env->fp_status);
>          fpush(env);

-- 
Eduardo


