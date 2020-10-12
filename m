Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8DF1C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 10:14:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58A2920679
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 10:14:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ck1iOD0t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58A2920679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRuqc-0003zT-Bb
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 06:14:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46634)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kRucq-0002Zr-K0
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 06:00:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45988)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kRucn-0002zU-Mz
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 06:00:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602496812;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HW5gyyKX4LTvRJZLCrqy56CrfvS2R9nbz3OBBLJXvyE=;
 b=ck1iOD0tZbgjL29J04tfxRKnjr+NJbEl466mR/1IdBEkx7s9Lg8w0yUf7AksJhdJX0QeDB
 YOaofMtqSpOsHYbwmFN4FETZlcoHA1cagk56mBSIFf19euiOS5WZvcSUMzeT7V3+vfKK9Y
 ihgFXomvtzGsBFF9eFmaY0CyXeEWwZY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-VMooic3dMNqbpQBNOzAB0g-1; Mon, 12 Oct 2020 06:00:10 -0400
X-MC-Unique: VMooic3dMNqbpQBNOzAB0g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 902E11800D42;
 Mon, 12 Oct 2020 10:00:09 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-113-22.ams2.redhat.com [10.36.113.22])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 66E8A6CE4D;
 Mon, 12 Oct 2020 10:00:00 +0000 (UTC)
Subject: Re: [PATCH] gitlab-ci.yml: Only run one test-case per fuzzer
To: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org
References: <20201002143524.56930-1-alxndr@bu.edu>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <cb9bd32a-adc4-4c9d-7863-3e6fa565bb7e@redhat.com>
Date: Mon, 12 Oct 2020 12:00:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201002143524.56930-1-alxndr@bu.edu>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/11 23:52:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/10/2020 16.35, Alexander Bulekov wrote:
> With 1000 runs, there is a non-negligible chance that the fuzzer can
> trigger a crash. With this CI job, we care about catching build/runtime
> issues in the core fuzzing code. Actual device fuzzing takes place on
> oss-fuzz. For these purposes, only running one input should be
> sufficient.
> 
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> Suggested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  .gitlab-ci.yml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index a51c89554f..075c15d45c 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -303,7 +303,7 @@ build-oss-fuzz:
>                        | grep -v slirp); do
>          grep "LLVMFuzzerTestOneInput" ${fuzzer} > /dev/null 2>&1 || continue ;
>          echo Testing ${fuzzer} ... ;
> -        "${fuzzer}" -runs=1000 -seed=1 || exit 1 ;
> +        "${fuzzer}" -runs=1 -seed=1 || exit 1 ;
>        done
>      # Unrelated to fuzzer: run some tests with -fsanitize=address
>      - cd build-oss-fuzz && make check-qtest-i386 check-unit

Thanks, queued to:

 https://gitlab.com/huth/qemu/-/commits/qtest-next/

 Thomas



