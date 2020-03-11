Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B335C0044D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 23:08:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 371682074B
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 23:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XvNVO2p3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 371682074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCAT4-0005k1-Aa
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 19:08:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39442)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1jCASV-0005G8-GQ
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 19:08:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1jCASU-0005V6-HB
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 19:08:15 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:28004
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1jCASU-0005UW-D8
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 19:08:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583968094;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=881/UJ4LtPLy3EJ8ElodRzp5g1wTQmAiDJLjS0h9aJk=;
 b=XvNVO2p3LzLX2JYdNanam4+HCYiF86dJkKpYcSD6Q7l65w7EXs5At1VhQWR3xl2flifXBJ
 pRkUIxc9CFifGlFSDOkoN0XdDjRq35kdr93OxnKEoK3CN/9TQC/z0Qv8WPgPF4m4PEXYdW
 9fkqX65t0+HCm1+rNxxZWmUw+Rw2SuE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-v9t1tSQrO-KUcoJsfBW1Fw-1; Wed, 11 Mar 2020 19:08:11 -0400
X-MC-Unique: v9t1tSQrO-KUcoJsfBW1Fw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 67490800D4E;
 Wed, 11 Mar 2020 23:08:10 +0000 (UTC)
Received: from localhost (unused-10-15-17-6.yyz.redhat.com [10.15.17.6])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E616960304;
 Wed, 11 Mar 2020 23:08:07 +0000 (UTC)
Date: Wed, 11 Mar 2020 19:08:06 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 1/2] Use -isystem for linux-headers dir
Message-ID: <20200311230806.GO1187748@habkost.net>
References: <20200311225130.1599619-1-ehabkost@redhat.com>
 <20200311225130.1599619-2-ehabkost@redhat.com>
 <20200311190458-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20200311190458-mutt-send-email-mst@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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
Cc: peter.maydell@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 jtomko@redhat.com, qemu-devel@nongnu.org, jingqi.liu@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Mar 11, 2020 at 07:05:45PM -0400, Michael S. Tsirkin wrote:
> On Wed, Mar 11, 2020 at 06:51:29PM -0400, Eduardo Habkost wrote:
> > glibc and Linux-provided headers are known to generate macro
> > redefinition warnings when used together.  For example:
> > <linux/mman.h> and <sys/mman.h> duplicate some macro definitions.
> >=20
> > We normally never see those warnings because GCC suppresses
> > warnings generated by system headers.  We carry our own copy of
> > Linux header files, though, and this makes those warnings not be
> > suppressed when glibc headers are included before Linux headers
> > (e.g. if <sys/mman.h> is included before <linux/mman.h>).
> >=20
> > Use -isystem instead of -I for linux-headers.  This makes the
> > compiler treat our linux-headers directory the same way it treats
> > system-provided Linux headers, and suppress warnings generated by
> > them.
> >=20
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > ---
> >  Makefile.target | 2 +-
> >  configure       | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/Makefile.target b/Makefile.target
> > index 2d43dc586a..934a9f7431 100644
> > --- a/Makefile.target
> > +++ b/Makefile.target
> > @@ -12,7 +12,7 @@ endif
> > =20
> >  $(call set-vpath, $(SRC_PATH):$(BUILD_DIR))
> >  ifdef CONFIG_LINUX
> > -QEMU_CFLAGS +=3D -I../linux-headers
> > +QEMU_CFLAGS +=3D -isystem ../linux-headers
> >  endif
> >  QEMU_CFLAGS +=3D -iquote .. -iquote $(SRC_PATH)/target/$(TARGET_BASE_A=
RCH) -DNEED_CPU_H
> > =20
> > diff --git a/configure b/configure
> > index cbf864bff1..04a2a7f2dd 100755
> > --- a/configure
> > +++ b/configure
> > @@ -899,7 +899,7 @@ Linux)
> >    linux=3D"yes"
> >    linux_user=3D"yes"
> >    kvm=3D"yes"
> > -  QEMU_INCLUDES=3D"-I\$(SRC_PATH)/linux-headers -I$PWD/linux-headers $=
QEMU_INCLUDES"
> > +  QEMU_INCLUDES=3D"-isystem \$(SRC_PATH)/linux-headers -I$PWD/linux-he=
aders $QEMU_INCLUDES"
>=20
> Shouldn't both be -isystem?

I haven't noticed we had both.

This line looks weird, does anybody know why we have
$PWD/linux-headers here?

--=20
Eduardo


