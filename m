Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 056CCC5ACD7
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 20:38:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C93A420714
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 20:38:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dQim3IbT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C93A420714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEIyR-0008E9-UA
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 16:38:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54272)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jEIxZ-0007GB-Oo
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 16:37:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1jEIxY-0007aI-Ll
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 16:37:09 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:44043)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1jEIxY-0007WS-GY
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 16:37:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584477428;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ItVAuHD+XdKiTqum/PLO2Snxg3UvjYq75JyUf3dp34I=;
 b=dQim3IbTs/5AjEaOKdcxdHpVKP4pJtZFlLeE/UPjhyOL6ADhd4zy0tkh6f6IfDyzCetHOG
 DWYUyN4deYNmv4cbetWXRsn2Zrp06leQpCOTrOSHeS1yAoSOMmxy/X9i1qbMXxLHHKEOgk
 1JqGwccvq+OKdIT+rquivyeKn4eXvF4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-JI1h1b8UPpuPrtATTyxCKQ-1; Tue, 17 Mar 2020 16:37:05 -0400
X-MC-Unique: JI1h1b8UPpuPrtATTyxCKQ-1
Received: by mail-wr1-f69.google.com with SMTP id t4so8294101wrv.9
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 13:37:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=JdAyyF/FwTMWBTq6jvhI5/YqCfhuYwnxedj032Did7c=;
 b=ITgvljuOomx+RAT/BgstRUeSxkzB4TYsg1WCUpD8FNqoZeSZ+zJ8FP6wWBdFQhJXFM
 iCZPUGXnh3B5yU/9VyIufhUULMoNpiDGSLG9gve0sXb73dphwL/sEwJrF5d8z5D6f0WQ
 E7SY8CFs/5TNqa3Q00C4fJhOqcRx2aHl26rPIU7rwZGhwemFfe9aMg6pHlzgFdeKwLs3
 Nxd9yus92HK9ciz2bfyh1IkqZZYQQrhB4NaVKVgX91TkNJV3CjxObRpII2amrk0riI9P
 hwYyw/S81lEMpK0kFafocWmWLXuvKiagw0/PO50Gce5T7wn+wHiUzOHNrtZs+XezHqi8
 6cNg==
X-Gm-Message-State: ANhLgQ3fbIMTBcOr3MRIKJtpI/Z5uT9N6w2c94HeWxOUn7L4qd1h/AON
 7mUmhm9zkiveKNaQUXgOwzY3rU41iRW9KFwSO8OpEtM7NRY+liXid5OfgKytSzQtnJSozgc1FJD
 hf4STJ1S9cJIpxwg=
X-Received: by 2002:a5d:6386:: with SMTP id p6mr825315wru.194.1584477423273;
 Tue, 17 Mar 2020 13:37:03 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsf3TG247ecpCsD1lOMqz6gChii/0iJOKghgeUrYAKVnMsyo8mWiNXeAV1mW6u5/QD15fHyJQ==
X-Received: by 2002:a5d:6386:: with SMTP id p6mr825295wru.194.1584477423088;
 Tue, 17 Mar 2020 13:37:03 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id k126sm789206wme.4.2020.03.17.13.37.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2020 13:37:02 -0700 (PDT)
Date: Tue, 17 Mar 2020 16:36:59 -0400
From: Peter Xu <peterx@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH] pci: Display PCI IRQ pin in "info pci"
Message-ID: <20200317203659.GC233068@xz-x1>
References: <20200317195908.283800-1-peterx@redhat.com>
 <20200317202117.GI3369@work-vm>
MIME-Version: 1.0
In-Reply-To: <20200317202117.GI3369@work-vm>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Mar 17, 2020 at 08:21:17PM +0000, Dr. David Alan Gilbert wrote:
> * Peter Xu (peterx@redhat.com) wrote:
> > Sometimes it would be good to be able to read the pin number along
> > with the IRQ number allocated.  Since we'll dump the IRQ number, no
> > reason to not dump the pin information.  For example, the vfio-pci
> > device will overwrite the pin with the hardware pin number.  It would
> > be nice to know the pin number of one assigned device from QMP/HMP.
> >=20
> > CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > CC: Alex Williamson <alex.williamson@redhat.com>
> > CC: Michael S. Tsirkin <mst@redhat.com>
> > CC: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> > CC: Julia Suvorova <jusual@redhat.com>
> > CC: Markus Armbruster <armbru@redhat.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >=20
> > This helped me to debug an IRQ sharing issue, so may good to have it
> > in master too.
> > ---
> >  hw/pci/pci.c       | 1 +
> >  monitor/hmp-cmds.c | 3 ++-
> >  qapi/misc.json     | 6 ++++--
> >  3 files changed, 7 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> > index e1ed6677e1..7ebf532ac9 100644
> > --- a/hw/pci/pci.c
> > +++ b/hw/pci/pci.c
> > @@ -1769,6 +1769,7 @@ static PciDeviceInfo *qmp_query_pci_device(PCIDev=
ice *dev, PCIBus *bus,
> >      info->regions =3D qmp_query_pci_regions(dev);
> >      info->qdev_id =3D g_strdup(dev->qdev.id ? dev->qdev.id : "");
> > =20
> > +    info->irq_pin =3D dev->config[PCI_INTERRUPT_PIN];
> >      if (dev->config[PCI_INTERRUPT_PIN] !=3D 0) {
> >          info->has_irq =3D true;
> >          info->irq =3D dev->config[PCI_INTERRUPT_LINE];
> > diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
> > index 58724031ea..04c86bbb03 100644
> > --- a/monitor/hmp-cmds.c
> > +++ b/monitor/hmp-cmds.c
> > @@ -680,7 +680,8 @@ static void hmp_info_pci_device(Monitor *mon, const=
 PciDeviceInfo *dev)
> >      }
> > =20
> >      if (dev->has_irq) {
> > -        monitor_printf(mon, "      IRQ %" PRId64 ".\n", dev->irq);
> > +        monitor_printf(mon, "      IRQ %" PRId64 ", pin %c\n",
> > +                       dev->irq, (char)('A' + dev->irq_pin - 1));
>=20
> Can we trust dev->irq_pin not to be something silly and generate a
> non-printable?

It should be strictly a value between 1-4 corresponds to irq pin A-D
(note the has_irq check masked out the zero value, or it could be
0-4), so I think it should always make sense. Otherwise I see it a
qemu bug somewhere...

Thanks,

--=20
Peter Xu


