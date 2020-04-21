Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E934C2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 09:17:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDAD920857
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 09:17:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="irjq4ICp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDAD920857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQp1a-0001lE-5E
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 05:17:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33252)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jQp0q-00014o-As
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 05:16:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jQp0c-0003Ad-5H
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 05:16:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56879
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jQp0b-000376-NY
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 05:16:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587460560;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gz6mKS6j6MmlP59LBxLcbQShrIQYPv+HTPBiEtIqKhs=;
 b=irjq4ICpPxoqJqBEoMtl8Iiz+PqR1AlbJTKWda1syjVTtwnFqtB1UTIoiPihbWDUqldkf2
 QIIfLd5gGUJXW1kj4qVXhhq4ly6m/39hO8qNaPIsS+gSUMpgigfgLKkPvgsfz6ZBv0U9CD
 dlPfinPT278VTyAgPlO4Zwg9KWPDZdU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-jkmlAydgP7iG5nAZgPSGBA-1; Tue, 21 Apr 2020 05:15:58 -0400
X-MC-Unique: jkmlAydgP7iG5nAZgPSGBA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EDA268017F3;
 Tue, 21 Apr 2020 09:15:56 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-193.ams2.redhat.com
 [10.36.113.193])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4B2631001B30;
 Tue, 21 Apr 2020 09:15:53 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 3FDE316E16; Tue, 21 Apr 2020 11:15:52 +0200 (CEST)
Date: Tue, 21 Apr 2020 11:15:52 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Subject: Re: [PATCH-for-5.0 v2] hw/display/sm501: Avoid heap overflow in
 sm501_2d_operation()
Message-ID: <20200421091552.77uogz2qwc7y4cxg@sirius.home.kraxel.org>
References: <20200413220100.18628-1-f4bug@amsat.org>
 <CAFEAcA8kF1dhR0k2kgEr-KxBspxcqLXxVqWcMadDns3-SYKrAQ@mail.gmail.com>
 <alpine.BSF.2.22.395.2004151923090.92157@zero.eik.bme.hu>
 <alpine.BSF.2.22.395.2004151934110.92157@zero.eik.bme.hu>
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.22.395.2004151934110.92157@zero.eik.bme.hu>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/21 03:31:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-stable <qemu-stable@nongnu.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Zhang Zi Ming <1015138407@qq.com>, qemu-ppc <qemu-ppc@nongnu.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> > > The SM501 datasheet is entirely unhelpful on this question, but
> > > my suggestion is that we should convert the code so that instead
> > > of operating directly on pointers into the middle of the local_mem
> > > buffer all the accesses to local_mem go via functions which mask
> > > off the high bits of the index. That effectively means that the
> > > behaviour if we index off the end of the graphics memory is
> > > that we just wrap round to the start of it. It should be fairly
> > > easy to be confident that the code isn't accessing off the end
> > > of the array and it might even be what the hardware actually does
> > > (since it would correspond to 'use low bits of the address to
> > > index the ram, ignore high bits')...
> >=20
> > Does that make it even slower than it is already? I think it should
> > rather be changed to do what I've done in ati_2d.c and call optimised
> > functions to do the blit operation instead of implementing it directly.
> > Then we'll need
>=20
> As blits are common operation in several video cards, such as sm501, cirr=
us
> and ati-vga at least maybe we could also split off some common helpers to
> have one implementation of these which could be secured and optimised onc=
e
> and not have to fix it in every device separately. I don't volunteer to d=
o
> that by maybe there's someone who wants to try that?

cirrus stopped using pointers years ago, exactly for the reasons
outlined above.  Conversion was pretty straight forward.

commit 026aeffcb4752054830ba203020ed6eb05bcaba8
Author: Gerd Hoffmann <kraxel@redhat.com>
Date:   Wed Mar 15 11:47:52 2017 +0100

    cirrus: stop passing around dst pointers in the blitter
   =20
    Instead pass around the address (aka offset into vga memory).  Calculat=
e
    the pointer in the rop_* functions, after applying the mask to the
    address, to make sure the address stays within the valid range.

Drawback of this approach is that it can't be used in case you offload
all your raster ops to pixman, so the basic idea doesn't help much for
ati.  Didn't check sm501.

take care,
  Gerd


