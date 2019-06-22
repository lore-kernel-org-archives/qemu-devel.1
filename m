Return-Path: <SRS0=QkNH=UV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AEEBC43613
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Jun 2019 17:34:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B4FF20679
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Jun 2019 17:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="xhcXLIA2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B4FF20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41882 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hejuF-0001Di-8c
	for qemu-devel@archiver.kernel.org; Sat, 22 Jun 2019 13:34:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59477)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <shmuel.eiderman@oracle.com>) id 1hejtV-0000kv-Hu
 for qemu-devel@nongnu.org; Sat, 22 Jun 2019 13:33:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shmuel.eiderman@oracle.com>) id 1hejtU-0006CS-L1
 for qemu-devel@nongnu.org; Sat, 22 Jun 2019 13:33:41 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:48124)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <shmuel.eiderman@oracle.com>)
 id 1hejtS-00064a-8U; Sat, 22 Jun 2019 13:33:38 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5MHUjs1095081;
 Sat, 22 Jun 2019 17:33:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=j/yMY4pj0yv88CoDyA0KUkiKPl5+NbMChya9kXlxn1I=;
 b=xhcXLIA2p3ksLvUjDJIpvCZBZCFRkk3RB5m6nftaLNipFe1Q30EO0wiWz0wq7aLXy8zS
 N+4jtjeX0UtYuaa0pMSls3V5pvogIxSu76z5wVFY8Gx8SSNwzM0Mo05tYuQ4EwGwPly/
 uEe1JNBaA0ly2HxjGS1Fp0rhYOXM8M5+GdL3UC5AJA4uigq+auAK8eDfZ6IM2+HoHLKe
 a1haZkS0gfSSAoWwMbNy6tlUPWYoG6bWyKOvlW+tTEh78UvsMtoq+X7/kEn8p8EtY3bp
 DoCImgADFC53rnGYN6knE5Ikp/Srl6W7uJv7+0+83fMHECck6FIw8+wfjYVImHSMQi7u UA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2120.oracle.com with ESMTP id 2t9cyq17e9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 22 Jun 2019 17:33:33 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5MHWDs1084586;
 Sat, 22 Jun 2019 17:33:33 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3030.oracle.com with ESMTP id 2t99f2q2kg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 22 Jun 2019 17:33:33 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5MHXToT019997;
 Sat, 22 Jun 2019 17:33:32 GMT
Received: from [10.0.0.38] (/79.180.42.160)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Sat, 22 Jun 2019 10:33:29 -0700
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
From: Sam Eiderman <shmuel.eiderman@oracle.com>
In-Reply-To: <20190622152723.GA3357@morn.lan>
Date: Sat, 22 Jun 2019 20:33:22 +0300
Content-Transfer-Encoding: quoted-printable
Message-Id: <4CD0FD44-FB0F-4D76-88FC-C853E874563B@oracle.com>
References: <20190619092352.23583-1-shmuel.eiderman@oracle.com>
 <20190619092352.23583-4-shmuel.eiderman@oracle.com>
 <20190620143749.GC17015@morn.lan>
 <62F1EBAB-C7E8-42D1-BB6F-22C4945E51B5@oracle.com>
 <20190621185953.GA6620@morn.lan>
 <78884F3A-DA66-43B0-B504-AD12BC7BDC3C@oracle.com>
 <20190622152723.GA3357@morn.lan>
To: "Kevin O'Connor" <kevin@koconnor.net>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9296
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=773
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906220159
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9296
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=822 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906220159
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



> On 22 Jun 2019, at 18:27, Kevin O'Connor <kevin@koconnor.net> wrote:
>=20
> On Sat, Jun 22, 2019 at 11:51:48AM +0300, Sam Eiderman wrote:
>> But maybe someone wants bootorder but doesn=E2=80=99t want to =
override legacy disk translations=E2=80=A6
>>=20
>> I=E2=80=99m thinking of maybe adding
>>=20
>> if (!CONFIG_BOOTORDER || !CONFIG_BIOS_GEOMETRY)
>>    return NULL;
>=20
> That's fine - though it's (!CONFIG_BOOTORDER && =
!CONFIG_BIOS_GEOMETRY).

Yes of course, my bad

>=20
> FYI, I think BIOS_GEOMETRY is a little confusing - maybe
> CUSTOM_DISK_GEOMETRY.

The thing is that disk geometry is actually (physical geometry, reported =
by the disk controller) and here
bios geometry stands for the geometry reported from bios int13.
Also =E2=80=9Cbios geometry=E2=80=9D =3D=3D=3D =E2=80=9Clogical =
geometry=E2=80=9D =3D=3D=3D =E2=80=9Clchs=E2=80=9D.
So following previous discussion with Gerd, maybe =
CONFIG_HOST_BIOS_GEOMETRY is better?

Sam

>=20
> -Kevin


