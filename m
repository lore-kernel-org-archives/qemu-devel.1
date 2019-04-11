Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45686C10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 11:11:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E4E02133D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 11:11:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="1CRDtqTi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E4E02133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46593 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEXcR-0001RQ-Br
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 07:11:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1hEXTT-0003Es-Gk
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 07:02:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1hEXTM-0000RA-8X
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 07:02:29 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:58964)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1hEXTL-0007Hd-Pu
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 07:02:24 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
	by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x3BArZxT090391; Thu, 11 Apr 2019 11:02:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
	h=from : to : cc :
	subject : date : message-id : mime-version : content-transfer-encoding; 
	s=corp-2018-07-02; bh=PCog7WmPdrJ3Z4PqseZQAwTpYfReok+Z2nleYdYdSaM=;
	b=1CRDtqTizOMaOu+/g1KtV0POtgecB//uMm00KfOluexnMU1g6ZmOfSqk4z2GGN3YfEWa
	ULvyRE5ybAVCw2UyGICOvhmsdzPNFsVIUUc1nHixh6jEH+LG8unE2wysSgQCPZkoGodm
	O4ZW8FCW533UATxLZrfZvqucCRer6mwnQ1zDlYHXY9ZXliStq9pIrRu3hy1ieAOM686D
	N/TEKAFyEPqIW4MS5sf02rkoDuNdQpiYQqRTxMIbpjSDCKvtxjlGp8YrWeq0AEgzASqZ
	epIAXCYuWdEZeBRzsRu0dgecMsHwoHYNqSI//Sfo2SgiBkH5HqhvPS58RqKmeoPqMXKm
	dw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
	by userp2120.oracle.com with ESMTP id 2rpmrqg6s5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Apr 2019 11:02:04 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
	by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x3BB1g4D059792; Thu, 11 Apr 2019 11:02:04 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
	by aserp3020.oracle.com with ESMTP id 2rpytcq8sr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Apr 2019 11:02:03 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
	by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x3BB23DN008373;
	Thu, 11 Apr 2019 11:02:03 GMT
Received: from host4.lan (/77.138.183.59)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Thu, 11 Apr 2019 04:02:02 -0700
From: Yuval Shaia <yuval.shaia@oracle.com>
To: virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org,
	mst@redhat.com, cohuck@redhat.com, marcel.apfelbaum@gmail.com,
	linux-rdma@vger.kernel.org, jgg@mellanox.com
Date: Thu, 11 Apr 2019 14:01:54 +0300
Message-Id: <20190411110157.14252-1-yuval.shaia@oracle.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9223
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
	malwarescore=0
	phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
	adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
	engine=8.0.1-1810050000 definitions=main-1904110077
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9223
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
	priorityscore=1501 malwarescore=0
	suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
	lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999
	adultscore=0
	classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
	definitions=main-1904110077
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.85
Subject: [Qemu-devel] [RFC 0/3] VirtIO RDMA
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
Cc: Yuval Shaia <yuval.shaia@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190411110154.y9RUKflYq-eMo4YJPo77UqeczoNtp95Xd0CZkwggtdQ@z>

Data center backends use more and more RDMA or RoCE devices and more and
more software runs in virtualized environment.
There is a need for a standard to enable RDMA/RoCE on Virtual Machines.

Virtio is the optimal solution since is the de-facto para-virtualizaton
technology and also because the Virtio specification
allows Hardware Vendors to support Virtio protocol natively in order to
achieve bare metal performance.

This RFC is an effort to addresses challenges in defining the RDMA/RoCE
Virtio Specification and a look forward on possible implementation
techniques.

Open issues/Todo list:
List is huge, this is only start point of the project.
Anyway, here is one example of item in the list:
- Multi VirtQ: Every QP has two rings and every CQ has one. This means that
  in order to support for example 32K QPs we will need 64K VirtQ. Not sure
  that this is reasonable so one option is to have one for all and
  multiplex the traffic on it. This is not good approach as by design it
  introducing an optional starvation. Another approach would be multi
  queues and round-robin (for example) between them.

Expectations from this posting:
In general, any comment is welcome, starting from hey, drop this as it is a
very bad idea, to yeah, go ahead, we really want it.
Idea here is that since it is not a minor effort i first want to know if
there is some sort interest in the community for such device.

The scope of the implementation is limited to probing the device and doing
some basic ibverbs commands. Data-path is not yet implemented. So with this
one can expect only that driver is (partialy) loaded and basic queries and
resource allocation is done.

One note regarding the patchset.
I know it is not standard to collaps patches from several repos as i did
here (qemu and linux) but decided to do it anyway so the whole picture can
be seen.

patch 1: virtio-net: Move some virtio-net-pci decl to include/hw/virtio
	This is a prelimenary patch just as a hack so i will not need to
	impelement new netdev
patch 2: hw/virtio-rdma: VirtIO rdma device
	The implementation of the device
patch 3: RDMA/virtio-rdma: VirtIO rdma driver
	The device driver

-- 
2.20.1


