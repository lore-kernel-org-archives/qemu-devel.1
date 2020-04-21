Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9957AC54FC9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 10:34:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 656B320679
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 10:34:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GmA25Ndc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 656B320679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQqEC-0000my-IS
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 06:34:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45740)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jQqDb-0000NH-7B
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 06:33:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jQqDZ-0001Ie-K2
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 06:33:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54894
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jQqDZ-0001HJ-4W
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 06:33:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587465206;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ha5QVakZu8kD0BP4b6mlXtosBX+D4tFJXW2z4aqeUDQ=;
 b=GmA25NdcW2HUq23jdx1QQYuwYm26eSilu3pnzu7DWMakUcOE8nU9H298mla1LGN1JCnsCv
 j1nRVT3zXAkmUq1/4tFQkSAcurydUGOnriiIkwIXttKfY1QiBBJfG4/mbXaH5oGmM6kXMb
 uATxOz8r5fd23ea9gw4yUBtiL9wUD/g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-437-xmpS2mhdNfqwc8gR1qbeDQ-1; Tue, 21 Apr 2020 06:33:14 -0400
X-MC-Unique: xmpS2mhdNfqwc8gR1qbeDQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2BE921934100;
 Tue, 21 Apr 2020 10:33:13 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.64])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E13081001B09;
 Tue, 21 Apr 2020 10:33:10 +0000 (UTC)
Date: Tue, 21 Apr 2020 11:33:07 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Subject: Re: SLiRP: use-afte-free in ip_reass() [CVE-2020-1983]
Message-ID: <20200421103307.GB479771@redhat.com>
References: <CAP+75-UisNwFqedDPfuGt=HFEEnPSO7sNq9JxpUuLPVdYDryuw@mail.gmail.com>
 <CAJ+F1C+YnbgCkYN1+7zpq0XvZYb2LWL6kbQXRSybJew1JnBgQQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJ+F1C+YnbgCkYN1+7zpq0XvZYb2LWL6kbQXRSybJew1JnBgQQ@mail.gmail.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/21 04:54:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.120
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Apr 21, 2020 at 12:22:05PM +0200, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Tue, Apr 21, 2020 at 11:18 AM Philippe Mathieu-Daud=C3=A9
> <philmd@redhat.com> wrote:
> >
> > Hi Samuel and Marc-Andr=C3=A9,
> >
> > Peter is going to tag 5.0-rc4 (final before release) today.
> > Do you have plans to send a last minute pull-request to fix CVE-2020-19=
83?
> >
> > https://gitlab.freedesktop.org/slirp/libslirp/-/commit/9ac0371bb
>=20
> libslirp is not following qemu release schedule. The master branch has
> a few changes that shouldn't be added to the release. We could create
> version/stable/qemu branches, but then between each version, we would
> end up with the submodule jumping between branches (with a non-linear
> history). Is that the only option?

In the short term, it looks like a stable branch is the easiest option.

In the medium term, we need to more strongly push people to use the
distro provided slirp, or build it themselves, like they would have to
for (almost) any other 3rd party library we depend on. QEMU shouldn't
carry on doing the work of OS vendors indefinitely for slirp by having
to worry about updates to pull in CVE fixes from an external project.

I've got a few configure patches nearly ready to send to add such a
deprecation. It's been a year since QEMU switched Slirp to be a
submodule, and even longer since Slirp started as an independant
project. With some time allowed for the deprecation period, it will
be nearly 2 years before we finally remove Slirp from QEMU entirely.

Admittedly this may be troublesome for Debian which, AFAICT, does not
add new packages to pre-existing stable releases. Presumably someone
can add it to the "backports" release archive if this is too hard to
get into a stable release ? Failing that, users would have to build
slirp themselves.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


