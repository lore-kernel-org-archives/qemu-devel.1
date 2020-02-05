Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14FE3C35254
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 13:13:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4E03217BA
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 13:13:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F65fhlra"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4E03217BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izKUF-0005uB-V1
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 08:12:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55961)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1izKS6-0004ZW-Pu
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 08:10:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1izKS5-00045m-Dv
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 08:10:46 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:44265
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1izKS5-0003tm-3f
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 08:10:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580908243;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=//iO38SNUFBf2sVgdCFlvKEtY7M2nNpSz7rbex5YuOY=;
 b=F65fhlrat8qabgLpT1eXlbuWrA4WVzkRPrlga5Eq2XEon2Ke/K7aNx66CRlINUH/xSksfY
 fHsbdfvKgBoJd5loM4Mv9/v2Qp9QeH1LFmf+fEyLohjMId+vA0/V+JjbrXXoP7+zqhzOkR
 ph3rUZ9PChEzo+FZJe9u5mAt+MrvJ5M=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-175-1Q321mvgO56yezy61NHZwg-1; Wed, 05 Feb 2020 08:10:36 -0500
Received: by mail-qk1-f200.google.com with SMTP id v2so1235785qkf.4
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2020 05:10:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=XNwzOL1zKzZ/u0+0Rk4vNAB9be5A442O/9OkSVKGp5c=;
 b=gjUzNLhZbJ/stes/WL+sv0SS/5Hd3RRIVUK+p7sQuBis0/BivV+t7YwXKDUcpl6qgq
 u64VBNo5tAQvBGmy3BWK//u+1y5rR2+RpDCnxFhvcF7MHdDAMk3vQLAiNt1mlr725NzX
 yNfhJXXFZj8qguWg+kDJAQfYflIRSC6qYvFEFePApVgJ4j3oxPUrZf8npXNSUXBJEtGI
 99kbUcvbgyJsmKsw5n88aIuq0kYkygUSvApV159nHKMeWe3c4bIlW0bd9R3oIkxhfqxa
 QV5xMHmN8tMivJeu0MsxtwWQ7vKVmMaVllDiMGEQM/vmU/AQ8dCMiWecz+0KPQLkXpAR
 hyxA==
X-Gm-Message-State: APjAAAUkFUU0d+GU3+c1YoNTr/6Ue0XeKxpY3BFnyo6TgifOasKTY4wy
 suR4HglpWQlsylT2itaHGi0K0pgUqmsG+c0WoF7W7JhUbsOSsPbj4iGRz/4+nmxYci83kVP1ArX
 cDrmNB2aJJQgIbCo=
X-Received: by 2002:a05:620a:1005:: with SMTP id
 z5mr33150174qkj.26.1580908235714; 
 Wed, 05 Feb 2020 05:10:35 -0800 (PST)
X-Google-Smtp-Source: APXvYqx08oiq6vHhHUfIemMGEHEvI7zsMwVnWKjPCWYpQXjQtnqoTy4wf0muRbLjq0g76qZDPXAcjQ==
X-Received: by 2002:a05:620a:1005:: with SMTP id
 z5mr33150151qkj.26.1580908235435; 
 Wed, 05 Feb 2020 05:10:35 -0800 (PST)
Received: from redhat.com (bzq-79-176-41-183.red.bezeqint.net. [79.176.41.183])
 by smtp.gmail.com with ESMTPSA id 63sm12791963qki.57.2020.02.05.05.10.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2020 05:10:34 -0800 (PST)
Date: Wed, 5 Feb 2020 08:10:30 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: Disabling PCI "hot-unplug" for a guest (and/or a single PCI
 device)
Message-ID: <20200205080952-mutt-send-email-mst@kernel.org>
References: <16db1dcd-d1a3-5bd9-2daa-d16a0f2d168e@redhat.com>
 <20200204013947-mutt-send-email-mst@kernel.org>
 <CAMDeoFVkoTZSQ=PV=mc_AGoZ445Wug4F+RV5utaYb+jhPEtkJg@mail.gmail.com>
 <20200204113457-mutt-send-email-mst@kernel.org>
 <20200205113637.GE2221087@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200205113637.GE2221087@redhat.com>
X-MC-Unique: 1Q321mvgO56yezy61NHZwg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: libvir-list@redhat.com, Julia Suvorova <jusual@redhat.com>,
 qemu-devel@nongnu.org, Laine Stump <laine@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Feb 05, 2020 at 11:36:37AM +0000, Daniel P. Berrang=E9 wrote:
> On Tue, Feb 04, 2020 at 11:35:37AM -0500, Michael S. Tsirkin wrote:
> > On Tue, Feb 04, 2020 at 05:13:54PM +0100, Julia Suvorova wrote:
> > > On Tue, Feb 4, 2020 at 11:26 AM Michael S. Tsirkin <mst@redhat.com> w=
rote:
> > > >
> > > > On Mon, Feb 03, 2020 at 05:19:51PM -0500, Laine Stump wrote:
> > > > > 3) qemu could add a "hotpluggable=3Dno" commandline option to all=
 PCI devices
> > > > > (including vfio-pci) and then do whatever is necessary to make su=
re this is
> > > > > honored in the emulated hardware (is it possible to set this on a=
 per-slot
> > > > > basis in a PCI controller? Or must it be done for an entire contr=
oller?
> > > >
> > > > I think it's possible on a per-slot basis, yes.
> > >=20
> > > There's a "Hot-Plug Capable" option in Slot Capability register, so w=
e
> > > can switch it off. But it's only for pcie devices, can't say anything
> > > about conventional pci.
> > >=20
> > > Best regards, Julia Suvorova.
> >=20
> > For conventional PCI, we can drop SHPC capability and remove
> > the eject method from ACPI.
>=20
> Before considering this, is there any compelling reason to care about
> this for PCI ?

Not that I know. I simply answered Julia's question.

> Currently with i440fx there's no direct representation
> of the 32 slots as objects in either QEMU or libvirt. So extending this
> to allow disabling hotplug for i440fx PCI slots is going to need much
> more config work for QEMU, libvirt and mgmt apps.  Personally I'd only
> do this for PCIe until there's a clear requirement given for legacy PCI
> support too.

Makes sense to me.

> Regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|


