Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46AC4C432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 13:51:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F6272075E
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 13:51:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WyGNbYxk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F6272075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVFX7-0004wL-4n
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 08:51:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38140)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <darren.kenny@oracle.com>) id 1iVFWI-0004AE-D2
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 08:50:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <darren.kenny@oracle.com>) id 1iVFWG-0000AI-Vn
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 08:50:45 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:39134)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <darren.kenny@oracle.com>)
 id 1iVFWG-000066-Ef
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 08:50:44 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAEDnOEP019649;
 Thu, 14 Nov 2019 13:50:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=TQBH6Z+K0aZZOrurj3b4BzXXQI/cM4CmEbeC8vb1XlI=;
 b=WyGNbYxk1dkqqVCh7tWQSouqXiw2gNtoLMbpEkRFP5lAnjoQd2CAf/3gd0V2bXWL0UVf
 D/5dnWjnqWmvI4hveuxelCigqI4+cVeg/1aORD//OmALteNhNuO68B+BVsCf/4VNwu4G
 7dZm/8UIcq3zECgzX7z1PzQT2H0sHT+mMK3y8fZahqyTI3uThniPOxqsNhsPIjte3gkA
 +INKOp2/vworjaSY1/bN3RdR6BnVbKJcpLAXgD8KQjwdT38iKZ0JZdTkHnEjU4bHgvhc
 jxnmep+uOV3kijdZm+c0UrU/z0Xc+a6B7fP5cWCQsqrEC3hZUmvmRbQnWdGjvQnaSX2h TA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2120.oracle.com with ESMTP id 2w5p3r373k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Nov 2019 13:50:40 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAEDn7na196250;
 Thu, 14 Nov 2019 13:50:39 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3020.oracle.com with ESMTP id 2w8ng90694-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Nov 2019 13:50:39 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xAEDoc7r001625;
 Thu, 14 Nov 2019 13:50:38 GMT
Received: from starbug-mbp.localdomain (/10.175.200.230)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 14 Nov 2019 05:50:38 -0800
Received: from starbug-mbp (localhost [127.0.0.1])
 by starbug-mbp.localdomain (Postfix) with SMTP id C70064C11042;
 Thu, 14 Nov 2019 13:50:35 +0000 (GMT)
Date: Thu, 14 Nov 2019 13:50:35 +0000
From: Darren Kenny <darren.kenny@oracle.com>
To: Yury Kotov <yury-kotov@yandex-team.ru>
Subject: Re: [PATCH] migration: Fix the re-run check of the migrate-incoming
 command
Message-ID: <20191114135035.ofqwgap355p2fx4p@starbug-mbp>
Mail-Followup-To: Yury Kotov <yury-kotov@yandex-team.ru>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 yc-core@yandex-team.ru
References: <20191113175325.29765-1-yury-kotov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20191113175325.29765-1-yury-kotov@yandex-team.ru>
User-Agent: NeoMutt/20180716
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9440
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=18
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1910280000 definitions=main-1911140128
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9440
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=18 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1910280000
 definitions=main-1911140128
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
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 yc-core@yandex-team.ru, Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Nov 13, 2019 at 08:53:25PM +0300, Yury Kotov wrote:
>The current check sets an error but doesn't fail the command.
>This may cause a problem if new connection attempt by the same URI
>affects the first connection.
>
>Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>

Reviewed-by: Darren Kenny <darren.kenny@oracle.com>

>---
> migration/migration.c | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/migration/migration.c b/migration/migration.c
>index 354ad072fa..fa2005b49f 100644
>--- a/migration/migration.c
>+++ b/migration/migration.c
>@@ -1784,6 +1784,7 @@ void qmp_migrate_incoming(const char *uri, Error **errp)
>     }
>     if (!once) {
>         error_setg(errp, "The incoming migration has already been started");
>+        return;
>     }
>
>     qemu_start_incoming_migration(uri, &local_err);
>-- 
>2.24.0
>
>

