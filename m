Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57AD1C31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 11:47:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F86521743
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 11:47:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="4Ug1hoyI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F86521743
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38736 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbOCq-0007YL-29
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 07:47:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50705)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <shmuel.eiderman@oracle.com>) id 1hbOBG-0006UL-FJ
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 07:46:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shmuel.eiderman@oracle.com>) id 1hbOBE-0006vw-Ui
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 07:46:10 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:47376)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <shmuel.eiderman@oracle.com>)
 id 1hbOBD-0006mP-1z; Thu, 13 Jun 2019 07:46:07 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5DBipLk053890;
 Thu, 13 Jun 2019 11:45:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : message-id :
 content-type : mime-version : subject : date : in-reply-to : cc : to :
 references; s=corp-2018-07-02;
 bh=db+34tNJ3CRMcKFSFoehrVjWduhUnKRLqjweyGF8v5M=;
 b=4Ug1hoyI16FNW8tCPL+bD3dopxl3TEe4rfB21ncqp+pNOBFBasfkEgaCQ0htdCb+5JKW
 opb6UAOm4SW1L4en0tvGyVkr+q4wiTXOCxX5ro8UXtLAoQfj+a6dLHw1PJ8m4bABOdVl
 Bbfj6dVlF2l+dhFcR8bI8O2n20S6aNgpFLWJojiN2E7eXdpj3ulLXiMdWD/dEQA31WSc
 yaz+aKqEFDwZfb3b6K4gSH7n2uPJnWyGyjg6L7rZTvK7/ygFbTqtY9qZeCjtIFWeq5xi
 UpOcjT/mFfBsUInCOIIqJfwRytpxRPyFpEmo/8oGLp/SU0wPPkV/2UhPIphoYcOKXPxb JQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2130.oracle.com with ESMTP id 2t04eu112u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 13 Jun 2019 11:45:59 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5DBiSlP047848;
 Thu, 13 Jun 2019 11:45:58 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3020.oracle.com with ESMTP id 2t0p9sbun4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 13 Jun 2019 11:45:58 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5DBjvu8026610;
 Thu, 13 Jun 2019 11:45:57 GMT
Received: from [10.74.126.124] (/10.74.126.124)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 13 Jun 2019 04:45:57 -0700
From: Sam Eiderman <shmuel.eiderman@oracle.com>
Message-Id: <730C65DE-A9B4-4553-B6A0-7A3B81A1FA12@oracle.com>
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Date: Thu, 13 Jun 2019 14:45:51 +0300
In-Reply-To: <20190613093850.5k7prawn6x4qt3fi@sirius.home.kraxel.org>
To: Gerd Hoffmann <kraxel@redhat.com>
References: <20190612115939.23825-1-shmuel.eiderman@oracle.com>
 <20190612130650.xftda65kgnsefyvs@sirius.home.kraxel.org>
 <A3F8BD49-3C35-4A07-8DE2-85F7CC293DC9@oracle.com>
 <20190612191817.5bilt2abif2xvcbv@sirius.home.kraxel.org>
 <02844D7D-ED79-4744-A203-8E713DE7A717@oracle.com>
 <20190613093850.5k7prawn6x4qt3fi@sirius.home.kraxel.org>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9286
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906130092
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9286
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906130092
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.86
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



> On 13 Jun 2019, at 12:38, Gerd Hoffmann <kraxel@redhat.com> wrote:
>=20
>  Hi,
>=20
>> Yes they are pretty rare.
>> Windows 2000 and Windows XP guests migrated from VMware to Qemu/KVM
>> would not boot due to incorrect disk geometries (some had 32/56 spt =
instead of
>> 56. Also number of heads was not entirely correct)
>=20
> Ok.
>=20
>>> Why?  Asking the user to deal with the mess is pretty lame if there =
are
>>> better options.  And IMO doing this fully automatic in seabios is
>>> better.
>>=20
>> I=E2=80=99m not against an automatic approach, however I do think =
that doing this
>> in SeaBIOS might break compatibility for already existing guests that =
will
>> suddenly see different LCHS values. (Explanation below)
>=20
>>> I can't see how this can break guests.  It should either have no =
effect
>>> (guests using LBA) or unbreak guests due to LCHS changing from =
"wrong"
>>> to "correct=E2=80=9D.
>>=20
>> I=E2=80=99m not sure what do you mean by "unbreak guests=E2=80=9D if =
you change an existing
>> guest that uses LCHS from 56 spt to LBA (63 spt) it will stop =
booting.
>=20
> Well, that LCHS change happens because you move the guest from vmware =
to
> qemu and seabios uses 63 spt no matter what if the disk is too big for
> chs addressing.
>=20
> When seabios is changed to look at the MBR to figure what the lchs of
> the disk is that will make your guest boot.

See below

>=20
>> Your guessing algorithm will have to guess 56, if it will fail =
guessing 56 correctly,
>> the user can not perform any action beside downgrading SeaBIOS in =
order to run
>> the guest.
>=20
> Sure, if the guess is wrong then the guest will not boot.  That isn't
> worse than the situation we have today where seabios will not even try
> to figure what the lchs of the disk is.
>=20
> And, no, downgrading seabios will not make your vmware guest with 56 =
spt
> boot.

I=E2=80=99m not talking about the vmware case here.
If you introduce MBR guessing into SeaBIOS and change its default =
behaviour you
risk making operating systems such as Windows XP / 2003 / 2000 created =
on
QEMU to not work anymore.

Example:

	Consider a Windows XP that works with the following geometries =
on standard
	QEMU/SeaBIOS today:
=09
	Disk is very large, therefore INT13 AH=3D02:

		255 heads, 63 spt

	Now you change SeaBIOS to guess from the MBR.
	In some cases the MBR guess can be incorrect so now SeaBIOS will =
guess:

		255 heads, 62 spt

	The guest no longer boots with these geometries and you broke =
compatibility.
=09
Can there be a guest that will fail the MBR in such a way? Yes.
Look at the following MBR partition table of a Windows XP guest in our =
production
environment:

Disk size in sectors: 16777216

Binary (only one partition 16 bytes): 80 01 01 00 07 fe ff ff 3f 00 00 =
00 d5 ea ff 00
Start: (0, 1, 1, 63)
End: (1023, 254, 63, 16771859)

As can be easily seen, any MBR guessing algorithm should guess:

	255 heads (since a value of 254 appears), 63 spt (since a value =
of 63 appears)

Turns out that this image does not work with 255, 63 but actually =
requires

	16 heads, 63 spt

to boot.

So relying on MBR partitions alone is not always enough and sometimes =
manual intervention
is required.

(VMware solves this by specifying 16 heads, 63 spt in the descriptor =
file and overrides its
default guessing algorithm which also fails here)

(By the way this is not a VMware specific problem, the disk itself was =
imported to VMware in
a P2V scenario, so that probably explains why the ddb.geometry.bios* =
values appear in the
VMDK in the first place)


>=20
> cheers,
>  Gerd
>=20

