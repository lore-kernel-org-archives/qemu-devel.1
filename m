Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C61EAC0044D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 17:07:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2287D206BE
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 17:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HeK596aH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2287D206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC4pJ-0002i3-P7
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 13:07:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53923)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jC4oT-000127-3y
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 13:06:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1jC4oR-0004Om-Uo
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 13:06:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36452
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1jC4oR-0004OY-QJ
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 13:06:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583946391;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J+dcWyO6Hq4Ysrqm6WwxLLpuKG4MqvIBIBS67y1b4sM=;
 b=HeK596aHKwVpUflEWACP9/ijpD9oS64Y2DIcEpJEomRHlJhq3nccigXqWHQB9MYeWxMhzc
 /uztXB4j/SYl35fu/sl+ntHNZ+p+fq59fgWHEpmUIIERnmOT0chbmMt4ChuxfiMofapA3t
 d4BbQfQeF6554D+oEvuCFr1ZOrLR/tk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-335-lSrvJmSDP9WKdKkLh9EG0Q-1; Wed, 11 Mar 2020 13:06:27 -0400
X-MC-Unique: lSrvJmSDP9WKdKkLh9EG0Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A432E107ACCA;
 Wed, 11 Mar 2020 17:06:26 +0000 (UTC)
Received: from localhost (unknown [10.36.118.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1EC825C1D4;
 Wed, 11 Mar 2020 17:06:25 +0000 (UTC)
Date: Wed, 11 Mar 2020 17:06:25 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 0/2] thread: add lock guard macros
Message-ID: <20200311170625.GD281087@stefanha-x1.localdomain>
References: <20200311123624.277221-1-stefanha@redhat.com>
 <CABgObfat-zQziF1EoJTjCO6zJBEYu074PZUCQOrgpeuC2uzFuw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CABgObfat-zQziF1EoJTjCO6zJBEYu074PZUCQOrgpeuC2uzFuw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="0IvGJv3f9h+YhkrH"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0IvGJv3f9h+YhkrH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2020 at 01:52:35PM +0100, Paolo Bonzini wrote:
> Il mer 11 mar 2020, 13:38 Stefan Hajnoczi <stefanha@redhat.com> ha scritt=
o:
>=20
> > Lock guards automatically call qemu_(rec_)mutex_unlock() when returning
> > from a
> > function or leaving leaving a lexical scope.  This simplifies code and
> > eliminates leaks (especially in error code paths).
> >
> > This series adds lock guards for QemuMutex and QemuRecMutex.  It does n=
ot
> > convert the entire tree but includes example conversions.
> >
>=20
> Thanks for picking this up! It should be possible to use QemuLockable to
> introduce a single set of lock guard macros that work for mutexes,
> spinlocks and CoMutexes. Would you look into that?
>=20
> (C++ also has unique_lock, a kind of lock guard that can be unlocked earl=
y
> and won't cause a double unlock, and also can be created unlocked. Howeve=
r
> it makes sense to not implement that unless one has a killer application =
of
> it in the tree).

I already looked at lockable.h and to be honest I didn't want to combine
g_autoptr macros with lockable's polymorphism macros.

However, since you have mentioned it I'll take another look and try to
overcome the aversion :).

Stefan

--0IvGJv3f9h+YhkrH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl5pGpAACgkQnKSrs4Gr
c8gfGgf8CCcxDRF4k3bZcr1OIrjCC9lh5rUngfu+ppwUlBiqvPpHvtO1QumQb5Mz
wJMW7Nq/sSWXFB/W4MAHG3icfGdWIvvrSE4D2Fq0IScFLFF+KLqphcs/t8OFZtYh
u3e5RFumf1bEljlQ0FbGTBbZIwvZ0bolVxIl3Zt5iqj83P+UCj2ev1hwt2MxXqRM
9TjrQ3OBmpJi9ScMP531u+ccIHcYJ0H/zoYHZWJdxOOqKf+YNxPCfpY9NZsp+8th
JGuGOd4IIQyx7RCjeoJaaYI2qjyX2E8r1T8OjEZg8zo6jU4TUfW86+Ucr9Yplkgr
jcgZL7A9h7xdGNv5F/wY4SWfWowFZg==
=SGfA
-----END PGP SIGNATURE-----

--0IvGJv3f9h+YhkrH--


