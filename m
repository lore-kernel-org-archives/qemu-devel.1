Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 946B0C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 13:50:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DEBF2467E
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 13:50:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a/by5EVb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DEBF2467E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihwCJ-0007bI-JL
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 08:50:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40933)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1ihvt7-0005YK-Hy
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:30:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1ihvt6-0000cW-Nd
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:30:45 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:54943
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1ihvt5-0000Z2-Qy
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:30:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576762243;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O0kkToBSsV4lC7fUOrXQnyUufjTfp/jAHZI7pYL7RFo=;
 b=a/by5EVbHK9CB/1Qk9tjJwkVOH/kw+DGbq+C5UfJO1ZrYlzMkt99/PsQon0JG5rFRA3N+Y
 7tpt1T7BvX8yrGw0oH+EaMWc95e364z9ihllaFSe8f6wuaeJD8th+bOQ9sH3iLZOlQURIB
 TcuoktFieIFmIabqIjTUFPcAipf2M1g=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-t1eZJVyeNjek26QAQRjlzQ-1; Thu, 19 Dec 2019 08:30:41 -0500
Received: by mail-qk1-f199.google.com with SMTP id i135so2946033qke.14
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 05:30:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=e58ZDOEpQ/Xl9I50RD0ywf5riBr5Vg9Ex8K5Of0ACys=;
 b=JB6DKS4D7p7Jhz19YT1f3oACJFe5617z/To1fiksSJifScLhZiC4H69IX8lQXQWeW/
 Vz/bVaUfL1i78ni3lBENvsyUh3BbHiI7ETHMWUh0SJjarp5Lbd9Nz+LyNAFIvCBkWFI7
 QVQjCL8osmOEmNRgtMycJ/GbbavZZYGK2p2pePIZt+265EbWlgcyGEC1TW+Jv1Ic83oe
 NRii+bPoa6WY66KUUPu8xNEywKvrGHqmz5tFgY0QxEzH7K4uXeat3b338AbZT4/s7Noz
 xxiAvmzDoeI+Ee2b8jLbE+q2jM7l/Q3hafaZX2omyZuhU5k+7Uiiy8Z/XrQngbJMcyMV
 zjqw==
X-Gm-Message-State: APjAAAV2k1WFgGrRqiUhnXOmg7VfpkvYr8wHNqHHun/jDdkh1gwxgGEF
 MXuCaDXyJ6JRky13zW0/7Pse2gwVBQLoE9q0NXjttOFanTafO8x4TM0n8jHixzMOBucdJhuKWiU
 SZhGptxOddYF0Mek=
X-Received: by 2002:aed:3c5b:: with SMTP id u27mr7026476qte.287.1576762241220; 
 Thu, 19 Dec 2019 05:30:41 -0800 (PST)
X-Google-Smtp-Source: APXvYqz3DkQhEzi9sCEUdm1EEP+LSL9jhx9eOYILP2Rca+G0zwtavbxBG8BpLUDFvu2iVyeOPNYoWA==
X-Received: by 2002:aed:3c5b:: with SMTP id u27mr7026462qte.287.1576762241078; 
 Thu, 19 Dec 2019 05:30:41 -0800 (PST)
Received: from redhat.com (bzq-79-181-48-215.red.bezeqint.net. [79.181.48.215])
 by smtp.gmail.com with ESMTPSA id m27sm1882093qta.21.2019.12.19.05.30.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2019 05:30:38 -0800 (PST)
Date: Thu, 19 Dec 2019 08:30:34 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH 0/2] numa: stop abusing numa_mem_supported
Message-ID: <20191219083024-mutt-send-email-mst@kernel.org>
References: <1576154936-178362-1-git-send-email-imammedo@redhat.com>
 <20191219142851.42cd33ff@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191219142851.42cd33ff@redhat.com>
X-MC-Unique: t1eZJVyeNjek26QAQRjlzQ-1
X-Mimecast-Spam-Score: 0
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
Cc: pbonzini@redhat.com, Tao Xu <tao3.xu@intel.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Dec 19, 2019 at 02:28:51PM +0100, Igor Mammedov wrote:
> On Thu, 12 Dec 2019 13:48:54 +0100
> Igor Mammedov <imammedo@redhat.com> wrote:
>=20
> > A fix  and cleanup for a mistakes that slipped by me in
> >   aa57020774 (numa: move numa global variable nb_numa_nodes into Machin=
eState)
>=20
> ping,
>=20
> could someone pick it up please?

Looks more like Eduardo's thing.

> >=20
> >=20
> > CC: Eduardo Habkost <ehabkost@redhat.com>
> > CC: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> > CC: Tao Xu <tao3.xu@intel.com>
> >=20
> > Igor Mammedov (2):
> >   numa: remove not needed check
> >   numa: properly check if numa is supported
> >=20
> >  hw/arm/sbsa-ref.c | 1 -
> >  hw/core/machine.c | 4 ++--
> >  hw/core/numa.c    | 7 +------
> >  3 files changed, 3 insertions(+), 9 deletions(-)
> >=20


