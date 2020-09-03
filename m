Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D23C433E7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 06:08:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 075772071B
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 06:08:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="abZokx+Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 075772071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDiQb-0007Wo-7Z
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 02:08:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54304)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1kDiPg-0006dy-Hb
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 02:08:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46834)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1kDiPe-00019p-Qh
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 02:08:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599113277;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xG0a7JPdagd7CBfuFiJ6pmrGfAZt41RrXbhI0jSHVSo=;
 b=abZokx+YnVkQKzlO8tUSzabU1726gFHyhP0d79TP+VBhDmCrnac4j6iHMrhw27PDJ6Efpw
 pve1qudU/jmdBkTo9Y1GwO+HzmO2y+jBIkC22zoxOT6v4snpV7Nq/pEN7BM5j3Kr3uzDul
 AehbrNZiXba8d1sLHEAxtDl3kXnNAAs=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-577-eodfLPfOOe-f2QAcjEzT-Q-1; Thu, 03 Sep 2020 02:07:56 -0400
X-MC-Unique: eodfLPfOOe-f2QAcjEzT-Q-1
Received: by mail-qt1-f200.google.com with SMTP id a14so1453420qtp.15
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 23:07:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=xG0a7JPdagd7CBfuFiJ6pmrGfAZt41RrXbhI0jSHVSo=;
 b=TGiPSqyW0umJEOOttZsWuWVMsbwy+VzlHJn+vBJJEeKJiBL9j46qJ+lP7bCiKLjy6M
 Qb3R/G5sFQTOgBc86G1iVjgs5qXN7+foM3mEnkphJkTknlXM7DoWxv8sIJU1Soaa5/fy
 8FfCtNh2SAu1+zZ61s8gMvETsfHog3CH34EOchUkluW7odIwEZ6M5b0uyAPD0S/wvUZE
 UI9KwojaVb+bnUhdR9lheZtHjaOzVKQyoHQct+pzXw+LT9+M8GW7QTQeCxl8M9N0EzAi
 ldgLTajsfrvyW5DiXUInQfrK7xgyny0Xm6jyxhqzY6+qHTQ1YbiJISUfN+bzdsAWkunR
 i2Ng==
X-Gm-Message-State: AOAM533Boihc3hnwx+vn7Gf83jqy6vHZ5AiRnjwDoGRvD6DyaqLrN1zV
 qknvyyKz4e+kH24u9duYnxGdd0whLmKO1ok027B1/ckuI00ea2UfsWxhGds9zvBQyqi0LDkPhX9
 1uDtwuOAoTqn4XBDOY5jpr44W5g6Sdbk=
X-Received: by 2002:a37:2713:: with SMTP id n19mr1650359qkn.497.1599113275587; 
 Wed, 02 Sep 2020 23:07:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxw2B6VeUYI190LG5kmUvX2831w240Ulzeam6Jt0N51SWaJ9yJJ9L14Z4GfEi3S29PRpFWns+ckIvXsAU7NVbc=
X-Received: by 2002:a37:2713:: with SMTP id n19mr1650342qkn.497.1599113275368; 
 Wed, 02 Sep 2020 23:07:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200901142608.24481-1-eperezma@redhat.com>
 <20200901142608.24481-5-eperezma@redhat.com>
 <20200901210424.GF3053@xz-x1>
In-Reply-To: <20200901210424.GF3053@xz-x1>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 3 Sep 2020 08:07:19 +0200
Message-ID: <CAJaqyWeNkL3Qc11NZcWgFm5vMfhAREf7m0u0zPi2vpDLwkm9zw@mail.gmail.com>
Subject: Re: [RFC v8 4/5] intel_iommu: Do not notify regular iotlb to
 device-iotlb notifiers
To: Peter Xu <peterx@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eperezma@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 01:47:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Yan Zhao <yan.y.zhao@intel.com>, Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Juan Quintela <quintela@redhat.com>, qemu-level <qemu-devel@nongnu.org>,
 Eric Auger <eric.auger@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Avi Kivity <avi@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 1, 2020 at 11:06 PM Peter Xu <peterx@redhat.com> wrote:
>
> On Tue, Sep 01, 2020 at 04:26:07PM +0200, Eugenio P=C3=A9rez wrote:
> > This improves performance in case of netperf with vhost-net:
> > * TCP_STREAM: From 1923.6Mbit/s to 2175.13Mbit/s (13%)
> > * TCP_RR: From 8464.73 trans/s to 8932.703333 trans/s (5.5%)
> > * UDP_RR: From 8562.08 trans/s to 9005.62/s (5.1%)
> > * UDP_STREAM: No change observed (insignificant 0.1% improvement)
>
> Just to confirm: are these numbers about applying this patch before/after=
, or
> applying the whole series before/after?
>
> Asked since we actually optimized two parts:
>
> Firstly we avoid sending two invalidations for vhost.  That's done by the
> previous patch, afaict.
>
> Secondly, this patch avoids the page walk for vhost since not needed.
>
> Am I right?
>

Right! The numbers are comparing v5.1.0 tag to this commit. Avoiding
sending invalidations for vhost did improve performance but in a very
small number, I thought it would improve more.

It also depends a lot on using rhel8 (better numbers, less but
appreciable improvements) or rhel7 guest (worse performance compared
to rhel8 but patches provide more improvements).


> >
> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > ---
> >  hw/i386/intel_iommu.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> > index cdddb089e7..fe82391b73 100644
> > --- a/hw/i386/intel_iommu.c
> > +++ b/hw/i386/intel_iommu.c
> > @@ -1964,6 +1964,12 @@ static void vtd_iotlb_domain_invalidate(IntelIOM=
MUState *s, uint16_t domain_id)
> >      vtd_iommu_unlock(s);
> >
> >      QLIST_FOREACH(vtd_as, &s->vtd_as_with_notifiers, next) {
> > +        if (vtd_as->iommu.iommu_notify_flags & IOMMU_NOTIFIER_DEVIOTLB=
) {
> > +            /* If IOMMU memory region is DEVICE IOTLB type, it does no=
t make
> > +             * sense to send regular IOMMU notifications. */
> > +            continue;
> > +        }
> > +
>
> We want to avoid vtd_sync_shadow_page_table() for vhost, however IMHO a b=
etter
> expression would be:
>
>     if (!(vtd_as->iommu.iommu_notify_flags &
>         (IOMMU_NOTIFIER_MAP | IOMMU_NOTIFIER_UNMAP))) {
>         continue;
>     }
>
> The thing is we can't avoid the page sync if e.g. we're registered with
> MAP|UNMAP|DEVIOTLB.  The important thing here, imho, is MAP|UNMAP because=
 these
> two messages are used for shadow page synchronizations, so we can skip th=
at if
> neither of the message is registered.
>
> Besides, we can add this at the entry of vtd_sync_shadow_page_table() so =
that
> all callers of vtd_sync_shadow_page_table() can benefit.
>

Agree on both. Testing the new changes.

Thanks!



> >          if (!vtd_dev_to_context_entry(s, pci_bus_num(vtd_as->bus),
> >                                        vtd_as->devfn, &ce) &&
> >              domain_id =3D=3D vtd_get_domain_id(s, &ce)) {
> > --
> > 2.18.1
> >
>
> --
> Peter Xu
>
>


