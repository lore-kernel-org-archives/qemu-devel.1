Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C107C47420
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 15:40:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 728B4206B5
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 15:40:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Whe9Id25"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 728B4206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO0hC-000145-EX
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 11:40:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56494)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1kO0aR-0002gb-Go
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 11:33:39 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:37910)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1kO0aL-0002Uf-EF
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 11:33:39 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 091FJuUR156374;
 Thu, 1 Oct 2020 15:33:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : in-reply-to : references : date : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=vOa43DurMXT/ALjF4zRlLkeIJcpT4yC4tq1PANvrQIA=;
 b=Whe9Id25vbxDx+y8rBM8Kpr4JmJg69sDycFobBk02YlT04XL2l3e1EGsCijJoy707X8I
 9UR5/pADVktnMAHJDBv3k0J06L6IyKeR1kL6R27lisgMh/j1vXRNlQMgOYa5/LR7uX5C
 4Euzg7k2xNrKTH8b+HkAPlQiXGkQHsJKmrTm5h7NXD+r/kh/PeAo+tH9ximLbTV22yRp
 oWvnymCBlMGppaiFZMnAULq5WO6eHyvvh1u7+PWEBINhqQimydFHYX916GETDSGyYyxA
 c/IvhIQHoPvMJYV+ZQtJbhFaXfpsj3mhoR4wwEWMEPJ+W8XqT3QVSoqax6EMampoBCBY 6Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2130.oracle.com with ESMTP id 33su5b6ukk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 01 Oct 2020 15:33:30 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 091FL0Mj093342;
 Thu, 1 Oct 2020 15:31:29 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3030.oracle.com with ESMTP id 33uv2h36fm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 01 Oct 2020 15:31:29 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 091FVSPI019724;
 Thu, 1 Oct 2020 15:31:28 GMT
Received: from starbug-mbp.localdomain (/79.97.215.145)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 01 Oct 2020 08:31:27 -0700
Received: by starbug-mbp.localdomain (Postfix, from userid 501)
 id AE86318EE1D4; Thu,  1 Oct 2020 16:31:24 +0100 (IST)
From: Darren Kenny <darren.kenny@oracle.com>
To: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 09/16] fuzz: add a crossover function to generic-fuzzer
In-Reply-To: <20200921022506.873303-10-alxndr@bu.edu>
References: <20200921022506.873303-1-alxndr@bu.edu>
 <20200921022506.873303-10-alxndr@bu.edu>
Date: Thu, 01 Oct 2020 16:31:24 +0100
Message-ID: <m2eemi6jzn.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9761
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 adultscore=0
 suspectscore=1 malwarescore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010010132
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9761
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 suspectscore=1
 lowpriorityscore=0 spamscore=0 clxscore=1015 mlxscore=0 impostorscore=0
 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010010132
Received-SPF: pass client-ip=141.146.126.79;
 envelope-from=darren.kenny@oracle.com; helo=aserp2130.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 09:58:19
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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
 Alexander Bulekov <alxndr@bu.edu>, bsd@redhat.com, stefanha@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As mentioned in an earlier patch, maybe the definition of SEPARATOR
should be here as well as some of the comments you provided in the
replies to it.

Otherwise, this looks good,

Reviewed-by: Darren Kenny <darren.kenny@oracle.com>

Thanks,

Darren.

On Sunday, 2020-09-20 at 22:24:59 -04, Alexander Bulekov wrote:
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> ---
>  tests/qtest/fuzz/general_fuzz.c | 90 ++++++++++++++++++++++++++++++++-
>  1 file changed, 89 insertions(+), 1 deletion(-)
>
> diff --git a/tests/qtest/fuzz/general_fuzz.c b/tests/qtest/fuzz/general_fuzz.c
> index 656ec7fd55..3833b505c8 100644
> --- a/tests/qtest/fuzz/general_fuzz.c
> +++ b/tests/qtest/fuzz/general_fuzz.c
> @@ -741,6 +741,92 @@ static void general_pre_fuzz(QTestState *s)
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
> +    size_t copy_len = 0, size = 0;
> +
> +    /* Check that we have enough space for data1 and at least part of data2 */
> +    if (max_out_size <= size + strlen(SEPARATOR) * 3 + 2) {
> +        return 0;
> +    }
> +
> +    /* Copy_Len in the first input */
> +    copy_len = size1;
> +    memcpy(out + size, data1, copy_len);
> +    size += copy_len;
> +    max_out_size -= copy_len;
> +
> +    /* Append a separator */
> +    copy_len = strlen(SEPARATOR);
> +    memcpy(out + size, SEPARATOR, copy_len);
> +    size += copy_len;
> +    max_out_size -= copy_len;
> +
> +    /* Clear out the DMA Patterns */
> +    copy_len = 1;
> +    if (copy_len) {
> +        out[size] = OP_CLEAR_DMA_PATTERNS;
> +    }
> +    size += copy_len;
> +    max_out_size -= copy_len;
> +
> +    /* Append a separator */
> +    copy_len = strlen(SEPARATOR);
> +    memcpy(out + size, SEPARATOR, copy_len);
> +    size += copy_len;
> +    max_out_size -= copy_len;
> +
> +    /* Disable PCI ops. Assume data1 took care of setting up PCI */
> +    copy_len = 1;
> +    if (copy_len) {
> +        out[size] = OP_DISABLE_PCI;
> +    }
> +    size += copy_len;
> +    max_out_size -= copy_len;
> +
> +    /* Append a separator */
> +    copy_len = strlen(SEPARATOR);
> +    memcpy(out + size, SEPARATOR, copy_len);
> +    size += copy_len;
> +    max_out_size -= copy_len;
> +
> +    /* Copy_Len over the second input */
> +    copy_len = MIN(size2, max_out_size);
> +    memcpy(out + size, data2, copy_len);
> +    size += copy_len;
> +    max_out_size -= copy_len;
> +
> +    return  size;
> +}
> +
> +
>  static GString *general_fuzz_cmdline(FuzzTarget *t)
>  {
>      GString *cmd_line = g_string_new(TARGET_NAME);
> @@ -760,7 +846,9 @@ static void register_general_fuzz_targets(void)
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
> -- 
> 2.28.0

