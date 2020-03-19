Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E21EC4332D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 09:34:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE08F20663
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 09:34:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BPF0S5as"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE08F20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jErZq-0003HJ-0f
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 05:34:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42383)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jErYo-0001zJ-Vq
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 05:33:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1jErYn-0005Cu-6b
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 05:33:54 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:56641)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1jErYm-0005BE-Ro
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 05:33:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584610432;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XxfcN3wn5+hdjg2I55GG60e4psxbEFuubx/X8zB678A=;
 b=BPF0S5asiYY/15yX3fXcQlBq5qAaENQeHdL+KwVKltj6JhWYjK/4btP+MaZ47A9M70vu2n
 qDjg9J7AUv/D6x/UDT9ZnDnHimeKf85qUxf4jowv2M4WVX6T3HpQwNv2APCvi/jhjHLKs/
 2Qrz1QcUmmInHGAqKQWIPDFZbCPcoKo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-Y_yIr_1aPAW8RXNGirTuhQ-1; Thu, 19 Mar 2020 05:33:50 -0400
X-MC-Unique: Y_yIr_1aPAW8RXNGirTuhQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 409EF800D53;
 Thu, 19 Mar 2020 09:33:49 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-49.ams2.redhat.com
 [10.36.112.49])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 92029BBBEE;
 Thu, 19 Mar 2020 09:33:43 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id BD59C3BD; Thu, 19 Mar 2020 10:33:42 +0100 (CET)
Date: Thu, 19 Mar 2020 10:33:42 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 00/13] microvm: add acpi support
Message-ID: <20200319093342.m6fppq4y2qoqefpa@sirius.home.kraxel.org>
References: <20200319080117.7725-1-kraxel@redhat.com>
 <2ed586e7-d7a1-77b2-ecc6-01b6fb38d72e@redhat.com>
MIME-Version: 1.0
In-Reply-To: <2ed586e7-d7a1-77b2-ecc6-01b6fb38d72e@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Mar 19, 2020 at 09:49:55AM +0100, Paolo Bonzini wrote:
> On 19/03/20 09:01, Gerd Hoffmann wrote:
> > I know that not supporting ACPI in microvm is intentional.  If you stil=
l
> > don't want ACPI this is perfectly fine, you can use the usual -no-acpi
> > switch to toggle ACPI support.
>=20
> Could we change -no-acpi into a "-machine acpi=3D..." property?  Then it
> can have type OnOffAuto and we can decide whether to enable it by
> default or not for microvm.

For all machine types not just microvm I guess?

> Also, can you confirm that it builds without CONFIG_I440FX and
> CONFIG_Q35?  You probably need to add "imply ACPI" and possibly some
> '#include "config-devices.h"' and '#ifdef CONFIG_ACPI' here and there.

Didn't try that yet, will do.

cheers,
  Gerd


