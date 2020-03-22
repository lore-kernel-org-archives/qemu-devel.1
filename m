Return-Path: <SRS0=K/vF=5H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE02C4332B
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2020 14:46:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0669420663
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2020 14:46:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fKOIoRIY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0669420663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jG1rz-0005Rk-2d
	for qemu-devel@archiver.kernel.org; Sun, 22 Mar 2020 10:46:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54467)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eyal.moscovici@oracle.com>) id 1jFwdt-0005oP-MD
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 05:11:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eyal.moscovici@oracle.com>) id 1jFwds-00014T-MS
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 05:11:37 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:33562)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eyal.moscovici@oracle.com>)
 id 1jFwdp-00012j-Ae; Sun, 22 Mar 2020 05:11:33 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02M99FK9095076;
 Sun, 22 Mar 2020 09:11:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=jl8vBWLguLNvo/+Y2quk6XVo7/0tsS1TD8lnUmQaOg4=;
 b=fKOIoRIYK1siFMj8tULfurgcTIOuW16YG/ktzaMYfz5l7afgBn0SzCHthe7fyjQPSgW1
 oZHzxegl5AGDfkgNcw2VbzDpUpepkcU3q11SYubewhhFyW5ScuQX7d6JqVbX9VHd4fiD
 BQrXeZ+YRZpUQOcXodbPV7iJgN60k3DupGDw/O+IkaC6NXtEXTSDlO0MN9hv6cuOKO3G
 i8MFBxPZ5083b2RHR8sDdxt3hmacVi+MCEj+r33IXEJoxf6G6NYNEdZGlZI5gH0ehY+9
 iQ6KX3bwCjZPNtCu853IUhFo7JdcTx9b5+GoMbEGhl9RLtFTJmMEreXC91AadKHrQmoy 5w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2130.oracle.com with ESMTP id 2ywabqtq57-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 22 Mar 2020 09:11:30 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02M92kVr158278;
 Sun, 22 Mar 2020 09:11:30 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3030.oracle.com with ESMTP id 2ywvd9xnch-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 22 Mar 2020 09:11:30 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02M9BS5I003689;
 Sun, 22 Mar 2020 09:11:28 GMT
Received: from localhost.localdomain (/10.74.126.182)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Sun, 22 Mar 2020 02:11:27 -0700
From: Eyal Moscovici <eyal.moscovici@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] Additional parameters for qemu_img map
Date: Sun, 22 Mar 2020 11:11:15 +0200
Message-Id: <20200322091117.79443-1-eyal.moscovici@oracle.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9567
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=689
 bulkscore=0 spamscore=0
 suspectscore=1 mlxscore=0 phishscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003220053
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9567
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=1
 lowpriorityscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 clxscore=1011 adultscore=0 mlxscore=0 mlxlogscore=751 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003220053
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.86
X-Mailman-Approved-At: Sun, 22 Mar 2020 10:44:45 -0400
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
Cc: Kevin Wolf <kwolf@redhat.com>, liran.alon@oracle.com,
 Eyal Moscovici <eyal.moscovici@oracle.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

The following series adds two parameters to qemu-img map:
1. start-offset: mapping starting offset.
2. max-length: the length of the mapping.

These parameters proved useful when mapping large disk spread across
long store file chains. It allows us to bound the execution time of each
qemu-img map execution as well as recover from failed mapping
operations. In addition the map operation can divided to
multiple independent tasks.

Eyal Moscovici (2):
  qemu-img: refactor dump_map_entry JSON format output
  qemu-img: Add --start-offset and --max-length to map

 docs/tools/qemu-img.rst |  2 +-
 qemu-img-cmds.hx        |  4 ++--
 qemu-img.c              | 42 ++++++++++++++++++++++++++++++++++++-----
 3 files changed, 40 insertions(+), 8 deletions(-)

-- 
2.17.2 (Apple Git-113)


