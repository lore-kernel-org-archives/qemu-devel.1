Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2892BC3565B
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 18:46:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7FF824653
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 18:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K3+XswMS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7FF824653
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5DJw-0005e4-1Q
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 13:46:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51775)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1j5DIf-0004av-MR
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 13:45:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1j5DIe-0000P9-7A
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 13:45:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35728
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1j5DIe-0000N0-2G
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 13:45:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582310719;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=quwocIFc9phT3aFeThVm5oPaacCGHoFU6sLWSh9O/YU=;
 b=K3+XswMSw/3fa3TgA50e2tsaHxUNxlAEt3OVta6Z/pe3v+QnE1zMy2lw02g3xyu3M+h5sc
 H757gCGBCsTIb4aY9SNKRMtbL7zJkM6TwYGZmRTiIXzZipcGP8M69LDmuvV5JPnbbO+7LT
 mbpEJEnn+o0cKH6Bghmm+uZY275snkE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-0FlZfv0VNsuijyWaHYXH2w-1; Fri, 21 Feb 2020 13:45:09 -0500
X-MC-Unique: 0FlZfv0VNsuijyWaHYXH2w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8336D107ACC9;
 Fri, 21 Feb 2020 18:45:07 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.1])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 24FC110021B2;
 Fri, 21 Feb 2020 18:45:03 +0000 (UTC)
Date: Fri, 21 Feb 2020 18:45:01 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH v1] block/nvme: introduce PMR support from NVMe 1.4 spec
Message-ID: <20200221184501.GL2931@work-vm>
References: <20200218224811.30050-1-andrzej.jakowski@linux.intel.com>
 <20200221134555.GK1484511@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <20200221134555.GK1484511@stefanha-x1.localdomain>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: kwolf@redhat.com, Haozhong Zhang <haozhong.zhang@intel.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com,
 keith.busch@intel.com, Zhang Yi <yi.z.zhang@linux.intel.com>,
 Andrzej Jakowski <andrzej.jakowski@linux.intel.com>,
 Junyan He <junyan.he@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Stefan Hajnoczi (stefanha@gmail.com) wrote:
> On Tue, Feb 18, 2020 at 03:48:11PM -0700, Andrzej Jakowski wrote:
> > This patch introduces support for PMR that has been defined as part of =
NVMe 1.4
> > spec. User can now specify a pmr_file which will be mmap'ed into qemu a=
ddress
> > space and subsequently in PCI BAR 2. Guest OS can perform mmio read and=
 writes
> > to the PMR region that will stay persistent accross system reboot.
> >=20
> > Signed-off-by: Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
> > ---
> >  hw/block/nvme.c       | 145 ++++++++++++++++++++++++++++++++++-
> >  hw/block/nvme.h       |   5 ++
> >  hw/block/trace-events |   5 ++
> >  include/block/nvme.h  | 172 ++++++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 326 insertions(+), 1 deletion(-)
>=20
> NVDIMM folks, please take a look.  There seems to be commonality here.
>=20
> Can this use -object memory-backend-file instead of manually opening and
> mapping a file?
>=20
> Also CCing David Gilbert because there is some similarity with the
> vhost-user-fs's DAX Window feature where QEMU mmaps regions of files
> into a BAR.

I guess the biggest difference here is that the read can have the side
effect; in my world I don't have to set read/write/endian ops - I just
map a chunk of memory and use memory_region_add_subregion, so all the
read/writes are native read/writes - I assume that would be a lot
faster - I guess it depends if NVME_PMRCAP_PMRWBM is something constant
you know early on; if you know that you don't need to do side effects in
the read you could do the same trick and avoid the IO ops altogether.


Isn't there also a requirement that BARs are powers of two? Wouldn't
you need to ensure the PMR file is a power of 2 in size?

Dave

> > @@ -1303,6 +1327,38 @@ static const MemoryRegionOps nvme_cmb_ops =3D {
> >      },
> >  };
> > =20
> > +static void nvme_pmr_write(void *opaque, hwaddr addr, uint64_t data,
> > +    unsigned size)
> > +{
> > +    NvmeCtrl *n =3D (NvmeCtrl *)opaque;
> > +    stn_le_p(&n->pmrbuf[addr], size, data);
> > +}
> > +
> > +static uint64_t nvme_pmr_read(void *opaque, hwaddr addr, unsigned size=
)
> > +{
> > +    NvmeCtrl *n =3D (NvmeCtrl *)opaque;
> > +    if (!NVME_PMRCAP_PMRWBM(n->bar.pmrcap)) {
> > +        int ret;
> > +        ret =3D msync(n->pmrbuf, n->f_pmr_size, MS_SYNC);
> > +        if (!ret) {
> > +            NVME_GUEST_ERR(nvme_ub_mmiowr_pmrread_barrier,
> > +                       "error while persisting data");
> > +        }
> > +    }
>=20
> Why is msync(2) done on memory loads instead of stores?


--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


