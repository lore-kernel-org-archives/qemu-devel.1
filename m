Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B3CAC2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 13:25:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF393217BA
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 13:25:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JHkOglfO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF393217BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izh9b-0001Wi-08
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 08:25:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44652)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1izh4n-0004k9-KG
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 08:20:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1izh4m-0005GJ-LP
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 08:20:13 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:56300
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1izh4m-0005CG-GF
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 08:20:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580995212;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LlAdUD5v1aWNFRNagTyqGCiLOl0lqsqwhVWeOSM14XM=;
 b=JHkOglfO2XzcAUw3zA5TWkS7HE3kTHOEPvx3qHl9poIoRxaM/IHNsdoePWV43B9evUbQ95
 T4pDhsMj7nHK7K78jymAYiL0oJvZTRBZRzY+z5CkTvUGX3MX9cMY4VB1WI9Iw/DN+xFi91
 aYGtl30RkrLGjSg3yip99uke5VP0QTY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-iPT4LpgrM-yZ2FT0tJToCQ-1; Thu, 06 Feb 2020 08:20:07 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 50AA71137853;
 Thu,  6 Feb 2020 13:20:06 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-112.ams2.redhat.com
 [10.36.116.112])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2993C8ECE8;
 Thu,  6 Feb 2020 13:20:03 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 62D921747D; Thu,  6 Feb 2020 14:20:02 +0100 (CET)
Date: Thu, 6 Feb 2020 14:20:02 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2 0/6] ui: rework -show-cursor option
Message-ID: <20200206132002.6piouqiatuj3tj7f@sirius.home.kraxel.org>
References: <20200206112908.5002-1-kraxel@redhat.com>
 <CAFEAcA8eHS7KuMW6RXdxoYAdQAJOJK6thqp5Vn+LZav7B79MWw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8eHS7KuMW6RXdxoYAdQAJOJK6thqp5Vn+LZav7B79MWw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: iPT4LpgrM-yZ2FT0tJToCQ-1
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
Cc: =?utf-8?Q?J=C3=A1n?= Tomko <jtomko@redhat.com>,
 Libvirt <libvir-list@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 jpewhacker@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Feb 06, 2020 at 11:52:05AM +0000, Peter Maydell wrote:
> On Thu, 6 Feb 2020 at 11:29, Gerd Hoffmann <kraxel@redhat.com> wrote:
> >
> >
>=20
> This cover letter is missing a description of what the patchset does...
>=20
> The closest thing the patchset seems to get to documentation is the
> oneliner in ui.json:
> +# @show-cursor:   Force showing the mouse cursor (default: off).
>=20
> but looking at the ui/cocoa.m implementation that isn't what it
> actually does -- it just seems to mean "default to shown on
> startup", because the logic that unconditionally hides the host
> cursor on mousegrab and unhides it on ungrab remains
> unchanged. This doesn't on the face of it sound like very
> useful behaviour, since the option will only have an effect for
> the short period of time between QEMU startup and the first
> mouse-grab, but without documentation of what the option
> is intended to do and in particular how it's intended to
> interact with grab/ungrab I don't know what your intention
> for the behaviour was.

Well, it doesn't change actual behavior for SDL and cocoa.  It only adds
"-display {sdl,cocoa},show-cursor=3Don" as replacement for the global
"-show-cursor" option.  Guess I should reorder the patches (move 5/6
before the individual UI patches) and reword the commit messages.

If you think cocoa behavior isn't useful we can revert commit
13aefd303cf996c2d183e94082413885bf1d15bf instead, or drop the
cursor_hide check in hideCursor() + unhideCursor().  Your call.

It also adds gtk support (based on a patch by jpewhacker@gmail.com).

cheers,
  Gerd


