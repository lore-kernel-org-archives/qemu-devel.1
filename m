Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99CBFC33C9E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 18:08:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E597214AF
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 18:08:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BRgtXsAD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E597214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irQcE-0005Vj-Cp
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 13:08:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49867)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1irQbQ-0004n1-MN
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 13:07:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1irQbN-0000YU-IS
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 13:07:44 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39063
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1irQbN-0000Y6-Ew
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 13:07:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579025260;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b0D2Zk5nViE/KJPekemIqHSmsw4Q4A+PCozkh7KIb4M=;
 b=BRgtXsADLeywyRw1sYaaycYUFtoAvFmNsdjfsL89ubnGYqjkw0R99/U3u9RyncNeD69NnC
 d1u4o8GFC+TvlJLZFj70pAe/7F3XOw3a0ICyYDIIyR2wRm0DDBbCKmXT3uUG1zIFjH8kbU
 /bjoSG4E+42ueulQIX2mgrZQ0ctgo4s=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-QU_XB2M4NrKZ2nV5hf5-DQ-1; Tue, 14 Jan 2020 13:07:37 -0500
Received: by mail-qk1-f200.google.com with SMTP id k10so8880491qki.2
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2020 10:07:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=7kAoMg/jig+jnyuJ7iufD/gl40iBEov1qz8zo/twzMg=;
 b=UQUOQsl4OGGEVYPIMphQJNGdV1sDKgXk8FFJEw9IeBf1vLeRHenJh+ukSI2xCnd0qa
 WY+x7WuAuXo9eMxfcIfUlktJN0gks4JOP4POr4tPV4rwYJ6+D1fOmraaydQ8PqgqPA6p
 yvFjzlzs3Yyo5xX/gjR0fxJPjRPmrWygqfjobfbuXarA0dbXm02K0jbibRQjd14t4eHU
 IDVJZFbVzQ00RUxeqc2zKVtaaROhbhzNzPg2O/4oVyIkFJUhVCE/dDV7+e5gKUrB28XG
 0scBsQWto4o10e2AruKk4MXOZJv37kf0yYkTGC1af0y/Q7Pkv40X52Xeauw0N98osB5w
 Tqqw==
X-Gm-Message-State: APjAAAXTgFoyIOkMHKnP+Q0Av32CceOS+xXW73UyXBS1uhihilb6wU1q
 A0LgZOEAz0wv9fEcp4IF/OH5G8lLPREPOjDqb6CXSx/R8Ksneu6x3k3+7af3t6YvkigRMuMXZ/i
 FTrK6PdNeE6a9FIw=
X-Received: by 2002:ac8:148b:: with SMTP id l11mr4828835qtj.390.1579025256695; 
 Tue, 14 Jan 2020 10:07:36 -0800 (PST)
X-Google-Smtp-Source: APXvYqz1EIeYJnsbVdFfDtknAh5bhN4FjvW+tK3jD/rS8W49NP8ePxZ8R8X9Flw/gbMO+0kN1fkJeQ==
X-Received: by 2002:ac8:148b:: with SMTP id l11mr4828815qtj.390.1579025256485; 
 Tue, 14 Jan 2020 10:07:36 -0800 (PST)
Received: from xz-x1 ([104.156.64.74])
 by smtp.gmail.com with ESMTPSA id d71sm7078517qkg.4.2020.01.14.10.07.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2020 10:07:35 -0800 (PST)
Date: Tue, 14 Jan 2020 13:07:34 -0500
From: Peter Xu <peterx@redhat.com>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v12 05/13] virtio-iommu: Endpoint and domains structs and
 helpers
Message-ID: <20200114180734.GB225163@xz-x1>
References: <20200109144319.15912-1-eric.auger@redhat.com>
 <20200109144319.15912-6-eric.auger@redhat.com>
 <20200113202301.GD201624@xz-x1>
 <51267d84-c805-a4a1-8084-b278721a5b3f@redhat.com>
MIME-Version: 1.0
In-Reply-To: <51267d84-c805-a4a1-8084-b278721a5b3f@redhat.com>
X-MC-Unique: QU_XB2M4NrKZ2nV5hf5-DQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: peter.maydell@linaro.org, kevin.tian@intel.com, tnowicki@marvell.com,
 jean-philippe@linaro.org, quintela@redhat.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com, bharatb.linux@gmail.com, qemu-arm@nongnu.org,
 mst@redhat.com, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jan 14, 2020 at 09:51:59AM +0100, Auger Eric wrote:
> Hi Peter,

Hi, Eric,

[...]

> >=20
> >> +{
> >> +    VirtIOIOMMUEndpoint *ep;
> >> +
> >> +    ep =3D g_tree_lookup(s->endpoints, GUINT_TO_POINTER(ep_id));
> >> +    if (ep) {
> >> +        return ep;
> >> +    }
> >> +    if (!virtio_iommu_mr(s, ep_id)) {
> >=20
> > Could I ask when this will trigger?
>=20
> This can happen when a device is attached to a domain and its RID does
> not correspond to one of the devices protected by the iommu.

So will it happen only because of a kernel driver bug?

Also, I think the name of "virtio_iommu_mr" is confusing on that it
returned explicitly a MemoryRegion however it's never been used:

(since they're not in the same patch I'm pasting)

static IOMMUMemoryRegion *virtio_iommu_mr(VirtIOIOMMU *s, uint32_t sid)
{
    uint8_t bus_n, devfn;
    IOMMUPciBus *iommu_pci_bus;
    IOMMUDevice *dev;

    bus_n =3D PCI_BUS_NUM(sid);
    iommu_pci_bus =3D iommu_find_iommu_pcibus(s, bus_n);
    if (iommu_pci_bus) {
        devfn =3D sid & 0xFF;
        dev =3D iommu_pci_bus->pbdev[devfn];
        if (dev) {
            return &dev->iommu_mr;
        }
    }
    return NULL;
}

Maybe "return !!dev" would be enough, then make the return a boolean?
Then we can rename it to virtio_iommu_has_device().

PS. I think we can also drop IOMMU_PCI_DEVFN_MAX (after all you even
didn't use it here!) and use PCI_DEVFN_MAX, and replace 0xFF.

Thanks,

--=20
Peter Xu


