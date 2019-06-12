Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A5AEC31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 13:34:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D87F20866
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 13:34:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="uyJkEP2c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D87F20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60492 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hb3Oz-0008EO-TR
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 09:34:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37719)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <shmuel.eiderman@oracle.com>) id 1hb3Kw-0006dL-8s
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 09:30:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shmuel.eiderman@oracle.com>) id 1hb3Ku-0007hn-FS
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 09:30:46 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:43376)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <shmuel.eiderman@oracle.com>)
 id 1hb3Kb-0007Hw-Ut; Wed, 12 Jun 2019 09:30:27 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5CDIh4o188058;
 Wed, 12 Jun 2019 13:30:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=0sWbF/W/kXCKuh65V/EBJWlQt9dNnS1irz/cuTotsvQ=;
 b=uyJkEP2cri2bVpfsvcLdmB1d7NxMi+MX4u6CTUzowwGaR3boomCx3ESxLCOhUts5pYHO
 C0+yG/JEgEF0WM5FcFUgn9cI02Ob42ru5JGLNcpzH4WGsIKolltU/iosA1/FbdwHI6MD
 hPDOCyA8qGgvLqwHndPpld+cnjQ9j2Wak1N3kp6iQ5KAbx69e6UIPDXNUT2/ggGcZUg2
 SkvHBUqqEIIN4rAc/ve/PrRHw6Kc5wbn9OcxwulX1r2509oO3AJ3C/tbtO+mbTuuAj3S
 ari8y0AYpvblq1F9Oh2Hcqvmbft+v3G8uC2RxaBUk+r3gOkl87y4pH6GgQQ31ekCeTbu MA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2130.oracle.com with ESMTP id 2t02heuj04-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 12 Jun 2019 13:30:12 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5CDSo0R087885;
 Wed, 12 Jun 2019 13:30:12 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3020.oracle.com with ESMTP id 2t1jpj12mx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 12 Jun 2019 13:30:11 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5CDUAe8006907;
 Wed, 12 Jun 2019 13:30:11 GMT
Received: from [10.0.5.157] (/213.57.127.10)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 12 Jun 2019 06:30:09 -0700
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
From: Sam Eiderman <shmuel.eiderman@oracle.com>
In-Reply-To: <20190612130650.xftda65kgnsefyvs@sirius.home.kraxel.org>
Date: Wed, 12 Jun 2019 16:30:03 +0300
Content-Transfer-Encoding: quoted-printable
Message-Id: <A3F8BD49-3C35-4A07-8DE2-85F7CC293DC9@oracle.com>
References: <20190612115939.23825-1-shmuel.eiderman@oracle.com>
 <20190612130650.xftda65kgnsefyvs@sirius.home.kraxel.org>
To: Gerd Hoffmann <kraxel@redhat.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9285
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906120092
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9285
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906120092
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 141.146.126.79
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
 seabios@seabios.org, QEMU <qemu-devel@nongnu.org>, mreitz@redhat.com,
 kevin@koconnor.net, liran.alon@oracle.com, karl.heubaum@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On 12 Jun 2019, at 16:06, Gerd Hoffmann <kraxel@redhat.com> wrote:
>=20
> On Wed, Jun 12, 2019 at 02:59:31PM +0300, Sam Eiderman wrote:
>> v1:
>>=20
>> Non-standard logical geometries break under QEMU.
>>=20
>> A virtual disk which contains an operating system which depends on
>> logical geometries (consistent values being reported from BIOS INT13
>> AH=3D08) will most likely break under QEMU/SeaBIOS if it has =
non-standard
>> logical geometries - for example 56 SPT (sectors per track).
>> No matter what QEMU will guess - SeaBIOS, for large enough disks - =
will
>> use LBA translation, which will report 63 SPT instead.
>=20
> --verbose please.
>=20
> As far I know seabios switches to LBA mode when the disk is simply too
> big for LCHS addressing.  So I fail to see which problem is solved by
> this.  If your guest needs LCHS, why do you assign a disk which can't
> be fully accessed using LCHS addressing?

The scenario is as follows:

A user has a disk with 56 spts.
This disk has been already created under a bios that reported 56 spts.
When migrating this disk to QEMU/SeaBIOS, SeaBIOS will report 63 spts
(under LBA translation) - this will break the boot for this guest.

>=20
>> In addition we can not enforce SeaBIOS to rely on phyiscal geometries =
at
>> all. A virtio-blk-pci virtual disk with 255 phyiscal heads can not
>> report more than 16 physical heads when moved to an IDE controller, =
the
>> ATA spec allows a maximum of 16 heads - this is an artifact of
>> virtualization.
>=20
> Well, not really.  Moving disks from one controller to another when =
the
> OS depends on LHCS addressing never is a good idea.  That already =
caused
> problems in the 90-ies, when moving scsi disks from one scsi host
> adapter to another type, *way* before virtualization became a thing.

I agree, but this is easily solvable in virtualized environments where =
the
hypervisor can guess the correct LCHS values by inspecting the MBR,
or letting the user set these values manually.

>=20
> BTW:  One possible way to figure which LCHS layout a disk uses is to
> check the MBR partition table.  With that we (a) don't need a new
> interface between qemu and seabios and (b) it is not needed to =
manually
> specify the geometry.

In my opinion SeaBIOS is not the correct place for this change since
=E2=80=9Cenhancing=E2=80=9D the detection of LCHS values in SeaBIOS may =
cause it to
suddenly report different values for already existing guests which rely =
on
LCHS - thus, breaking compatibility.
Much like smbios, acpi and mptables - I believe that the correct place =
to
use MBR guessing is QEMU (which already has one, with some issues)
and pass the guess using fw_cfg - this will allow using the compat =
system
in qemu itself.

Sam

>=20
> cheers,
>  Gerd
>=20


