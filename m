Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92333C18E5B
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 09:05:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B62820663
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 09:05:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B0uvF5Ji"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B62820663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH1yj-0004Ga-A3
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 05:05:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49938)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jH1xr-0003lg-Cy
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 05:04:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1jH1xo-00085c-TM
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 05:04:42 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:29084)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1jH1xo-00084r-Nn
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 05:04:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585127080;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JwBIGnuv6rotfSvGzH7i8XelpaSwwUchjRX/WiuKboc=;
 b=B0uvF5JiA69T4hVqVvw+sEt4YFT40mCtGwgnPga0JuAujdDksTHHYtTGmNXyW/Kb6RdCX4
 Kfgd+62K13YywRoqRkfP3bs+XEHbUXKQIs5AZ4unicxFbZgwiIWLDVYh/71MnpwcYW7WGZ
 U2pAp6ONhOWATrdn+1iJUNigaU0+sgo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-176-ksFY_2y-PlSUq3gO9s_aPA-1; Wed, 25 Mar 2020 05:04:38 -0400
X-MC-Unique: ksFY_2y-PlSUq3gO9s_aPA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1A11B800D4E;
 Wed, 25 Mar 2020 09:04:37 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-49.ams2.redhat.com
 [10.36.112.49])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9B0B091D61;
 Wed, 25 Mar 2020 09:04:30 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 6F03217535; Wed, 25 Mar 2020 10:04:29 +0100 (CET)
Date: Wed, 25 Mar 2020 10:04:29 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH 04/13] microvm: add minimal acpi support.
Message-ID: <20200325090429.gx4bpz244w4fcfz7@sirius.home.kraxel.org>
References: <20200319080117.7725-1-kraxel@redhat.com>
 <20200319080117.7725-5-kraxel@redhat.com>
 <20200319150033.13f50947@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200319150033.13f50947@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  Hi,

> > +    {
> > +        AcpiRsdpData rsdp_data =3D {
> > +            .revision =3D 0,
> > +            .oem_id =3D ACPI_BUILD_APPNAME6,
> > +            .xsdt_tbl_offset =3D NULL,
> > +            .rsdt_tbl_offset =3D &rsdt,
> are we interested in 32-bit guests?

Well, sort-of.  seabios runs in 32bit mode.

> if not than maybe use xsdt and newer revision like arm/virt does

Point being?  It's not like we can place the tables above 4G then.

cheers,
  Gerd


