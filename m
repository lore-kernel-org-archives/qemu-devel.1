Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F18AC4363D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 04:54:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EBDD206FC
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 04:54:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MbvvGv74"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EBDD206FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKwnx-0003Zb-Gp
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 00:54:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53032)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kKwn4-0002ht-Q4
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 00:54:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57679)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kKwn3-0004FY-8l
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 00:54:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600836840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DhEeg8qpTgI5VI9YScodyeGoyqeFH0j/KZbk9G8MmTo=;
 b=MbvvGv74Y67aC9m9gvEEJ6H97EUPpVvP0p+ocWUpDyjiok6jkfB0Zm6kBmmI5MpgPg42Nq
 4NSAwtzmpmGJF4ELGpQkyLsoocJzdpasM1UJLZzkKTauBGVqwAJngdO8DjMX7HtU5Wg+0g
 5RR4cM/gLPTl7HOO0xinBYmO7Qd5wl0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-zKYH-zt3OTu-Nhi2ecBkGA-1; Wed, 23 Sep 2020 00:53:56 -0400
X-MC-Unique: zKYH-zt3OTu-Nhi2ecBkGA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4C25B186DD2C;
 Wed, 23 Sep 2020 04:53:55 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-49.ams2.redhat.com [10.36.112.49])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1FEF955780;
 Wed, 23 Sep 2020 04:53:50 +0000 (UTC)
Subject: Re: [PATCH v1 1/8] s390x/tcg: Implement ADD HALFWORD (AGH)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20200922103129.12824-1-david@redhat.com>
 <20200922103129.12824-2-david@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <587016e6-9c02-257e-cab7-e8ed9255e004@redhat.com>
Date: Wed, 23 Sep 2020 06:53:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200922103129.12824-2-david@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 00:53:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22/09/2020 12.31, David Hildenbrand wrote:
> Easy, just like ADD HALFWORD IMMEDIATE (AGHI).
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/insn-data.def | 1 +
>  target/s390x/translate.c   | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
> index d79ae9e3f1..8dbeaf8c49 100644
> --- a/target/s390x/insn-data.def
> +++ b/target/s390x/insn-data.def
> @@ -52,6 +52,7 @@
>  /* ADD HALFWORD */
>      C(0x4a00, AH,      RX_a,  Z,   r1, m2_16s, new, r1_32, add, adds32)
>      C(0xe37a, AHY,     RXY_a, LD,  r1, m2_16s, new, r1_32, add, adds32)
> +    C(0xe338, AGH,     RXY_a, MIE2,r1, m2_16s, r1, 0, add, adds64)
>  /* ADD HALFWORD IMMEDIATE */
>      C(0xa70a, AHI,     RI_a,  Z,   r1, i2, new, r1_32, add, adds32)
>      C(0xa70b, AGHI,    RI_a,  Z,   r1, i2, r1, 0, add, adds64)
> diff --git a/target/s390x/translate.c b/target/s390x/translate.c
> index a777343821..21d77b7e74 100644
> --- a/target/s390x/translate.c
> +++ b/target/s390x/translate.c
> @@ -6098,6 +6098,7 @@ enum DisasInsnEnum {
>  #define FAC_AIS         S390_FEAT_ADAPTER_INT_SUPPRESSION
>  #define FAC_V           S390_FEAT_VECTOR /* vector facility */
>  #define FAC_VE          S390_FEAT_VECTOR_ENH /* vector enhancements facility 1 */
> +#define FAC_MIE2        S390_FEAT_MISC_INSTRUCTION_EXT /* miscellaneous-instruction-extensions facility 2 */

Maybe you should use "S390_FEAT_MISC_INSTRUCTION_EXT2" (i.e. with 2 at
the end) to avoid that it gets confused with the first MIE ?

 Thomas


