Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 622D6C4CEC4
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 17:28:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38D5F21928
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 17:28:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38D5F21928
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iB0EY-0007Ke-ND
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 13:28:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50174)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1iB06w-0008UJ-8p
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 13:20:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1iB06s-0000rN-VX
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 13:20:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44610)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1iB06s-0000qn-O0
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 13:20:50 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 538D43022465;
 Thu, 19 Sep 2019 17:20:49 +0000 (UTC)
Received: from x1.home (ovpn-118-102.phx2.redhat.com [10.3.118.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DB45660872;
 Thu, 19 Sep 2019 17:20:48 +0000 (UTC)
Date: Thu, 19 Sep 2019 11:20:48 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [Qemu-devel] vhost, iova, and dirty page tracking
Message-ID: <20190919112048.09b3edaa@x1.home>
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19D57B785@SHSMSX104.ccr.corp.intel.com>
References: <AADFC41AFE54684AB9EE6CBC0274A5D19D577BEA@SHSMSX104.ccr.corp.intel.com>
 <60110ea3-9228-7e5d-ea32-05c72a95af0b@redhat.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D57A080@SHSMSX104.ccr.corp.intel.com>
 <20190917085404.3b063e53@x1.home>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D57AFBA@SHSMSX104.ccr.corp.intel.com>
 <a82101bf-f8a7-5ddd-5abe-6060762d9abe@redhat.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D57B785@SHSMSX104.ccr.corp.intel.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Thu, 19 Sep 2019 17:20:49 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: Jason Wang <jasowang@redhat.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 18 Sep 2019 07:21:05 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:

> > From: Jason Wang [mailto:jasowang@redhat.com]
> > Sent: Wednesday, September 18, 2019 2:04 PM
> >=20
> > On 2019/9/18 =E4=B8=8A=E5=8D=889:31, Tian, Kevin wrote: =20
> > >> From: Alex Williamson [mailto:alex.williamson@redhat.com]
> > >> Sent: Tuesday, September 17, 2019 10:54 PM
> > >>
> > >> On Tue, 17 Sep 2019 08:48:36 +0000
> > >> "Tian, Kevin"<kevin.tian@intel.com>  wrote:
> > >> =20
> > >>>> From: Jason Wang [mailto:jasowang@redhat.com]
> > >>>> Sent: Monday, September 16, 2019 4:33 PM
> > >>>>
> > >>>>
> > >>>> On 2019/9/16 =E4=B8=8A=E5=8D=889:51, Tian, Kevin wrote: =20
> > >>>>> Hi, Jason
> > >>>>>
> > >>>>> We had a discussion about dirty page tracking in VFIO, when =20
> > vIOMMU =20
> > >>>>> is enabled:
> > >>>>>
> > >>>>> https://lists.nongnu.org/archive/html/qemu-devel/2019- =20
> > >>>> 09/msg02690.html =20
> > >>>>> It's actually a similar model as vhost - Qemu cannot interpose th=
e =20
> > fast- =20
> > >>>> path =20
> > >>>>> DMAs thus relies on the kernel part to track and report dirty pag=
e =20
> > >>>> information. =20
> > >>>>> Currently Qemu tracks dirty pages in GFN level, thus demanding a =
=20
> > >>>> translation =20
> > >>>>> from IOVA to GPA. Then the open in our discussion is where this =
=20
> > >>>> translation =20
> > >>>>> should happen. Doing the translation in kernel implies a device i=
otlb =20
> > >>>> flavor, =20
> > >>>>> which is what vhost implements today. It requires potentially lar=
ge =20
> > >>>> tracking =20
> > >>>>> structures in the host kernel, but leveraging the existing log_sy=
nc =20
> > flow =20
> > >> in =20
> > >>>> Qemu. =20
> > >>>>> On the other hand, Qemu may perform log_sync for every removal =20
> > of =20
> > >>>> IOVA =20
> > >>>>> mapping and then do the translation itself, then avoiding the GPA=
 =20
> > >>>> awareness =20
> > >>>>> in the kernel side. It needs some change to current Qemu log-sync=
 =20
> > >> flow, =20
> > >>>> and =20
> > >>>>> may bring more overhead if IOVA is frequently unmapped.
> > >>>>>
> > >>>>> So we'd like to hear about your opinions, especially about how yo=
u =20
> > >> came =20
> > >>>>> down to the current iotlb approach for vhost. =20
> > >>>> We don't consider too much in the point when introducing vhost. And
> > >>>> before IOTLB, vhost has already know GPA through its mem table
> > >>>> (GPA->HVA). So it's nature and easier to track dirty pages at GPA =
level
> > >>>> then it won't any changes in the existing ABI. =20
> > >>> This is the same situation as VFIO. =20
> > >> It is?  VFIO doesn't know GPAs, it only knows HVA, HPA, and IOVA.  In
> > >> some cases IOVA is GPA, but not all. =20
> > > Well, I thought vhost has a similar design, that the index of its mem=
 table
> > > is GPA when vIOMMU is off and then becomes IOVA when vIOMMU is on.
> > > But I may be wrong here. Jason, can you help clarify? I saw two
> > > interfaces which poke the mem table: VHOST_SET_MEM_TABLE (for GPA)
> > > and VHOST_IOTLB_UPDATE (for IOVA). Are they used exclusively or =20
> > together? =20
> > > =20
> >=20
> > Actually, vhost maintains two interval trees, mem table GPA->HVA, and
> > device IOTLB IOVA->HVA. Device IOTLB is only used when vIOMMU is
> > enabled, and in that case mem table is used only when vhost need to
> > track dirty pages (do reverse lookup of memtable to get HVA->GPA). So in
> > conclusion, for datapath, they are used exclusively, but they need
> > cowork for logging dirty pages when device IOTLB is enabled.
> >  =20
>=20
> OK. Then it's different from current VFIO design, which maintains only
> one tree which is indexed by either GPA or IOVA exclusively, upon=20
> whether vIOMMU is in use.=20

Nit, the VFIO tree is only ever indexed by IOVA.  The MAP_DMA ioctl is
only ever performed with an IOVA.  Userspace decides how that IOVA maps
to GPA, VFIO only needs to know how the IOVA maps to HPA via the HVA.
Thanks,

Alex

