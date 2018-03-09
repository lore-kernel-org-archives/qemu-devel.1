Received: from eggs.gnu.org ([2001:4830:134:3::10]:47623)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <farosas@linux.vnet.ibm.com>) id 1euMfD-0005U1-KJ
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 13:22:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <farosas@linux.vnet.ibm.com>) id 1euMf9-0001jH-JE
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 13:22:43 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36486
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <farosas@linux.vnet.ibm.com>)
	id 1euMf9-0001j9-E1
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 13:22:39 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w29IKJeh061885
	for <qemu-devel@nongnu.org>; Fri, 9 Mar 2018 13:22:39 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2gkuw89awn-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 09 Mar 2018 13:22:38 -0500
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <farosas@linux.vnet.ibm.com>;
	Fri, 9 Mar 2018 13:22:38 -0500
From: Fabiano Rosas <farosas@linux.vnet.ibm.com>
Date: Fri,  9 Mar 2018 15:21:57 -0300
In-Reply-To: <20180309182202.31206-1-farosas@linux.vnet.ibm.com>
References: <20180309182202.31206-1-farosas@linux.vnet.ibm.com>
Message-Id: <20180309182202.31206-2-farosas@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 1/5] block/replication: Remove protocol_name
 field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, Wen Congyang <wencongyang2@huawei.com>, Xie Changlong <xiechanglong.d@gmail.com>

The replication driver is only selected explicitly (via
driver=replication,mode=primary,...) so it is not a protocol driver.

This patch removes the protocol_name field from the brdv_replication
structure so that attempts to invoke this driver using protocol
syntax (i.e. replication:<filename:options:...>) will fail gracefully:

  $ qemu-img info replication:foo
  qemu-img: Could not open 'replication:': Unknown protocol 'replication'

Buglink: https://bugs.launchpad.net/qemu/+bug/1726733
Signed-off-by: Fabiano Rosas <farosas@linux.vnet.ibm.com>
---
 block/replication.c | 1 -
 replication.h       | 1 -
 2 files changed, 2 deletions(-)

diff --git a/block/replication.c b/block/replication.c
index f98ef094b9..6c0c7186d9 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -703,7 +703,6 @@ static void replication_stop(ReplicationState *rs, bool failover, Error **errp)
 
 BlockDriver bdrv_replication = {
     .format_name                = "replication",
-    .protocol_name              = "replication",
     .instance_size              = sizeof(BDRVReplicationState),
 
     .bdrv_open                  = replication_open,
diff --git a/replication.h b/replication.h
index 8faefe005f..4c8354de23 100644
--- a/replication.h
+++ b/replication.h
@@ -67,7 +67,6 @@ typedef struct ReplicationState ReplicationState;
  *
  * BlockDriver bdrv_replication = {
  *     .format_name                = "replication",
- *     .protocol_name              = "replication",
  *     .instance_size              = sizeof(BDRVReplicationState),
  *
  *     .bdrv_open                  = replication_open,
-- 
2.13.6
