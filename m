Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA47C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 05:29:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CE42206EB
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 05:29:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BvnrwwdN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CE42206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCGPO-0000oI-Du
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 01:29:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45659)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jCGOm-0008VP-P8
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 01:28:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jCGOk-00040G-OV
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 01:28:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51767
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jCGOk-0003yu-HU
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 01:28:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583990925;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WBWOnQNrnvaTL/mjkReMXjNi6Grb8eHjaK2em2EqO5s=;
 b=BvnrwwdNhBjjUzW2hp5aKpU3Qi067tGQ2r4AETjsHFeLaL1WOs64dh+CzKtR2r9Ww6yhlR
 FUloa8xq/SfUlE9+QXyxIYEZuvTyVkKdk26nmM8bnTegtZWtW38pfHlGe+9D5GluH/Xv49
 aRPSBPpmbRom2iyIqeIhe6VJN8SpFxY=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220-521jJQ26On66BL1Hxjwf4Q-1; Thu, 12 Mar 2020 01:28:42 -0400
X-MC-Unique: 521jJQ26On66BL1Hxjwf4Q-1
Received: by mail-qt1-f197.google.com with SMTP id z5so2787500qtd.4
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2020 22:28:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=xkTgSXkLGMyhSjq81uvY6IY0AQhekWx26l/OQw7MJw8=;
 b=cYxVKvB9INsEUFdysdFzVYGcxRc5UeMEdw3tftztbjKAW1fYWwvouicac4mj0KAVIr
 6axGFp9aa2Il/LjJcOGv7vTUHunFU4slV41ydN+7MfQyTm59laGmGMdXJ0q4PRww0zde
 rjWUtfkoVElhJxSPTXt87W5d8Af5MWD/xR+bEPXVSoJGr23vosyRgodjvjZDdHZJKGcg
 woW7QH16c77mR/BJ9IV+jrjJNOnfCEBWRVLY6vyegQPPl+tM5VM4+TZ7fMbL8Z/Nh04P
 vg2oy8ElHlYxReNOVwV66OBiCqdTl9aupq052QqXGpSZa5w6fEIOgaIvLQ8F0OPMxys0
 mEgg==
X-Gm-Message-State: ANhLgQ2Fc0Wo4rlSeTN9/+SYSkeQCckE7o2ffQ3+XwpwwJNf31nYILKW
 e4nB6+vda5j29O8LPp+IDJyAZP7xvs5ZKMRuvrT8Dd8Rt6uHTuPCuxWAD/VgefrjOqIJueFXxAM
 CL5Z6lqiYH/dRSwc=
X-Received: by 2002:ac8:19ee:: with SMTP id s43mr5857130qtk.306.1583990920626; 
 Wed, 11 Mar 2020 22:28:40 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsk16loAzj62lyI66qDMtqp562OCRjNNbKrKu99TU6th5oun3OBeI+4uNqTpR7RkV+xbq7VXQ==
X-Received: by 2002:ac8:19ee:: with SMTP id s43mr5857106qtk.306.1583990920329; 
 Wed, 11 Mar 2020 22:28:40 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
 by smtp.gmail.com with ESMTPSA id u26sm1660959qku.97.2020.03.11.22.28.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2020 22:28:39 -0700 (PDT)
Date: Thu, 12 Mar 2020 01:28:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH 1/2] Use -isystem for linux-headers dir
Message-ID: <20200312012547-mutt-send-email-mst@kernel.org>
References: <20200311225130.1599619-1-ehabkost@redhat.com>
 <20200311225130.1599619-2-ehabkost@redhat.com>
 <20200311190458-mutt-send-email-mst@kernel.org>
 <20200311230806.GO1187748@habkost.net>
MIME-Version: 1.0
In-Reply-To: <20200311230806.GO1187748@habkost.net>
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
Cc: peter.maydell@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 jtomko@redhat.com, qemu-devel@nongnu.org, jingqi.liu@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Mar 11, 2020 at 07:08:06PM -0400, Eduardo Habkost wrote:
> On Wed, Mar 11, 2020 at 07:05:45PM -0400, Michael S. Tsirkin wrote:
> > On Wed, Mar 11, 2020 at 06:51:29PM -0400, Eduardo Habkost wrote:
> > > glibc and Linux-provided headers are known to generate macro
> > > redefinition warnings when used together.  For example:
> > > <linux/mman.h> and <sys/mman.h> duplicate some macro definitions.
> > >=20
> > > We normally never see those warnings because GCC suppresses
> > > warnings generated by system headers.  We carry our own copy of
> > > Linux header files, though, and this makes those warnings not be
> > > suppressed when glibc headers are included before Linux headers
> > > (e.g. if <sys/mman.h> is included before <linux/mman.h>).
> > >=20
> > > Use -isystem instead of -I for linux-headers.  This makes the
> > > compiler treat our linux-headers directory the same way it treats
> > > system-provided Linux headers, and suppress warnings generated by
> > > them.
> > >=20
> > > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > > ---
> > >  Makefile.target | 2 +-
> > >  configure       | 2 +-
> > >  2 files changed, 2 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/Makefile.target b/Makefile.target
> > > index 2d43dc586a..934a9f7431 100644
> > > --- a/Makefile.target
> > > +++ b/Makefile.target
> > > @@ -12,7 +12,7 @@ endif
> > > =20
> > >  $(call set-vpath, $(SRC_PATH):$(BUILD_DIR))
> > >  ifdef CONFIG_LINUX
> > > -QEMU_CFLAGS +=3D -I../linux-headers
> > > +QEMU_CFLAGS +=3D -isystem ../linux-headers
> > >  endif
> > >  QEMU_CFLAGS +=3D -iquote .. -iquote $(SRC_PATH)/target/$(TARGET_BASE=
_ARCH) -DNEED_CPU_H
> > > =20
> > > diff --git a/configure b/configure
> > > index cbf864bff1..04a2a7f2dd 100755
> > > --- a/configure
> > > +++ b/configure
> > > @@ -899,7 +899,7 @@ Linux)
> > >    linux=3D"yes"
> > >    linux_user=3D"yes"
> > >    kvm=3D"yes"
> > > -  QEMU_INCLUDES=3D"-I\$(SRC_PATH)/linux-headers -I$PWD/linux-headers=
 $QEMU_INCLUDES"
> > > +  QEMU_INCLUDES=3D"-isystem \$(SRC_PATH)/linux-headers -I$PWD/linux-=
headers $QEMU_INCLUDES"
> >=20
> > Shouldn't both be -isystem?
>=20
> I haven't noticed we had both.
>=20
> This line looks weird, does anybody know why we have
> $PWD/linux-headers here?

Look at the build directory and you'll figure it out:

$ ls -l $PWD/linux-headers/
total 0
lrwxrwxrwx. 1 mst mst 31 Mar 10 05:59 asm -> /scm/qemu/linux-headers/asm-x8=
6


Introduced here:

commit a585140dd546ffb606ec506b362ab9decf1ab14e
Author: Alexey Kardashevskiy <aik@ozlabs.ru>
Date:   Wed May 29 23:30:43 2013 +1000

    qemu: fix out of tree cross compile
   =20
    The symlink to "asm" platform linux headers is made in the build tree b=
y
    the configure script but gcc is not told to look for them there.
   =20
    The patch fixes this.
   =20
    Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
    Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

--=20
MST


