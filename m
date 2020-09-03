Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA99C433E7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 09:05:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB82B20709
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 09:05:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Wd/b2StO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB82B20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDlBg-0000AR-U8
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 05:05:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33018)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1kDlAQ-0007dD-4D
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 05:04:26 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:43772)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1kDlAM-0005kh-Dj
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 05:04:25 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08394Jge106065;
 Thu, 3 Sep 2020 09:04:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : in-reply-to : references : date : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=c4MpqCDH5DhXVFdNVDQ2UYYGovqeaMdlZ214vLo1Jzk=;
 b=Wd/b2StOi6U0y6Q6ChT3s/m6kIkapxR/fgXNw0WHkNSMvIgJtoB3geGnRWWuJGkSVe8z
 HO4VqU8T3cNMzyM8uG8IVnu39kEqAPMIp4hnR3KLo/oKdWaDlWolLdWkhswLT8gYep7i
 NpQIc7pGcsBVgRdxGF1SZ8j18I2S3sFMrHDQSflFAnEd8f75gYSVLxA83F+3rWVDfmWh
 FcQmkkDm6+hLwuuox4yHwEZc750qpWE5shVNvSYhC8cEQeR0KmcA9JHkyb+4aF4G5+Ua
 B1gNdBzKo5ApthinKnCWhRkmEEl9vUyLM0Ztr2nVWd/ccSxdg8qTgMdkVIF1Ze+q+rnG Vw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2120.oracle.com with ESMTP id 337eymfg9m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 03 Sep 2020 09:04:19 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 083918Oi074334;
 Thu, 3 Sep 2020 09:04:18 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3020.oracle.com with ESMTP id 3380svqus6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 03 Sep 2020 09:04:18 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08394HqL024027;
 Thu, 3 Sep 2020 09:04:17 GMT
Received: from starbug-mbp.localdomain (/79.97.215.145)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 03 Sep 2020 02:04:17 -0700
Received: by starbug-mbp.localdomain (Postfix, from userid 501)
 id C0435134F901; Thu,  3 Sep 2020 10:04:13 +0100 (IST)
From: Darren Kenny <darren.kenny@oracle.com>
To: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 09/15] fuzz: add a crossover function to generic-fuzzer
In-Reply-To: <20200819061110.1320568-10-alxndr@bu.edu>
References: <20200819061110.1320568-1-alxndr@bu.edu>
 <20200819061110.1320568-10-alxndr@bu.edu>
Date: Thu, 03 Sep 2020 10:04:13 +0100
Message-ID: <m2k0xbs036.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9732
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0
 suspectscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009030083
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9732
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 adultscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009030084
Received-SPF: pass client-ip=141.146.126.78;
 envelope-from=darren.kenny@oracle.com; helo=aserp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 04:47:13
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

On Wednesday, 2020-08-19 at 02:11:04 -04, Alexander Bulekov wrote:
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> ---
>  tests/qtest/fuzz/general_fuzz.c | 81 ++++++++++++++++++++++++++++++++-
>  1 file changed, 80 insertions(+), 1 deletion(-)
>
> diff --git a/tests/qtest/fuzz/general_fuzz.c b/tests/qtest/fuzz/general_fuzz.c
> index 26fcd69e45..2c3716f8cc 100644
> --- a/tests/qtest/fuzz/general_fuzz.c
> +++ b/tests/qtest/fuzz/general_fuzz.c
> @@ -739,6 +739,83 @@ static void general_pre_fuzz(QTestState *s)
>  
>      counter_shm_init();
>  }
> +
> +/*
> + * When libfuzzer gives us two inputs to combine, return a new input with the
> + * following structure:
> + *
> + * Input 1 (data1)
> + * SEPARATOR
> + * Clear out the DMA Patterns
> + * SEPARATOR
> + * Disable the pci_read/write instructions
> + * SEPARATOR
> + * Input 2 (data2)
> + *
> + * The idea is to collate the core behaviors of the two inputs.
> + * For example:
> + * Input 1: maps a device's BARs, sets up three DMA patterns, and triggers
> + *          device functionality A
> + * Input 2: maps a device's BARs, sets up one DMA pattern, and triggers device
> + *          functionality B
> + *
> + * This function attempts to produce an input that:
> + * Ouptut: maps a device's BARs, set up three DMA patterns, triggers
> + *          functionality A device, replaces the DMA patterns with a single
> + *          patten, and triggers device functionality B.
> + */
> +static size_t general_fuzz_crossover(const uint8_t *data1, size_t size1, const
> +                                     uint8_t *data2, size_t size2, uint8_t *out,
> +                                     size_t max_out_size, unsigned int seed)
> +{

I don't see this function as well documented, but it might be a good
idea to check up front whether out is not NULL and that the max_out_size
is capable of holding what you're likely to consume, i.e. approx:

  size1 + size2 + (SEPARATOR * 3) + 2 /* Ops */

If nothing else means you can be sure you won't have to call MIN() all
the time, but also that you won't end up only partially filling it too.

> +    size_t copy = 0, size = 0;

NIT: Maybe copy should be copy_len or something rather than a verb?

> +
> +    // Copy in the first input
> +    copy = MIN(size1, max_out_size);
> +    memcpy(out+size, data1, copy);
> +    size+= copy;
> +    max_out_size-= copy;
> +
> +    // Append a separator
> +    copy = MIN(strlen(SEPARATOR), max_out_size);
> +    memcpy(out+size, SEPARATOR, copy);
> +    size+= copy;
> +    max_out_size-= copy;
> +
> +    // Clear out the
> +    copy = MIN(1, max_out_size);
> +    if (copy) {
> +        out[size] = OP_CLEAR_DMA_PATTERNS;
> +    }
> +    size+= copy;
> +    max_out_size-= copy;
> +
> +    copy = MIN(strlen(SEPARATOR), max_out_size);
> +    memcpy(out+size, SEPARATOR, copy);
> +    size+= copy;
> +    max_out_size-= copy;
> +
> +    copy = MIN(1, max_out_size);
> +    if (copy) {
> +        out[size] = OP_DISABLE_PCI;
> +    }
> +    size+= copy;
> +    max_out_size-= copy;
> +
> +    copy = MIN(strlen(SEPARATOR), max_out_size);
> +    memcpy(out+size, SEPARATOR, copy);
> +    size+= copy;
> +    max_out_size-= copy;
> +
> +    copy = MIN(size2, max_out_size);
> +    memcpy(out+size, data2, copy);
> +    size+= copy;
> +    max_out_size-= copy;
> +
> +    return  size;
> +}
> +
> +
>  static GString *general_fuzz_cmdline(FuzzTarget *t)
>  {
>      GString *cmd_line = g_string_new(TARGET_NAME);
> @@ -758,7 +835,9 @@ static void register_general_fuzz_targets(void)
>              .description = "Fuzz based on any qemu command-line args. ",
>              .get_init_cmdline = general_fuzz_cmdline,
>              .pre_fuzz = general_pre_fuzz,
> -            .fuzz = general_fuzz});
> +            .fuzz = general_fuzz,
> +            .crossover = general_fuzz_crossover
> +    });
>  }
>  
>  fuzz_target_init(register_general_fuzz_targets);

Thanks,

Darren.

