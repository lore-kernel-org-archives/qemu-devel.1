Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F24C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 00:48:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2338220756
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 00:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nN9POeGl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2338220756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbZNU-0005ZN-9R
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 20:48:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39858)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.g.johnson@oracle.com>)
 id 1jbZMs-00058P-0t
 for qemu-devel@nongnu.org; Wed, 20 May 2020 20:47:26 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:43804)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.g.johnson@oracle.com>)
 id 1jbZMq-0001dz-JC
 for qemu-devel@nongnu.org; Wed, 20 May 2020 20:47:25 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04L0HgA1155940;
 Thu, 21 May 2020 00:47:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=rLQe2a08B4+gFsbqnK9NPtNEMOiAtbcZNXVu4BG0roQ=;
 b=nN9POeGlpUCE97w46+l4sGgG+gHwN5Zw0PjIYBx9Z6K4yqO1xB3u0LQ3KPpllEKa5oe7
 YKPIdPJLBlyNUK6oCPHKp7sPBfgoTssRW85jP05nzxffvNH3GrmeX40EEqGLdR+hhHPf
 hbtmdk38H02yRVeTVILVlkBYOir5yMTxzu4BSEWiePT2EQJLjumQvA3sAPqHceX5yFK4
 lG46ItICy5V6maC3UVA5Oocm4D8+Wzx2olrPrfvf2/6YixyRvApHORCy5n3F5iRl579N
 6JTY54dJbmPoRUA8x7sxfThYlR3foIh9wa/Ph5RXBIIGQy5xBr07DTvMfTbLSK+zodE9 Iw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2120.oracle.com with ESMTP id 31501rcgv1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 21 May 2020 00:47:17 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04L0IUAo166952;
 Thu, 21 May 2020 00:45:17 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3030.oracle.com with ESMTP id 314gm85syg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 21 May 2020 00:45:17 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 04L0jFW2010230;
 Thu, 21 May 2020 00:45:15 GMT
Received: from [192.168.10.3] (/24.5.35.151)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 20 May 2020 17:45:15 -0700
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.14\))
Subject: Re: RFC: use VFIO over a UNIX domain socket to implement device
 offloading
From: John G Johnson <john.g.johnson@oracle.com>
In-Reply-To: <8101D131-3B95-4CF5-8D46-8755593AA97D@oracle.com>
Date: Wed, 20 May 2020 17:45:13 -0700
Content-Transfer-Encoding: quoted-printable
Message-Id: <A0E4C51F-B41C-486B-A5CE-3C4C2C9C1A40@oracle.com>
References: <MN2PR02MB62052E54C752229C115EAD898BCF0@MN2PR02MB6205.namprd02.prod.outlook.com>
 <20200401091712.GA221892@stefanha-x1.localdomain>
 <MW2PR02MB372349E25A0842DE045B95F58BD40@MW2PR02MB3723.namprd02.prod.outlook.com>
 <8101D131-3B95-4CF5-8D46-8755593AA97D@oracle.com>
To: Alex Williamson <alex.williamson@redhat.com>
X-Mailer: Apple Mail (2.3445.104.14)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9627
 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxlogscore=999
 adultscore=0 phishscore=0 mlxscore=0 spamscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005210000
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9627
 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 spamscore=0
 mlxlogscore=999 clxscore=1015 priorityscore=1501 cotscore=-2147483648
 impostorscore=0 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005210000
Received-SPF: pass client-ip=156.151.31.85;
 envelope-from=john.g.johnson@oracle.com; helo=userp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 20:47:21
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 Swapnil Ingle <swapnil.ingle@nutanix.com>, "Harris,
 James R" <james.r.harris@intel.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Felipe Franciosi <felipe@nutanix.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 Kanth Ghatraju <Kanth.Ghatraju@oracle.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>, "Zhang,
 Tina" <tina.zhang@intel.com>, "Liu, Changpeng" <changpeng.liu@intel.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> I'm confused by VFIO_USER_ADD_MEMORY_REGION vs =
VFIO_USER_IOMMU_MAP_DMA.
> The former seems intended to provide the server with access to the
> entire GPA space, while the latter indicates an IOVA to GPA mapping of
> those regions.  Doesn't this break the basic isolation of a vIOMMU?
> This essentially says to me "here's all the guest memory, but please
> only access these regions for which we're providing DMA mappings".
> That invites abuse.
>=20

	The purpose behind separating QEMU into multiple processes is
to provide an additional layer protection for the infrastructure against
a malign guest, not for the guest against itself, so preventing a server
that has been compromised by a guest from accessing all of guest memory
adds no additional benefit.  We don=E2=80=99t even have an IOMMU in our =
current
guest model for this reason.

	The implementation was stolen from vhost-user, with the =
exception
that we push IOTLB translations from client to server like VFIO does, as
opposed to pulling them from server to client like vhost-user does.

	That said, neither the qemu-mp nor MUSER implementation uses an
IOMMU, so if you prefer another IOMMU model, we can consider it.  We
could only send the guest memory file descriptors with IOMMU_MAP_DMA
requests, although that would cost performance since each request would
require the server to execute an mmap() system call.


> Also regarding VFIO_USER_ADD_MEMORY_REGION, it's not clear to me how
> "an array of file descriptors will be sent as part of the message
> meta-data" works.  Also consider s/SUB/DEL/.  Why is the Device ID in
> the table specified as 0?  How does a client learn their Device ID?
>=20

	SCM_RIGHTS message controls allow sendmsg() to send an array of
file descriptors over a UNIX domain socket.

	We=E2=80=99re only supporting one device per socket in this =
protocol
version, so the device ID will always be 0.  This may change in a future
revision, so we included the field in the header to avoid a major =
version
change if device multiplexing is added later.


> VFIO_USER_DEVICE_GET_REGION_INFO (or anything else making use of a
> capability chain), the cap_offset and next pointers within the chain
> need to specify what their offset is relative to (ie. the start of the
> packet, the start of the vfio compatible data structure, etc).  I
> assume the latter for client compatibility.
>=20

	Yes.  We will attempt to make the language clearer.


> Also on REGION_INFO, offset is specified as "the base offset to be
> given to the mmap() call for regions with the MMAP attribute".  Base
> offset from what?  Is the mmap performed on the socket fd?  Do we not
> allow read/write, we need to use VFIO_USER_MMIO_READ/WRITE instead?
> Why do we specify "MMIO" in those operations versus simply "REGION"?
> Are we arbitrarily excluding support for I/O port regions or device
> specific regions?  If these commands replace direct read and write to
> an fd offset, how is PCI config space handled?
>=20

	The base offset refers to the sparse areas, where the sparse =
area
offset is added to the base region offset.  We will try to make the text
clearer here as well.

	MMIO was added to distinguish these operations from DMA =
operations.
I can see how this can cause confusion when the region refers to a port =
range,
so we can change the name to REGION_READ/WRITE.=20


> VFIO_USER_MMIO_READ specifies the count field is zero and the reply
> will include the count specifying the amount of data read.  How does
> the client specify how much data to read?  Via message size?
>=20

	This is a bug in the doc.  As you said, the read field should
be the amount of data to be read.
=09

> VFIO_USER_DMA_READ/WRITE, is the address a GPA or IOVA?  IMO the =
device
> should only ever have access via IOVA, which implies a DMA mapping
> exists for the device.  Can you provide an example of why we need =
these
> commands since there seems little point to this interface if a device
> cannot directly interact with VM memory.
>=20

	It is a GPA.  The device emulation code would only handle the =
DMA
addresses the guest programmed it with; the server infrastructure knows
whether an IOMMU exists, and whether the DMA address needs translation =
to
GPA or not.


> The IOMMU commands should be unnecessary, a vIOMMU should be
> transparent to the server by virtue that the device only knows about
> IOVA mappings accessible to the device.  Requiring the client to =
expose
> all memory to the server implies that the server must always be =
trusted.
>=20

	The client and server are equally trusted; the guest is the =
untrusted
entity.


> Interrupt info format, s/type/index/, s/vector/subindex/
>=20

	ok


> In addition to the unused ioctls, the entire concept of groups and
> containers are not found in this specification.  To some degree that
> makes sense and even mdevs and typically SR-IOV VFs have a 1:1 device
> to group relationship.  However, the container is very much involved =
in
> the development of migration support, where it's the container that
> provides dirty bitmaps.  Since we're doing map and unmap without that
> container concept here, perhaps we'd equally apply those APIs to this
> same socket.  Thanks,

	Groups and containers are host IOMMU concepts, and we don=E2=80=99=
t
interact with the host here.  The kernel VFIO driver doesn=E2=80=99t =
even need
to exist for VFIO over socket.  I think it=E2=80=99s fine to assume a =
1-1
correspondence between containers, groups, and a VFIO over socket =
device.

	Thanks for looking this over.

							Thanos & JJ





