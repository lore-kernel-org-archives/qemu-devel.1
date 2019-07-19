Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFDA0C76195
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 10:10:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACBA62184E
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 10:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="exrJQVsf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACBA62184E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoPqQ-0007H6-UD
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 06:10:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48915)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <shmuel.eiderman@oracle.com>) id 1hoPqF-0006nL-Ew
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 06:10:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shmuel.eiderman@oracle.com>) id 1hoPqE-0000Ni-5n
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 06:10:19 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:37490)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <shmuel.eiderman@oracle.com>)
 id 1hoPqB-0000Kt-KE; Fri, 19 Jul 2019 06:10:15 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6JA8fDb047980;
 Fri, 19 Jul 2019 10:10:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=qRA9v+Dsdc9YIbcL7bETvAyGhOHnz/yXCIg7hXIWruM=;
 b=exrJQVsfSPaRNl1CeBmsvkKyjIt1Ioj3nLS8y83pqBrbAXNsVpqjNlPSfEhuyPPYAOKG
 NqBvbCyLVW7LgGExHpMwugXtZeC75IXOgMMH901xfnVahFT6n0lTCpQ7YQBOqYEFk3GG
 WlJ+wfamTJ+IKIIkaM4FSL3j2dF/00OogeClt7vR8aLt0K8N6D0nLV7/QlWf/iHbweWy
 gxgpbLmtWiTk9HeFpqrHmSUa+HCMmGENj4jGrIR6FEA0jNMPYT6FMy4l082diQ+Z1hxl
 got05WiFA5sEdWnwhY9+i750tTuVMwdT/4myJgVvlNIl02x13c5E4WbS+bet1g8LAfZX 3Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by aserp2120.oracle.com with ESMTP id 2tq78q5rq1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Jul 2019 10:10:11 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6JA7NNe024565;
 Fri, 19 Jul 2019 10:10:11 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3030.oracle.com with ESMTP id 2tt77j7y8r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Jul 2019 10:10:10 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6JAA98e015187;
 Fri, 19 Jul 2019 10:10:09 GMT
Received: from [10.0.0.38] (/79.181.134.95)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 19 Jul 2019 10:10:09 +0000
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
From: Sam Eiderman <shmuel.eiderman@oracle.com>
In-Reply-To: <20190717194623.GF6471@localhost.localdomain>
Date: Fri, 19 Jul 2019 13:10:04 +0300
Content-Transfer-Encoding: quoted-printable
Message-Id: <65B72D23-26BE-4C3B-B298-A6231D08BF6C@oracle.com>
References: <20190626123948.10199-1-shmuel.eiderman@oracle.com>
 <20190701074117.pkmzhon6v7nafq2p@sirius.home.kraxel.org>
 <424BE97C-7EAF-4B28-B580-AC2B5261197C@oracle.com>
 <EB5E5E3C-CCA1-4138-9623-89ECA7335F88@oracle.com>
 <20190717194623.GF6471@localhost.localdomain>
To: Kevin Wolf <kwolf@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>, philmd@redhat.com
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9322
 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907190117
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9322
 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907190117
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 141.146.126.78
Subject: Re: [Qemu-devel] [QEMU] [PATCH v5 0/8] Add Qemu to SeaBIOS LCHS
 interface
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
Cc: qemu-block@nongnu.org, Arbel Moshe <arbel.moshe@oracle.com>,
 seabios@seabios.org, QEMU <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Kevin O'Connor <kevin@koconnor.net>,
 Liran Alon <liran.alon@oracle.com>, Karl Heubaum <karl.heubaum@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Well, this patch introduces 3 command line parameters (=E2=80=9Clcyls=E2=80=
=9D, =E2=80=9Clheads=E2=80=9D, =E2=80=9Clsecs=E2=80=9D)
to =E2=80=9Cscsi-hd=E2=80=9D =E2=80=9Cide-hd=E2=80=9D and =
=E2=80=9Cvirtio-pci-blk=E2=80=9D so this somehow has something to do =
with
block.

This patch also adds fw_cfg interface to send these parameters to =
SeaBIOS.

"scripts/get_maintainer.pl -f hw/nvram/fw_cfg.c=E2=80=9D gives

"Philippe Mathieu-Daud=C3=A9" <philmd@redhat.com> (supporter:Firmware =
configur...)
Laszlo Ersek <lersek@redhat.com> (reviewer:Firmware configur...)
Gerd Hoffmann <kraxel@redhat.com> (reviewer:Firmware configur=E2=80=A6)

And this was already Reviewed-by Gerd.

How should I proceed?

Sam

> On 17 Jul 2019, at 22:46, Kevin Wolf <kwolf@redhat.com> wrote:
>=20
> Am 17.07.2019 um 21:03 hat Sam Eiderman geschrieben:
>> Gentle ping.
>=20
> Through which tree is this supposed to go? I feel this is more =
firmware
> interface related than block layer stuff.
>=20
> Kevin
>=20
>>> On 8 Jul 2019, at 20:30, Sam Eiderman <shmuel.eiderman@oracle.com> =
wrote:
>>>=20
>>> Thanks Gerd,
>>>=20
>>> Gentle ping on this.
>>>=20
>>> Sam
>>>=20
>>>> On 1 Jul 2019, at 10:41, Gerd Hoffmann <kraxel@redhat.com> wrote:
>>>>=20
>>>> On Wed, Jun 26, 2019 at 03:39:40PM +0300, Sam Eiderman wrote:
>>>>> v1:
>>>>>=20
>>>>> Non-standard logical geometries break under QEMU.
>>>>>=20
>>>>> A virtual disk which contains an operating system which depends on
>>>>> logical geometries (consistent values being reported from BIOS =
INT13
>>>>> AH=3D08) will most likely break under QEMU/SeaBIOS if it has =
non-standard
>>>>> logical geometries - for example 56 SPT (sectors per track).
>>>>> No matter what QEMU will guess - SeaBIOS, for large enough disks - =
will
>>>>> use LBA translation, which will report 63 SPT instead.
>>>>>=20
>>>>> In addition we can not enforce SeaBIOS to rely on phyiscal =
geometries at
>>>>> all. A virtio-blk-pci virtual disk with 255 phyiscal heads can not
>>>>> report more than 16 physical heads when moved to an IDE =
controller, the
>>>>> ATA spec allows a maximum of 16 heads - this is an artifact of
>>>>> virtualization.
>>>>>=20
>>>>> By supplying the logical geometies directly we are able to support =
such
>>>>> "exotic" disks.
>>>>>=20
>>>>> We will use fw_cfg to do just that.
>>>>>=20
>>>>> v2:
>>>>>=20
>>>>> Fix missing parenthesis check in
>>>>>  "hd-geo-test: Add tests for lchs override"
>>>>>=20
>>>>> v3:
>>>>>=20
>>>>> * Rename fw_cfg key to "bios-geometry".
>>>>> * Remove "extendible" interface.
>>>>> * Add cpu_to_le32 fix as Laszlo suggested or big endian hosts
>>>>> * Fix last qtest commit - automatic docker tester for some reason =
does not have qemu-img set
>>>>>=20
>>>>> v4:
>>>>>=20
>>>>> * Change fw_cfg interface from mixed textual/binary to textual =
only
>>>>>=20
>>>>> v5:
>>>>>=20
>>>>> * Fix line > 80 chars in tests/hd-geo-test.c
>>>>=20
>>>> Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
>>>>=20
>>>> cheers,
>>>> Gerd
>>>>=20
>>>=20
>>=20


