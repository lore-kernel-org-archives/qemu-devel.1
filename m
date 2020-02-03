Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 816BAC35247
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 18:21:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52C3120838
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 18:21:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cs5l0HJZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52C3120838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iygLb-0001d2-Go
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 13:21:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35700)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1iygKM-0000VX-DC
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 13:20:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1iygKK-0002Ol-Uk
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 13:20:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26463
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1iygKK-0002In-8n
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 13:20:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580754001;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3X9Ke/6lhCDOgaCdoimSHbklEKDhb4IMe/P+NV5GSW8=;
 b=cs5l0HJZqwn202mYFkf6YbvMTR7iSl645mXBd3x7Jtl/XT7QRFiOHxQIigXp9585b3z6TV
 Ch40+XxSrtm/2E/Cqye+Q6vjDFmteddwvuJaA4wY9Fm8y+puCXcQn1azMenhs2gALji1hc
 ipDLzKI3ZiVs3j7dY8Y+WUjSAaZGunM=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-pCQyiYDVM-qmco2akliv8w-1; Mon, 03 Feb 2020 13:19:43 -0500
Received: by mail-qt1-f199.google.com with SMTP id a13so10546116qtp.8
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 10:19:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=fIm6vORCNJsGm/WnM7kjpe/TUdEBocbXhFHEzvxfb8c=;
 b=QP3y61DK+VgWShLvZWEs0vllPVXCgrjC1oAhJNSLpISOtrJDpDfcX/k55j8Vq+jpOM
 Pt42JYAfZmXjjp8+uHz7BSWp1QVtLGaQRviCSf9IEw8saVdiN0wvAvcaGFaBuWrPxDVw
 h3Ca/u+/Kg+TEkjF9h+sLW7wWtupOKoHNiUyggIYad36wwZIsU9iweKnhnDw22F20Phu
 733vlxTi+E+k5QQlVV1GpJChVAgS7sGmZSCW1genjKiKQy7YqzMo1xR9L7shpSJpb64x
 TNpkrpLJva6pnij0SqiiPSSn+jlcyQpDb+boJEzwve28aqqXuhPlUPeZ9RLJ8qd+TI6R
 O53Q==
X-Gm-Message-State: APjAAAVPqPhV6S5Znw3U2iERHYocKxrf5VcLiRB6oKC9POcpu6c1yAJu
 XTJjSp9WvRCwN7Xdj5eD/OZiyZw4mleLocO2SgX4tMVG/DQOWl1LB4MFh9GvqU0MnJOyAe2/RR6
 bKdicO0eZPmFXzEw=
X-Received: by 2002:a05:620a:14bc:: with SMTP id
 x28mr24785032qkj.494.1580753982617; 
 Mon, 03 Feb 2020 10:19:42 -0800 (PST)
X-Google-Smtp-Source: APXvYqx3pODFz4dIOJ6Yge4TKI0GBhk7YL/bkyfERRLqZTX8O6RkUppTSnw93qQRQCQ6yeumo5clJA==
X-Received: by 2002:a05:620a:14bc:: with SMTP id
 x28mr24785011qkj.494.1580753982340; 
 Mon, 03 Feb 2020 10:19:42 -0800 (PST)
Received: from xz-x1 ([2607:9880:19c8:32::2])
 by smtp.gmail.com with ESMTPSA id f11sm9625207qkh.96.2020.02.03.10.19.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2020 10:19:41 -0800 (PST)
Date: Mon, 3 Feb 2020 13:19:38 -0500
From: Peter Xu <peterx@redhat.com>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v13 03/10] virtio-iommu: Implement attach/detach command
Message-ID: <20200203181938.GE155875@xz-x1>
References: <20200125171955.12825-1-eric.auger@redhat.com>
 <20200125171955.12825-4-eric.auger@redhat.com>
 <20200203134915.GA155875@xz-x1>
 <ce49f691-d944-2e5e-87a3-7e7c9651c2af@redhat.com>
 <20200203151917.GD155875@xz-x1>
 <5289913a-43fc-aaae-5b82-151922de93bf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <5289913a-43fc-aaae-5b82-151922de93bf@redhat.com>
X-MC-Unique: pCQyiYDVM-qmco2akliv8w-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: peter.maydell@linaro.org, kevin.tian@intel.com, tnowicki@marvell.com,
 quintela@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com, bharatb.linux@gmail.com, qemu-arm@nongnu.org,
 jean-philippe@linaro.org, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Feb 03, 2020 at 06:46:36PM +0100, Auger Eric wrote:
> Hi Peter,
>=20
> On 2/3/20 4:19 PM, Peter Xu wrote:
> > On Mon, Feb 03, 2020 at 03:59:00PM +0100, Auger Eric wrote:
> >=20
> > [...]
> >=20
> >>>> +static void virtio_iommu_detach_endpoint_from_domain(VirtIOIOMMUEnd=
point *ep)
> >>>> +{
> >>>> +    QLIST_REMOVE(ep, next);
> >>>> +    g_tree_unref(ep->domain->mappings);
> >>>
> >>> Here domain->mapping is unreferenced for each endpoint, while at [1]
> >>> below you only reference the domain->mappings if it's the first
> >>> endpoint.  Is that problematic?
> >> in [1] I take a ref to the domain->mappings if it is *not* the 1st
> >> endpoint. This aims at deleting the mappings gtree when the last EP is
> >> detached from the domain.
> >>
> >> This fixes the issue reported by Jean in:
> >> https://patchwork.kernel.org/patch/11258267/#23046313
> >=20
> > Ah OK. :)
> >=20
> > However this is tricky.  How about do explicit g_tree_destroy() in
> > virtio_iommu_detach() when it's the last endpoint?  I see that you
> > have:
> >=20
> >     /*
> >      * when the last EP is detached, simply remove the domain for
> >      * the domain list and destroy it. Note its mappings were already
> >      * freed by the ref count mechanism. Next operation involving
> >      * the same domain id will re-create one domain object.
> >      */
> >     if (QLIST_EMPTY(&domain->endpoint_list)) {
> >         g_tree_remove(s->domains, GUINT_TO_POINTER(domain->id));
> >     }
> >=20
> > Then it becomes:
> >=20
> >     if (QLIST_EMPTY(&domain->endpoint_list)) {
> >         g_tree_destroy(domain->mappings);
> >         g_tree_remove(s->domains, GUINT_TO_POINTER(domain->id));
> >     }
> >=20
> > And also remove the trick in attach() so you take the domain ref
> > unconditionally.  Would that work?
> Yes I think so. On the other hand this ref counting mechanism is also
> made for that purpose of destroying objects without being forced to
> explicitly call the destroy function.

IMHO that's two different things.  g_tree_destroy() should be the same
as g_tree_unref() here when the tree is empty.  It's really a matter
of easy reading of code:

void
g_tree_destroy (GTree *tree)
{
  g_return_if_fail (tree !=3D NULL);

  g_tree_remove_all (tree);
  g_tree_unref (tree);
}

What we really changed here is to allow the ref/unref to be clearly
paired, i.e., for each EP it'll ref once and unref once.  The prvious
solution has the trick in that the 1st EP don't ref, the latter EPs
ref, and when the domain quits it doesn't unref to match the first
ref.  It's error prone to me.  Then, if we can do it in the paired way
easily, I don't see why not...

Thanks,

--=20
Peter Xu


