Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3AF2C54FD0
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 11:28:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F360206B8
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 11:28:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wu7EJ2Qa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F360206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQr4b-0005Uj-Pv
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 07:28:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52764)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jQr3Y-0004ed-7U
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 07:27:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jQr3X-0007gi-5r
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 07:27:12 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:23671
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jQr3W-0007gA-Py
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 07:27:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587468429;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=phBnxlIs2vB0gHxNGdqu1VaFUKy2GtPFmks8lV2V+rs=;
 b=Wu7EJ2QaJgCRsNus54Hsjh5zlxqHojN3nzFcPHvutU8co90A7BU4hVk5kuZZKcM7nbOrt3
 wzRDlhACwNSgsUk5rT+io8mzdy0DvF+Znr8TbSQbnQXF8FtiG3JCZ9HdyKpadxfENshP0t
 gPMfDVUJqFgMqtdL7YW0QqTYAUnVLxQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-wpjYR_ruMO2dyAeKCG02KQ-1; Tue, 21 Apr 2020 07:27:01 -0400
X-MC-Unique: wpjYR_ruMO2dyAeKCG02KQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 639A31B18BC3;
 Tue, 21 Apr 2020 11:26:59 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-193.ams2.redhat.com
 [10.36.113.193])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C796076E82;
 Tue, 21 Apr 2020 11:26:55 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 9720516E18; Tue, 21 Apr 2020 13:26:54 +0200 (CEST)
Date: Tue, 21 Apr 2020 13:26:54 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH-for-5.0 v2] hw/display/sm501: Avoid heap overflow in
 sm501_2d_operation()
Message-ID: <20200421112654.nboie2r4hmfpk2m7@sirius.home.kraxel.org>
References: <20200413220100.18628-1-f4bug@amsat.org>
 <CAFEAcA8kF1dhR0k2kgEr-KxBspxcqLXxVqWcMadDns3-SYKrAQ@mail.gmail.com>
 <alpine.BSF.2.22.395.2004151923090.92157@zero.eik.bme.hu>
 <alpine.BSF.2.22.395.2004151934110.92157@zero.eik.bme.hu>
 <20200421091552.77uogz2qwc7y4cxg@sirius.home.kraxel.org>
 <CAFEAcA_vW0uzJ8icr2iHS9e8TVu67ue9ZBEuXU1Me1KC2aXtJQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_vW0uzJ8icr2iHS9e8TVu67ue9ZBEuXU1Me1KC2aXtJQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/21 01:28:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 qemu-stable <qemu-stable@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Zhang Zi Ming <1015138407@qq.com>,
 qemu-ppc <qemu-ppc@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Apr 21, 2020 at 10:25:49AM +0100, Peter Maydell wrote:
> On Tue, 21 Apr 2020 at 10:16, Gerd Hoffmann <kraxel@redhat.com> wrote:
> > cirrus stopped using pointers years ago, exactly for the reasons
> > outlined above.  Conversion was pretty straight forward.
> >
> > commit 026aeffcb4752054830ba203020ed6eb05bcaba8
> > Author: Gerd Hoffmann <kraxel@redhat.com>
> > Date:   Wed Mar 15 11:47:52 2017 +0100
> >
> >     cirrus: stop passing around dst pointers in the blitter
> >
> >     Instead pass around the address (aka offset into vga memory).  Calc=
ulate
> >     the pointer in the rop_* functions, after applying the mask to the
> >     address, to make sure the address stays within the valid range.
>=20
> Aha, thanks for bringing up the prior art. (Did anybody benchmark
> whether there was a noticeable performance impact for that cirrus
> change? My guess is that there wouldn't be much/any because the memory
> operations will dominate and you get to do the masking operation more
> or less for free, but guesses are notoriously unreliable when it
> comes to performance :-) )

In case of the cirrus the first problem is finding an guest which is
old enough that it actually uses the blitter ;)

So, in 99% of the cases the difference is zero due to the blitter not
being used by the guest.  And, no, I don't have numbers for the
remaining 1%.

take care,
  Gerd


