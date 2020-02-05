Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F65C35254
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 13:59:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E63522082E
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 13:59:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="m+HlqgtS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E63522082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izLCm-0001GD-4T
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 08:59:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57889)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <darren.kenny@oracle.com>) id 1izLC2-0000KP-3j
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 08:58:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <darren.kenny@oracle.com>) id 1izLC1-0004RL-4Q
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 08:58:14 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:59522)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <darren.kenny@oracle.com>)
 id 1izLC0-0004Q0-S8
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 08:58:13 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 015Dm7cV113993;
 Wed, 5 Feb 2020 13:58:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=b4Gxom9NNENRpWt086fw3zrZNjH1cBO2Oqub6FIRNuM=;
 b=m+HlqgtSugSSj8IxHY+V15cz1YswsQOPcirGQTq8QSGfLC4UENaRKeyR++hDUc1FiPuy
 1bMQ5dugG6KQstUA/6nTfFhrQrwqy9K6bRCyv0251GkRBtScHzcG7RTC4XE/axM/BRs9
 ToqOMjaxbi3oHbLTVcDH8XwRnVQAfr4S/XnsOSYkyQJNHFATRAnMMwt7/0yHPyc0JJ9I
 H3IHGTyAw8liejAxs7zoQ51lXRxWOUM35nCktARYLdUVvis4W6Kh5lKltF1NtDlP3+Yu
 alPKQhqP2YopaYSAb/b+gEdJVllBL3+iN4sMm/JxCuZRxjZE85J3yEoezqkPBTIlI2yA hA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2120.oracle.com with ESMTP id 2xykbpb4gh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 05 Feb 2020 13:58:11 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 015DiO0X018006;
 Wed, 5 Feb 2020 13:58:10 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3030.oracle.com with ESMTP id 2xykbrwupk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 05 Feb 2020 13:58:10 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 015Dw9pN014554;
 Wed, 5 Feb 2020 13:58:09 GMT
Received: from starbug-mbp.localdomain (/10.169.111.17)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 05 Feb 2020 05:58:08 -0800
Received: from starbug-mbp (localhost [127.0.0.1])
 by starbug-mbp.localdomain (Postfix) with SMTP id 73C2757DC58E;
 Wed,  5 Feb 2020 13:58:06 +0000 (GMT)
Date: Wed, 5 Feb 2020 13:58:06 +0000
From: Darren Kenny <darren.kenny@oracle.com>
To: "Bulekov, Alexander" <alxndr@bu.edu>
Subject: Re: [PATCH v8 13/21] main: keep rcu_atfork callback enabled for qtest
Message-ID: <20200205135806.6jfluyyoejyknlyx@starbug-mbp>
Mail-Followup-To: "Bulekov, Alexander" <alxndr@bu.edu>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "bsd@redhat.com" <bsd@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
References: <20200129053357.27454-1-alxndr@bu.edu>
 <20200129053357.27454-14-alxndr@bu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20200129053357.27454-14-alxndr@bu.edu>
User-Agent: NeoMutt/20180716
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9521
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2002050110
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9521
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2002050110
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.85
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
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jan 29, 2020 at 05:34:22AM +0000, Bulekov, Alexander wrote:
>The qtest-based fuzzer makes use of forking to reset-state between
>tests. Keep the callback enabled, so the call_rcu thread gets created
>within the child process.
>
>Signed-off-by: Alexander Bulekov <alxndr@bu.edu>

Reviewed-by: Darren Kenny <darren.kenny@oracle.com>

>---
> vl.c | 9 ++++++++-
> 1 file changed, 8 insertions(+), 1 deletion(-)
>
>diff --git a/vl.c b/vl.c
>index bb77935f04..cf8e2d3ebb 100644
>--- a/vl.c
>+++ b/vl.c
>@@ -3794,7 +3794,14 @@ void qemu_init(int argc, char **argv, char **envp)
>     set_memory_options(&ram_slots, &maxram_size, machine_class);
>
>     os_daemonize();
>-    rcu_disable_atfork();
>+
>+    /*
>+     * If QTest is enabled, keep the rcu_atfork enabled, since system processes
>+     * may be forked testing purposes (e.g. fork-server based fuzzing)
>+     */
>+    if (!qtest_enabled()) {
>+        rcu_disable_atfork();
>+    }
>
>     if (pid_file && !qemu_write_pidfile(pid_file, &err)) {
>         error_reportf_err(err, "cannot create PID file: ");
>-- 
>2.23.0
>
>

