Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50021C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 10:46:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D9B720786
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 10:46:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dg47H/i2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D9B720786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaGIv-00069b-AV
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 05:46:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45018)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kaGHi-0005Wz-0d
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 05:44:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39679)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kaGHf-0004zg-Ff
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 05:44:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604486693;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WPWDujVNM8hBiDf9P/eY9c/7XJIrt2NIUD9AJ+9wrdM=;
 b=dg47H/i22HLDyZX2jaW2XWXwz3S7vcQv5QIWQsG+SwCqO/Q/swWdnVT5assb2cIGYNwy8b
 ke8hChTZT5jMDfI/RvnGtN3mrrPweUnAKoDwMvaUouf6dF8kYvdW3tnPXb7v1Yxh8KFg0C
 4VIQZ+N20xx1qLcy1g0z+Ja5Fj39GfM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-cOxaQyZSNxmZMwziDzEJIg-1; Wed, 04 Nov 2020 05:44:51 -0500
X-MC-Unique: cOxaQyZSNxmZMwziDzEJIg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AB77D186DD28;
 Wed,  4 Nov 2020 10:44:50 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-151.ams2.redhat.com [10.36.112.151])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F076110013C4;
 Wed,  4 Nov 2020 10:44:47 +0000 (UTC)
Subject: Re: [PATCH] qtest: Fix bad printf format specifiers
To: AlexChen <alex.chen@huawei.com>, lvivier@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>
References: <5FA28117.3020802@huawei.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <67eca43e-99ea-f2ce-5d9e-a9cb5c7a3a83@redhat.com>
Date: Wed, 4 Nov 2020 11:44:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <5FA28117.3020802@huawei.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 04/11/2020 11.23, AlexChen wrote:
> We should use printf format specifier "%u" instead of "%d" for
> argument of type "unsigned int".
> 
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Alex Chen <alex.chen@huawei.com>
> ---
>  tests/qtest/arm-cpu-features.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/qtest/arm-cpu-features.c b/tests/qtest/arm-cpu-features.c
> index d20094d5a7..bc681a95d5 100644
> --- a/tests/qtest/arm-cpu-features.c
> +++ b/tests/qtest/arm-cpu-features.c
> @@ -536,7 +536,7 @@ static void test_query_cpu_model_expansion_kvm(const void *data)
>          if (kvm_supports_sve) {
>              g_assert(vls != 0);
>              max_vq = 64 - __builtin_clzll(vls);
> -            sprintf(max_name, "sve%d", max_vq * 128);
> +            sprintf(max_name, "sve%u", max_vq * 128);
> 
>              /* Enabling a supported length is of course fine. */
>              assert_sve_vls(qts, "host", vls, "{ %s: true }", max_name);
> @@ -556,7 +556,7 @@ static void test_query_cpu_model_expansion_kvm(const void *data)
>                   * unless all larger, supported vector lengths are also
>                   * disabled.
>                   */
> -                sprintf(name, "sve%d", vq * 128);
> +                sprintf(name, "sve%u", vq * 128);
>                  error = g_strdup_printf("cannot disable %s", name);
>                  assert_error(qts, "host", error,
>                               "{ %s: true, %s: false }",
> @@ -569,7 +569,7 @@ static void test_query_cpu_model_expansion_kvm(const void *data)
>               * we need at least one vector length enabled.
>               */
>              vq = __builtin_ffsll(vls);
> -            sprintf(name, "sve%d", vq * 128);
> +            sprintf(name, "sve%u", vq * 128);
>              error = g_strdup_printf("cannot disable %s", name);
>              assert_error(qts, "host", error, "{ %s: false }", name);
>              g_free(error);
> @@ -581,7 +581,7 @@ static void test_query_cpu_model_expansion_kvm(const void *data)
>                  }
>              }
>              if (vq <= SVE_MAX_VQ) {
> -                sprintf(name, "sve%d", vq * 128);
> +                sprintf(name, "sve%u", vq * 128);
>                  error = g_strdup_printf("cannot enable %s", name);
>                  assert_error(qts, "host", error, "{ %s: true }", name);
>                  g_free(error);
> 

max_vq and vq are both "uint32_t" and not "unsigned int" ... so if you want
to fix this really really correctly, please use PRIu32 from inttypes.h instead.

 Thanks,
  Thomas


