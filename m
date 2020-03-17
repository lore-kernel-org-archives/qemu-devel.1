Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59486C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 14:56:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23C57206EC
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 14:56:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eLsdrCoz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23C57206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEDdn-0000H9-AR
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 10:56:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39669)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jEDcv-0006BE-O3
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 10:55:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jEDct-0007kc-LJ
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 10:55:29 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:23798)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jEDct-0007d9-8Q
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 10:55:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584456926;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lbnrHwPbuZNDbLD0ZIsEFYgVp0jEjyA9pKkel//xrWQ=;
 b=eLsdrCoz5MYsBiRPlzS1LZbeRsPBV9/pMepAS0yj15Bs1wZSr6q2cWWfaRWk6yjn1m68wi
 lRiHJ+esajLib1HLx0vc85tX32swbznmZePFq7HxKk8/A8DMnoSRVbldgLjEKGMCDwZQUX
 nN1H7sLiF1oJT13En75607LFXAFESEg=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-492-Udd_WvgWOymDmEs823-QJg-1; Tue, 17 Mar 2020 10:55:24 -0400
X-MC-Unique: Udd_WvgWOymDmEs823-QJg-1
Received: by mail-qk1-f197.google.com with SMTP id m6so21985212qkm.2
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 07:55:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=v05JXTRCM4dhATfRG8n32Cw4lbTTUrsNlNKmx6iGBsc=;
 b=XQVTPUoIESizdCtsi1X/v8aLow8FnIzZvzYGxpBDA9/n8OIuVSb9hsYv/jQ6e3j4Zw
 4/5BDZSLJsPqVZ3aXMBxZWUl8sOWeWA4EogEKKAytghiBetJ3oVn4Rsgl9hAzYaxOg4D
 YE5QwQvkhQESvovnamPO6YyCY+ASqSftZbxUUPQMESE0nlej+9NEc8Cia18O9fiSUQlf
 37krFk59P03X1JmGqrs1kLTVI2oCZrUk3l4Bkg0gnnIH/IW1ZnvoLzllrTLWOLdAQAgu
 gQdJGhfa0V3xy6wTiiASXCa8MKoZ2tzmzWH/vyrcPPsW8A8LHdnWzuKoaeFmPH1HaOwj
 lbqw==
X-Gm-Message-State: ANhLgQ2TQuzFot1MhubeKv2y+cRDBQ2g0SXqeJXWXUHGDH1H/OxmFsJw
 L5mkML0LkT10JCXhY9zm3XCZKzmNprt+45BW7ZtVJmRq5whorNKFdakxc4igglHELbjaC0/NOLQ
 aWciSPeMtrq7/O/Y=
X-Received: by 2002:ad4:510f:: with SMTP id g15mr5314741qvp.105.1584456924334; 
 Tue, 17 Mar 2020 07:55:24 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvWni5jut5Gib5amArqMACFFTD1Kf5VObIXONLz8nQPIZ5pBbj3h5Y72kq9IlZ0YqkbdvHniw==
X-Received: by 2002:ad4:510f:: with SMTP id g15mr5314719qvp.105.1584456923984; 
 Tue, 17 Mar 2020 07:55:23 -0700 (PDT)
Received: from redhat.com (bzq-79-183-62-79.red.bezeqint.net. [79.183.62.79])
 by smtp.gmail.com with ESMTPSA id
 l12sm2247377qtp.44.2020.03.17.07.55.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2020 07:55:23 -0700 (PDT)
Date: Tue, 17 Mar 2020 10:55:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH V2] vhost: correctly turn on VIRTIO_F_IOMMU_PLATFORM
Message-ID: <20200317105312-mutt-send-email-mst@kernel.org>
References: <20200226115009-mutt-send-email-mst@kernel.org>
 <20200227140215.2d12149c.pasic@linux.ibm.com>
 <20200227104233-mutt-send-email-mst@kernel.org>
 <20200313134446.782c5f7c.pasic@linux.ibm.com>
 <20200313112902-mutt-send-email-mst@kernel.org>
 <20200313163122.GB95517@xz-x1>
 <20200316131723-mutt-send-email-mst@kernel.org>
 <20200316181405.GB184827@xz-x1>
 <20200317022707-mutt-send-email-mst@kernel.org>
 <20200317143904.GC199571@xz-x1>
MIME-Version: 1.0
In-Reply-To: <20200317143904.GC199571@xz-x1>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Tom Lendacky <thomas.lendacky@amd.com>, "Singh,
 Brijesh" <brijesh.singh@amd.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Mar 17, 2020 at 10:39:04AM -0400, Peter Xu wrote:
> On Tue, Mar 17, 2020 at 02:28:42AM -0400, Michael S. Tsirkin wrote:
> > On Mon, Mar 16, 2020 at 02:14:05PM -0400, Peter Xu wrote:
> > > On Mon, Mar 16, 2020 at 01:19:54PM -0400, Michael S. Tsirkin wrote:
> > > > On Fri, Mar 13, 2020 at 12:31:22PM -0400, Peter Xu wrote:
> > > > > On Fri, Mar 13, 2020 at 11:29:59AM -0400, Michael S. Tsirkin wrot=
e:
> > > > > > On Fri, Mar 13, 2020 at 01:44:46PM +0100, Halil Pasic wrote:
> > > > > > > [..]
> > > > > > > > >=20
> > > > > > > > > CCing Tom. @Tom does vhost-vsock work for you with SEV an=
d current qemu?
> > > > > > > > >=20
> > > > > > > > > Also, one can specify iommu_platform=3Don on a device tha=
t ain't a part of
> > > > > > > > > a secure-capable VM, just for the fun of it. And that bre=
aks
> > > > > > > > > vhost-vsock. Or is setting iommu_platform=3Don only valid=
 if
> > > > > > > > > qemu-system-s390x is protected virtualization capable?
> > > > > > > > >=20
> > > > > > > > > BTW, I don't have a strong opinion on the fixes tag. We c=
urrently do not
> > > > > > > > > recommend setting iommu_platform, and thus I don't think =
we care too
> > > > > > > > > much about past qemus having problems with it.
> > > > > > > > >=20
> > > > > > > > > Regards,
> > > > > > > > > Halil
> > > > > > > >=20
> > > > > > > >=20
> > > > > > > > Let's just say if we do have a Fixes: tag we want to set it=
 correctly to
> > > > > > > > the commit that needs this fix.
> > > > > > > >=20
> > > > > > >=20
> > > > > > > I finally did some digging regarding the performance degradat=
ion. For
> > > > > > > s390x the performance degradation on vhost-net was introduced=
 by commit
> > > > > > > 076a93d797 ("exec: simplify address_space_get_iotlb_entry"). =
Before
> > > > > > > IOMMUTLBEntry.addr_mask used to be based on plen, which in tu=
rn was
> > > > > > > calculated as the rest of the memory regions size (from addre=
ss), and
> > > > > > > covered most of the guest address space. That is we didn't ha=
ve a whole
> > > > > > > lot of IOTLB API overhead.
> > > > > > >=20
> > > > > > > With commit 076a93d797 I see IOMMUTLBEntry.addr_mask =3D=3D 0=
xfff which comes
> > > > > > > as ~TARGET_PAGE_MASK from flatview_do_translate(). To have th=
ings working
> > > > > > > properly I applied 75e5b70e6, b021d1c044, and d542800d1e on t=
he level of
> > > > > > > 076a93d797 and 076a93d797~1.
> > > > > >=20
> > > > > > Peter, what's your take on this one?
> > > > >=20
> > > > > Commit 076a93d797 was one of the patchset where we want to provid=
e
> > > > > sensible IOTLB entries and also that should start to work with hu=
ge
> > > > > pages.
> > > >=20
> > > > So the issue bundamentally is that it
> > > > never produces entries larger than page size.
> > > >=20
> > > > Wasteful even just with huge pages, all the more
> > > > so which passthrough which could have giga-byte
> > > > entries.
> > > >=20
> > > > Want to try fixing that?
> > >=20
> > > Yes we can fix that, but I'm still not sure whether changing the
> > > interface of address_space_get_iotlb_entry() to cover adhoc regions i=
s
> > > a good idea, because I think it's still a memory core API and imho it
> > > would still be good to have IOTLBs returned to be what the hardware
> > > will be using (always page aligned IOTLBs).
> >=20
> > E.g. with virtio-iommu, there's no hardware in sight.
> > Even with e.g. VTD page aligned does not mean TARGET_PAGE,
> > can be much bigger.
>=20
> Right. Sorry to be unclear, but I meant the emulated device (in this
> case for x86 it's VT-d) should follow the hardware.  Here the page
> mask is decided by VT-d in vtd_iommu_translate() for PT mode which is
> 4K only.  For another example, ARM SMMU is doing similar thing (return
> PAGE_SIZE when PT enabled, smmuv3_translate()).  That actually makes
> sense to me.  On the other hand, I'm not sure whether there's side
> effect if we change this to cover the whole address space for PT.
>=20
> Thanks,

Well we can translate a batch of entries in a loop, and
as long as VA/PA mappings are consistent, treat the
batch as one.

This is a classical batching approach and not doing this is a classical
reason for bad performance.


> >=20
> > >  Also it would still be
> > > not ideal because vhost backend will still need to send the MISSING
> > > messages and block for each of the continuous guest memory ranges
> > > registered, so there will still be misterious delay.  Not to say
> > > logically all the caches can be invalidated too so in that sense I
> > > think it's as hacky as the vhost speedup patch mentioned below..
> > >=20
> > > Ideally I think vhost should be able to know when PT is enabled or
> > > disabled for the device, so the vhost backend (kernel or userspace)
> > > should be able to directly use GPA for DMA.  That might need some new
> > > vhost interface.
> > >=20
> > > For the s390's specific issue, I would think Jason's patch an simple
> > > and ideal solution already.
> > >=20
> > > Thanks,
> > >=20
> > > >=20
> > > >=20
> > > > >  Frankly speaking after a few years I forgot the original
> > > > > motivation of that whole thing, but IIRC there's a patch that was
> > > > > trying to speedup especially for vhost but I noticed it's not mer=
ged:
> > > > >=20
> > > > > https://lists.gnu.org/archive/html/qemu-devel/2017-06/msg00574.ht=
ml
> > > > >=20
> > > > > Regarding to the current patch, I'm not sure I understand it
> > > > > correctly, but is that performance issue only happens when (1) th=
ere's
> > > > > no intel-iommu device, and (2) there is iommu_platform=3Don speci=
fied
> > > > > for the vhost backend?
> > > > >=20
> > > > > If so, I'd confess I am not too surprised if this fails the boot =
with
> > > > > vhost-vsock because after all we speicified iommu_platform=3Don
> > > > > explicitly in the cmdline, so if we want it to work we can simply
> > > > > remove that iommu_platform=3Don when vhost-vsock doesn't support =
it
> > > > > yet...  I thougth iommu_platform=3Don was added for that case - w=
hen we
> > > > > want to force IOMMU to be enabled from host side, and it should a=
lways
> > > > > be used with a vIOMMU device.
> > > > >=20
> > > > > However I also agree that from performance POV this patch helps f=
or
> > > > > this quite special case.
> > > > >=20
> > > > > Thanks,
> > > > >=20
> > > > > --=20
> > > > > Peter Xu
> > > >=20
> > >=20
> > > --=20
> > > Peter Xu
> >=20
>=20
> --=20
> Peter Xu


