Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A40C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 13:29:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F315E206E2
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 13:29:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AATTNCjE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F315E206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jg6yV-0005Xa-6f
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 09:29:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57342)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1jg6xq-00052e-Mw
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 09:28:22 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:57270)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1jg6xo-0003vx-TF
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 09:28:22 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 052DRtL1072761;
 Tue, 2 Jun 2020 13:28:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : in-reply-to : references : date : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=Z9i3dNXf92zZ3KUTmqGudyEyud2r168VSM5eqFIp2to=;
 b=AATTNCjE20otHCHBWjEdS2XXnuBE5B5TJ0ZWG6RMRKhovCCa0dPjdfWJ+65Gh3wN3ihv
 THSdwZlvV5FpxVxV785zNrZhuCmYptlbljHLivQUQca59x4IKnZq3wTesFaLsgMF9rOR
 e7fAQxbIJg7mOdj3XSMwQ2JHGPwAzUqGgEjqVu+F7jQpQ0aP/xynGRrZ8FqVRsEFBA3J
 xs7bLad3lIjL8b729SHKkewrAdYD96KZ5vdiHNzP74y06fBkys7Nf79Z4Z/vMHGGQvCQ
 TauE9QgoP4tliQo4ZGIILNsusQX15aWS0wAzAafBuyBoMusjR9RGY+Y//+XGPAoqFXr8 DA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2130.oracle.com with ESMTP id 31bewqv3f2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 02 Jun 2020 13:28:14 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 052DS0CD055341;
 Tue, 2 Jun 2020 13:28:14 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3020.oracle.com with ESMTP id 31dju1ef5p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 02 Jun 2020 13:28:13 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 052DSCOV026704;
 Tue, 2 Jun 2020 13:28:12 GMT
Received: from starbug-mbp.localdomain (/79.97.215.145)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 02 Jun 2020 06:28:12 -0700
Received: by starbug-mbp.localdomain (Postfix, from userid 501)
 id 8F48150BBE7; Tue,  2 Jun 2020 14:28:09 +0100 (IST)
From: Darren Kenny <darren.kenny@oracle.com>
To: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 0/2] fuzz: Skip QTest serialization
In-Reply-To: <20200529221450.26673-1-alxndr@bu.edu>
References: <20200529221450.26673-1-alxndr@bu.edu>
Date: Tue, 02 Jun 2020 14:28:09 +0100
Message-ID: <m2v9k9wqae.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9639
 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=679
 phishscore=0 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006020096
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9639
 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 bulkscore=0
 phishscore=0 suspectscore=0 impostorscore=0 cotscore=-2147483648
 lowpriorityscore=0 mlxscore=0 adultscore=0 spamscore=0 mlxlogscore=695
 malwarescore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006020096
Received-SPF: pass client-ip=156.151.31.86;
 envelope-from=darren.kenny@oracle.com; helo=userp2130.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/02 09:28:16
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
Cc: Alexander Bulekov <alxndr@bu.edu>, bsd@redhat.com, f4bug@amsat.org,
 stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Hi Alex,

In general the series looks good, so:

Reviewed-by: Darren Kenny <darren.kenny@oracle.com>

But not sure how to handle the patchew output though, not sure if it is
really a concern or not, since do/while won't work that context.

Thanks,

Darren.

On Friday, 2020-05-29 at 18:14:48 -04, Alexander Bulekov wrote:
> In the same vein as Philippe's patch:
>
> https://patchew.org/QEMU/20200528165303.1877-1-f4bug@amsat.org/
>
> This uses linker trickery to wrap calls to libqtest functions and
> directly call the corresponding read/write functions, rather than
> relying on the ASCII-serialized QTest protocol.
>
> v2: applies properly
>
> v3: add missing qtest_wrappers.c file and fix formatting in fuzz.c
>
> Alexander Bulekov (2):
>   fuzz: skip QTest serialization
>   fuzz: Add support for logging QTest commands
>
>  tests/qtest/fuzz/Makefile.include |  21 +++
>  tests/qtest/fuzz/fuzz.c           |  20 ++-
>  tests/qtest/fuzz/fuzz.h           |   3 +
>  tests/qtest/fuzz/qtest_wrappers.c | 252 ++++++++++++++++++++++++++++++
>  4 files changed, 295 insertions(+), 1 deletion(-)
>  create mode 100644 tests/qtest/fuzz/qtest_wrappers.c
>
> -- 
> 2.26.2

