Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B27B6C4332B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 10:24:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79D5120658
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 10:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W27SgD41"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79D5120658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGKFv-0002jK-L7
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 06:24:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60593)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jGKFM-0002Aq-Sm
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 06:23:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1jGKFL-00022o-Vz
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 06:23:52 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:50875)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1jGKFL-00022Z-T5
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 06:23:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584959031;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=daDnbBNoHF11R61Pi4ceqAtvjN+hB7a/SCk81WqvW3M=;
 b=W27SgD41xDT0Si0eDwTVIgM8ZnVCaaofRzwO4bKoUuzkXvmMrcLfiPHEVX9/4tzQCT6JUJ
 pXDdlUF7Fc9KJMpJsCkjqXPa+P5/5HQsZAyTVN3zApfsZe2YTJLA1QV9OorsPVGeUstITj
 U1pUlTYYakY4OdI+sDLEXwb+s9EcnAA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-439-_Jv2WlICMba5qzRnWcfd-Q-1; Mon, 23 Mar 2020 06:23:47 -0400
X-MC-Unique: _Jv2WlICMba5qzRnWcfd-Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 76D21800D48;
 Mon, 23 Mar 2020 10:23:46 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-49.ams2.redhat.com
 [10.36.112.49])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 18ED010027AF;
 Mon, 23 Mar 2020 10:23:46 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 540E817449; Mon, 23 Mar 2020 11:23:45 +0100 (CET)
Date: Mon, 23 Mar 2020 11:23:45 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH 13/13] microvm/acpi: use GSI 16-23 for virtio
Message-ID: <20200323102345.so4l25ya67nvz6l5@sirius.home.kraxel.org>
References: <20200319080117.7725-1-kraxel@redhat.com>
 <20200319080117.7725-14-kraxel@redhat.com>
 <20200320153016.GK4541@char.us.oracle.com>
MIME-Version: 1.0
In-Reply-To: <20200320153016.GK4541@char.us.oracle.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Mar 20, 2020 at 11:30:16AM -0400, Konrad Rzeszutek Wilk wrote:
> On Thu, Mar 19, 2020 at 09:01:17AM +0100, Gerd Hoffmann wrote:
> > With ACPI enabled and IO-APIC being properly declared in the ACPI table=
s
> > we can use interrupt lines 16-23 for virtio and avoid shared interrupts=
.
>=20
> 7 interrupt lines? Is there a specific requirements of which
> ones should be assigned to what device?

8 lines (23 is inclusive), one for each virtio device.  It wouldn't give
you separate config change or per-queue interrupts (I think virtio-mmio
doesn't support that).  It only avoids sharing interrupts with legacy
pc devices like rtc and acpi.

cheers,
  Gerd


