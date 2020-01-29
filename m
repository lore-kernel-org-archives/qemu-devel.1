Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44163C33CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 11:37:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C09D20CC7
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 11:37:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="E5PW53bS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C09D20CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwlee-000737-AI
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 06:37:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39877)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <darren.kenny@oracle.com>) id 1iwldw-0006Sm-6i
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 06:36:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <darren.kenny@oracle.com>) id 1iwldv-0000jT-4d
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 06:36:24 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:37144)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <darren.kenny@oracle.com>)
 id 1iwlds-0000Z8-7r; Wed, 29 Jan 2020 06:36:20 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00TBX7Wc148796;
 Wed, 29 Jan 2020 11:36:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=jgP2MBoawxu0v45uQoG0HdcSNOOBAku0cKZKrwZwBio=;
 b=E5PW53bSCG3a02+E2OEEYYwo4yjSfBXwcCvlNN6pRXdyWsU7xVRsdS5akdBcd3LVoBEA
 urSSFV0lVoSCDrN6nsgwk8vyqzL6qHFX1EPiRbbwlJW4qB4+x0LNnJoNxVxKzlgWBG2a
 o1MIR5FR4QT39lEb89E5u1VbzK5OtR1WS0LmrRCz1kebrcM0Qf5IKAGU/qzBnLdVotuL
 JnWd818WJcU4PSFnHuHmVP/Ep9zk8tZjpzkQnncGgeSnHy/LIzfm6BqKRz5pPF7/NDlG
 ohDjI2ql+lAp1ExzIhBJyO9jcOImWHQIMoBiae2ZcEJau6USabb9ZWlcIEae4QI+RYa+ Lw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2120.oracle.com with ESMTP id 2xrearcf63-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Jan 2020 11:36:11 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00TBXlsq142379;
 Wed, 29 Jan 2020 11:36:10 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3030.oracle.com with ESMTP id 2xtg7x48d2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Jan 2020 11:36:02 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 00TBZxAU029756;
 Wed, 29 Jan 2020 11:35:59 GMT
Received: from starbug-mbp.localdomain (/10.175.199.231)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 29 Jan 2020 03:35:59 -0800
Received: from starbug-mbp (localhost [127.0.0.1])
 by starbug-mbp.localdomain (Postfix) with SMTP id C092657075D8;
 Wed, 29 Jan 2020 11:35:56 +0000 (GMT)
Date: Wed, 29 Jan 2020 11:35:56 +0000
From: Darren Kenny <darren.kenny@oracle.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] hw/i386/vmmouse: Fix crash when using the vmmouse on a
 machine without vmport
Message-ID: <20200129113556.z3wzi6a25w4ffxk6@starbug-mbp>
Mail-Followup-To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 "Michael S . Tsirkin " <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
References: <20200129112954.4282-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20200129112954.4282-1-thuth@redhat.com>
User-Agent: NeoMutt/20180716
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9514
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001290097
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9514
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001290097
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S . Tsirkin " <mst@redhat.com>, qemu-trivial@nongnu.org,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jan 29, 2020 at 12:29:54PM +0100, Thomas Huth wrote:
>QEMU currently crashes when the user tries to use the "vmmouse" on a
>machine without vmport, e.g.:
>
> $ x86_64-softmmu/qemu-system-x86_64 -machine microvm -device vmmouse
> Segmentation fault (core dumped)
>
>or:
>
> $ x86_64-softmmu/qemu-system-x86_64 -device vmmouse -M pc,vmport=off
> Segmentation fault (core dumped)
>
>Let's avoid the crash by checking for the vmport device first.
>
>Signed-off-by: Thomas Huth <thuth@redhat.com>

Makes sense.

Reviewed-by: Darren Kenny <darren.kenny@oracle.com>

Thanks,

Darren

>---
> hw/i386/vmmouse.c | 6 ++++++
> 1 file changed, 6 insertions(+)
>
>diff --git a/hw/i386/vmmouse.c b/hw/i386/vmmouse.c
>index 7c2a375527..e8e62bd96b 100644
>--- a/hw/i386/vmmouse.c
>+++ b/hw/i386/vmmouse.c
>@@ -23,6 +23,7 @@
>  */
>
> #include "qemu/osdep.h"
>+#include "qapi/error.h"
> #include "ui/console.h"
> #include "hw/i386/pc.h"
> #include "hw/input/i8042.h"
>@@ -269,6 +270,11 @@ static void vmmouse_realizefn(DeviceState *dev, Error **errp)
>
>     DPRINTF("vmmouse_init\n");
>
>+    if (!object_resolve_path_type("", TYPE_VMPORT, NULL)) {
>+        error_setg(errp, "vmmouse needs a machine with vmport");
>+        return;
>+    }
>+
>     vmport_register(VMMOUSE_STATUS, vmmouse_ioport_read, s);
>     vmport_register(VMMOUSE_COMMAND, vmmouse_ioport_read, s);
>     vmport_register(VMMOUSE_DATA, vmmouse_ioport_read, s);
>-- 
>2.18.1
>
>

