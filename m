Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7843C2D0C0
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 14:38:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96702218AC
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 14:38:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j/q6dP0d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96702218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiJQG-0004zh-Na
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 09:38:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59823)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iiJHF-0000UJ-8N
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 09:29:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iiJHD-0007Cp-Pj
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 09:29:12 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:45073)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1iiJHD-00076m-Fw
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 09:29:11 -0500
Received: by mail-wr1-x443.google.com with SMTP id j42so9574880wrj.12
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 06:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=G9Aw4/kNg3vcw8vax8uibZv8AAkyijCI6PeyUx9IoSE=;
 b=j/q6dP0dzWp/3lQm02lEburUE39mKqImuDYfSwA16cZ7GrkMu3g9+HzkKNgkPbJjTQ
 2DPz0pp33Z4qBDRlWLkJDPhufOEN23MlCZOzY49Z+Uym0Dof3xSphaSo3frIGRy/ynF+
 ao/SDRmMxy9P9sqUNbktQI3RxcjsbumHDq4x/9pNL5P38yVEidMCwpjD544x52hFCYpU
 kmvoGxTC7oSQxbxBDuncoXTm4JKRNnvUTAoLnpD+ndb8RvhdrvVm2EUzKdB1Ckb8s3T0
 xxoNbfthCmQ4Ihkckmo8lK49PGJe2XUSxC/xgQmyg2rh60H3ntoXmnm/BQR842K7w+e3
 +rQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=G9Aw4/kNg3vcw8vax8uibZv8AAkyijCI6PeyUx9IoSE=;
 b=JdBuAUiMAwzhGb2OOto7kizJ3ylew3M6701uE7y7r3NRwBTvqyf5psgU5L/WjMtRJl
 3clU1OaSAH4wCiJFjlIP/asCA4rg0mHwc8CVs/txLGEn2tvpe2KHcN4HxuDKNw4JFbWG
 oxJ+DA4RLKPwrhaBPVzvV8zagPcDy0qtTy0KULMP3N4bByhzYmvabc/qLxypMRboJFTc
 uCKE1uhtljJEOb95qEBS1oXTKkJVOSLbmskmPw6/GpMTs9LATCUMDKpSbLi7i5GJEEKm
 RX+PxrdhkdOgjNXkk8K+Z38Mrw9m5VX7a3t5A+sPjfvye6Zgm8lUQ6Io98CMXSqYasaW
 HiEg==
X-Gm-Message-State: APjAAAWkSmsVH591F1ibxhVOb8XsEA6XxETc4Da3XWIZT/OI6ERc8tmG
 ON44JG7LGbGgr9wtSy5DUBs9j5uWqgX7gkwlcew=
X-Google-Smtp-Source: APXvYqzmWRGO4qUN4k/JBpDAX10a9aQ+tJkCT9jAFjHzkrb2SiK8TH4kIUDHCjegUVG6+JT4C8UXTS4+ET1yRm2F6Jk=
X-Received: by 2002:a5d:4a84:: with SMTP id o4mr15452496wrq.396.1576852150100; 
 Fri, 20 Dec 2019 06:29:10 -0800 (PST)
MIME-Version: 1.0
References: <20191219123029.200788-1-marcandre.lureau@redhat.com>
 <20191219123029.200788-10-marcandre.lureau@redhat.com>
 <20191220141452.GP1699760@redhat.com>
In-Reply-To: <20191220141452.GP1699760@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 20 Dec 2019 18:28:54 +0400
Message-ID: <CAJ+F1CJmj6eJcbd0faGRA+wp=06zVprR2HBkiNmLeBPdGdXtOg@mail.gmail.com>
Subject: Re: [PATCH v7 9/9] tests: add dbus-vmstate-test
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: Michal Privoznik <mprivozn@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 QEMU <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Dec 20, 2019 at 6:24 PM Daniel P. Berrang=C3=A9 <berrange@redhat.co=
m> wrote:
>
> On Thu, Dec 19, 2019 at 04:30:29PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  MAINTAINERS                  |   1 +
> >  roms/SLOF                    |   2 +-
> >  tests/Makefile.include       |  22 +-
> >  tests/dbus-vmstate-daemon.sh |  95 +++++++++
> >  tests/dbus-vmstate-test.c    | 382 +++++++++++++++++++++++++++++++++++
> >  tests/dbus-vmstate1.xml      |  12 ++
> >  6 files changed, 512 insertions(+), 2 deletions(-)
> >  create mode 100755 tests/dbus-vmstate-daemon.sh
> >  create mode 100644 tests/dbus-vmstate-test.c
> >  create mode 100644 tests/dbus-vmstate1.xml
>
>
> > diff --git a/roms/SLOF b/roms/SLOF
> > index 9546892a80..8ebf2f55e1 160000
> > --- a/roms/SLOF
> > +++ b/roms/SLOF
> > @@ -1 +1 @@
> > -Subproject commit 9546892a80d5a4c73deea6719de46372f007f4a6
> > +Subproject commit 8ebf2f55e1ba1492b942ba4b682160e644fc0f98
>
> Accidental change. With that removed
>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

argh, removed, thanks

>
>
> Regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
>
>


--=20
Marc-Andr=C3=A9 Lureau

