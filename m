Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A628CC43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 09:32:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64E892082C
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 09:32:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Raf2cp3Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64E892082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45276 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdtQI-0006ES-JW
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 05:32:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49812)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <shmuel.eiderman@oracle.com>) id 1hdtEP-0003Ff-BU
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 05:19:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shmuel.eiderman@oracle.com>) id 1hdszj-0007E7-Sy
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 05:05:33 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:43598)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <shmuel.eiderman@oracle.com>)
 id 1hdsur-0002GV-Q8; Thu, 20 Jun 2019 04:59:33 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5K8wt8K170615;
 Thu, 20 Jun 2019 08:59:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=sNsSDf8hgxnENr5bve0ufzPqBfT3rSp1SMEFcctj3N4=;
 b=Raf2cp3ZU0kPKc4nciwCNpEEwik1vD8UJWFl5Hi/GMDyttGXpJFrAv5lZzZ6gFrhk0fk
 jfoMIaHlc9qB+J50/fgWBM6rziyUNE/jVH2LgGYiEqRGf6px8uLpB8bhkl6M2Xol2PAa
 ooUHJedDRWfRo/JcMp9yo1EWQgxlkdLUtObCJUpXlFQOC9OSxPUcoG4SaN+fyUqe3BRu
 WXBuZbVkpAD0ajakAJH1SiXugXyQvV2Dqmndo9C8cBZ2vWBdiU7TSdVeYdkwAyWi6t5e
 avSqb3lzOHQVx8S5qmHRHLvyJ4Z1/ThQQ6L7Jtx2E8OH+nlDfUUnO38CqPeONw2smqIK yw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2120.oracle.com with ESMTP id 2t7809fvuf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 20 Jun 2019 08:59:32 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5K8xHV7046503;
 Thu, 20 Jun 2019 08:59:31 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3030.oracle.com with ESMTP id 2t7rdx2g47-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 20 Jun 2019 08:59:31 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5K8xT8H014500;
 Thu, 20 Jun 2019 08:59:30 GMT
Received: from [10.0.0.38] (/79.180.42.160)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 20 Jun 2019 01:52:47 -0700
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
From: Sam Eiderman <shmuel.eiderman@oracle.com>
In-Reply-To: <20190620055038.w7zwwxviqfp4vxvr@sirius.home.kraxel.org>
Date: Thu, 20 Jun 2019 11:52:43 +0300
Content-Transfer-Encoding: quoted-printable
Message-Id: <56B86010-3F22-4CCF-BBFA-2F40F419828B@oracle.com>
References: <20190619092905.24029-1-shmuel.eiderman@oracle.com>
 <156093697557.22612.8821990862661724517@ce79690b2cb9>
 <20190620055038.w7zwwxviqfp4vxvr@sirius.home.kraxel.org>
To: Gerd Hoffmann <kraxel@redhat.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9293
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906200067
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9293
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906200067
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 141.146.126.78
Subject: Re: [Qemu-devel] [SeaBIOS] [QEMU] [PATCH v4 0/8] Add Qemu to
 SeaBIOS LCHS interface
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
 kevin@koconnor.net, karl.heubaum@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On 20 Jun 2019, at 8:50, Gerd Hoffmann <kraxel@redhat.com> wrote:
>=20
>> =3D=3D=3D OUTPUT BEGIN =3D=3D=3D
>> 1/8 Checking commit cf2168a66dbd (block: Refactor macros - fix =
tabbing)
>> ERROR: Macros with complex values should be enclosed in parenthesis
>> #55: FILE: include/hw/block/block.h:65:
>> +#define DEFINE_BLOCK_CHS_PROPERTIES(_state, _conf)                   =
   \
>> +    DEFINE_PROP_UINT32("cyls", _state, _conf.cyls, 0),               =
   \
>> +    DEFINE_PROP_UINT32("heads", _state, _conf.heads, 0),             =
   \
>>     DEFINE_PROP_UINT32("secs", _state, _conf.secs, 0)
>=20
> False positive.
>=20
>> 8/8 Checking commit 6664d7d898d5 (hd-geo-test: Add tests for lchs =
override)
>> WARNING: line over 80 characters
>> #242: FILE: tests/hd-geo-test.c:579:
>> +                     (char *)r->dev_path, &(r->chs.c), &(r->chs.h), =
&(r->chs.s));
>=20
> Should be fixed.

I=E2=80=99ll resubmit.

Sam

>=20
>> WARNING: Block comments use a leading /* on a separate line
>> #640: FILE: tests/hd-geo-test.c:995:
>> +                       "skipping hd-geo/override/* tests");
>=20
> False positive too.
>=20
> cheers,
>  Gerd
>=20


