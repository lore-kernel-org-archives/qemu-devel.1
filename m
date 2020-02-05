Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B514CC35254
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 13:02:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 815B221927
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 13:02:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="m14lW5/3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 815B221927
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izKK3-0008Vz-Lx
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 08:02:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47395)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <darren.kenny@oracle.com>) id 1izKIN-0007nh-DR
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 08:00:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <darren.kenny@oracle.com>) id 1izKII-0008PY-Qg
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 08:00:40 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:35502)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <darren.kenny@oracle.com>)
 id 1izKII-0008Ar-Gl
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 08:00:38 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 015CwDEV084318;
 Wed, 5 Feb 2020 13:00:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=528mZc6pKne0iNpe9MId4cn1ZpBWfl6HpfMiqEO+828=;
 b=m14lW5/3Mmit1ZipvHPGHIMj4DaDNOVqZSwhXVsuNo/32QQQdO+45RUAfC8m/H2YDDJv
 V+xeAHM+CgaWWnFXblUsvNsbn1mg3UFaM+nlvemMTnND/jK3llEkqnqgMEbjX03HV4Z9
 z+mFQjw4PtVEW/N3GOVSbnDHdflizvF54OLQ8yh5Rb1WQwsn2st27uvrklh3jBpMshOV
 hxMQbqc/QGBA2156t8wJo8vcFbeXBqQviVRGxblVIF1Z7X7eBvxh9W0SKRLvk1VbS5Ku
 ylF6rWRv7RDsrZ5kcdYfJFaK06VkOk2CS/O37PI+VNrytNJIqDN3/zlr3fpxfZt//jA1 Ew== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2130.oracle.com with ESMTP id 2xykbp2tnd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 05 Feb 2020 13:00:32 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 015CxHef051819;
 Wed, 5 Feb 2020 13:00:32 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3030.oracle.com with ESMTP id 2xymusph77-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 05 Feb 2020 13:00:32 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 015D0U01026582;
 Wed, 5 Feb 2020 13:00:31 GMT
Received: from starbug-mbp.localdomain (/10.169.111.17)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 05 Feb 2020 05:00:30 -0800
Received: from starbug-mbp (localhost [127.0.0.1])
 by starbug-mbp.localdomain (Postfix) with SMTP id 2DA8957DAEF2;
 Wed,  5 Feb 2020 13:00:28 +0000 (GMT)
Date: Wed, 5 Feb 2020 13:00:27 +0000
From: Darren Kenny <darren.kenny@oracle.com>
To: "Bulekov, Alexander" <alxndr@bu.edu>
Subject: Re: [PATCH v8 12/21] exec: keep ram block across fork when using qtest
Message-ID: <20200205130027.3n3ieg35azi5iwre@starbug-mbp>
Mail-Followup-To: "Bulekov, Alexander" <alxndr@bu.edu>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "bsd@redhat.com" <bsd@redhat.com>,
 Richard Henderson <rth@twiddle.net>,
 "stefanha@redhat.com" <stefanha@redhat.com>
References: <20200129053357.27454-1-alxndr@bu.edu>
 <20200129053357.27454-13-alxndr@bu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20200129053357.27454-13-alxndr@bu.edu>
User-Agent: NeoMutt/20180716
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9521
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2002050105
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9521
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2002050105
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.86
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "bsd@redhat.com" <bsd@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jan 29, 2020 at 05:34:21AM +0000, Bulekov, Alexander wrote:
>Ram blocks were marked MADV_DONTFORK breaking fuzzing-tests which
>execute each test-input in a forked process.
>
>Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
>Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: Darren Kenny <darren.kenny@oracle.com>

>---
> exec.c | 12 ++++++++++--
> 1 file changed, 10 insertions(+), 2 deletions(-)
>
>diff --git a/exec.c b/exec.c
>index d4b769d0d4..99368f175b 100644
>--- a/exec.c
>+++ b/exec.c
>@@ -35,6 +35,7 @@
> #include "sysemu/kvm.h"
> #include "sysemu/sysemu.h"
> #include "sysemu/tcg.h"
>+#include "sysemu/qtest.h"
> #include "qemu/timer.h"
> #include "qemu/config-file.h"
> #include "qemu/error-report.h"
>@@ -2306,8 +2307,15 @@ static void ram_block_add(RAMBlock *new_block, Error **errp, bool shared)
>     if (new_block->host) {
>         qemu_ram_setup_dump(new_block->host, new_block->max_length);
>         qemu_madvise(new_block->host, new_block->max_length, QEMU_MADV_HUGEPAGE);
>-        /* MADV_DONTFORK is also needed by KVM in absence of synchronous MMU */
>-        qemu_madvise(new_block->host, new_block->max_length, QEMU_MADV_DONTFORK);
>+        /*
>+         * MADV_DONTFORK is also needed by KVM in absence of synchronous MMU
>+         * Configure it unless the machine is a qtest server, in which case
>+         * KVM is not used and it may be forked (eg for fuzzing purposes).
>+         */
>+        if (!qtest_enabled()) {
>+            qemu_madvise(new_block->host, new_block->max_length,
>+                         QEMU_MADV_DONTFORK);
>+        }
>         ram_block_notify_add(new_block->host, new_block->max_length);
>     }
> }
>-- 
>2.23.0
>
>

