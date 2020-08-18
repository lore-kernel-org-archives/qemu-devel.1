Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7510C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 11:13:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94D79206B5
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 11:13:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JD80n/ok"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94D79206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7zY7-0006sL-Ro
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 07:13:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35326)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.edmondson@oracle.com>)
 id 1k7zWB-0003ZP-Es; Tue, 18 Aug 2020 07:11:03 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:42316)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.edmondson@oracle.com>)
 id 1k7zW8-0007SG-3B; Tue, 18 Aug 2020 07:11:03 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07IB2sfi087295;
 Tue, 18 Aug 2020 11:10:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=JBqGh+zO8087VX0pAgw3ZIo4sOQnGHdPmFW/MNYZ9Do=;
 b=JD80n/okUuchtrOYW2eh3nIKJt0GphQpfwgRYgD/+Nwdp71c5/02YJOazHMJEzyruavM
 GCgPWMDq3aIL25I8UiWucbCtGKk7I/94K0NivxBYIbxjUvokRFeegF1RUWLycLENyZSA
 LUl09hAkL6LcwMY2WnA1Y33qDQwnroj0BSJHtcgSonr8dm8aQuALzPGP+G4OeYRsBItr
 at7TC86Emmc04/g4ySYmzw5wVKeyENAbYjZRPlL8m44L2L7y1rdDrMqpHVBCHHeyA9Zi
 rsxxRzsz5aoPhh0PRoRvjNJEM++Co2ue+P+32l/QFwvYNhUHsA4f7VWH4DGuc4dwSoXZ 8Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2120.oracle.com with ESMTP id 32x8bn3yh2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 18 Aug 2020 11:10:51 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07IB8Agg171562;
 Tue, 18 Aug 2020 11:08:50 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3030.oracle.com with ESMTP id 32xs9mtymk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Aug 2020 11:08:50 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 07IB8mIn024307;
 Tue, 18 Aug 2020 11:08:48 GMT
Received: from disaster-area.hh.sledj.net (/81.187.26.238)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 18 Aug 2020 04:08:48 -0700
Received: from localhost (disaster-area.hh.sledj.net [local])
 by disaster-area.hh.sledj.net (OpenSMTPD) with ESMTPA id 3bdd2715;
 Tue, 18 Aug 2020 11:08:45 +0000 (UTC)
From: David Edmondson <david.edmondson@oracle.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 0/9] block/curl: Add caching of data downloaded from the
 remote server
Date: Tue, 18 Aug 2020 12:08:36 +0100
Message-Id: <20200818110845.3825105-1-david.edmondson@oracle.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9716
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 adultscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 suspectscore=1 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008180080
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9716
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 lowpriorityscore=0
 impostorscore=0 suspectscore=1 adultscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008180079
Received-SPF: pass client-ip=156.151.31.85;
 envelope-from=david.edmondson@oracle.com; helo=userp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 07:09:07
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, David Edmondson <david.edmondson@oracle.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When using qemu-img to convert an image that is hosted on an HTTP
server to some faster local (or pseudo-local) storage, the overall
performance can be improved by reading data from the HTTP server in
larger blocks and by caching and re-using blocks already read. This
set of patches implements both of these, and adds a further patch
allowing an offset to be added to all of the HTTP requests.

The first patch (block/curl: Add an 'offset' parameter, affecting all
range requests) allows the user to add an arbitrary offset to all
range requests sent to the HTTP server. This is useful if the image to
be read from the HTTP server is embedded in another file (for example
an uncompressed tar file). It avoids the need to first download the
file containing the source image and extract it (both of which will
require writing the image to local storage). It is logically distinct
from the rest of the patches and somewhat use-case specific.

The remaining patches implement block based retrieval of data from the
HTTP server and, optionally, caching of those blocks in memory.

The existing HTTP implementation simply reads whatever data is
requested by the caller, with the option for a user-specified amount
of readahead. This is poor for performance because most IO requests
(from QCOW2, for example) are for relatively small amounts of data,
typically no more than 64kB. This does not allow the underlying TCP
connections to achieve peak throughput.

The existing readhead mechanism is also intended to work in
conjunction with the HTTP driver's attempt to piggy-back a new IO
request on one that is already in flight. This works, but is often
defeated because it relies on the existing IO request *completely*
satisfying any subsequent request that might piggy-back onto it. This
is rarely the case and, particularly when used with "readahead", can
result in the same data being downloaded repeatedly.

The observed performance will depend greatly on the environment, but
when using qemu-img to retrieve a 1GiB QCOW2 image from an HTTPS
server, the following was observed:

| approach                                   | time (hh:mm:ss) |
|--------------------------------------------+-----------------|
| QCOW2 over HTTPS (existing implementation) |        00:00:59 |
| 256kB blocks, 8 cached blocks              |        00:00:42 |
| 2MB blocks, 100 cached blocks              |        00:00:34 |

By way of comparison, aria2c (a dedicated HTTP download client) can
retrieve the same image in 19 seconds. Obviously this is without any
QCOW2 layer.

David Edmondson (9):
  block/curl: Add an 'offset' parameter, affecting all range requests
  block/curl: Remove readahead support
  block/curl: Tracing
  block/curl: Perform IO in fixed size chunks
  block/curl: Allow the blocksize to be specified by the user
  block/curl: Cache downloaded blocks
  block/curl: Allow the user to control the number of cache blocks
  block/curl: Allow 16 sockets/ACB
  block/curl: Add readahead support

 block/curl.c                          | 515 ++++++++++++++++++++++----
 block/io.c                            |   4 +
 block/linux-aio.c                     |   6 +
 block/trace-events                    |  18 +-
 docs/system/device-url-syntax.rst.inc |  15 +
 qapi/block-core.json                  |  11 +-
 6 files changed, 488 insertions(+), 81 deletions(-)

-- 
2.27.0


