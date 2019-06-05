Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 259EBC282DE
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 06:24:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E39962083E
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 06:24:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EQN3ys0j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E39962083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36218 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYPLJ-0002MI-7j
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 02:24:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lidong.chen@oracle.com>) id 1hYPKW-000239-Q2
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 02:23:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lidong.chen@oracle.com>) id 1hYPKV-0001ep-WF
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 02:23:24 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:43821)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lidong.chen@oracle.com>)
	id 1hYPKV-0001cx-N7
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 02:23:23 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
	by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x556Iukr194189; Wed, 5 Jun 2019 06:23:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
	h=from : to : cc :
	subject : date : message-id : mime-version : content-type :
	content-transfer-encoding; s=corp-2018-07-02;
	bh=+PMsfItGVketrxIb+Jzsa6Y6gSXQaHicTKjm1XqgqLY=;
	b=EQN3ys0jgGsEBupNzq4taZ29/nLRjhb/ju2Y6yBypg0rTWwlPky1794b3/3r6NzAgIIt
	yKsedtJrFZapuK1n3lXn4h+BuH7Te4xYs1aYUT/OY1p5Dc5aLQhONwhMRz6CbxtcQ8Pe
	17IpviGrIHXWL63odIY9k3wvQMfSP8RYbsK2iej2H/ng1bbMev2MMpDgatpLL8Bk5wG4
	/6FqqVt7R/OPy8uqXhKJrimIuLIw4BEertYUWvOoUAOeUriVvMU8nTlnELUT7KxtIlK1
	zHw19NL8UelQjQBBAmvwVHQ4w23zw+oJ+oLF6xaOJ9uv2/xK3gya9yDRpsBU+hnfRuc6
	SQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
	by userp2120.oracle.com with ESMTP id 2suj0qgtwj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Jun 2019 06:23:20 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
	by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x556KVbm184955; Wed, 5 Jun 2019 06:21:20 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
	by userp3020.oracle.com with ESMTP id 2swnha08ux-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Jun 2019 06:21:20 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
	by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x556LIi5030974;
	Wed, 5 Jun 2019 06:21:19 GMT
Received: from ca-virt2-2.us.oracle.com (/10.211.11.112)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Tue, 04 Jun 2019 23:21:18 -0700
From: Lidong Chen <lidong.chen@oracle.com>
To: qemu-devel@nongnu.org
Date: Wed,  5 Jun 2019 02:21:04 -0400
Message-Id: <cover.1559710447.git.lidong.chen@oracle.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9278
	signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
	malwarescore=0
	phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=564
	adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
	engine=8.0.1-1810050000 definitions=main-1906050040
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9278
	signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
	priorityscore=1501 malwarescore=0
	suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
	lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=616
	adultscore=0
	classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
	definitions=main-1906050040
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.85
Subject: [Qemu-devel] [Qemu-devel PATCH v2 0/2] sd: Fix out-of-bounds
 assertions
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

The v2 changes include the fix for the incorrect assertion for poll_fds
in util/main-loop.c according to the review comments from the previous
sd fixes.

Lidong Chen (2):
  sd: Fix out-of-bounds assertions
  util/main-loop: Fix incorrect assertion

 hw/sd/sd.c       | 4 ++--
 util/main-loop.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
1.8.3.1


