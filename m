Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2678FC5DF66
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 17:42:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E64A02178F
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 17:42:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JBN4rOaA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E64A02178F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSPJo-0006tY-1k
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 12:42:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48403)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <darren.kenny@oracle.com>) id 1iSPIi-0006FV-KB
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 12:41:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <darren.kenny@oracle.com>) id 1iSPIh-00039h-7P
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 12:41:00 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:60220)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <darren.kenny@oracle.com>)
 id 1iSPIg-00033T-Uc
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 12:40:59 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA6HcprX001766;
 Wed, 6 Nov 2019 17:40:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=BrXsEQx7fh/aEVHg6ZIGwvr6jQBByxOT4Ql3SjJekPM=;
 b=JBN4rOaAT0YMSk0L8r9tr/SL41Y1n0iIL+yKovjsWfoUnv3uZNIfHTEfpZHVHDVyqVAz
 wtvld3gzBj1mB+whCW796GJ+fYzCcJp3ykfwHHucfP7FZBV0MxG6VI9m7RIFpdT5gDxB
 vy/nzDyIMGP5zncW84p+zd6UNSoyV2eBiCQZc1mgso0K7aqN/1vT+MVjxmwxfPfvB7Ky
 HtKfWrdSSF4FvjUszpxQ/+jrRRdhJ50a2ayCxIF8K/Np/otStYelv6h/3lJN32tdlR/M
 5GIBhxhLDhtfcbf1dZJFTBGGSncnNJnsigzVftKPjlYeIeI8/MvOSX+Hn0AUR94Ycp7x xQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2130.oracle.com with ESMTP id 2w41w10g4s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 06 Nov 2019 17:40:55 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA6HdDo3102072;
 Wed, 6 Nov 2019 17:40:55 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3020.oracle.com with ESMTP id 2w41wf3c24-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 06 Nov 2019 17:40:55 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xA6Her55000809;
 Wed, 6 Nov 2019 17:40:54 GMT
Received: from starbug-mbp.localdomain (/10.175.168.158)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 06 Nov 2019 17:40:53 +0000
Received: from starbug-mbp (localhost [127.0.0.1])
 by starbug-mbp.localdomain (Postfix) with SMTP id 5B8C04B151DA;
 Wed,  6 Nov 2019 17:40:51 +0000 (GMT)
Date: Wed, 6 Nov 2019 17:40:51 +0000
From: Darren Kenny <darren.kenny@oracle.com>
To: "Oleinik, Alexander" <alxndr@bu.edu>
Subject: Re: [PATCH v4 06/20] module: check module wasn't already initialized
Message-ID: <20191106174051.eotyqpytxistgkns@starbug-mbp>
Mail-Followup-To: "Oleinik, Alexander" <alxndr@bu.edu>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20191030144926.11873-1-alxndr@bu.edu>
 <20191030144926.11873-7-alxndr@bu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20191030144926.11873-7-alxndr@bu.edu>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9433
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1910280000 definitions=main-1911060171
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9433
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1910280000
 definitions=main-1911060171
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Oct 30, 2019 at 02:49:52PM +0000, Oleinik, Alexander wrote:
>From: Alexander Oleinik <alxndr@bu.edu>
>
>The virtual-device fuzzer must initialize QOM, prior to running
>vl:qemu_init, so that it can use the qos_graph to identify the arguments
>required to initialize a guest for libqos-assisted fuzzing. This change
>prevents errors when vl:qemu_init tries to (re)initialize the previously
>initialized QOM module.
>
>Signed-off-by: Alexander Oleinik <alxndr@bu.edu>

My only question here really is whether there is any possibility of
the list of any given module type being modified later, if so this
might break things if attempts are made to re-init modules.

In that case, this test might be more correctly belong in the
module's own init() function instead.

Assuming for now that it is the correct place to do it, unless
someone can say otherwise:

Reviewed-by: Darren Kenny <darren.kenny@oracle.com>

>---
> util/module.c | 7 +++++++
> 1 file changed, 7 insertions(+)
>
>diff --git a/util/module.c b/util/module.c
>index e9fe3e5422..841e490e06 100644
>--- a/util/module.c
>+++ b/util/module.c
>@@ -30,6 +30,7 @@ typedef struct ModuleEntry
> typedef QTAILQ_HEAD(, ModuleEntry) ModuleTypeList;
>
> static ModuleTypeList init_type_list[MODULE_INIT_MAX];
>+static bool modules_init_done[MODULE_INIT_MAX];
>
> static ModuleTypeList dso_init_list;
>
>@@ -91,11 +92,17 @@ void module_call_init(module_init_type type)
>     ModuleTypeList *l;
>     ModuleEntry *e;
>
>+    if (modules_init_done[type]) {
>+        return;
>+    }
>+
>     l = find_type(type);
>
>     QTAILQ_FOREACH(e, l, node) {
>         e->init();
>     }
>+
>+    modules_init_done[type] = true;
> }
>
> #ifdef CONFIG_MODULES
>-- 
>2.23.0
>
>

