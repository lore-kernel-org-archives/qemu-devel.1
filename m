Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F7BCC2D0EF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 16:10:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00D5C20771
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 16:10:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FTIxAQrY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00D5C20771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPTZ7-0007Kv-3i
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 12:10:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58655)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jPTYD-00068h-Sp
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 12:09:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jPTYB-0004vI-WD
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 12:09:09 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:51442
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jPTYB-0004tK-Qr
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 12:09:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587139746;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g0S7QFP+CVHgNxdQFuggiU/bVlLSo2bymUmVNcV3lsI=;
 b=FTIxAQrYuF9guu3Wz/q+D0wTTPEupG+yrc4moeo7V9mPp7TFYhd6PKfD9X+Lzbn/+yrJSm
 U7NNsDFwHhbe/TDQe7t9P2kCTHinebX1jT5L4bVzOeMfPvAymmPOYK1uwqT2fKE4PFTU6s
 O4wtqkzZ6gREpE2njUZlcBDf2WNv2I0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-9at4eY9vPJalkmjw55tjwg-1; Fri, 17 Apr 2020 12:09:04 -0400
X-MC-Unique: 9at4eY9vPJalkmjw55tjwg-1
Received: by mail-wr1-f70.google.com with SMTP id i10so1243386wrq.8
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2020 09:09:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=H6NNClUmmzsdMk/PF7rOufoHsQR3CrXpOiq3cyvFyDI=;
 b=HrMkJX7UW11sMmDf5gZjnRhegfCirKp1TPRgIx8XoQ57W6iKaRRfz1PJXrgec+AbZG
 K3Wf5XIZCh7opmwKREXpTHIkpI+xOpGx5Ud3K+jg21EaS3zvsfkYctgIJF71cvIvvKHr
 DmtPOGJvsiI4CDGPtPgAkXy/XyAoShtaACb2aHepKPg1Zt09QpSGgefDN12bF/4c/cNT
 7ppB47044FuVVYIZrCP6pYDrK5jrg7zdPFupK2a6Mm55D4l62OSFJqFCRxJgqTOWTvV7
 EthJ/DwU4EFE/9xsTE3B/01ODyTj3gUD2jRVEM75ezBresPnxKVVWRUb2nQ+b8YHghAz
 VUdQ==
X-Gm-Message-State: AGi0PuZu/iLr72SeyYR4XWazWTCj/YPywF1eFopbiDOwtZ92eKbg3G9/
 egq6JS53QzitxWIIhiNGj3TWwmPAcI59FgYDRckm4vVeZgU8XCRUn+YLH9oS7zCrsIFOikloL8r
 ysaUeDLeqPMn7eZw=
X-Received: by 2002:a5d:4b04:: with SMTP id v4mr4975197wrq.358.1587139743547; 
 Fri, 17 Apr 2020 09:09:03 -0700 (PDT)
X-Google-Smtp-Source: APiQypIjmIgdOPk18ekxKkugdoMa+kWa99991YYofEbGMagSZJSyE19I3UscTFqHPNohETPo2RzWGw==
X-Received: by 2002:a5d:4b04:: with SMTP id v4mr4975173wrq.358.1587139743358; 
 Fri, 17 Apr 2020 09:09:03 -0700 (PDT)
Received: from redhat.com (bzq-79-183-51-3.red.bezeqint.net. [79.183.51.3])
 by smtp.gmail.com with ESMTPSA id a125sm1963425wme.3.2020.04.17.09.09.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2020 09:09:02 -0700 (PDT)
Date: Fri, 17 Apr 2020 12:09:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ani Sinha <ani.sinha@nutanix.com>
Subject: Re: [PATCH] Add a new PIIX option to control PCI hot unplugging of
 devices on non-root buses
Message-ID: <20200417120732-mutt-send-email-mst@kernel.org>
References: <1587136411-200885-1-git-send-email-ani.sinha@nutanix.com>
 <20200417112620-mutt-send-email-mst@kernel.org>
 <2A13ACCD-BD24-41FB-B6EA-2804F7C1FF1D@nutanix.com>
MIME-Version: 1.0
In-Reply-To: <2A13ACCD-BD24-41FB-B6EA-2804F7C1FF1D@nutanix.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Apr 17, 2020 at 03:36:14PM +0000, Ani Sinha wrote:
>=20
>=20
> > On Apr 17, 2020, at 8:57 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> >=20
> > Is there a real reason to do this? Can't we just limit the
> > hotplug control to pcie ports? At some point I'd like us to
> > start leaving piix alone..
>=20
> Yes we really need this feature as want to be able to hot plug devices in=
to the guest but prevent customers from hot unplugging them from say Window=
s system tray.
>=20
> ani

Problem is, I think this is not something we can support with pcie or shpc.
I'm reluctant to add features that only ACPI can support,
we are trying to phase that out.
Better ideas?

--=20
MST


