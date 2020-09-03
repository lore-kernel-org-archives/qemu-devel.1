Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D90C433E7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 08:50:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6711208FE
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 08:50:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="xKS12qs4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6711208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDkx1-0000c9-P7
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 04:50:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58138)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1kDkwM-00007k-Jb
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 04:49:54 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:51956)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1kDkwK-0003rL-OG
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 04:49:54 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0838mw2C193257;
 Thu, 3 Sep 2020 08:49:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : in-reply-to : references : date : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=Ccsm97qJS6MAIgnZgzOAyP8F/LrlBgvfHkDEOsD1hEA=;
 b=xKS12qs4i0hqZ3Wg7nuHkHalF4CkXx2IOO/pnUmyivCudlmPpAUgCbwFIyqV7DAyjWwq
 uiB4jfOiDkq/0eU27K0A8JGXrlM/VyT88nwyAauNk/NYNv40TehsrY+xLwjVQusjj5ZC
 Wp5x+C2WW7eKvo/miWx9JeeWASCmtgrOj4QqXKrhKWHrQP0gm7vdd9Zl2acIhkKp6qXQ
 MeKx1+KmW/N9baMkp1ZZhnaT5HZPSA+M7mD7tJRTUMYwf0XGFlUZhOHk/ic5v1223s7N
 ovk2ApWkbtgcufez6WAuXbKOtBgW5iVgHHi9OWla4NldRmJRKPnel4K7IEERbCDeszpz wA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2130.oracle.com with ESMTP id 337eer7gpt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 03 Sep 2020 08:49:49 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0838jHG9115934;
 Thu, 3 Sep 2020 08:49:48 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3030.oracle.com with ESMTP id 3380krdfsq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 03 Sep 2020 08:49:48 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0838nlDf009472;
 Thu, 3 Sep 2020 08:49:47 GMT
Received: from starbug-mbp.localdomain (/79.97.215.145)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 03 Sep 2020 01:49:47 -0700
Received: by starbug-mbp.localdomain (Postfix, from userid 501)
 id 91DE5134F2B8; Thu,  3 Sep 2020 09:49:44 +0100 (IST)
From: Darren Kenny <darren.kenny@oracle.com>
To: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 08/15] fuzz: add a DISABLE_PCI op to general-fuzzer
In-Reply-To: <20200819061110.1320568-9-alxndr@bu.edu>
References: <20200819061110.1320568-1-alxndr@bu.edu>
 <20200819061110.1320568-9-alxndr@bu.edu>
Date: Thu, 03 Sep 2020 09:49:44 +0100
Message-ID: <m2pn73s0rb.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9732
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 adultscore=0
 mlxscore=0 suspectscore=1 malwarescore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009030080
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

On Wednesday, 2020-08-19 at 02:11:03 -04, Alexander Bulekov wrote:
> This new operation is used in the next commit, which concatenates two
> fuzzer-generated inputs. With this operation, we can prevent the second
> input from clobbering the PCI configuration performed by the first.
>
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>

Reviewed-by: Darren Kenny <darren.kenny@oracle.com>

> ---
>  tests/qtest/fuzz/general_fuzz.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/tests/qtest/fuzz/general_fuzz.c b/tests/qtest/fuzz/general_fuzz.c
> index 36d41acea0..26fcd69e45 100644
> --- a/tests/qtest/fuzz/general_fuzz.c
> +++ b/tests/qtest/fuzz/general_fuzz.c
> @@ -40,6 +40,7 @@ enum cmds{
>      OP_WRITE,
>      OP_PCI_READ,
>      OP_PCI_WRITE,
> +    OP_DISABLE_PCI,
>      OP_ADD_DMA_PATTERN,
>      OP_CLEAR_DMA_PATTERNS,
>      OP_CLOCK_STEP,
> @@ -93,6 +94,7 @@ static GArray *dma_regions;
>  
>  static GArray *dma_patterns;
>  static int dma_pattern_index;
> +static bool pci_disabled = false;
>  
>  void fuzz_dma_read_cb(size_t addr, size_t len, MemoryRegion *mr, bool is_write);
>  
> @@ -433,7 +435,7 @@ static void op_pci_read(QTestState *s, const unsigned char * data, size_t len)
>          uint8_t base;
>          uint8_t offset;
>      } a;
> -    if (len < sizeof(a) || fuzzable_pci_devices->len == 0) {
> +    if (len < sizeof(a) || fuzzable_pci_devices->len == 0 || pci_disabled) {
>          return;
>      }
>      memcpy(&a, data, sizeof(a));
> @@ -463,7 +465,7 @@ static void op_pci_write(QTestState *s, const unsigned char * data, size_t len)
>          uint8_t offset;
>          uint32_t value;
>      } a;
> -    if (len < sizeof(a) || fuzzable_pci_devices->len == 0) {
> +    if (len < sizeof(a) || fuzzable_pci_devices->len == 0 || pci_disabled) {
>          return;
>      }
>      memcpy(&a, data, sizeof(a));
> @@ -518,6 +520,11 @@ static void op_clock_step(QTestState *s, const unsigned char *data, size_t len)
>      qtest_clock_step_next(s);
>  }
>  
> +static void op_disable_pci(QTestState *s, const unsigned char *data, size_t len)
> +{
> +    pci_disabled = true;
> +}
> +
>  static void handle_timeout(int sig)
>  {
>      if (getenv("QTEST_LOG")) {
> @@ -559,6 +566,7 @@ static void general_fuzz(QTestState *s, const unsigned char *Data, size_t Size)
>          [OP_WRITE]              = op_write,
>          [OP_PCI_READ]           = op_pci_read,
>          [OP_PCI_WRITE]          = op_pci_write,
> +        [OP_DISABLE_PCI]        = op_disable_pci,
>          [OP_ADD_DMA_PATTERN]    = op_add_dma_pattern,
>          [OP_CLEAR_DMA_PATTERNS] = op_clear_dma_patterns,
>          [OP_CLOCK_STEP]         = op_clock_step,
> @@ -591,6 +599,7 @@ static void general_fuzz(QTestState *s, const unsigned char *Data, size_t Size)
>          }
>  
>          op_clear_dma_patterns(s, NULL, 0);
> +        pci_disabled = false;
>  
>          while (cmd && Size) {
>              /* Get the length until the next command or end of input */
> -- 
> 2.27.0

