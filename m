Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06AE9C54E4B
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 08:03:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6A352075E
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 08:03:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="co7FP3Vg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6A352075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYPsc-000757-0Y
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 04:03:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59988)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1jYPrW-00067H-07
 for qemu-devel@nongnu.org; Tue, 12 May 2020 04:02:02 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:39136)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1jYPrU-0004ot-UJ
 for qemu-devel@nongnu.org; Tue, 12 May 2020 04:02:01 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04C7l1wQ148252;
 Tue, 12 May 2020 08:01:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : in-reply-to : references : date : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=5IMmnEnffuj4VRXJfytQyjtbOaAo9hK3PVrs4zKPBC4=;
 b=co7FP3Vgo0CVkI2uYPE4Pli4rHWeUu435iI7tDqzg7ksVxT2vPNdIGasxQyteLkmwD97
 P5/1V0XO3ZFhdR7VbtdQsA/VxrbKiM9Ib7n51aDD+PZRQw7T74KQT7F0EGq94ScoCBnP
 lRIK4MkasfnfYirVgz5jaBzXnVVxs605hjVwdIV4Y8eDLQeFbfEzdlbZZuC2zfgdTFeS
 WGdw3lTQuDITKYOOzVEJrrSZVlY7eN0B+sKFfUZNrxpMhzb8uyNMUBkth+3lGvMMm3ie
 lssmeN/7UtK0A4Z79JoDhdPv1oSrJHlQJ2kaWxEfAZ2V4S0nuKqRqS15bswmdorITCW+ Tg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2120.oracle.com with ESMTP id 30x3gshdea-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 12 May 2020 08:01:59 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04C7gJFx076474;
 Tue, 12 May 2020 08:01:58 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3020.oracle.com with ESMTP id 30x69spngc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 12 May 2020 08:01:58 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 04C81vIv002096;
 Tue, 12 May 2020 08:01:57 GMT
Received: from starbug-mbp.localdomain (/79.97.215.145)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 12 May 2020 01:01:56 -0700
Received: by starbug-mbp.localdomain (Postfix, from userid 501)
 id 3A2576920C67; Tue, 12 May 2020 09:01:54 +0100 (IST)
From: Darren Kenny <darren.kenny@oracle.com>
To: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org
Subject: Re: [PATCH 3/4] fuzz: add mangled object name to linker script
In-Reply-To: <20200512030133.29896-4-alxndr@bu.edu>
References: <20200512030133.29896-1-alxndr@bu.edu>
 <20200512030133.29896-4-alxndr@bu.edu>
Date: Tue, 12 May 2020 09:01:54 +0100
Message-ID: <m2tv0llgy5.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9618
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 adultscore=0
 spamscore=0 suspectscore=1 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005120067
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9618
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999
 malwarescore=0 adultscore=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 clxscore=1015 bulkscore=0 phishscore=0
 suspectscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005120067
Received-SPF: pass client-ip=141.146.126.78;
 envelope-from=darren.kenny@oracle.com; helo=aserp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 03:59:36
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Monday, 2020-05-11 at 23:01:32 -04, Alexander Bulekov wrote:
> Previously, we relied on "FuzzerTracePC*(.bss*)" to place libfuzzer's
> fuzzer::TPC object into our contiguous shared-memory region. This does
> not work for some libfuzzer builds, so this addition identifies the
> region by its mangled name: *(.bss._ZN6fuzzer3TPCE);
>
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>

FWIW, since I'm not really familiar with the syntax, but I understand
what the intent is:

Reviewed-by: Darren Kenny <darren.kenny@oracle.com>


> ---
>  tests/qtest/fuzz/fork_fuzz.ld | 5 +++++
>  1 file changed, 5 insertions(+)
>
> This isn't ideal, but I looked at the libfuzzer builds packaged for
> debian, for versions 6, 7, 8, 9, 10 and 11 and this (mangled) object
> name appears consistently in the symbol tables.
>
> diff --git a/tests/qtest/fuzz/fork_fuzz.ld b/tests/qtest/fuzz/fork_fuzz.ld
> index e086bba873..bfb667ed06 100644
> --- a/tests/qtest/fuzz/fork_fuzz.ld
> +++ b/tests/qtest/fuzz/fork_fuzz.ld
> @@ -28,6 +28,11 @@ SECTIONS
>  
>        /* Internal Libfuzzer TracePC object which contains the ValueProfileMap */
>        FuzzerTracePC*(.bss*);
> +      /*
> +       * In case the above line fails, explicitly specify the (mangled) name of
> +       * the object we care about
> +       */
> +       *(.bss._ZN6fuzzer3TPCE);
>    }
>    .data.fuzz_end : ALIGN(4K)
>    {
> -- 
> 2.26.2

