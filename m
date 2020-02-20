Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF7BBC11D04
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 10:34:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A29A24672
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 10:34:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GnkSytzG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A29A24672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4jAC-000696-Qj
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 05:34:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33626)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <darren.kenny@oracle.com>) id 1j4j9P-0005hN-EC
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 05:33:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <darren.kenny@oracle.com>) id 1j4j9O-00017V-0w
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 05:33:47 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:48032)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <darren.kenny@oracle.com>)
 id 1j4j9N-00017M-Pc
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 05:33:45 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01KAW7nr028179;
 Thu, 20 Feb 2020 10:33:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=ehuA1Qd1I/7lJjHMs8aC9lyLaJj+jB3lVriQbdnonao=;
 b=GnkSytzGvLP3NpzLvhwWRux9BGfILHC6fMShzGI+63NnZiRxHMVBjFKN3Stdlh084yV8
 DjfupwYhPSn9jN0uC08Yliv1iVeZzOgEX/QsBurEyugFF/+oDXkBAGSw7rJEDnZIFP3Y
 KMX8O9twb0DOqyvvQi+xVDITgRqGwo3vUshgm321DaCUCVF9p9zL9bAoS3LPhpqDNq0+
 LE1SsukafBoR2ZoCeky5rszFFRkSt51uUZgjV3lZdtyHO90IOrNE3RxZ8m1ZcGdESFs/
 wSysgobl3X/pvYzmDtTwhpvGHCyVUp/USrYmH7tVYPXsTbZK+S8zpjTwKNWBe+U5xjdu Aw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by aserp2120.oracle.com with ESMTP id 2y8udkgvme-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 20 Feb 2020 10:33:42 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01KAS3r5193726;
 Thu, 20 Feb 2020 10:33:41 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3030.oracle.com with ESMTP id 2y8ud5n7ka-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 20 Feb 2020 10:33:41 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01KAXe38016134;
 Thu, 20 Feb 2020 10:33:40 GMT
Received: from starbug-mbp.localdomain (/10.169.111.17)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 20 Feb 2020 02:33:40 -0800
Received: from starbug-mbp (localhost [127.0.0.1])
 by starbug-mbp.localdomain (Postfix) with SMTP id DB97959EAFC2;
 Thu, 20 Feb 2020 10:33:37 +0000 (GMT)
Date: Thu, 20 Feb 2020 10:33:37 +0000
From: Darren Kenny <darren.kenny@oracle.com>
To: Alexander Bulekov <alxndr@bu.edu>
Subject: Re: [PATCH v10 01/22] softmmu: move vl.c to softmmu/
Message-ID: <20200220103337.q54ifn43rja6oj5i@starbug-mbp>
Mail-Followup-To: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org,
 bsd@redhat.com, pbonzini@redhat.com, stefanha@redhat.com
References: <20200220041118.23264-1-alxndr@bu.edu>
 <20200220041118.23264-2-alxndr@bu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20200220041118.23264-2-alxndr@bu.edu>
User-Agent: NeoMutt/20180716
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9536
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxlogscore=999 mlxscore=0
 adultscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002200076
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9536
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 adultscore=0 mlxscore=0 clxscore=1015
 malwarescore=0 mlxlogscore=999 phishscore=0 impostorscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002200076
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 141.146.126.78
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
Cc: pbonzini@redhat.com, bsd@redhat.com, qemu-devel@nongnu.org,
 stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Feb 19, 2020 at 11:10:57PM -0500, Alexander Bulekov wrote:
>Move vl.c to a separate directory, similar to linux-user/
>Update the chechpatch and get_maintainer scripts, since they relied on
>/vl.c for top_of_tree checks.
>
>Signed-off-by: Alexander Bulekov <alxndr@bu.edu>

Reviewed-by: Darren Kenny <darren.kenny@oracle.com>

>---
> MAINTAINERS               | 2 +-
> Makefile.objs             | 2 --
> Makefile.target           | 1 +
> scripts/checkpatch.pl     | 2 +-
> scripts/get_maintainer.pl | 3 ++-
> softmmu/Makefile.objs     | 2 ++
> vl.c => softmmu/vl.c      | 0
> 7 files changed, 7 insertions(+), 5 deletions(-)
> create mode 100644 softmmu/Makefile.objs
> rename vl.c => softmmu/vl.c (100%)
>
>diff --git a/MAINTAINERS b/MAINTAINERS
>index c7717df720..98cbeaab97 100644
>--- a/MAINTAINERS
>+++ b/MAINTAINERS
>@@ -2023,7 +2023,7 @@ F: include/qemu/main-loop.h
> F: include/sysemu/runstate.h
> F: util/main-loop.c
> F: util/qemu-timer.c
>-F: vl.c
>+F: softmmu/vl.c
> F: qapi/run-state.json
>
> Human Monitor (HMP)
>diff --git a/Makefile.objs b/Makefile.objs
>index 26b9cff954..8a1cbe8000 100644
>--- a/Makefile.objs
>+++ b/Makefile.objs
>@@ -58,8 +58,6 @@ common-obj-y += ui/
> common-obj-m += ui/
>
> common-obj-y += dma-helpers.o
>-common-obj-y += vl.o
>-vl.o-cflags := $(GPROF_CFLAGS) $(SDL_CFLAGS)
> common-obj-$(CONFIG_TPM) += tpm.o
>
> common-obj-y += backends/
>diff --git a/Makefile.target b/Makefile.target
>index 6e61f607b1..06c36d1161 100644
>--- a/Makefile.target
>+++ b/Makefile.target
>@@ -160,6 +160,7 @@ obj-y += qapi/
> obj-y += memory.o
> obj-y += memory_mapping.o
> obj-y += migration/ram.o
>+obj-y += softmmu/
> LIBS := $(libs_softmmu) $(LIBS)
>
> # Hardware support
>diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
>index ce43a306f8..c85ad11de1 100755
>--- a/scripts/checkpatch.pl
>+++ b/scripts/checkpatch.pl
>@@ -462,7 +462,7 @@ sub top_of_kernel_tree {
> 	my @tree_check = (
> 		"COPYING", "MAINTAINERS", "Makefile",
> 		"README.rst", "docs", "VERSION",
>-		"vl.c"
>+		"linux-user", "softmmu"
> 	);
>
> 	foreach my $check (@tree_check) {
>diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
>index 27991eb1cf..271f5ff42a 100755
>--- a/scripts/get_maintainer.pl
>+++ b/scripts/get_maintainer.pl
>@@ -795,7 +795,8 @@ sub top_of_tree {
>         && (-f "${lk_path}Makefile")
>         && (-d "${lk_path}docs")
>         && (-f "${lk_path}VERSION")
>-        && (-f "${lk_path}vl.c")) {
>+        && (-d "${lk_path}linux-user/")
>+        && (-d "${lk_path}softmmu/")) {
> 	return 1;
>     }
>     return 0;
>diff --git a/softmmu/Makefile.objs b/softmmu/Makefile.objs
>new file mode 100644
>index 0000000000..d80a5ffe5a
>--- /dev/null
>+++ b/softmmu/Makefile.objs
>@@ -0,0 +1,2 @@
>+obj-y += vl.o
>+vl.o-cflags := $(GPROF_CFLAGS) $(SDL_CFLAGS)
>diff --git a/vl.c b/softmmu/vl.c
>similarity index 100%
>rename from vl.c
>rename to softmmu/vl.c
>-- 
>2.25.0
>

