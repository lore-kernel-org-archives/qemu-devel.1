Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D77EC48BD6
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 11:37:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C7D520656
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 11:37:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qS1wwxUP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C7D520656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hg6Ej-000629-Gf
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 07:37:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41429)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <shmuel.eiderman@oracle.com>) id 1hg6Dr-0005X6-1a
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 07:36:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shmuel.eiderman@oracle.com>) id 1hg6Dp-0007c8-Uc
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 07:36:18 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:59204)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <shmuel.eiderman@oracle.com>)
 id 1hg6Dn-0007QP-Fn; Wed, 26 Jun 2019 07:36:15 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5QBYRTB144509;
 Wed, 26 Jun 2019 11:36:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=5ManQhj20iXcRJbk15PjvEVuM3rA+acuY046NdK54mw=;
 b=qS1wwxUPBaEGsxm8F+48kpCqxnOX0o+nluVu5TRZjQqvba0zRfuP3xCw7H1D7eQwxrS+
 dQ3fKAC5OdvMFI1SXP0amTnJm1qqqOUbJRPqrQ+h+NRszfqqhviWYF6kRGzbKRAGqIFn
 TXxyp3N5H3k272JYA53oqswa1DNOfIkYZrX8+S3KfTu2viJFKgcAMXqeFCwlZ/jDURpt
 /VlLORT0c/3yG8ODAghIb5zEHB0Nu/22HB9BTk+QeeGqYXxAeGKgA6VKrrkskBVk8kCb
 pPnReOPqrSm2X4xhB1MJp38ns4K3hvWxXTPRnpRp1ebEJT3NDFBbX0gmWLEN2NEc55ao bA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2120.oracle.com with ESMTP id 2t9cyqhpj2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Jun 2019 11:36:11 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5QBXvQe018828;
 Wed, 26 Jun 2019 11:34:11 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3030.oracle.com with ESMTP id 2t99f4dp2d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Jun 2019 11:34:11 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5QBYAhK031888;
 Wed, 26 Jun 2019 11:34:10 GMT
Received: from [10.30.3.6] (/213.57.127.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 26 Jun 2019 04:34:09 -0700
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
From: Sam Eiderman <shmuel.eiderman@oracle.com>
In-Reply-To: <4CD0FD44-FB0F-4D76-88FC-C853E874563B@oracle.com>
Date: Wed, 26 Jun 2019 14:34:04 +0300
Content-Transfer-Encoding: quoted-printable
Message-Id: <0A73A4B2-90AB-4290-B549-B64F19303D6E@oracle.com>
References: <20190619092352.23583-1-shmuel.eiderman@oracle.com>
 <20190619092352.23583-4-shmuel.eiderman@oracle.com>
 <20190620143749.GC17015@morn.lan>
 <62F1EBAB-C7E8-42D1-BB6F-22C4945E51B5@oracle.com>
 <20190621185953.GA6620@morn.lan>
 <78884F3A-DA66-43B0-B504-AD12BC7BDC3C@oracle.com>
 <20190622152723.GA3357@morn.lan>
 <4CD0FD44-FB0F-4D76-88FC-C853E874563B@oracle.com>
To: "Kevin O'Connor" <kevin@koconnor.net>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9299
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906260139
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9299
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906260139
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

Kevin,

Rethinking this change (where we construct the device path from outside =
and call boot_prio_find()),
this is pretty tricky to implement since we need to take care of =
csm_bootprio_ata() and
csm_bootprio_pci() which do not work with device path.
In addition,
	bootprio_find_fdc_device
	bootprio_find_pci_rom
	bootprio_find_named_rom
        bootprio_find_usb
Will not require this change and this will just result in too much =
refactoring.

Maybe simply introduce build_scsi_path() and build_ata_path() functions =
and then,
for instance, make booprio_find_scsi_device() and =
boot_lchs_find_scsi_device()
call the same build_scsi_path() function, resulting in less code =
duplication.

Sam


> On 22 Jun 2019, at 20:33, Sam Eiderman <shmuel.eiderman@oracle.com> =
wrote:
>=20
>=20
>=20
>> On 22 Jun 2019, at 18:27, Kevin O'Connor <kevin@koconnor.net> wrote:
>>=20
>> On Sat, Jun 22, 2019 at 11:51:48AM +0300, Sam Eiderman wrote:
>>> But maybe someone wants bootorder but doesn=E2=80=99t want to =
override legacy disk translations=E2=80=A6
>>>=20
>>> I=E2=80=99m thinking of maybe adding
>>>=20
>>> if (!CONFIG_BOOTORDER || !CONFIG_BIOS_GEOMETRY)
>>>   return NULL;
>>=20
>> That's fine - though it's (!CONFIG_BOOTORDER && =
!CONFIG_BIOS_GEOMETRY).
>=20
> Yes of course, my bad
>=20
>>=20
>> FYI, I think BIOS_GEOMETRY is a little confusing - maybe
>> CUSTOM_DISK_GEOMETRY.
>=20
> The thing is that disk geometry is actually (physical geometry, =
reported by the disk controller) and here
> bios geometry stands for the geometry reported from bios int13.
> Also =E2=80=9Cbios geometry=E2=80=9D =3D=3D=3D =E2=80=9Clogical =
geometry=E2=80=9D =3D=3D=3D =E2=80=9Clchs=E2=80=9D.
> So following previous discussion with Gerd, maybe =
CONFIG_HOST_BIOS_GEOMETRY is better?
>=20
> Sam
>=20
>>=20
>> -Kevin
>=20


