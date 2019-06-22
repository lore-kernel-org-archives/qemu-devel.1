Return-Path: <SRS0=QkNH=UV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A483C43613
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Jun 2019 08:53:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 606D82089C
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Jun 2019 08:53:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="f9+3smrq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 606D82089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39450 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hebls-0000dk-GN
	for qemu-devel@archiver.kernel.org; Sat, 22 Jun 2019 04:53:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51572)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <shmuel.eiderman@oracle.com>) id 1hebke-00007Y-TU
 for qemu-devel@nongnu.org; Sat, 22 Jun 2019 04:52:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shmuel.eiderman@oracle.com>) id 1hebkd-0001Nx-Tu
 for qemu-devel@nongnu.org; Sat, 22 Jun 2019 04:52:00 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:55538)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <shmuel.eiderman@oracle.com>)
 id 1hebkb-0001Lu-MK; Sat, 22 Jun 2019 04:51:57 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5M8n9G4181488;
 Sat, 22 Jun 2019 08:51:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=lBooEATFVWR/o6kkB03NSjkAzs7dsoxs9N1HQk3lrrI=;
 b=f9+3smrqRBPJpOZl8ajcYN5OpgTLfB/hu3RQcC8Agi9CJmadY8uiv8YTDTwXRxiWSKvb
 2iNa0vKUcB27hW9bMgPxixFtS3GlXnill3VCBQAXy24ih84ZY3PzCUE9sLcXtHufesUu
 M0ZWYgWzsLYdHjzDIDBOEgYGjzbRYFlq2zesIkxAD9jBd/A9Sm62kuXqyuTjd1iyZo3L
 4U1Fw0wHwcyZYkxNbda+t6ODcb6p0xjW5g8mI8xvicjC5lvI9iFE8Omk8eI02LqcoEhZ
 oBkuVjm33xjEkdf9YxxECsNjiEhqNt/JBzfEJKw4wRz7F3JJOrbGvJgFLLnPeBWZBCN5 OA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2120.oracle.com with ESMTP id 2t9cyq0g6a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 22 Jun 2019 08:51:54 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5M8pLWo080959;
 Sat, 22 Jun 2019 08:51:53 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3030.oracle.com with ESMTP id 2t9acaumm4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 22 Jun 2019 08:51:53 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5M8pqUx020291;
 Sat, 22 Jun 2019 08:51:52 GMT
Received: from [10.30.3.6] (/213.57.127.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Sat, 22 Jun 2019 01:51:52 -0700
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
From: Sam Eiderman <shmuel.eiderman@oracle.com>
In-Reply-To: <20190621185953.GA6620@morn.lan>
Date: Sat, 22 Jun 2019 11:51:48 +0300
Content-Transfer-Encoding: quoted-printable
Message-Id: <78884F3A-DA66-43B0-B504-AD12BC7BDC3C@oracle.com>
References: <20190619092352.23583-1-shmuel.eiderman@oracle.com>
 <20190619092352.23583-4-shmuel.eiderman@oracle.com>
 <20190620143749.GC17015@morn.lan>
 <62F1EBAB-C7E8-42D1-BB6F-22C4945E51B5@oracle.com>
 <20190621185953.GA6620@morn.lan>
To: "Kevin O'Connor" <kevin@koconnor.net>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9295
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906220081
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9295
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906220081
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.85
Subject: Re: [Qemu-devel] [SeaBIOS] [PATCH v3 3/4] geometry: Add
 boot_lchs_find_*() utility functions
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, arbel.moshe@oracle.com,
 seabios@seabios.org, QEMU <qemu-devel@nongnu.org>, mreitz@redhat.com,
 liran.alon@oracle.com, kraxel@redhat.com, karl.heubaum@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

But maybe someone wants bootorder but doesn=E2=80=99t want to override =
legacy disk translations=E2=80=A6

I=E2=80=99m thinking of maybe adding

if (!CONFIG_BOOTORDER || !CONFIG_BIOS_GEOMETRY)
    return NULL;

In each of the get_*_devpath functions (which will normally return an =
allocated string, not on stack).

Another approach can be make CONFIG_BIOS_GEOMETRY depend on =
CONFIG_BOOTORDER.
Then we should only keep:

if (!CONFIG_BOOTORDER)
    return NULL;

In the get_*_devpath functions.

I think the first approach will look better when reading the code - will =
not require the reader to
analize dependancies in the Kconfig file.

Sam


> On 21 Jun 2019, at 21:59, Kevin O'Connor <kevin@koconnor.net> wrote:
>=20
> On Fri, Jun 21, 2019 at 08:42:28PM +0300, Sam Eiderman wrote:
>> Sounds reasonable, how do purpose to deal with:
>>=20
>> config BIOS_GEOMETRY
>> config BOOTORDER
>>=20
>> precompiler optouts?
>=20
> I think you can stick them both under BOOTORDER.  That option is only
> there in case someone wants to reduce the size of the SeaBIOS binary.
> I can't think of a reasonable situation where one cares that much
> about binary size, yet wants to override legacy disk translations..
>=20
>> If we don=E2=80=99t need any of them we also don=E2=80=99t need to =
call =E2=80=9Cget_scsi_devpath", =E2=80=9Cget_ata_devpath=E2=80=9D, =
=E2=80=9Cget_pci_dev_path=E2=80=9D.
>>=20
>> I=E2=80=99ll see what can be done.=20
>=20
> Thanks.
> -Kevin


