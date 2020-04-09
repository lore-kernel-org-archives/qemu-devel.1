Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8114BC2BA19
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 17:55:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D00920769
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 17:55:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eP6Uyi27"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D00920769
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMbP7-0000zo-HA
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 13:55:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42505)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jMbOO-0000W2-Mz
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 13:55:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1jMbON-0006EV-D3
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 13:55:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60152
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1jMbON-0006E6-8R
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 13:55:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586454906;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CRLxGsEJ8oonQg2Sfzzgn/yhXQ0dnrlMsVotJr0hi0Y=;
 b=eP6Uyi27ONqXLNT0+Gm2tdFWXQ2QpE0YfBRTNI+JaAqgIor7DfUXZ0GV8uV5X9fSlSylcG
 GpEqob/MeDpgQ3LZYMqM4ZbkPPlyE7JhaCbjH/SzlOWQH/DBMSslVuSh1KgES2HYeIh9LV
 U8CPsrvdDVzzbiiuxjCJPXGPG5DDZSI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-120-QRSp1mriOq-oSbLXe9kuvQ-1; Thu, 09 Apr 2020 13:54:58 -0400
X-MC-Unique: QRSp1mriOq-oSbLXe9kuvQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D3993800D53;
 Thu,  9 Apr 2020 17:54:56 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4426D60BF3;
 Thu,  9 Apr 2020 17:54:55 +0000 (UTC)
Date: Thu, 9 Apr 2020 18:54:51 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH RESEND 3/3] .travis.yml: Test building with Xcode 11.3
Message-ID: <20200409175451.GA1202384@redhat.com>
References: <20200218142018.7224-1-philmd@redhat.com>
 <20200218142018.7224-4-philmd@redhat.com>
 <874kvezw8h.fsf@linaro.org>
 <41c6101f-8334-b3de-8ba2-2d5808ec4e18@redhat.com>
MIME-Version: 1.0
In-Reply-To: <41c6101f-8334-b3de-8ba2-2d5808ec4e18@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Fam Zheng <fam@euphon.net>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Apr 09, 2020 at 07:44:46PM +0200, Philippe Mathieu-Daud=C3=A9 wrote=
:
> On 2/25/20 1:29 PM, Alex Benn=C3=A9e wrote:
> >=20
> > Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
> >=20
> > > We currently run a CI job on macOS Mojave with Xcode 10.
> > >=20
> > > QEMU policy is to support the two last major OS releases.
> > > Add a job building on macOS Catalina, which comes with Xcode 11.
> > >=20
> > > Split the target list in two, as we don't need to cover twice the
> > > same targets.
> > >=20
> > > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> > > ---
> > >   .travis.yml | 36 +++++++++++++++++++++++++++++++++++-
> > >   1 file changed, 35 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/.travis.yml b/.travis.yml
> > > index a2a7fd0dd1..d02a477623 100644
> > > --- a/.travis.yml
> > > +++ b/.travis.yml
> > > @@ -269,9 +269,10 @@ matrix:
> > >       # MacOSX builds - cirrus.yml also tests some MacOS builds inclu=
ding latest Xcode
> > > +    # On macOS Mojave, the SDK comes bundled with Xcode 10.
> > >       - name: "OSX Xcode 10.3"
> > >         env:
> > > -        - CONFIG=3D"--target-list=3Di386-softmmu,ppc-softmmu,ppc64-s=
oftmmu,m68k-softmmu,x86_64-softmmu --extra-cflags=3D-I/usr/local/opt/ncurse=
s/include --extra-ldflags=3D-L/usr/local/opt/ncurses/lib"
> > > +        - CONFIG=3D"--target-list=3Di386-softmmu,ppc-softmmu,ppc64-s=
oftmmu,m68k-softmmu --extra-cflags=3D-I/usr/local/opt/ncurses/include --ext=
ra-ldflags=3D-L/usr/local/opt/ncurses/lib"
> > >         os: osx
> > >         osx_image: xcode10.3
> > >         compiler: clang
> > > @@ -301,6 +302,39 @@ matrix:
> > >           - ${SRC_DIR}/configure ${BASE_CONFIG} ${CONFIG} || { cat co=
nfig.log && exit 1; }
> > > +    # On macOS Catalina, the SDK comes bundled with Xcode 11.
> > > +    - name: "OSX Xcode 11.3"
> > > +      env:
> > > +        - CONFIG=3D"--target-list=3Darm-softmmu,ppc64-softmmu,x86_64=
-softmmu --extra-cflags=3D-I/usr/local/opt/ncurses/include --extra-ldflags=
=3D-L/usr/local/opt/ncurses/lib"
> > > +      os: osx
> > > +      osx_image: xcode11.3
> >=20
> > Are we duplicating what the latest Xcode on Cirrus is here?
>=20
> Maybe, I'm not sure. It seems only few people care about Cirrus/Shippable
> but they are not taken seriously by the community, as they are often brok=
en
> and nobody is notified. Currently Travis has a broader audience.
>=20
> Also I sent a series to fix various things that break on Cirrus from time=
 to
> time but I felt there is not many interest so I stopped spending energy o=
n
> it:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg675074.html
>=20
> We could change that by refusing to merge pullreq that break such CI.

IMHO less is more. IOW, we should use/support the fewest  possible CI
systems required to get the coverage we want.  If we can get all macOS
coverage on Travis, I'd remove it from Cirrus, or vica-verca. The fewer
places we have to look at the more likely we'll pay attention to it
when it breaks.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


