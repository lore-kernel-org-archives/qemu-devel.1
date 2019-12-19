Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F585C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 14:55:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59A3020684
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 14:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IenbsFkx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59A3020684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihxCe-0003HO-5R
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 09:55:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60639)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nsoffer@redhat.com>) id 1ihx7l-0004Cz-Vv
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 09:49:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nsoffer@redhat.com>) id 1ihx7k-0005eG-5e
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 09:49:57 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:53601
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <nsoffer@redhat.com>) id 1ihx7j-0005by-VF
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 09:49:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576766995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2jL9y9Irc9aF4WE6Bv2hasioUx0bagEywYcLr/1Y8SQ=;
 b=IenbsFkxWvB7rKOYPoKYWsPZdlrCtXTnCmdp4osgj6k2mgw1EnmyFqoXeyIV8ets0+C53s
 Z4haYsiY1S5MBeBZC8cSL7OwDuqk0UEz9FfOzUSTQBot1dqYnlmd3xTW0Hwkv2zLiwtSI0
 tX628b+YHyWcM5WOY1HQFg9HHHQhQug=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-261-WZ4ZwiSZOGW7HikR88JtAQ-1; Thu, 19 Dec 2019 09:49:52 -0500
Received: by mail-oi1-f197.google.com with SMTP id c137so1953864oib.11
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 06:49:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Q2heyqxOxFRRm7uWCGEs4npzMF4RHI6SCahtegVTv98=;
 b=bxN3ngD/WzUnZcI03RN7KAIwK4M9WA6rqI7F/MrKXSkvsEW2wZOtilruvmdtOo5S6d
 qcdN73T47cMibnpqGOjxsmp3hEjsLBMOS98fomYEbBKTkAhSaLRCIWfUGUYOZq4+mpDh
 ROHEo+P8T+Us8cHI8jOZG3cxeAr0ljGrtw3MwUSzSV3WJ+SPoAtUkC79wmaYnGqvVZ4A
 cyHAea0TnFVoGcS/Jef/6B73abfyHr15OlfJjLtThqUc93rxiNl3NT1zKgro5rpvf3A0
 ByBLUuvbzVaI22WHKdEkn5xsZApN9cfA3fftc1Ha2pkYH5xRhmG1hl52R2DwWhfP2iiz
 hYFw==
X-Gm-Message-State: APjAAAWU2D7FeEZYMQt3tjLWnKS1sv0uLulK5ifXboEnEM0YddbEu3KM
 c8b5pq38ENTL7Vz/WlJuFOo9Ln0a67P6kDrT03SQZ8JE4pvS4QE3FGWDfnA+xNgB4dpU64/Hehu
 SygJu91oBNrRPGzYu6X6GH0mxvsb1Fvg=
X-Received: by 2002:a9d:5885:: with SMTP id x5mr9002008otg.132.1576766991215; 
 Thu, 19 Dec 2019 06:49:51 -0800 (PST)
X-Google-Smtp-Source: APXvYqzJ2YVPP2q++PffR82vzMYM6evSuuNMfDVn+4Xh45GWhck689hdYMkkKnPZf7czLvD0S9KRK51gtlsNYq8eaL0=
X-Received: by 2002:a9d:5885:: with SMTP id x5mr9001968otg.132.1576766990834; 
 Thu, 19 Dec 2019 06:49:50 -0800 (PST)
MIME-Version: 1.0
References: <20191219125151.21482-1-nsoffer@redhat.com>
 <443c32b3-0e0c-ef9e-4d5b-9404b16eaa02@virtuozzo.com>
In-Reply-To: <443c32b3-0e0c-ef9e-4d5b-9404b16eaa02@virtuozzo.com>
From: Nir Soffer <nsoffer@redhat.com>
Date: Thu, 19 Dec 2019 16:49:10 +0200
Message-ID: <CAMRbyyurHvOo5hWSScSGdfiB4i11jXKED=4FtWvxUSAcCefJVQ@mail.gmail.com>
Subject: Re: [PATCH] block: nbd: Fix dirty bitmap context name
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-MC-Unique: WZ4ZwiSZOGW7HikR88JtAQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Nir Soffer <nirsof@gmail.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Dec 19, 2019 at 3:42 PM Vladimir Sementsov-Ogievskiy
<vsementsov@virtuozzo.com> wrote:
>
> I'd not call it a "fix".. As it implies something broken.
>
> [edit: OK, now I see that something is broken, and why you called it "fix=
",
>   see below]
>
> 19.12.2019 15:51, Nir Soffer wrote:
> > When adding an export with a dirty bitmap, expose the bitmap at:
> >
> >      qemu:dirty-bitmap:export-name
>
> export-name? But it would be extra information, as client already knows
> with which export it works.

Right, using empty string would be good as well.

> NBD commands NBD_OPT_GET/SET_META_CONTEXT includes export name as a
> parameter, so, any queried metadata (bitmaps, etc) is always bound to
> specified export.
>
> >
> > This matches qapi documentation, and user expectations.
>
> Hmmm,
> "qemu" namespace is documented in docs/interop/nbd.txt, not in Qapi,
> which is also mention in official NBD spec.
>
>
> Ahh, I see, it's documented as
>
> +# @bitmap: Also export the dirty bitmap reachable from @device, so the
> +#          NBD client can use NBD_OPT_SET_META_CONTEXT with
> +#          "qemu:dirty-bitmap:NAME" to inspect the bitmap. (since 4.0)
>
> and it is logical to assume that export name (which is @name argument) is
> mentioned. But we never mentioned it. This is just documented after
> removed experimenatl command x-nbd-server-add-bitmap,
>
> look at
>
> commit 7dc570b3806e5b0a4c9219061556ed5a4a0de80c
> Author: Eric Blake <eblake@redhat.com>
> Date:   Fri Jan 11 13:47:18 2019 -0600
>
>      nbd: Remove x-nbd-server-add-bitmap
>
> ...
>
> -# @bitmap-export-name: How the bitmap will be seen by nbd clients
> -#                      (default @bitmap)
> -#
> -# Note: the client must use NBD_OPT_SET_META_CONTEXT with a query of
> -# "qemu:dirty-bitmap:NAME" (where NAME matches @bitmap-export-name) to a=
ccess
> -# the exposed bitmap.
>
>
> So, this "NAME" is saved and now looks incorrect. What should be fixed, i=
s Qapi
> documentation.
>
>
> >
> > Without this, qemu leaks libvirt implementations details to clients by
> > exposing the bitmap using the actual bitmap name:
> >
> >      qemu:dirty-bitmap:bitmap-name
>
> Yes, "qemu" namespace specification says:
> qemu:dirty-bitmap:<dirty-bitmap-export-name>
>
> so, <dirty-bitmap-export-name> may be exact bitmap name or may be somethi=
ng other.
>
> We just don't have an interface to set such name. It was in removed
> x-nbd-server-add-bitmap
>
> So, if you need this possibility now, the correct way is to add 'export-b=
itmap-name'
> optional parameter to nbd-server-add, like it was in x-nbd-server-add-bit=
map

I don't think we need such API. How would it help users trying to get
dirty extents
from an image?

> > And all clients need to duplicate code like:
> >
> >      meta_context =3D "qemu:dirty-bitmap:backup-" + export_name
> >
> > NBD allows exposing multiple bitmaps under "qemu:dirty-bitmap:"
> > namespace, and clients can query the available bitmaps, but it is not
> > clear what a client should do if a server provides multiple bitmaps.
> > ---
> >   nbd/server.c               |  2 +-
> >   tests/qemu-iotests/223     | 16 ++++++++--------
> >   tests/qemu-iotests/223.out |  8 ++++----
> >   3 files changed, 13 insertions(+), 13 deletions(-)
> >
> > diff --git a/nbd/server.c b/nbd/server.c
> > index 24ebc1a805..f20f2994c0 100644
> > --- a/nbd/server.c
> > +++ b/nbd/server.c
> > @@ -1574,7 +1574,7 @@ NBDExport *nbd_export_new(BlockDriverState *bs, u=
int64_t dev_offset,
> >           exp->export_bitmap =3D bm;
> >           assert(strlen(bitmap) <=3D BDRV_BITMAP_MAX_NAME_SIZE);
> >           exp->export_bitmap_context =3D g_strdup_printf("qemu:dirty-bi=
tmap:%s",
> > -                                                     bitmap);
> > +                                                     name);
>
> I think it's a bad idea to automatically name bitmap after export. Actual=
ly export may
> have several bitmaps (we just don't support it).

What are the semantics of multiple dirty bitmaps for same export? How
users are going
to use this?

>  "NAME" in Qapi spec is a mistake.
>
> >           assert(strlen(exp->export_bitmap_context) < NBD_MAX_STRING_SI=
ZE);
> >       }
> >
> > diff --git a/tests/qemu-iotests/223 b/tests/qemu-iotests/223
> > index ea69cd4b8b..3068a7c280 100755
> > --- a/tests/qemu-iotests/223
> > +++ b/tests/qemu-iotests/223
> > @@ -167,7 +167,7 @@ $QEMU_IO -r -c 'r -P 0x22 512 512' -c 'r -P 0 512k =
512k' -c 'r -P 0x11 1m 1m' \
> >   $QEMU_IMG map --output=3Djson --image-opts \
> >     "$IMG" | _filter_qemu_img_map
> >   $QEMU_IMG map --output=3Djson --image-opts \
> > -  "$IMG,x-dirty-bitmap=3Dqemu:dirty-bitmap:b" | _filter_qemu_img_map
> > +  "$IMG,x-dirty-bitmap=3Dqemu:dirty-bitmap:n" | _filter_qemu_img_map
> >
> >   echo
> >   echo "=3D=3D=3D Contrast to small granularity dirty-bitmap =3D=3D=3D"
> > @@ -175,7 +175,7 @@ echo
> >
> >   IMG=3D"driver=3Dnbd,export=3Dn2,server.type=3Dunix,server.path=3D$SOC=
K_DIR/nbd"
> >   $QEMU_IMG map --output=3Djson --image-opts \
> > -  "$IMG,x-dirty-bitmap=3Dqemu:dirty-bitmap:b2" | _filter_qemu_img_map
> > +  "$IMG,x-dirty-bitmap=3Dqemu:dirty-bitmap:n2" | _filter_qemu_img_map
> >
> >   echo
> >   echo "=3D=3D=3D End qemu NBD server =3D=3D=3D"
> > @@ -199,15 +199,15 @@ echo
> >   echo "=3D=3D=3D Use qemu-nbd as server =3D=3D=3D"
> >   echo
> >
> > -nbd_server_start_unix_socket -r -f $IMGFMT -B b "$TEST_IMG"
> > -IMG=3D"driver=3Dnbd,server.type=3Dunix,server.path=3D$nbd_unix_socket"
> > +nbd_server_start_unix_socket -r -f $IMGFMT -x n -B b "$TEST_IMG"
> > +IMG=3D"driver=3Dnbd,export=3Dn,server.type=3Dunix,server.path=3D$nbd_u=
nix_socket"
> >   $QEMU_IMG map --output=3Djson --image-opts \
> > -  "$IMG,x-dirty-bitmap=3Dqemu:dirty-bitmap:b" | _filter_qemu_img_map
> > +  "$IMG,x-dirty-bitmap=3Dqemu:dirty-bitmap:n" | _filter_qemu_img_map
> >
> > -nbd_server_start_unix_socket -f $IMGFMT -B b2 "$TEST_IMG"
> > -IMG=3D"driver=3Dnbd,server.type=3Dunix,server.path=3D$nbd_unix_socket"
> > +nbd_server_start_unix_socket -f $IMGFMT -x n -B b2 "$TEST_IMG"
> > +IMG=3D"driver=3Dnbd,export=3Dn,server.type=3Dunix,server.path=3D$nbd_u=
nix_socket"
> >   $QEMU_IMG map --output=3Djson --image-opts \
> > -  "$IMG,x-dirty-bitmap=3Dqemu:dirty-bitmap:b2" | _filter_qemu_img_map
> > +  "$IMG,x-dirty-bitmap=3Dqemu:dirty-bitmap:n" | _filter_qemu_img_map
> >
> >   # success, all done
> >   echo '*** done'
> > diff --git a/tests/qemu-iotests/223.out b/tests/qemu-iotests/223.out
> > index f175598802..9f879add60 100644
> > --- a/tests/qemu-iotests/223.out
> > +++ b/tests/qemu-iotests/223.out
> > @@ -61,7 +61,7 @@ exports available: 2
> >     max block: 33554432
> >     available meta contexts: 2
> >      base:allocation
> > -   qemu:dirty-bitmap:b
> > +   qemu:dirty-bitmap:n
> >    export: 'n2'
> >     size:  4194304
> >     flags: 0xced ( flush fua trim zeroes df cache fast-zero )
> > @@ -70,7 +70,7 @@ exports available: 2
> >     max block: 33554432
> >     available meta contexts: 2
> >      base:allocation
> > -   qemu:dirty-bitmap:b2
> > +   qemu:dirty-bitmap:n2
> >
> >   =3D=3D=3D Contrast normal status to large granularity dirty-bitmap =
=3D=3D=3D
> >
> > @@ -141,7 +141,7 @@ exports available: 2
> >     max block: 33554432
> >     available meta contexts: 2
> >      base:allocation
> > -   qemu:dirty-bitmap:b
> > +   qemu:dirty-bitmap:n
> >    export: 'n2'
> >     size:  4194304
> >     flags: 0xced ( flush fua trim zeroes df cache fast-zero )
> > @@ -150,7 +150,7 @@ exports available: 2
> >     max block: 33554432
> >     available meta contexts: 2
> >      base:allocation
> > -   qemu:dirty-bitmap:b2
> > +   qemu:dirty-bitmap:n2
> >
> >   =3D=3D=3D Contrast normal status to large granularity dirty-bitmap =
=3D=3D=3D
> >
> >
>
>
> --
> Best regards,
> Vladimir


