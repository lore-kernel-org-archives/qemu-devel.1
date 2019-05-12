Return-Path: <SRS0=55mG=TM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF93C04A6B
	for <qemu-devel@archiver.kernel.org>; Sun, 12 May 2019 08:15:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B3E221019
	for <qemu-devel@archiver.kernel.org>; Sun, 12 May 2019 08:15:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="giWaUyNn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B3E221019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40287 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hPje8-00086Q-7l
	for qemu-devel@archiver.kernel.org; Sun, 12 May 2019 04:15:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shmuel.eiderman@oracle.com>) id 1hPjdD-0007b1-6K
	for qemu-devel@nongnu.org; Sun, 12 May 2019 04:14:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shmuel.eiderman@oracle.com>) id 1hPjdB-00019w-6M
	for qemu-devel@nongnu.org; Sun, 12 May 2019 04:14:51 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:35680)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <shmuel.eiderman@oracle.com>)
	id 1hPjd6-00015o-Gn; Sun, 12 May 2019 04:14:45 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
	by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x4C88ru4142499; Sun, 12 May 2019 08:14:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
	h=from : message-id :
	content-type : mime-version : subject : date : in-reply-to : cc : to :
	references; s=corp-2018-07-02;
	bh=zbZAYH+lzFdxtMXZKeT3AMmhd8SECW22VefYEquuBag=;
	b=giWaUyNnf0pH94HlC/Ech2qafbTd9PmrN5X6Tfb7adW4/jVMHp1PxGtTZu1QwmNyONRi
	S3BzDQ9SmytNOkfOOM5X8v9QPQdPuwVVWpc8haDInP0RYKiPDAp1IrkmVfEKQ4ioFTgX
	9QL6MM5UWThsyY58VJZs+gwpjRTQGLp0mIITsRwyVjiO0PgXMSRK16NKfGtFKzEbP3v6
	/Oada3esKbD86g/IXDgoCNKM48Z38N93MQiMj0t3B0SOXwoeGYX4ue8q4Skm9AqUuzQe
	rPgWotO+PokYLMkAk+AnwTI3YNJEFDMSagNoLoTHrXYhU0oQaYAoaqhjrHWoGHpyXzVy
	7A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
	by aserp2130.oracle.com with ESMTP id 2sdkwdanq1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 12 May 2019 08:14:27 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
	by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x4C8DoIY136920; Sun, 12 May 2019 08:14:27 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
	by aserp3020.oracle.com with ESMTP id 2se0tv5dc1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 12 May 2019 08:14:27 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
	by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4C8EP7a013691;
	Sun, 12 May 2019 08:14:26 GMT
Received: from [10.0.5.147] (/213.57.127.10)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Sun, 12 May 2019 08:14:25 +0000
From: Sam <shmuel.eiderman@oracle.com>
Message-Id: <7687F664-4BC3-47B9-A6CB-1B9B72ED80C2@oracle.com>
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Date: Sun, 12 May 2019 11:14:21 +0300
In-Reply-To: <20190424074901.31430-1-shmuel.eiderman@oracle.com>
To: fam@euphon.net, kwolf@redhat.com, Max Reitz <mreitz@redhat.com>,
	qemu-block@nongnu.org
References: <20190424074901.31430-1-shmuel.eiderman@oracle.com>
X-Mailer: Apple Mail (2.3445.104.8)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9254
	signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
	malwarescore=0
	phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
	adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
	engine=8.0.1-1810050000 definitions=main-1905120061
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9254
	signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
	priorityscore=1501 malwarescore=0
	suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
	lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999
	adultscore=0
	classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
	definitions=main-1905120061
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 141.146.126.79
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH 0/2]: vmdk: Add read-only support for the
 new seSparse format
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
Cc: eyal.moscovici@oracle.com, Arbel Moshe <arbel.moshe@oracle.com>,
	yuchenlin@synology.com, qemu-devel@nongnu.org,
	liran.alon@oracle.com, Karl Heubaum <karl.heubaum@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Gentle ping on "[PATCH 2/2] vmdk: Add read-only support for seSparse =
snapshots=E2=80=9D.
Yuchenlin reviewed "[PATCH 1/2] vmdk: Fix comment regarding max l1_size =
coverage=E2=80=9D.

Thanks, Sam

> On 24 Apr 2019, at 10:48, Sam Eiderman <shmuel.eiderman@oracle.com> =
wrote:
>=20
> VMware introduced a new snapshot format in VMFS6 - seSparse (Space
> Efficient Sparse) which is the default format available in ESXi 6.7.
> Add read-only support for the new snapshot format.
>=20

