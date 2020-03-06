Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F20C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 08:25:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB5CC207FD
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 08:25:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fnofdwU4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB5CC207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jA8I5-0005t6-Kq
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 03:25:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35678)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jA8H6-0005RZ-6t
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 03:24:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1jA8H4-0007mr-8U
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 03:24:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59372
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1jA8H4-0007hS-2U
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 03:24:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583483040;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W19VIZ5DArl0vX9ipAmljsHCZh7au1/aSE4pD0GHOwg=;
 b=fnofdwU4ZIgXe6ug8T+0DOhC5MlGaJNDdjk7Ev7rTa/yOTbGBKuNb3XYVhBUa9zXC5kQ06
 u++oD2sBo3ND9g5cWzEIJdqrsrSbT9dhR7EGBcpgfyeP9Va6MAUidXJ1KaJUrqh7Iv1On7
 vyY8C3bgUNHcjKmSmd56LLwFYKZoBw4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-50-O35EmQ6hOpG_G9AH8Lc_PA-1; Fri, 06 Mar 2020 03:23:58 -0500
X-MC-Unique: O35EmQ6hOpG_G9AH8Lc_PA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0FC388010EB;
 Fri,  6 Mar 2020 08:23:58 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-150.ams2.redhat.com
 [10.36.116.150])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CD81A5C57E;
 Fri,  6 Mar 2020 08:23:57 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id EAD7C9D12; Fri,  6 Mar 2020 09:23:56 +0100 (CET)
Date: Fri, 6 Mar 2020 09:23:56 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Brad Smith <brad@comstyle.com>
Subject: Re: [PATCH] audio: Add sndio backend
Message-ID: <20200306082356.7iosf6hbg7t23ujp@sirius.home.kraxel.org>
References: <20200304145003.GB15649@humpty.home.comstyle.com>
 <158333424649.21741.12510392429749383012@abdcc9e1aa82>
 <20200305085019.hbmih2m43vmpdc5v@sirius.home.kraxel.org>
 <a4e6c1e0-6c8b-5281-e945-c6a032752e3e@comstyle.com>
MIME-Version: 1.0
In-Reply-To: <a4e6c1e0-6c8b-5281-e945-c6a032752e3e@comstyle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> > > ERROR: g_free(NULL) is safe this check is probably not required
> > > #381: FILE: audio/sndioaudio.c:318:
> > > +    if (self->pfds) {
> > > +        g_free(self->pfds);
> > Reasonable too.
>=20
> Not clear to me. Leave as is or needs a change?

Just use "g_free(self->pfds)".

cheers,
  Gerd


