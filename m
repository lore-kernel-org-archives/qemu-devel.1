Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC35BC43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 15:50:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 720B120748
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 15:50:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BKZFXOdE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 720B120748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHrFh-0001sH-9g
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 11:50:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54081)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jHrEE-0001I6-Mx
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 11:49:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1jHrEC-000365-Bs
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 11:49:01 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:32876)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1jHrEA-0002yi-Qt
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 11:48:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585324136;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uzM8XfO0az8MIrat4zu/mY+z30wQg8bEdQYVpnSGfJo=;
 b=BKZFXOdEc5I9Za+91P6Kkowzh+klM7uToE/4/3RxtVNWNd0XFM4LgNHaYnoPzahOFm8vAj
 YJE2cMAPKIqpR0VYZh8JyjJg94rQ/J4lFJti2kVJq4lMseRiIp8wJGr9BpJWfPWJFkn6IV
 cqaiE7ui8YfDoe2oNR65NbgY2IBfun4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-BBSTMjx_M3uf7ioLIq2y-w-1; Fri, 27 Mar 2020 11:48:51 -0400
X-MC-Unique: BBSTMjx_M3uf7ioLIq2y-w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5AED8107B270;
 Fri, 27 Mar 2020 15:48:50 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C7DF219756;
 Fri, 27 Mar 2020 15:48:47 +0000 (UTC)
Date: Fri, 27 Mar 2020 15:48:44 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH] qemu-user: fix build with LLVM lld 10
Message-ID: <20200327154844.GN1619@redhat.com>
References: <20200326134316.36059-1-roger.pau@citrix.com>
 <f71f7cf8-af7d-7b45-a026-8ab87e106759@linaro.org>
 <20200327101600.GA28583@Air-de-Roger> <87sghum3zv.fsf@linaro.org>
 <20200327140839.GB28583@Air-de-Roger> <878sjln6og.fsf@linaro.org>
MIME-Version: 1.0
In-Reply-To: <878sjln6og.fsf@linaro.org>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Dimitry Andric <dim@freebsd.org>, Laurent Vivier <laurent@vivier.eu>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Mar 27, 2020 at 03:44:47PM +0000, Alex Benn=C3=A9e wrote:
>=20
> Roger Pau Monn=C3=A9 <roger.pau@citrix.com> writes:
>=20
> > On Fri, Mar 27, 2020 at 11:28:04AM +0000, Alex Benn=C3=A9e wrote:
> >>=20
> >> Roger Pau Monn=C3=A9 <roger.pau@citrix.com> writes:
> >>=20
> >> > On Thu, Mar 26, 2020 at 09:56:38AM -0700, Richard Henderson wrote:
> >> >> On 3/26/20 6:43 AM, Roger Pau Monne wrote:
> >> >> > lld 10.0.0 introduced a new linker option --image-base equivalent=
 to
> >> >> > the GNU -Ttext-segment one, hence use it when available.
> >> >> >=20
> >> >> > This fixes the build of QEMU on systems using lld 10 or greater.
> >> >> >=20
> >> >> > Signed-off-by: Dimitry Andric <dim@FreeBSD.org>
> >> >> > Signed-off-by: Roger Pau Monn=C3=A9 <roger.pau@citrix.com>
> >> >> > ---
> >> >> > Cc: Laurent Vivier <laurent@vivier.eu>
> >> >> > Cc: Richard Henderson <richard.henderson@linaro.org>
> >> >> > Cc: "Philippe Mathieu-Daud=C3=A9" <philmd@redhat.com>
> >> >> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> >> >> > Cc: "Daniel P. Berrang=C3=A9" <berrange@redhat.com>
> >> >> > ---
> >> >>=20
> >> >> The Plan is still to drop this whole section of code.
> >> >>=20
> >> >> However, it's still blocked on getting the x86_64 vsyscall patches =
upstream.
> >> >
> >> > While this doesn't materialize, could it be possible to get this pat=
ch
> >> > accepted?
> >> >
> >> > This is currently blocking the build of QEMU on FreeBSD HEAD, which
> >> > has already switched to LLVM 10.0.0.
> >>=20
> >> I think the vsyscall patch has just been merged, however way I don't
> >> think targeting HEAD of a OS release during the rc phase is appropriat=
e.
> >
> > I'm not sure I understand what you mean. If QEMU doesn't build on
> > FreeBSD HEAD it won't build on the next release. Also the LLVM
> > toolchain used is not a development version AFAIK, but the actual
> > 10.0.0 release, which QEMU should aim to support?
>=20
> QEMU's supported build platforms are based on what is currently shipping
> as stable versions:
>=20
>   https://www.qemu.org/docs/master/system/build-platforms.html

FWIW, when I wrote that my intention was *not* to exclude the bleeding
edge distro development branches.

Obviously we can break on those distros at any time as they're moving
targets, but IMHO we should treat bugs as we would for any other
released distros and aim to fix them promptly when bugs occurr.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


