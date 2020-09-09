Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85BCCC433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 13:22:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C77272087C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 13:22:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ij8s6Wbn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C77272087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG039-0008IZ-RA
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 09:22:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60010)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1kG01K-0006ai-P6
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 09:20:18 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:26681
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1kG01I-00043e-VX
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 09:20:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599657616;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nNR4JeplfVNGEJVbR6Up0yfGEfHTqExcrAoXNO8LEI0=;
 b=Ij8s6WbnZn4FNM+CzvdrtJSiTRDPwfvR7s3CPe4Q940AABjvH/pv7wuwHcRfoSovYe8Bb+
 7s6q5PHHR0cieiYYnjtUtyEqeN8PCBDZBQsFcmPbJn6YIkOD0HyN1ZlfNbuBLt6E95bbcf
 IRtan3J/jqreSdwpvz/5H7TlMUMSNDo=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-bH62_gYiNyGYNOobIakO1Q-1; Wed, 09 Sep 2020 09:20:14 -0400
X-MC-Unique: bH62_gYiNyGYNOobIakO1Q-1
Received: by mail-io1-f72.google.com with SMTP id l8so1910131ioa.11
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2020 06:20:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=nNR4JeplfVNGEJVbR6Up0yfGEfHTqExcrAoXNO8LEI0=;
 b=rEg71Jbx90n6cXfOZn5Jjj930DAesSV38SW67vhrwlGHb9GdJwV5rUxvVRmyNfW8Pu
 sQp5HZEIcCoFGyKK0wVZ5TleKP3zDSskh8IT5dE/GqPKcHW9Em7ncRvFrDmmZduisIlV
 Y8T5yZIrk5C7X0YDRfTYAiYR/A3K0EGi8vdHbYNrGvBA8sEwfeu8OSoti0VCOXM/tlFZ
 RGlZINNAAF0MFL82od6L03mENMi5WeXL9p8qdAsK8/X36vjc3jo/7zsZA3yJJqwI2vb4
 PSy+pvgA4shr3xooem+G5G/9hm2CfvYUyxoqXLJygjMlw0m7VtKtD45RhWvGOUoOueTh
 LUVw==
X-Gm-Message-State: AOAM530Z+s5q3SQeh6CGNASW/5Vu7SX5NIyHoaUz8Ubfx9q5zM3yGhpe
 D5bfvldOiCb7W+mRdL53aU52jHInwYmyRxI2N2Ox8TzN3FGfvKqSSjbTx9W7CMQlWMPgwHan6TJ
 O5raTCTW27y+shmsAo7XshOnocFZ6VQA=
X-Received: by 2002:a02:ce8c:: with SMTP id y12mr4079627jaq.53.1599657613889; 
 Wed, 09 Sep 2020 06:20:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwU5paDOTBDA/OwKl6npEkUuXiJ3m2a74amgBCx3SKtoJa9KWIoJgOB9HC5GxAOEoZ93i7Zf4/3eTqfioeL818=
X-Received: by 2002:a02:ce8c:: with SMTP id y12mr4079612jaq.53.1599657613723; 
 Wed, 09 Sep 2020 06:20:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200826110419.528931-1-marcandre.lureau@redhat.com>
 <20200826110419.528931-3-marcandre.lureau@redhat.com>
 <bfe25907-88ef-05ad-0464-1220c37439e2@redhat.com>
In-Reply-To: <bfe25907-88ef-05ad-0464-1220c37439e2@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 9 Sep 2020 17:20:02 +0400
Message-ID: <CAMxuvaztQgHRk4JzNsS278azStVxPSkS2M2xz9ZsDikRv8tUOQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/8] configure: always /-seperate directory from
 qemu_suffix
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mlureau@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 02:43:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Stefan Weil <sw@weilnetz.de>, "P. Berrange, Daniel" <berrange@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, "Bonzini, Paolo" <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Wed, Sep 9, 2020 at 5:15 PM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.c=
om> wrote:
>
> On 8/26/20 1:04 PM, marcandre.lureau@redhat.com wrote:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
>
> Typo "separate" in subject.
>
> Btw can you copy the subject in the commit description?
> This makes review simpler (no need to go back in the
> thread view to see the subject and go back into the
> mail to see the content).

ok

>
> > Otherwise, we may accept very strange directory names...
> >
> > While at it, quote the variables.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

The patch is already merged upstream :)

>
> > ---
> >  configure | 14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> >
> > diff --git a/configure b/configure
> > index 0e04c47722..61216b9210 100755
> > --- a/configure
> > +++ b/configure
> > @@ -474,7 +474,7 @@ modules=3D"no"
> >  module_upgrades=3D"no"
> >  prefix=3D"/usr/local"
> >  firmwarepath=3D"\${prefix}/share/qemu-firmware"
> > -qemu_suffix=3D"/qemu"
> > +qemu_suffix=3D"qemu"
> >  slirp=3D""
> >  oss_lib=3D""
> >  bsd=3D"no"
> > @@ -1823,12 +1823,12 @@ Advanced options (experts only):
> >    --with-git=3DGIT           use specified git [$git]
> >    --static                 enable static build [$static]
> >    --mandir=3DPATH            install man pages in PATH
> > -  --datadir=3DPATH           install firmware in PATH$qemu_suffix
> > -  --docdir=3DPATH            install documentation in PATH$qemu_suffix
> > +  --datadir=3DPATH           install firmware in PATH/$qemu_suffix
> > +  --docdir=3DPATH            install documentation in PATH/$qemu_suffi=
x
> >    --bindir=3DPATH            install binaries in PATH
> >    --libdir=3DPATH            install libraries in PATH
> >    --libexecdir=3DPATH        install helper binaries in PATH
> > -  --sysconfdir=3DPATH        install config in PATH$qemu_suffix
> > +  --sysconfdir=3DPATH        install config in PATH/$qemu_suffix
> >    --localstatedir=3DPATH     install local state in PATH (set at runti=
me on win32)
> >    --firmwarepath=3DPATH      search PATH for firmware files
> >    --efi-aarch64=3DPATH       PATH of efi file to use for aarch64 VMs.
> > @@ -6467,9 +6467,9 @@ EOF
> >      fi
> >  fi
> >
> > -qemu_confdir=3D$sysconfdir$qemu_suffix
> > -qemu_moddir=3D$libdir$qemu_suffix
> > -qemu_datadir=3D$datadir$qemu_suffix
> > +qemu_confdir=3D"$sysconfdir/$qemu_suffix"
> > +qemu_moddir=3D"$libdir/$qemu_suffix"
> > +qemu_datadir=3D"$datadir/$qemu_suffix"
> >  qemu_localedir=3D"$datadir/locale"
> >  qemu_icondir=3D"$datadir/icons"
> >  qemu_desktopdir=3D"$datadir/applications"
> >
>


