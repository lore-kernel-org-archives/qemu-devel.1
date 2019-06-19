Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA5EC31E49
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 09:41:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DB5A2084A
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 09:41:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FRIHkc25"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DB5A2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36242 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdX5w-0006hL-Ay
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 05:41:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37946)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <shmuel.eiderman@oracle.com>) id 1hdWwA-0005pl-Fr
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 05:31:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shmuel.eiderman@oracle.com>) id 1hdWw9-0001Kp-Dm
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 05:31:26 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:38976)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <shmuel.eiderman@oracle.com>)
 id 1hdWw6-0001GT-NB; Wed, 19 Jun 2019 05:31:22 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5J9SXNf181020;
 Wed, 19 Jun 2019 09:31:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=qLOgLzrqVODbWJVK9V7BaImb29sBhYI3F2PkgrGpE5Y=;
 b=FRIHkc25HTosxAQX1mdOounyn2zPUOfht/rdfJuE3z2rox8wdiyKBhWvIiqv1nKQBIAW
 5qKnclQ7TcWfyIt+Ztt5mR9xdv9frGHWZKoAadeqUiEJYXa7q9FOKGRK7GSouCjaiCno
 GMihIlCGPRa3XsCcqHdW8tdB6jSMh5vQk26F2mraWuGLerrPPm0AnQRYyhDtrzn9Osnh
 dHxfHqL3s4QUds/tbC08AfWP0Svd7uP5SAZJVesRvgayMKwrcTsjx0srQxocwFd7lkqM
 zr19Ta51vuzyjzDgTxdwWWXF2DXHCa4vaymdlIhmhv9gBK24xl4EFNb0MdqNDjeL/M/T Hw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2120.oracle.com with ESMTP id 2t7809aa2v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Jun 2019 09:31:21 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5J9Tcp9001174;
 Wed, 19 Jun 2019 09:31:21 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3030.oracle.com with ESMTP id 2t77ymyuw9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Jun 2019 09:31:21 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5J9VK4r005995;
 Wed, 19 Jun 2019 09:31:20 GMT
Received: from [10.30.3.6] (/213.57.127.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 19 Jun 2019 02:31:20 -0700
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
From: Sam Eiderman <shmuel.eiderman@oracle.com>
In-Reply-To: <20190605121721.29815-1-shmuel.eiderman@oracle.com>
Date: Wed, 19 Jun 2019 12:31:14 +0300
Content-Transfer-Encoding: quoted-printable
Message-Id: <724CF60D-BEA9-479D-BA6C-9848CB23389F@oracle.com>
References: <20190605121721.29815-1-shmuel.eiderman@oracle.com>
To: kwolf@redhat.com, qemu-block@nongnu.org, QEMU <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9292
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=942
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906190077
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9292
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=991 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906190078
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.85
Subject: Re: [Qemu-devel] [PATCH v2 0/3] vmdk: Add read-only support for the
 new seSparse format
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
Cc: arbel.moshe@oracle.com, liran.alon@oracle.com,
 Eyal Moscovici <eyal.moscovici@oracle.com>, karl.heubaum@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Gentle ping

> On 5 Jun 2019, at 15:17, Sam Eiderman <shmuel.eiderman@oracle.com> =
wrote:
>=20
> v1:
>=20
> VMware introduced a new snapshot format in VMFS6 - seSparse (Space
> Efficient Sparse) which is the default format available in ESXi 6.7.
> Add read-only support for the new snapshot format.
>=20
> v2:
>=20
> Fixed after Max's review:
>=20
> * Removed strict sesparse checks
> * Reduced maximal L1 table size
> * Added non-write mode check in vmdk_open() on sesparse
>=20
> Sam Eiderman (3):
>  vmdk: Fix comment regarding max l1_size coverage
>  vmdk: Reduce the max bound for L1 table size
>  vmdk: Add read-only support for seSparse snapshots
>=20
> block/vmdk.c               | 371 =
++++++++++++++++++++++++++++++++++++++++++---
> tests/qemu-iotests/059.out |   2 +-
> 2 files changed, 352 insertions(+), 21 deletions(-)
>=20
> --=20
> 2.13.3
>=20


