Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF2E1C46477
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 09:54:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50E47217F4
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 09:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VIzbvLle"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50E47217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49702 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbiue-0001mq-6q
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 05:54:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41172)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <shmuel.eiderman@oracle.com>) id 1hbif2-0005Fs-2B
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 05:38:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shmuel.eiderman@oracle.com>) id 1hbiez-0003eF-Vy
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 05:38:15 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:55046)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <shmuel.eiderman@oracle.com>)
 id 1hbieo-0003Tq-7c; Fri, 14 Jun 2019 05:38:02 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5E9Y7Tc019604;
 Fri, 14 Jun 2019 09:37:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : message-id :
 content-type : mime-version : subject : date : in-reply-to : cc : to :
 references; s=corp-2018-07-02;
 bh=/HqfolA0l45zKFTf6lfKoXhQAx3ZKwmNgxpRyQxQeSo=;
 b=VIzbvLleq/33IrB2lhgrGJURB+3xrmOzu3gfUI/CAF4I4mvCfEn1qnRDH3zVW15Jawdj
 PbKS8bAZ6w7Y2vqnmcJPAuCsvIuo9ufVah1Tq4v52F+R5yCObchLwxKlUmt8Snks19a3
 9jAtaKXYTGV4CH6E4md5GGozssxmNYKK9KjHO8teYGOyeC1DKy87+eMI+e8C0PrgYa3h
 bIoa38g8X4urQ1Is2MM7MrAaGJyRDncNxTsUb/mtuZnJ30dxWH1OPcXBgoMQA9jFeo5b
 OuUxwy/sRU7TaInUNY1KpmDwAxoMUlD3981mKBodt2mQhazY3K3fXWbeLuLI3/kXpkoN Aw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2120.oracle.com with ESMTP id 2t04ynxd5d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Jun 2019 09:37:57 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5E9bll1008013;
 Fri, 14 Jun 2019 09:37:56 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3020.oracle.com with ESMTP id 2t1jpk27nw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Jun 2019 09:37:56 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5E9bsPc024835;
 Fri, 14 Jun 2019 09:37:54 GMT
Received: from [10.0.0.38] (/79.179.64.139)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 14 Jun 2019 02:37:54 -0700
From: Sam Eiderman <shmuel.eiderman@oracle.com>
Message-Id: <985C60F2-999C-44C6-B8BC-B5603DD0F716@oracle.com>
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Date: Fri, 14 Jun 2019 12:37:38 +0300
In-Reply-To: <20190614044310.wxnkwxagr23d5cbt@sirius.home.kraxel.org>
To: Gerd Hoffmann <kraxel@redhat.com>
References: <20190612115939.23825-1-shmuel.eiderman@oracle.com>
 <20190612130650.xftda65kgnsefyvs@sirius.home.kraxel.org>
 <A3F8BD49-3C35-4A07-8DE2-85F7CC293DC9@oracle.com>
 <20190612191817.5bilt2abif2xvcbv@sirius.home.kraxel.org>
 <02844D7D-ED79-4744-A203-8E713DE7A717@oracle.com>
 <20190613093850.5k7prawn6x4qt3fi@sirius.home.kraxel.org>
 <730C65DE-A9B4-4553-B6A0-7A3B81A1FA12@oracle.com>
 <20190614044310.wxnkwxagr23d5cbt@sirius.home.kraxel.org>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9287
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906140080
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9287
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906140079
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 141.146.126.78
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [QEMU] [PATCH v2 0/8] Add Qemu to SeaBIOS LCHS
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, arbel.moshe@oracle.com,
 seabios@seabios.org, QEMU <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Kevin O'Connor <kevin@koconnor.net>,
 liran.alon@oracle.com, Karl Heubaum <karl.heubaum@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On 14 Jun 2019, at 7:43, Gerd Hoffmann <kraxel@redhat.com> wrote:
>=20
>  Hi,
>=20
>> Can there be a guest that will fail the MBR in such a way? Yes.
>> Look at the following MBR partition table of a Windows XP guest in =
our production
>> environment:
>>=20
>> Disk size in sectors: 16777216
>>=20
>> Binary (only one partition 16 bytes): 80 01 01 00 07 fe ff ff 3f 00 =
00 00 d5 ea ff 00
>> Start: (0, 1, 1, 63)
>> End: (1023, 254, 63, 16771859)
>>=20
>> As can be easily seen, any MBR guessing algorithm should guess:
>>=20
>> 	255 heads (since a value of 254 appears), 63 spt (since a value =
of 63 appears)
>>=20
>> Turns out that this image does not work with 255, 63 but actually =
requires
>>=20
>> 	16 heads, 63 spt
>>=20
>> to boot.
>>=20
>> So relying on MBR partitions alone is not always enough and sometimes =
manual intervention
>> is required.
>=20
> Ok, given that seabios has no setup any manual configuration needs to =
be done via qemu.
>=20
> But why do we need a new interface for that?  IDE can pass the =
geometry
> to the guest.  virtio-blk has support too (VIRTIO_BLK_F_GEOMETRY).
> Likewise scsi (MODE_PAGE_HD_GEOMETRY).  So this should be doable =
without
> any qemu changes.

This was indeed considered (all 3 methods) but it has the following =
issues:

Physical geometries of devices must now also be logical geometries with =
translation=3Dnone.
When the OS will query these devices - It will now see different =
physical geometries, adapted to be logical geometries.
I=E2=80=99m not sure even how to implement this without breaking =
existing compatibility - since we don=E2=80=99t want to affect logical =
geometries of currently used guests.
MODE_PAGE_HD_GEOMETRY does not contain the spts, only cylinders (as 3 =
byte number) and heads (as 1 byte number) and computes the spts using: =
number_of_total_sectors / (heads * cylinders), this means that qemu now =
must report number_of_total_sectors as heads * cylinders * spt for =
SeaBIOS to correctly receive the number of spts - this is not optimal =
since number_of_total_sectors can not reflect the real amount of sectors =
in the disk which should be reported from CDB_CMD_READ_CAPACITY.
Moving a scsi-hd/virtio-blk with 255 physical heads to ide-hd, we will =
still need to report 255 heads - this is possible since a whole byte can =
be used in the =E2=80=9Cide identify=E2=80=9D command, but goes against =
the spec of a maximum of 16 heads for IDE.

Overall this approach is much more complicated.

Sam

>=20
> cheers,
>  Gerd
>=20

