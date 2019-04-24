Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE56C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 07:57:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9040720693
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 07:57:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SNdgOWEQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9040720693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37529 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJCmE-0007Ee-Ce
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 03:57:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shmuel.eiderman@oracle.com>) id 1hJChc-0003k9-9v
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 03:52:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shmuel.eiderman@oracle.com>) id 1hJCek-00081k-UB
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 03:49:27 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:59106)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <shmuel.eiderman@oracle.com>)
	id 1hJCej-0007tt-Om; Wed, 24 Apr 2019 03:49:25 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
	by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x3O7n8MS137072; Wed, 24 Apr 2019 07:49:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
	h=from : to : cc :
	subject : date : message-id; s=corp-2018-07-02;
	bh=4rDjmkHTtaJHc8ncDaZly5LiQ0cjqYlrwdEebvSKfZs=;
	b=SNdgOWEQtNub/r54f2SQhqeGsWc2sJYPOkGNG3y1I8AX9uTl0dT9Buo2jl+kTirVRGUZ
	xG/fjyHtQRdWECxTtUmN9PP0pSGKXedADvYpfoRAUpEjQ4ueoZ3gpp8NwZYpiiI7LOIY
	fcQ4NtS/AM3i6sMIZpIXAkrLtSBjIreCFPREyIxBzqeD7xoQcarVPjGI4v1KunXWTV8c
	xyc9Uy1aRZKm+Y7XUwL723xJYp/oDdu+YW2apLIOSw50NIDD3IirIK5vJIHucNhXxocM
	OOZCS+hygRVtJwtPs9a9llaN1DQSTCxBhKdNB2dGZ2he0Q41I00XoFnYfF+RgL3N72bQ
	Fw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
	by userp2120.oracle.com with ESMTP id 2ryv2q8j19-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Apr 2019 07:49:14 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
	by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x3O7mPi9060342; Wed, 24 Apr 2019 07:49:13 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
	by aserp3030.oracle.com with ESMTP id 2s0f0vxfjg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Apr 2019 07:49:13 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
	by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x3O7nBKP030507;
	Wed, 24 Apr 2019 07:49:11 GMT
Received: from nexus.ravello.local (/213.57.127.2)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Wed, 24 Apr 2019 00:49:11 -0700
From: Sam Eiderman <shmuel.eiderman@oracle.com>
To: fam@euphon.net, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org
Date: Wed, 24 Apr 2019 10:48:59 +0300
Message-Id: <20190424074901.31430-1-shmuel.eiderman@oracle.com>
X-Mailer: git-send-email 2.13.3
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9236
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
	malwarescore=0
	phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=845
	adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
	engine=8.0.1-1810050000 definitions=main-1904240068
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9236
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
	priorityscore=1501 malwarescore=0
	suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
	lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=879
	adultscore=0
	classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
	definitions=main-1904240068
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.85
Subject: [Qemu-devel] [PATCH 0/2]: vmdk: Add read-only support for the new
 seSparse format
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
Cc: eyal.moscovici@oracle.com, arbel.moshe@oracle.com, qemu-devel@nongnu.org,
	shmuel.eiderman@oracle.com, liran.alon@oracle.com, karl.heubaum@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190424074859.qG3IdSxfPSpPEv7tA_EEpU_J-LpGfFdt62J_hDt_4wc@z>

VMware introduced a new snapshot format in VMFS6 - seSparse (Space
Efficient Sparse) which is the default format available in ESXi 6.7.
Add read-only support for the new snapshot format.


