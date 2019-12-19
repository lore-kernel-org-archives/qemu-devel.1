Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB0FC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 15:01:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0983A2146E
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 15:01:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IGsKLZk1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0983A2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihxIc-0003HZ-2h
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 10:01:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33782)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nsoffer@redhat.com>) id 1ihxH6-0001ul-HO
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 09:59:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nsoffer@redhat.com>) id 1ihxH5-00021z-1t
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 09:59:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47879
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <nsoffer@redhat.com>) id 1ihxH4-0001xc-SI
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 09:59:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576767574;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4WWy+5Bx/dL8fRWurgHdarKsEsD+NPE4AlSFHDBTPo4=;
 b=IGsKLZk1E2vLr/r2GdWXvd+KCwf9RzD639XgWv0Xjm+/lNpOGCPY2hJG5AgHHjkJv+JFmp
 0dgb65rM/PmphX3AuAYL8W1qDhoAE7g/7+ftNfuojbutsfgcUUxa150dAnYK25nl2bcwy5
 hAG0lIaRqxLHgEUDZYSCVsYJlJ57LrI=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-McABfoK0Noi4W_8JJEZOvQ-1; Thu, 19 Dec 2019 09:59:30 -0500
Received: by mail-oi1-f199.google.com with SMTP id u16so2886479oic.5
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 06:59:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=J2KiB+wsrNiC0sVE3a/EJ/BbJfwSjuSAteQiJafrJa0=;
 b=UKh76xYdPSzgurDwePuQxu7BLaBjwS2CI7ChKrQPsdvvPyj0JBJpUf1hCuB1sd35lS
 MQZXU61p6QjR6/5HFN/sHwO9o2at7GFHrGCbzflU5B2He3lT1Nd/3d/odc142R/6jniO
 iYcV6ToI/ic4bo9CD6Vv8Osqf9NZ2qPDQahGexQplYTF7MD940w2KRpIWeczo6RXMEw3
 nD+uAaJ8iAO9OtAOB+EB7SNygzXZrW/1WGmx6FeYRLFx+cIom5QBx4DcDshz3ssnpj2t
 OeMmaBmsRDZbq9AqNkoUZDpDu5LJpng25gxd571b63Kjt/cWgEJIrNYNeclvHvBTCcFu
 jzoA==
X-Gm-Message-State: APjAAAWms4rzAN77Wi8RZ7XDRr1T9L8fbQjpANLNorItbAF9Q13UeVD0
 FMJBEC0/kEYgCi/dks1X8zCSTasQ78A4Wa8Ui4exyBu99XY47vQRkvmqVOCzAHYsrKi/6L6RAZh
 BkqxVyqqGPN7Tob9Bc9z3cx8LVcpckT0=
X-Received: by 2002:aca:b986:: with SMTP id j128mr2386475oif.16.1576767569602; 
 Thu, 19 Dec 2019 06:59:29 -0800 (PST)
X-Google-Smtp-Source: APXvYqx2dg6auhd2Hdh+lwJmuGxnilOuFdC3kkUB4HZ3GA2XCtJ/216hCqIKowgSC8BwbQ5/t6sOrfQMhfEo0K6TFC8=
X-Received: by 2002:aca:b986:: with SMTP id j128mr2386467oif.16.1576767569264; 
 Thu, 19 Dec 2019 06:59:29 -0800 (PST)
MIME-Version: 1.0
References: <20191219125151.21482-1-nsoffer@redhat.com>
 <443c32b3-0e0c-ef9e-4d5b-9404b16eaa02@virtuozzo.com>
 <20191219140433.GK5230@linux.fritz.box>
In-Reply-To: <20191219140433.GK5230@linux.fritz.box>
From: Nir Soffer <nsoffer@redhat.com>
Date: Thu, 19 Dec 2019 16:59:13 +0200
Message-ID: <CAMRbyyvqa1_3U=2Q7HmCrRcEq+yJjxUP7MM-GM5hUdrZw=yBOw@mail.gmail.com>
Subject: Re: [PATCH] block: nbd: Fix dirty bitmap context name
To: Kevin Wolf <kwolf@redhat.com>
X-MC-Unique: McABfoK0Noi4W_8JJEZOvQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Nir Soffer <nirsof@gmail.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Dec 19, 2019 at 4:04 PM Kevin Wolf <kwolf@redhat.com> wrote:
>
> Am 19.12.2019 um 14:41 hat Vladimir Sementsov-Ogievskiy geschrieben:
> > Ahh, I see, it's documented as
> >
> > +# @bitmap: Also export the dirty bitmap reachable from @device, so the
> > +#          NBD client can use NBD_OPT_SET_META_CONTEXT with
> > +#          "qemu:dirty-bitmap:NAME" to inspect the bitmap. (since 4.0)
> >
> > and it is logical to assume that export name (which is @name argument) =
is
> > mentioned. But we never mentioned it. This is just documented after
> > removed experimenatl command x-nbd-server-add-bitmap,
> >
> > look at
> >
> > commit 7dc570b3806e5b0a4c9219061556ed5a4a0de80c
> > Author: Eric Blake <eblake@redhat.com>
> > Date:   Fri Jan 11 13:47:18 2019 -0600
> >
> >      nbd: Remove x-nbd-server-add-bitmap
> >
> > ...
> >
> > -# @bitmap-export-name: How the bitmap will be seen by nbd clients
> > -#                      (default @bitmap)
> > -#
> > -# Note: the client must use NBD_OPT_SET_META_CONTEXT with a query of
> > -# "qemu:dirty-bitmap:NAME" (where NAME matches @bitmap-export-name) to=
 access
> > -# the exposed bitmap.
> >
> >
> > So, this "NAME" is saved and now looks incorrect. What should be fixed,=
 is Qapi
> > documentation.
>
> Hm, I don't know these interfaces very well, but from you explanation it
> looks to me as if having a bitmap name made sense with
> x-nbd-server-add-bitmap because it could be called more than once for
> exporting multiple bitmaps.
>
> But now, we have only nbd-server-add, which takes a single bitmap name.
> As we don't have to distinguish multiple bitmaps any more, wouldn't it
> make more sense to use "qemu:dirty-bitmap" without any other
> information? Both export name and bitmap name are already identified by
> the connection.

We can use empty string (like the default export name), so the bitmap
would be exposed as:

    "qemu:dirty-bitmap:"

This would solve the issue for users, and keep the API extensible.

> But if we have to have something there, using the bitmap name (which may
> or may not be the same as used in the image file) makes a little more
> sense because it makes the interface extensible for the case that we
> ever want to re-introduce an nbd-server-add-bitmap.

But using the bitmap name means user of the NBD server need to know this na=
me.

One option is that libvirt would publish the name of the bitmap in the
xml describing
the backup, and oVirt will have to propagate this name to the actual
program accessing
the NBD server, which may be a user program in the case when we expose the =
NBD
URL to users (planned for future version).

Another option is that the user will control this name, and libvirt
will use the name specified
by the user. This means oVirt will have to provide API to set this
name and pass it to libvirt.

Both cases require lot of effort which does not help anyone in the
task of getting dirty
extents from an image - which is our current goal. We need to have
good defaults that
save unneeded effort in the entire stack.

> (By the way, even if the patch were correct,

I don't think this is about correctness, but having better default for user=
s.

Nir


