Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B28FC35247
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 16:38:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA3E52084E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 16:38:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OILfGDNg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA3E52084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iz1DF-00075N-Oj
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 11:38:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56941)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iz1Ax-0004lr-Vb
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 11:35:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iz1Aw-0000no-J3
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 11:35:47 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:40987
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iz1Aw-0000jm-Ec
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 11:35:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580834144;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XSgC84icQ/wBgmcf5haCbJpws9LSYyLFwtxis8QR+oM=;
 b=OILfGDNgaWcWoXWWZ+up1HJNczIdT9DGc7zYBfsPLw8eId2IU20ZBcGeaGPRl8eJAodSda
 FVMX0SdKwk/flZvlCv2Yy6aqF6B7De8fcLyXMtERAFVFSJGeeuuTBWb7GJXo3gt8B9yVcH
 NI8ewM3mWIIk3AVP80WgCfJbsIDcMOE=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-10-YsJcqXvEO4uyt6lh6vRmSQ-1; Tue, 04 Feb 2020 11:35:42 -0500
Received: by mail-qv1-f71.google.com with SMTP id p3so12036802qvt.9
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2020 08:35:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=cKlaznnxeyTZ2PrUbRVAnKf+C27TZOwI8FwyQQsX3Zc=;
 b=MILq7kjmaJxVLas1esnA2hidS16wJWu4vLWfMQ6zaSX31WH5Kg/Hj1fHTvOZOjs7rM
 Og1T18Q75o+oNj516nGsHCj8/SX0QihGEOGgRrGt1Qj7+N3bE6dMrs3vJ6naQQ7nkEhf
 ssINc7prZOuCr59oaXqybIsrg08mPxc+Ro7jNw9DEZg2GLKsyL1dQRU59Pe2GdOGqX2d
 ghbZhMGMZx+lxiL7sfRIhSSgjUd1hzkkCL+mnz98lwDVatLz1hKElCZaV8uISAYFTQ2M
 NK5uFw3Hmay2cdtxiTUTVjBdv5jBOzNXkyPHKdLX/sdGY/tRe5N2lxTKCTaT7xi+F2VL
 v6Fg==
X-Gm-Message-State: APjAAAUZ/oA4oBQ/dX6c0A+Ig1FUlb6O8xsRNTTK/tOsjvJ5nw/u/j9x
 Z0iQc2ecUvaHScBvfNauluwKHcv6qDc7JHOMBioEtFVQI8BUoGxYea2XHTHS4j59hJbbHdCZMOk
 oXtqPsySlsS/Mnp4=
X-Received: by 2002:ac8:6b4f:: with SMTP id x15mr29060173qts.152.1580834142492; 
 Tue, 04 Feb 2020 08:35:42 -0800 (PST)
X-Google-Smtp-Source: APXvYqwUoldSuV5+ufVddMYHwlWVYp43Q8ARL4moShoY6KScPHHk4wcnsFacAuO4Qfo2W5sK3VkfPg==
X-Received: by 2002:ac8:6b4f:: with SMTP id x15mr29060165qts.152.1580834142248; 
 Tue, 04 Feb 2020 08:35:42 -0800 (PST)
Received: from redhat.com (bzq-79-176-41-183.red.bezeqint.net. [79.176.41.183])
 by smtp.gmail.com with ESMTPSA id f11sm11260658qkh.96.2020.02.04.08.35.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2020 08:35:41 -0800 (PST)
Date: Tue, 4 Feb 2020 11:35:37 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Julia Suvorova <jusual@redhat.com>
Subject: Re: Disabling PCI "hot-unplug" for a guest (and/or a single PCI
 device)
Message-ID: <20200204113457-mutt-send-email-mst@kernel.org>
References: <16db1dcd-d1a3-5bd9-2daa-d16a0f2d168e@redhat.com>
 <20200204013947-mutt-send-email-mst@kernel.org>
 <CAMDeoFVkoTZSQ=PV=mc_AGoZ445Wug4F+RV5utaYb+jhPEtkJg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAMDeoFVkoTZSQ=PV=mc_AGoZ445Wug4F+RV5utaYb+jhPEtkJg@mail.gmail.com>
X-MC-Unique: YsJcqXvEO4uyt6lh6vRmSQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: libvir-list@redhat.com, qemu-devel@nongnu.org,
 Laine Stump <laine@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Feb 04, 2020 at 05:13:54PM +0100, Julia Suvorova wrote:
> On Tue, Feb 4, 2020 at 11:26 AM Michael S. Tsirkin <mst@redhat.com> wrote=
:
> >
> > On Mon, Feb 03, 2020 at 05:19:51PM -0500, Laine Stump wrote:
> > > 3) qemu could add a "hotpluggable=3Dno" commandline option to all PCI=
 devices
> > > (including vfio-pci) and then do whatever is necessary to make sure t=
his is
> > > honored in the emulated hardware (is it possible to set this on a per=
-slot
> > > basis in a PCI controller? Or must it be done for an entire controlle=
r?
> >
> > I think it's possible on a per-slot basis, yes.
>=20
> There's a "Hot-Plug Capable" option in Slot Capability register, so we
> can switch it off. But it's only for pcie devices, can't say anything
> about conventional pci.
>=20
> Best regards, Julia Suvorova.

For conventional PCI, we can drop SHPC capability and remove
the eject method from ACPI.


