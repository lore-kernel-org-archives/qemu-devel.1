Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C8BC28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 19:17:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F4DD2075C
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 19:17:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QrhoHKVt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F4DD2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48635 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYbPQ-0002ES-5o
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 15:17:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53316)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lidong.chen@oracle.com>) id 1hYbNv-0001TC-RV
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 15:15:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lidong.chen@oracle.com>) id 1hYbNs-0004KK-LN
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 15:15:41 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:58890)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lidong.chen@oracle.com>)
	id 1hYbNs-0004IQ-C4
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 15:15:40 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
	by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x55JEU0i031608; Wed, 5 Jun 2019 19:15:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
	h=from : to : cc :
	subject : date : message-id : mime-version : content-type :
	content-transfer-encoding; s=corp-2018-07-02;
	bh=M1v7ynO0rrOyZZPx2CeWEpCeFBpAO/mgdCmDzdwpFzs=;
	b=QrhoHKVtRqTH/m6lJQM04sOw3RssIIi8lqNK0PKcP2eNb9NI7jGqWvLIW+psYP/INj0k
	hknHT7tDb0m5Wv6d+9xxZRC8HiEoiYSolg+s5nmfjDijqeGSGXiBdLclHGwz+EMma0J5
	mNrQnUeYtyg1AJcyAU7X2edCH7MMypDyoCPkp7EdDad91YI0Yw3b2C2xgd69pA9ge+ek
	Kl7iaOOIZQkQl+Qx3ayUNVCVP22x5WtwS5nEkQsAnWO8vZp4PW8TiSd1kUWGUsm9A3gU
	5RADiohiyT35QNecfAIv0whroRU0IBgqrp+UlOyOwC0gsWbXRuNI0lBxFZ2/0C5nfquM
	IQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
	by userp2130.oracle.com with ESMTP id 2sugstmksx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Jun 2019 19:15:34 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
	by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x55JEXq2005767; Wed, 5 Jun 2019 19:15:34 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
	by userp3020.oracle.com with ESMTP id 2swnhac6as-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Jun 2019 19:15:34 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
	by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x55JFWPB017420;
	Wed, 5 Jun 2019 19:15:32 GMT
Received: from ca-virt2-2.us.oracle.com (/10.211.11.112)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Wed, 05 Jun 2019 12:15:31 -0700
From: Lidong Chen <lidong.chen@oracle.com>
To: qemu-devel@nongnu.org
Date: Wed,  5 Jun 2019 15:15:19 -0400
Message-Id: <cover.1559761541.git.lidong.chen@oracle.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9279
	signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
	malwarescore=0
	phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=655
	adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
	engine=8.0.1-1810050000 definitions=main-1906050120
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9279
	signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
	priorityscore=1501 malwarescore=0
	suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
	lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=708
	adultscore=0
	classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
	definitions=main-1906050120
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.86
Subject: [Qemu-devel] [Qemu-devel PATCH v2 0/2] Fix incorrect assertions in
 sd and main-loop
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
Cc: peter.maydell@linaro.org, berrange@redhat.com, liran.alon@oracle.com,
	liq3ea@gmail.com, armbru@redhat.com, lidong.chen@oracle.com,
	darren.kenny@oracle.com, marcandre.lureau@gmail.com,
	amarkovic@wavecomp.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

v1: Patch1 fixed out-of-bounds assertions in hw/sd/sd.c

v2: Added patch2 that fixed the incorrect assertion for poll_fds
    in util/main-loop.c based on the feedbacks from Peter Maydell
    and Liam Merwick,

Lidong Chen (2):
  sd: Fix out-of-bounds assertions
  util/main-loop: Fix incorrect assertion

 hw/sd/sd.c       | 4 ++--
 util/main-loop.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
1.8.3.1


