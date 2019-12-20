Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C2FAC43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 10:41:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 377B02465E
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 10:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I3wVUUcl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 377B02465E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiFip-0004ax-BC
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 05:41:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36160)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pkrempa@redhat.com>) id 1iiFhy-0003nm-RW
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 05:40:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pkrempa@redhat.com>) id 1iiFhw-000488-AV
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 05:40:34 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:50613
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pkrempa@redhat.com>) id 1iiFhv-00041G-W4
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 05:40:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576838430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X3Vb64JyzecrG3PZ5SCzYB+5PwEz191yESrWY+6bAww=;
 b=I3wVUUclxgheWSqKFj92jUuTsxERTUBBbBoEKHpx6Swfgvw29AGzDA9txEIfr93Nf7ArpI
 vjr2sjBwb3nTvX/5ZXHEmlmq6YdVcYUDoBtj1hFu3q+3iaauhlmzLdTkqU899BYohzMbQX
 eBOy35THPq1kul/rUXKqFbdgGGUqEqE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-DgeOI6ejN1SsMoDADNMdhA-1; Fri, 20 Dec 2019 05:40:29 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F1BA2800C74;
 Fri, 20 Dec 2019 10:40:27 +0000 (UTC)
Received: from andariel.pipo.sk (ovpn-205-6.brq.redhat.com [10.40.205.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A1A135DA70;
 Fri, 20 Dec 2019 10:40:25 +0000 (UTC)
Date: Fri, 20 Dec 2019 11:40:22 +0100
From: Peter Krempa <pkrempa@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH] block: nbd: Fix dirty bitmap context name
Message-ID: <20191220104022.GL4914@andariel.pipo.sk>
References: <20191219125151.21482-1-nsoffer@redhat.com>
 <443c32b3-0e0c-ef9e-4d5b-9404b16eaa02@virtuozzo.com>
 <20191219140433.GK5230@linux.fritz.box>
 <CAMRbyyvqa1_3U=2Q7HmCrRcEq+yJjxUP7MM-GM5hUdrZw=yBOw@mail.gmail.com>
 <ddf58827-72e8-f853-e6bc-05d19100c62d@virtuozzo.com>
 <CAMRbyysHGjsWaCWXW2+iNSwU03DhavRF6sJ9-POUx3Mky6LK7Q@mail.gmail.com>
 <42c73579-fdaa-5590-39f9-ca9cacfeaa5e@virtuozzo.com>
 <20191220095617.GK4914@andariel.pipo.sk>
 <a372b586-17a4-9984-68d2-a1131fc219f2@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <a372b586-17a4-9984-68d2-a1131fc219f2@virtuozzo.com>
X-PGP-Key-ID: 0xD018682B
X-PGP-Key-Fingerprint: D294 FF38 A6A2 BF40 6C75  5DEF 36EC 16AC D018 682B
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: DgeOI6ejN1SsMoDADNMdhA-1
X-Mimecast-Spam-Score: 0
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
Cc: Kevin Wolf <kwolf@redhat.com>, Nir Soffer <nirsof@gmail.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Nir Soffer <nsoffer@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Dec 20, 2019 at 10:06:17 +0000, Vladimir Sementsov-Ogievskiy wrote:
> 20.12.2019 12:56, Peter Krempa wrote:
> > On Fri, Dec 20, 2019 at 09:39:17 +0000, Vladimir Sementsov-Ogievskiy wr=
ote:
> >> 19.12.2019 18:55, Nir Soffer wrote:
> >>> On Thu, Dec 19, 2019 at 5:17 PM Vladimir Sementsov-Ogievskiy
> >>> <vsementsov@virtuozzo.com> wrote:
> >>>>
> >>>> 19.12.2019 17:59, Nir Soffer wrote:
> >>>>> On Thu, Dec 19, 2019 at 4:04 PM Kevin Wolf <kwolf@redhat.com> wrote=
:
> >>>>>>
> >>>>>> Am 19.12.2019 um 14:41 hat Vladimir Sementsov-Ogievskiy geschriebe=
n:
> >>>>>>> Ahh, I see, it's documented as
> >>>>>>>
> >>>>>>> +# @bitmap: Also export the dirty bitmap reachable from @device, =
so the
> >>>>>>> +#          NBD client can use NBD_OPT_SET_META_CONTEXT with
> >>>>>>> +#          "qemu:dirty-bitmap:NAME" to inspect the bitmap. (sinc=
e 4.0)
> >>>>>>>
> >>>>>>> and it is logical to assume that export name (which is @name argu=
ment) is
> >>>>>>> mentioned. But we never mentioned it. This is just documented aft=
er
> >>>>>>> removed experimenatl command x-nbd-server-add-bitmap,
> >>>>>>>
> >>>>>>> look at
> >>>>>>>
> >>>>>>> commit 7dc570b3806e5b0a4c9219061556ed5a4a0de80c
> >>>>>>> Author: Eric Blake <eblake@redhat.com>
> >>>>>>> Date:   Fri Jan 11 13:47:18 2019 -0600
> >>>>>>>
> >>>>>>>         nbd: Remove x-nbd-server-add-bitmap
> >>>>>>>
> >>>>>>> ...
> >>>>>>>
> >>>>>>> -# @bitmap-export-name: How the bitmap will be seen by nbd client=
s
> >>>>>>> -#                      (default @bitmap)
> >>>>>>> -#
> >>>>>>> -# Note: the client must use NBD_OPT_SET_META_CONTEXT with a quer=
y of
> >>>>>>> -# "qemu:dirty-bitmap:NAME" (where NAME matches @bitmap-export-na=
me) to access
> >>>>>>> -# the exposed bitmap.
> >>>>>>>
> >>>>>>>
> >>>>>>> So, this "NAME" is saved and now looks incorrect. What should be =
fixed, is Qapi
> >>>>>>> documentation.
> >>>>>>
> >>>>>> Hm, I don't know these interfaces very well, but from you explanat=
ion it
> >>>>>> looks to me as if having a bitmap name made sense with
> >>>>>> x-nbd-server-add-bitmap because it could be called more than once =
for
> >>>>>> exporting multiple bitmaps.
> >>>>>>
> >>>>>> But now, we have only nbd-server-add, which takes a single bitmap =
name.
> >>>>>> As we don't have to distinguish multiple bitmaps any more, wouldn'=
t it
> >>>>>> make more sense to use "qemu:dirty-bitmap" without any other
> >>>>>> information? Both export name and bitmap name are already identifi=
ed by
> >>>>>> the connection.
> >>>>>
> >>>>> We can use empty string (like the default export name), so the bitm=
ap
> >>>>> would be exposed as:
> >>>>>
> >>>>>        "qemu:dirty-bitmap:"
> >>>>>
> >>>>> This would solve the issue for users, and keep the API extensible.
> >>>>
> >>>> As I already said, we can not. If we really wont such thing, use ano=
ther name,
> >>>> likq qemu:default-dirty-bitmap..
> >>>>
> >>>> Or call bitmap export "default", to produce
> >>>>     "qemu:dirty-bitmaps:default"
> >>>>
> >>>> But don't change default behavior of nbd-server-add
> >>>>
> >>>>>
> >>>>>> But if we have to have something there, using the bitmap name (whi=
ch may
> >>>>>> or may not be the same as used in the image file) makes a little m=
ore
> >>>>>> sense because it makes the interface extensible for the case that =
we
> >>>>>> ever want to re-introduce an nbd-server-add-bitmap.
> >>>>>
> >>>>> But using the bitmap name means user of the NBD server need to know=
 this name.
> >>>>
> >>>> Why not? What is your case exactly? User knows, what kind of bitmap =
you are
> >>>> exporting, so user is in some relation with exporting process anyway=
. Why
> >>>> shouldn't it know the name?
> >>>
> >>> Because the user configuring qemu (libvirt) is not the same user
> >>> accessing qemu NBD
> >>> server (ovirt, or some backup application).
> >>>
> >>>> This name may be defined in you exporting protocol.. What are you ex=
porting?
> >>>
> >>> We export HTTP API, allowing getting dirty extents and reading data:
> >>> https://www.ovirt.org/develop/release-management/features/storage/inc=
remental-backup.html#map-request
> >>> (this document is outdated, but it gives the general idea)
> >>>
> >>> Or provide the NBD URL directly to user (future).
> >>>
> >>>> Note also, that client may use NBD_OPT_LIST_META_CONTEXT with query
> >>>> "qemu:dirty-bitmap:", to get list of all exported bitmaps.
> >>>
> >>> This is another option, I did not try to use this yet. We can use the=
 single
> >>> exported bitmap and fail if we get more than one. This is probably be=
tter
> >>> than changing the entire stack to support bitmap name.
> >>>
> >>>>> One option is that libvirt would publish the name of the bitmap in =
the
> >>>>> xml describing
> >>>>> the backup, and oVirt will have to propagate this name to the actua=
l
> >>>>> program accessing
> >>>>> the NBD server, which may be a user program in the case when we exp=
ose the NBD
> >>>>> URL to users (planned for future version).
> >>>>>
> >>>>> Another option is that the user will control this name, and libvirt
> >>>>> will use the name specified
> >>>>> by the user. This means oVirt will have to provide API to set this
> >>>>> name and pass it to libvirt.
> >>>>>
> >>>>> Both cases require lot of effort which does not help anyone in the
> >>>>> task of getting dirty
> >>>>> extents from an image - which is our current goal. We need to have
> >>>>> good defaults that
> >>>>> save unneeded effort in the entire stack.
> >>>>
> >>>> So, you implementing some protocol, and need to export only one bitm=
ap for
> >>>> your specified scenario. Why not just give a constant name? Like ovi=
rt-bitmap,
> >>>> or something like this?
> >>>
> >>> But we don't use qemu directly. We use libvirt, and libvirt does not =
expose
> >>> the name of the bitmap, or let use control this name.
> >>>
> >>> This is a simplified flow:
> >>> 1. libvirt starts a backup, creating the "backup-exportname" bitmap
> >>
> >> But do you manage exportname, or not?
> >=20
> > They can't manage the export name either, but apparently the default
> > that libvirt uses suits them.
> >=20
> > I can add possibility to name the actual backup output bitmap
> > arbitrarily. Obviously the user then has to pass a sensible name of a
> > non existant bitmap to proceed.
> >=20
> > Making both configurable at the same time may be worth doing as it will
> > be basically the same code.
> >=20
>=20
> Intuitively, I think it's better leave bitmap name as is: libvirt manages
> bitmaps, so let it manage their names as it wants. And I don't think that
> Nir want to care about existing bitmaps.

Actually for an incremental backup we are creating a new bitmap which is
used for merging all the appropriate bitmaps for the expected backup
range. This is done also when only one bitmap would be selected this way
as there's no point in optimizing this algorithm.

This means we can name the new bitmap arbitrarily (if it doesn't clash
with existing bitmap) and since that name will be also exported it's the
same they request.


