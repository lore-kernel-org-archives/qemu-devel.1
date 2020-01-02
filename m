Return-Path: <SRS0=Q/S9=2X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D9EC2D0DC
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 09:53:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C67A421655
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 09:53:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SaL22AhV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C67A421655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imxAg-0002am-Ud
	for qemu-devel@archiver.kernel.org; Thu, 02 Jan 2020 04:53:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60923)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1imxA6-0002CI-HJ
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 04:53:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1imxA5-0000ph-0Z
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 04:53:01 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:28185
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1imxA4-0000p1-TJ
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 04:53:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577958779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HR4o1dgI7m7Lvv43Hd4fIP5HgWcYtVGsiwcK+pC40JU=;
 b=SaL22AhV/1d6NT7VG2U4SU51qD9FJbSJYkE4NyWVQgkL501NlRGHvO3X8lg0p6Y87GcNND
 ENVaartW+pVVm+3tgo9BaiviclHHX/Ao8obLhbGVYnx+owyYZseoSAOhVWZQ8Yzhkh3pRR
 tWvuLLRjxYc4bTnJaaudoLB0yTJUock=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-54-oOKeFUdYMOCB-InWBVvokQ-1; Thu, 02 Jan 2020 04:52:54 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1C281100550E;
 Thu,  2 Jan 2020 09:52:53 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-98.ams2.redhat.com
 [10.36.116.98])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9A73383C07;
 Thu,  2 Jan 2020 09:52:52 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 8BBA99DA5; Thu,  2 Jan 2020 10:52:51 +0100 (CET)
Date: Thu, 2 Jan 2020 10:52:51 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Subject: Re: [PATCH 0/7] console: screendump improvements
Message-ID: <20200102095251.ehwbbh6bevxn2kiz@sirius.home.kraxel.org>
References: <20191127115202.375107-1-marcandre.lureau@redhat.com>
 <CAJ+F1CKVV4bWEKWrioOgf6RRQvwGx2c-j6XmLNSBen_F4j7uwg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CKVV4bWEKWrioOgf6RRQvwGx2c-j6XmLNSBen_F4j7uwg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: oOKeFUdYMOCB-InWBVvokQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Dec 20, 2019 at 06:36:41PM +0400, Marc-Andr=E9 Lureau wrote:
> Hi Gerd,
>=20
> On Wed, Nov 27, 2019 at 3:52 PM Marc-Andr=E9 Lureau
> <marcandre.lureau@redhat.com> wrote:
> >
> > Hi,
> >
> > The following patches have been extracted from the "[PATCH v6 00/25]
> > monitor: add asynchronous command type", as they are
> > reviewable/mergeable independantly.
> >
> > They introduce some internal API changes, and fix
> > qemu_open()/qemu_close()/unlink() misusages which should be quite
> > harmless.
> >
> > Marc-Andr=E9 Lureau (7):
> >   console: add graphic_hw_update_done()
> >   ppm-save: pass opened fd
> >   ui: add pixman image g_autoptr support
> >   object: add g_autoptr support
> >   screendump: replace FILE with QIOChannel and fix close()/qemu_close()
> >   osdep: add qemu_unlink()
> >   screendump: use qemu_unlink()
>=20
> The series has been reviewed by Daniel. Can I send a PR or do you plan
> to take a look and make the PR yourself?

Looks all sane.  Feel free to send a PR.

Acked-by: Gerd Hoffmann <kraxel@redhat.com>

cheers,
  Gerd


