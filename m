Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 153EBC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 03:55:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDA0020775
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 03:55:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hzIocXDX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDA0020775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jofSx-0007wB-2A
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 23:55:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46952)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.g.johnson@oracle.com>)
 id 1jofRo-0006Da-PN
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 23:54:40 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:46166)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.g.johnson@oracle.com>)
 id 1jofRm-0005lC-LJ
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 23:54:40 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05Q3ptsJ077686;
 Fri, 26 Jun 2020 03:54:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=77ACAzk9WutKtZyM6KLHPxOZ4Brvg7PmGi/0yhGp6lA=;
 b=hzIocXDX4IgIn0w45Vn0p7e3KnkIusogsLuu9B+K+cG2kpcbLUJskWgaFDkgpzFAO313
 KEdn1BBAF0U1MWCWCmwRfzcJOU6FH6xmU5ffdAw8PWPYi/d9tMzF8leFzcDtGv7Nq/OI
 h6cZ3VXIa1HwCQP4gJg5Txab3L5SpaxWeEOUV6OG9ReT6V84lyvetExUN/hYWvwjhDZy
 hH8TLln8GpXsdrZZ9xTTYzQCpIWqIsICVo0rzp7T2cU9AO6DT/prJvqX8zkpdJHa9P1A
 imO+YeI/BmWVZDJkSDIvVA76RfOs7HIIyufNGvCDP4xTqHVfKBG6Ngg5mbMJAU9k/CMm nA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2120.oracle.com with ESMTP id 31uustuuu0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 26 Jun 2020 03:54:31 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05Q3nSmn124376;
 Fri, 26 Jun 2020 03:54:31 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3030.oracle.com with ESMTP id 31uurthyex-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 26 Jun 2020 03:54:31 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 05Q3sRZi025780;
 Fri, 26 Jun 2020 03:54:27 GMT
Received: from [192.168.10.3] (/24.5.35.151)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 26 Jun 2020 03:54:27 +0000
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.14\))
Subject: Re: RFC: use VFIO over a UNIX domain socket to implement device
 offloading
From: John G Johnson <john.g.johnson@oracle.com>
In-Reply-To: <20200623122715.GF36568@stefanha-x1.localdomain>
Date: Thu, 25 Jun 2020 20:54:25 -0700
Content-Transfer-Encoding: quoted-printable
Message-Id: <7B305CB0-0D5F-4FF8-ACDC-828AF37687B1@oracle.com>
References: <MN2PR02MB62052E54C752229C115EAD898BCF0@MN2PR02MB6205.namprd02.prod.outlook.com>
 <20200401091712.GA221892@stefanha-x1.localdomain>
 <MW2PR02MB372349E25A0842DE045B95F58BD40@MW2PR02MB3723.namprd02.prod.outlook.com>
 <8101D131-3B95-4CF5-8D46-8755593AA97D@oracle.com>
 <A0E4C51F-B41C-486B-A5CE-3C4C2C9C1A40@oracle.com>
 <20200602090629.66f9e3f7@x1.home>
 <E78F4C2E-4382-4C98-9606-F1ABD9753699@oracle.com>
 <20200615104929.GD1491454@stefanha-x1.localdomain>
 <DE330A27-2343-459F-9EA0-D3C5F20EE87D@oracle.com>
 <20200623122715.GF36568@stefanha-x1.localdomain>
To: Stefan Hajnoczi <stefanha@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>
X-Mailer: Apple Mail (2.3445.104.14)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9663
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006260025
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9663
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 mlxlogscore=999
 cotscore=-2147483648 adultscore=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 impostorscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006260025
Received-SPF: pass client-ip=156.151.31.85;
 envelope-from=john.g.johnson@oracle.com; helo=userp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 23:54:35
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: "Walker, Benjamin" <benjamin.walker@intel.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, Jag Raman <jag.raman@oracle.com>,
 "Harris, James R" <james.r.harris@intel.com>,
 Swapnil Ingle <swapnil.ingle@nutanix.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 Kanth Ghatraju <Kanth.Ghatraju@oracle.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Felipe Franciosi <felipe@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>, "Zhang,
 Tina" <tina.zhang@intel.com>, "Liu, Changpeng" <changpeng.liu@intel.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On Jun 23, 2020, at 5:27 AM, Stefan Hajnoczi <stefanha@gmail.com> =
wrote:
>=20
> On Thu, Jun 18, 2020 at 02:38:04PM -0700, John G Johnson wrote:
>>> On Jun 15, 2020, at 3:49 AM, Stefan Hajnoczi <stefanha@redhat.com> =
wrote:
>>> An issue with file descriptor passing is that it's hard to revoke =
access
>>> once the file descriptor has been passed. memfd supports sealing =
with
>>> fnctl(F_ADD_SEALS) it doesn't revoke mmap(MAP_WRITE) on other =
processes.
>>>=20
>>> Memory Protection Keys don't seem to be useful here either and their
>>> availability is limited (see pkeys(7)).
>>>=20
>>> One crazy idea is to use KVM as a sandbox for running the device and =
let
>>> the vIOMMU control the page tables instead of the device (guest). =
That
>>> way the hardware MMU provides memory translation, but I think this =
is
>>> impractical because the guest environment is too different from the
>>> Linux userspace environment.
>>>=20
>>> As a starting point adding DMA_READ/DMA_WRITE messages would provide =
the
>>> functionality and security. Unfortunately it makes DMA expensive and
>>> performance will suffer.
>>>=20
>>=20
>> 	Are you advocating for only using VFIO_USER_DMA_READ/WRITE and
>> not passing FDs at all?  The performance penalty would be large for =
the
>> cases where the client and server are equally trusted.  Or are you
>> advocating for an option where the slower methods are used for cases
>> where the server is less trusted?
>=20
> I think the enforcing IOMMU should be optional (due to the performance
> overhead) but part of the spec from the start.
>=20


	With this in mind, we will collapse the current memory region
messages (VFIO_USER_ADD_MEMORY_REGION and VFIO_USER_SUB_MEMORY_REGION)
and the IOMMU messages (VFIO_USER_IOMMU_MAP and VFIO_USER_IOMMU_UNMAP)
into new messages (VFIO_USER_DMA_MAP and VFIO_USER_DMA_UNMAP).  Their
contents will be the same as the memory region messages.

	On a system without an IOMMU, the new messages will be used to
export the system physical address space as DMA addresses.  On a system
with an IOMMU they will be used to export the valid device DMA ranges
programmed into the IOMMU by the guest.  This behavior matches how the
existing QEMU VFIO object programs the host IOMMU.  The server will not
be aware of whether the client is using an IOMMU.

	In the QEMU VFIO implementation, will will add a =
=E2=80=98secure-dma=E2=80=99
option that suppresses exporting mmap()able FDs to the server.  All
DMA will use the slow path to be validated by the client before =
accessing
guest memory.

	Is this acceptable to you (and Alex, of course)?

								JJ


