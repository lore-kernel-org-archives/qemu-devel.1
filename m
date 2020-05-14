Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09CAEC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 19:23:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA8E620643
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 19:23:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zz74n2Q7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA8E620643
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZJS8-0000tO-07
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 15:23:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58040)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1jZJPh-0006Qa-5Q
 for qemu-devel@nongnu.org; Thu, 14 May 2020 15:21:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23175
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1jZJPf-0007In-Bc
 for qemu-devel@nongnu.org; Thu, 14 May 2020 15:21:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589484057;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sYhxwmcCxDkhf+3ZjmXPVIIlOTv6CwVksSvU6004YAw=;
 b=Zz74n2Q7oP+pw3Za713ji/mobcWNCsOxqyhRWdtCYs40i6RxeC0SE2eFUij9wXhbtvoRQ5
 tjiqwXuHxVsbaEUP4FAOk9OA+VlSi9yyT9+wsSPaabezST8RRC748QFIIAG/E0ESX2mqBn
 adv8kLmJcTPn0IJN67v1kv9JNykyUCU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-DEokjF9rPo2tEfEIx0HCSA-1; Thu, 14 May 2020 15:20:41 -0400
X-MC-Unique: DEokjF9rPo2tEfEIx0HCSA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 545F3100A91C;
 Thu, 14 May 2020 19:20:39 +0000 (UTC)
Received: from w520.home (ovpn-113-111.phx2.redhat.com [10.3.113.111])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 880175D9F1;
 Thu, 14 May 2020 19:20:32 +0000 (UTC)
Date: Thu, 14 May 2020 13:20:32 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: John G Johnson <john.g.johnson@oracle.com>
Subject: Re: RFC: use VFIO over a UNIX domain socket to implement device
 offloading
Message-ID: <20200514132032.5e635249@w520.home>
In-Reply-To: <8101D131-3B95-4CF5-8D46-8755593AA97D@oracle.com>
References: <MN2PR02MB62052E54C752229C115EAD898BCF0@MN2PR02MB6205.namprd02.prod.outlook.com>
 <20200401091712.GA221892@stefanha-x1.localdomain>
 <MW2PR02MB372349E25A0842DE045B95F58BD40@MW2PR02MB3723.namprd02.prod.outlook.com>
 <8101D131-3B95-4CF5-8D46-8755593AA97D@oracle.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120;
 envelope-from=alex.williamson@redhat.com; helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 11:31:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 Kanth Ghatraju <Kanth.Ghatraju@oracle.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Felipe Franciosi <felipe@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>, "Zhang,
 Tina" <tina.zhang@intel.com>, "Liu, Changpeng" <changpeng.liu@intel.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 14 May 2020 09:32:15 -0700
John G Johnson <john.g.johnson@oracle.com> wrote:

> =09Thanos and I have made some changes to the doc in response to the
> feedback we=E2=80=99ve received.  The biggest difference is that it is le=
ss reliant
> on the reader being familiar with the current VFIO implementation.  We=E2=
=80=99d
> appreciate any additional feedback you could give on the changes.  Thanks
> in advance.
>=20
> =09=09=09=09=09=09=09Thanos and JJ
>=20
>=20
> The link remains the same:
>=20
> https://docs.google.com/document/d/1FspkL0hVEnZqHbdoqGLUpyC38rSk_7HhY471T=
sVwyK8/edit?usp=3Dsharing

Hi,

I'm confused by VFIO_USER_ADD_MEMORY_REGION vs VFIO_USER_IOMMU_MAP_DMA.
The former seems intended to provide the server with access to the
entire GPA space, while the latter indicates an IOVA to GPA mapping of
those regions.  Doesn't this break the basic isolation of a vIOMMU?
This essentially says to me "here's all the guest memory, but please
only access these regions for which we're providing DMA mappings".
That invites abuse.

Also regarding VFIO_USER_ADD_MEMORY_REGION, it's not clear to me how
"an array of file descriptors will be sent as part of the message
meta-data" works.  Also consider s/SUB/DEL/.  Why is the Device ID in
the table specified as 0?  How does a client learn their Device ID?

VFIO_USER_DEVICE_GET_REGION_INFO (or anything else making use of a
capability chain), the cap_offset and next pointers within the chain
need to specify what their offset is relative to (ie. the start of the
packet, the start of the vfio compatible data structure, etc).  I
assume the latter for client compatibility.

Also on REGION_INFO, offset is specified as "the base offset to be
given to the mmap() call for regions with the MMAP attribute".  Base
offset from what?  Is the mmap performed on the socket fd?  Do we not
allow read/write, we need to use VFIO_USER_MMIO_READ/WRITE instead?
Why do we specify "MMIO" in those operations versus simply "REGION"?
Are we arbitrarily excluding support for I/O port regions or device
specific regions?  If these commands replace direct read and write to
an fd offset, how is PCI config space handled?

VFIO_USER_MMIO_READ specifies the count field is zero and the reply
will include the count specifying the amount of data read.  How does
the client specify how much data to read?  Via message size?

VFIO_USER_DMA_READ/WRITE, is the address a GPA or IOVA?  IMO the device
should only ever have access via IOVA, which implies a DMA mapping
exists for the device.  Can you provide an example of why we need these
commands since there seems little point to this interface if a device
cannot directly interact with VM memory.

The IOMMU commands should be unnecessary, a vIOMMU should be
transparent to the server by virtue that the device only knows about
IOVA mappings accessible to the device.  Requiring the client to expose
all memory to the server implies that the server must always be trusted.

Interrupt info format, s/type/index/, s/vector/subindex/

In addition to the unused ioctls, the entire concept of groups and
containers are not found in this specification.  To some degree that
makes sense and even mdevs and typically SR-IOV VFs have a 1:1 device
to group relationship.  However, the container is very much involved in
the development of migration support, where it's the container that
provides dirty bitmaps.  Since we're doing map and unmap without that
container concept here, perhaps we'd equally apply those APIs to this
same socket.  Thanks,

Alex


