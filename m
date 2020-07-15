Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87BC9C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 09:08:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53B9020672
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 09:08:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="auZ0AXC4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53B9020672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvdOY-0003Qt-Jb
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 05:08:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45780)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jvdO0-00030W-81
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 05:07:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26560
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jvdNx-0002yV-R0
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 05:07:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594804048;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/xxIYPgxJsVkBSoqBOVpx5WBa9vAvs/e2Y8qHXnPF4c=;
 b=auZ0AXC41+OIrX/kSsJjB6dv9bT1OR54VLbrPfgK8rx1KzLdJOcx/e0G9/JRDVnDXv+4IC
 rySrd3S6BgWBZl5dcKs9HSrv3i39NzJf44OVOItffQ/s4YMIkZ8R5qzSrlrS98bV+atkdC
 0KDbDnHeKce05dDZMWR43DrVvGVWzdg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-nK1LvRHaOFeh7dA4PnD1cw-1; Wed, 15 Jul 2020 05:07:25 -0400
X-MC-Unique: nK1LvRHaOFeh7dA4PnD1cw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E1D52106B243;
 Wed, 15 Jul 2020 09:07:24 +0000 (UTC)
Received: from [10.36.112.108] (ovpn-112-108.ams2.redhat.com [10.36.112.108])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D373D60C84;
 Wed, 15 Jul 2020 09:07:19 +0000 (UTC)
Subject: Re: [PATCH] qtest: bios-tables-test: fix a memory leak
To: Li Qiang <liq3ea@163.com>, imammedo@redhat.com, thuth@redhat.com,
 lvivier@redhat.com, pbonzini@redhat.com
References: <20200714153536.66060-1-liq3ea@163.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <1bfe619d-23c8-d7e9-c4dd-0f533ba5222f@redhat.com>
Date: Wed, 15 Jul 2020 11:07:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200714153536.66060-1-liq3ea@163.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/15 05:07:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: liq3ea@gmail.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Li,

On 7/14/20 5:35 PM, Li Qiang wrote:
> Fixes: 5da7c35e25a("bios-tables-test: Add Q35/TPM-TIS test")
> Signed-off-by: Li Qiang <liq3ea@163.com>
> ---
>  tests/qtest/bios-tables-test.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
> index c315156858..d49b3988ec 100644
> --- a/tests/qtest/bios-tables-test.c
> +++ b/tests/qtest/bios-tables-test.c
> @@ -924,6 +924,7 @@ static void test_acpi_tcg_tpm(const char *machine, const char *tpm_if,
>      g_free(variant);
>      g_free(tmp_path);
>      g_free(tmp_dir_name);
> +    g_free(args);
>      free_test_data(&data);
>  #else
>      g_test_skip("TPM disabled");
> 
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks!

Eric


