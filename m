Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD5DC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 15:56:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58989227BF
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 15:56:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IVxUv7V7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58989227BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihyAB-0005DH-ID
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 10:56:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38754)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nsoffer@redhat.com>) id 1ihy9J-0004hw-VQ
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 10:55:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nsoffer@redhat.com>) id 1ihy9F-0001M6-Jm
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 10:55:37 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:28988
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <nsoffer@redhat.com>) id 1ihy9E-0001DK-Tm
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 10:55:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576770931;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZvjUA/BXhVRI0ozbYHiM0cud0VpjqyTU6Z5qZGGAStk=;
 b=IVxUv7V7V2jE17TlQnp7Jtm5ZHHc9rxngMDoB4LzSGVjy13viuxSmGcY2Oetr+V/1NtyZI
 tdyO5DEYtVnrTr71ZFeBMTp3CcWvVLC58aOZNa4XGKDTqbEtbpc40S0IEo5etLGfHkASLJ
 R5hrsGK4XCs3gwC2vR50RKYbWwxxFbM=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-biFPEl7XPqaFnmwIC8-2-A-1; Thu, 19 Dec 2019 10:55:27 -0500
Received: by mail-ot1-f72.google.com with SMTP id d16so2854492otq.19
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 07:55:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fgLLVviSuUig0QoiFOQk5aCUg6uWZ76TuJ1SocUnWgs=;
 b=Il+KQQlkfSO/ZCDI0bs9Ausdb/MC9f//uIUBpAkQXrexEeK3Fblr5uPUipA+56oOcQ
 lYRxF/7xROZ/4FPB4zxe6vb8xrVOhoSMJtYACHHXjt9WUZAM15oTlALG3EXKPlvWKGGv
 /iGMzVmxXlLbdy6jfhs1I6ygpRJXdBRksSLLm0M1qk4cxknkIu34dpBcEqB5FenmCNkK
 OrG79PSzcUaieA6h36SE3+GHuQPSrrsB1x1D0ahlU5e+Lbo2NFlOOd5/9JGNokiDZmgQ
 3cgJaa+oryUSEGqpnyBCcp4Ks+PEgUbAS+9JJ3SMFoZgMQDM//22/lFZmo6FXZdz5+zh
 VMsg==
X-Gm-Message-State: APjAAAWH9gFFkSPd89nEGJXR/nfVM2hQ2oZSIhhQnop/rLYOJULuhBsq
 /b9gjB0lDR/rKu7fZhZjXYUp7O3uynyTqTxQ9CIfQaQQ5QysTTFexD+6lkN9TMO/QqFnm0Jf+6y
 z6WWP4JHJzRnmu9Ane0oRgb70TP0yYcg=
X-Received: by 2002:a9d:7757:: with SMTP id t23mr9835700otl.315.1576770926417; 
 Thu, 19 Dec 2019 07:55:26 -0800 (PST)
X-Google-Smtp-Source: APXvYqySmcH56XDeA8RJJlr/JlxNfdZwS9GMszvt5O5peeasf/Ut85p0I4tjmVAg2WD1CQbN2yTKgmCMtCID8nQYxJc=
X-Received: by 2002:a9d:7757:: with SMTP id t23mr9835667otl.315.1576770925943; 
 Thu, 19 Dec 2019 07:55:25 -0800 (PST)
MIME-Version: 1.0
References: <20191219125151.21482-1-nsoffer@redhat.com>
 <443c32b3-0e0c-ef9e-4d5b-9404b16eaa02@virtuozzo.com>
 <20191219140433.GK5230@linux.fritz.box>
 <CAMRbyyvqa1_3U=2Q7HmCrRcEq+yJjxUP7MM-GM5hUdrZw=yBOw@mail.gmail.com>
 <ddf58827-72e8-f853-e6bc-05d19100c62d@virtuozzo.com>
In-Reply-To: <ddf58827-72e8-f853-e6bc-05d19100c62d@virtuozzo.com>
From: Nir Soffer <nsoffer@redhat.com>
Date: Thu, 19 Dec 2019 17:55:09 +0200
Message-ID: <CAMRbyysHGjsWaCWXW2+iNSwU03DhavRF6sJ9-POUx3Mky6LK7Q@mail.gmail.com>
Subject: Re: [PATCH] block: nbd: Fix dirty bitmap context name
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-MC-Unique: biFPEl7XPqaFnmwIC8-2-A-1
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>,
 Nir Soffer <nirsof@gmail.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Dec 19, 2019 at 5:17 PM Vladimir Sementsov-Ogievskiy
<vsementsov@virtuozzo.com> wrote:
>
> 19.12.2019 17:59, Nir Soffer wrote:
> > On Thu, Dec 19, 2019 at 4:04 PM Kevin Wolf <kwolf@redhat.com> wrote:
> >>
> >> Am 19.12.2019 um 14:41 hat Vladimir Sementsov-Ogievskiy geschrieben:
> >>> Ahh, I see, it's documented as
> >>>
> >>> +# @bitmap: Also export the dirty bitmap reachable from @device, so t=
he
> >>> +#          NBD client can use NBD_OPT_SET_META_CONTEXT with
> >>> +#          "qemu:dirty-bitmap:NAME" to inspect the bitmap. (since 4.=
0)
> >>>
> >>> and it is logical to assume that export name (which is @name argument=
) is
> >>> mentioned. But we never mentioned it. This is just documented after
> >>> removed experimenatl command x-nbd-server-add-bitmap,
> >>>
> >>> look at
> >>>
> >>> commit 7dc570b3806e5b0a4c9219061556ed5a4a0de80c
> >>> Author: Eric Blake <eblake@redhat.com>
> >>> Date:   Fri Jan 11 13:47:18 2019 -0600
> >>>
> >>>       nbd: Remove x-nbd-server-add-bitmap
> >>>
> >>> ...
> >>>
> >>> -# @bitmap-export-name: How the bitmap will be seen by nbd clients
> >>> -#                      (default @bitmap)
> >>> -#
> >>> -# Note: the client must use NBD_OPT_SET_META_CONTEXT with a query of
> >>> -# "qemu:dirty-bitmap:NAME" (where NAME matches @bitmap-export-name) =
to access
> >>> -# the exposed bitmap.
> >>>
> >>>
> >>> So, this "NAME" is saved and now looks incorrect. What should be fixe=
d, is Qapi
> >>> documentation.
> >>
> >> Hm, I don't know these interfaces very well, but from you explanation =
it
> >> looks to me as if having a bitmap name made sense with
> >> x-nbd-server-add-bitmap because it could be called more than once for
> >> exporting multiple bitmaps.
> >>
> >> But now, we have only nbd-server-add, which takes a single bitmap name=
.
> >> As we don't have to distinguish multiple bitmaps any more, wouldn't it
> >> make more sense to use "qemu:dirty-bitmap" without any other
> >> information? Both export name and bitmap name are already identified b=
y
> >> the connection.
> >
> > We can use empty string (like the default export name), so the bitmap
> > would be exposed as:
> >
> >      "qemu:dirty-bitmap:"
> >
> > This would solve the issue for users, and keep the API extensible.
>
> As I already said, we can not. If we really wont such thing, use another =
name,
> likq qemu:default-dirty-bitmap..
>
> Or call bitmap export "default", to produce
>   "qemu:dirty-bitmaps:default"
>
> But don't change default behavior of nbd-server-add
>
> >
> >> But if we have to have something there, using the bitmap name (which m=
ay
> >> or may not be the same as used in the image file) makes a little more
> >> sense because it makes the interface extensible for the case that we
> >> ever want to re-introduce an nbd-server-add-bitmap.
> >
> > But using the bitmap name means user of the NBD server need to know thi=
s name.
>
> Why not? What is your case exactly? User knows, what kind of bitmap you a=
re
> exporting, so user is in some relation with exporting process anyway. Why
> shouldn't it know the name?

Because the user configuring qemu (libvirt) is not the same user
accessing qemu NBD
server (ovirt, or some backup application).

> This name may be defined in you exporting protocol.. What are you exporti=
ng?

We export HTTP API, allowing getting dirty extents and reading data:
https://www.ovirt.org/develop/release-management/features/storage/increment=
al-backup.html#map-request
(this document is outdated, but it gives the general idea)

Or provide the NBD URL directly to user (future).

> Note also, that client may use NBD_OPT_LIST_META_CONTEXT with query
> "qemu:dirty-bitmap:", to get list of all exported bitmaps.

This is another option, I did not try to use this yet. We can use the singl=
e
exported bitmap and fail if we get more than one. This is probably better
than changing the entire stack to support bitmap name.

> > One option is that libvirt would publish the name of the bitmap in the
> > xml describing
> > the backup, and oVirt will have to propagate this name to the actual
> > program accessing
> > the NBD server, which may be a user program in the case when we expose =
the NBD
> > URL to users (planned for future version).
> >
> > Another option is that the user will control this name, and libvirt
> > will use the name specified
> > by the user. This means oVirt will have to provide API to set this
> > name and pass it to libvirt.
> >
> > Both cases require lot of effort which does not help anyone in the
> > task of getting dirty
> > extents from an image - which is our current goal. We need to have
> > good defaults that
> > save unneeded effort in the entire stack.
>
> So, you implementing some protocol, and need to export only one bitmap fo=
r
> your specified scenario. Why not just give a constant name? Like ovirt-bi=
tmap,
> or something like this?

But we don't use qemu directly. We use libvirt, and libvirt does not expose
the name of the bitmap, or let use control this name.

This is a simplified flow:
1. libvirt starts a backup, creating the "backup-exportname" bitmap
2. oVirt host agent reports the nbd url for the disk
3. oVirt manager configures nbd/http proxy with nbd url
4. User (e.g. backup application) access the http/nbd proxy to get the
dirty extents

Alternatively, oVirt mangaer would provide the NBD url directly to the user=
,
and it will access it directly with some NBD client.

To make this work we need to pass more information between the
different programs
and change APIs to publish or accept bitmap names. This is a lot of
work that does
not help the current use case, accessing a single dirty bitmap.

We can solve it in libvirt if we don't have another choice.

> (of course, we need new optional paramter export-bitmap-name for nbd-serv=
er-add,
> as I proposes, or reimplement nbd-server-add-bitmap)
>
> >
> >> (By the way, even if the patch were correct,
> >
> > I don't think this is about correctness, but having better default for =
users.
> >
>
> Changing defaults always breaks existing users. For example Virtuozzo. We=
 live
> with these defaults, you can't just change it without any new option.. I =
hope.

That's a good point, we should not break existing usage.

Nir


