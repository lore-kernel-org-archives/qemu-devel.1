Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7914C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 08:51:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 833672065F
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 08:51:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="R39uBhOd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 833672065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDkxt-0001Vz-Kq
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 04:51:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58268)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1kDkwl-0000TZ-W0
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 04:50:20 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:52656)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1kDkwk-0003w4-6k
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 04:50:19 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0838mvJI193189;
 Thu, 3 Sep 2020 08:50:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : in-reply-to : references : date : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=URKUbVRt2VBnaQr1iHIBg3OY8YM1Q3u7gh+wje0xXcE=;
 b=R39uBhOdH7pL+BcuYu+mFaQ/DHsxC0iGHlJv4Qt1t94Jw1KlsYEGACI/kqUxu3YFOq4x
 6RzefqZNNOxf3lcLdtMIbc3oIjBO3RFDcP3GPxp73ZNhxI/7Hjkyw48J81MOEWvgjlD0
 9YwhoqfRVp89uYYYE3Cg1BETh+e3VOTnKC/iMUCpoQhYOe/gYlKUctpql5d7BmweQDtW
 QTXIfmdRSVD/wSUuicwDRKGp6BNmxduVA1DWkXqNl9hJAannmRd24EAEbt2NnJ8lxzRo
 Af5/MAk2gTffdZvB+WEJuvj3eiOSoCWd3nuHzKkKOAcB94+l8IKE+dQR4f3e9+g9jDQ7 XQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2130.oracle.com with ESMTP id 337eer7gxb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 03 Sep 2020 08:50:15 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0838nmZE161786;
 Thu, 3 Sep 2020 08:50:15 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3030.oracle.com with ESMTP id 3380y1g2ad-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 03 Sep 2020 08:50:15 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0838oEp1010972;
 Thu, 3 Sep 2020 08:50:14 GMT
Received: from starbug-mbp.localdomain (/79.97.215.145)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 03 Sep 2020 01:50:13 -0700
Received: by starbug-mbp.localdomain (Postfix, from userid 501)
 id 154F3134F2E3; Thu,  3 Sep 2020 09:50:10 +0100 (IST)
From: Darren Kenny <darren.kenny@oracle.com>
To: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 07/15] fuzz: Add support for custom crossover functions
In-Reply-To: <20200819061110.1320568-8-alxndr@bu.edu>
References: <20200819061110.1320568-1-alxndr@bu.edu>
 <20200819061110.1320568-8-alxndr@bu.edu>
Date: Thu, 03 Sep 2020 09:50:10 +0100
Message-ID: <m2mu27s0ql.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9732
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 phishscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009030081
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9732
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 impostorscore=0 mlxlogscore=999 bulkscore=0 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009030081
Received-SPF: pass client-ip=156.151.31.86;
 envelope-from=darren.kenny@oracle.com; helo=userp2130.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 04:48:18
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 f4bug@amsat.org, Alexander Bulekov <alxndr@bu.edu>, bsd@redhat.com,
 stefanha@redhat.com, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wednesday, 2020-08-19 at 02:11:02 -04, Alexander Bulekov wrote:
> libfuzzer supports a "custom crossover function". Libfuzzer often tries
> to blend two inputs to create a new interesting input. Sometimes, we
> have a better idea about how to blend inputs together. This change
> allows fuzzers to specify a custom function for blending two inputs
> together.
>
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>

Reviewed-by: Darren Kenny <darren.kenny@oracle.com>

> ---
>  tests/qtest/fuzz/fuzz.c | 13 +++++++++++++
>  tests/qtest/fuzz/fuzz.h | 26 ++++++++++++++++++++++++++
>  2 files changed, 39 insertions(+)
>
> diff --git a/tests/qtest/fuzz/fuzz.c b/tests/qtest/fuzz/fuzz.c
> index 8234b68754..248fab5f37 100644
> --- a/tests/qtest/fuzz/fuzz.c
> +++ b/tests/qtest/fuzz/fuzz.c
> @@ -118,6 +118,19 @@ static FuzzTarget *fuzz_get_target(char* name)
>  }
>  
>  
> +/* Sometimes called by libfuzzer to mutate two inputs into one */
> +size_t LLVMFuzzerCustomCrossOver(const uint8_t *data1, size_t size1,
> +                                 const uint8_t *data2, size_t size2,
> +                                 uint8_t *out, size_t max_out_size,
> +                                 unsigned int seed)
> +{
> +    if(fuzz_target->crossover) {
> +        return fuzz_target->crossover(data1, size1, data2, size2, out,
> +                                      max_out_size, seed);
> +    }
> +    return 0;
> +}
> +
>  /* Executed for each fuzzing-input */
>  int LLVMFuzzerTestOneInput(const unsigned char *Data, size_t Size)
>  {
> diff --git a/tests/qtest/fuzz/fuzz.h b/tests/qtest/fuzz/fuzz.h
> index 9ca3d107c5..d36642b5ec 100644
> --- a/tests/qtest/fuzz/fuzz.h
> +++ b/tests/qtest/fuzz/fuzz.h
> @@ -77,6 +77,28 @@ typedef struct FuzzTarget {
>       */
>      void(*fuzz)(QTestState *, const unsigned char *, size_t);
>  
> +    /*
> +     * The fuzzer can specify a "Custom Crossover" function for combining two
> +     * inputs from the corpus. This function is sometimes called by libfuzzer
> +     * when mutating inputs.
> +     *
> +     * data1: location of first input
> +     * size1: length of first input
> +     * data1: location of second input
> +     * size1: length of second input
> +     * out: where to place the resulting, mutated input
> +     * max_out_size: the maximum length of the input that can be placed in out
> +     * seed: the seed that should be used to make mutations deterministic, when needed
> +     *
> +     * See libfuzzer's LLVMFuzzerCustomCrossOver API for more info.
> +     *
> +     * Can be NULL
> +     */
> +    size_t(*crossover)(const uint8_t *data1, size_t size1,
> +                       const uint8_t *data2, size_t size2,
> +                       uint8_t *out, size_t max_out_size,
> +                       unsigned int seed);
> +
>  } FuzzTarget;
>  
>  void flush_events(QTestState *);
> @@ -91,6 +113,10 @@ void fuzz_qtest_set_serialize(bool option);
>   */
>  void fuzz_add_target(const FuzzTarget *target);
>  
> +size_t LLVMFuzzerCustomCrossOver(const uint8_t *data1, size_t size1,
> +                                 const uint8_t *data2, size_t size2,
> +                                 uint8_t *out, size_t max_out_size,
> +                                 unsigned int seed);
>  int LLVMFuzzerTestOneInput(const unsigned char *Data, size_t Size);
>  int LLVMFuzzerInitialize(int *argc, char ***argv, char ***envp);
>  
> -- 
> 2.27.0

