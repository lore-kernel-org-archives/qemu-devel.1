Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF43EC10F13
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 13:21:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7BE92077C
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 13:21:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="W+QZ7w4s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7BE92077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36689 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGO1i-0006Th-JT
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 09:21:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1hGNgY-00062l-FZ
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:59:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1hGNgX-000226-If
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:59:38 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:37950)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liran.alon@oracle.com>)
	id 1hGNgX-000213-8w
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:59:37 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
	by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x3GCxQxR055570; Tue, 16 Apr 2019 12:59:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
	h=from : to : cc :
	subject : date : message-id : mime-version : content-transfer-encoding; 
	s=corp-2018-07-02; bh=nZ3TR4ekQ+AmfrbsJuvzmUCXFKLtV22K9QLAaZEaIKg=;
	b=W+QZ7w4s2AFZAJDZKyfvGZN0G5baY54NEwqnhGDXIBxOybpT1gZ0g8RJRkx9FTg3jvIu
	jf5ASCqkiBRB3/1u0vktv+07L3kYFL3tuTTxMSiI4b6AdgpsIIi/I1HDeoRWaKngifQO
	0ayLc/vDnlClzedwHBeVqey1uE6s1T9qtxKueXsKRyMRSPwBlkgnMVmos7aiF8uP+Eqi
	fDpcVTdnKan8ywnUYFyu7JLXbkXdbDEL19XzkzNjCE0tEbzaHw6QRUucxG/ikQ5HYAtL
	hKhqlC7Jz/SkFUbZXxEgWuwh3ugM6qGXtNlzF5/k5YBK0uJkHP16pvKOJEgEhYQfeiu+
	SA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
	by userp2120.oracle.com with ESMTP id 2rusnetf6x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Apr 2019 12:59:33 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
	by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x3GCw9E4024575; Tue, 16 Apr 2019 12:59:32 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
	by aserp3020.oracle.com with ESMTP id 2rv2tur99g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Apr 2019 12:59:32 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
	by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x3GCxVoS027853;
	Tue, 16 Apr 2019 12:59:31 GMT
Received: from spark.ravello.local (/213.57.127.2)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Tue, 16 Apr 2019 05:59:31 -0700
From: Liran Alon <liran.alon@oracle.com>
To: qemu-devel@nongnu.org
Date: Tue, 16 Apr 2019 15:59:09 +0300
Message-Id: <20190416125912.44001-1-liran.alon@oracle.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9228
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
	malwarescore=0
	phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=355
	adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
	engine=8.0.1-1810050000 definitions=main-1904160088
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9228
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
	priorityscore=1501 malwarescore=0
	suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
	lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=395
	adultscore=0
	classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
	definitions=main-1904160088
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.85
Subject: [Qemu-devel] [PATCH v2 0/3] vhost-scsi: Support migration
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: ehabkost@redhat.com, stefanha@gmail.com, mtosatti@redhat.com,
	bijan.mottahedeh@oracle.com, pbonzini@redhat.com,
	nir.weiner@oracle.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190416125909.WAmSekoVv0i-E8lBiSm5sv5CzrDzKPuBAhhHF_jG4l8@z>

Hi,

This patch series aims to add supprot to migrate a VM with a vhost-scsi device.

The 1st patch fixes a bug of mistakenly not stopping vhost-scsi backend when a
VM is stopped (As happens on migratino pre-copy completion).

The 2nd patch adds ability to save/load vhost-scsi device state in VMState.

The 3rd and final paqtch adds a flag to vhost-scsi which allows admin to specify
it's setup supports vhost-scsi migratino. For more detailed information on why
this is valid, see commit message of specific patch.

Regards,
-Liran


