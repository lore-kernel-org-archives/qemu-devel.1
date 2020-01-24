Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF65C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 13:40:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BBDD20702
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 13:40:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J+/D38IS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BBDD20702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuzCc-0001FU-Cu
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 08:40:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35831)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iuzBP-00005h-R2
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 08:39:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iuzBN-0007aw-Un
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 08:39:35 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:23274
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iuzBN-0007Y2-Pq
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 08:39:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579873173;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jZwNwWEPVCsTrqhmqr3jMlYKmkCSFC78F4CAG0t+dwE=;
 b=J+/D38IS5C7shJ156IqMkxSEAUz3J4+RqLc90DHhWjqBVrEzlaLyD9X8V3XahkAXsPMVen
 aDuE4gh4ff5+f44XriSK2tA7Df+mpPyxMLzSbsS79TvEu0PaOSgfNX0JqtXo76HSbAIirP
 raW1mnUZY+iZAAIrH1X959dSX48FrRQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-72-iqt6Flj7OReFMa8v9GnpIg-1; Fri, 24 Jan 2020 08:39:31 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 063F21800D48;
 Fri, 24 Jan 2020 13:39:30 +0000 (UTC)
Received: from dhcp-200-226.str.redhat.com (dhcp-200-226.str.redhat.com
 [10.33.200.226])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7B52684D90;
 Fri, 24 Jan 2020 13:39:20 +0000 (UTC)
Date: Fri, 24 Jan 2020 14:39:19 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Felipe Franciosi <felipe@nutanix.com>
Subject: Re: [PATCH] iscsi: Cap block count from GET LBA STATUS (CVE-2020-1711)
Message-ID: <20200124133919.GD4732@dhcp-200-226.str.redhat.com>
References: <B07CB62A-7860-4385-A6A4-4ECA211DBE42@nutanix.com>
 <9F93582E-139B-45B2-8630-FDD331F09DEF@kamp.de>
 <c00fc076-3a46-7a52-a539-66751fb2943a@redhat.com>
 <6C861A00-A30A-4CED-85F7-412A13760C4B@nutanix.com>
MIME-Version: 1.0
In-Reply-To: <6C861A00-A30A-4CED-85F7-412A13760C4B@nutanix.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: iqt6Flj7OReFMa8v9GnpIg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Peter Turschmid <peter.turschm@nutanix.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Peter Lieven <pl@kamp.de>,
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, P J P <ppandit@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 24.01.2020 um 11:48 hat Felipe Franciosi geschrieben:
> > On Jan 24, 2020, at 10:04 AM, Philippe Mathieu-Daud=E9 <philmd@redhat.c=
om> wrote:
> > On 1/23/20 11:58 PM, Peter Lieven wrote:
> >>> Am 23.01.2020 um 22:29 schrieb Felipe Franciosi <felipe@nutanix.com>:
> >>>> On Jan 23, 2020, at 5:46 PM, Philippe Mathieu-Daud=E9 <philmd@redhat=
.com> wrote:
> >>>>> On 1/23/20 1:44 PM, Felipe Franciosi wrote:
> >>>>> When querying an iSCSI server for the provisioning status of blocks=
 (via
> >>>>> GET LBA STATUS), Qemu only validates that the response descriptor z=
ero's
> >>>>> LBA matches the one requested. Given the SCSI spec allows servers t=
o
> >>>>> respond with the status of blocks beyond the end of the LUN, Qemu m=
ay
> >>>>> have its heap corrupted by clearing/setting too many bits at the en=
d of
> >>>>> its allocmap for the LUN.
> >>>>> A malicious guest in control of the iSCSI server could carefully pr=
ogram
> >>>>> Qemu's heap (by selectively setting the bitmap) and then smash it.
> >>>>> This limits the number of bits that iscsi_co_block_status() will tr=
y to
> >>>>> update in the allocmap so it can't overflow the bitmap.
> >>>>=20
> >>>> Please add:
> >>>>=20
> >>>> Fixes: CVE-2020-1711 (title of CVE if possible)
> >>>=20
> >>> I wasn't sure we had one yet. Kevin: can you do the needful in your b=
ranch?

I added the CVE number, though I don't have a title.

> >>>> Cc: qemu-stable@nongnu.org
> >>>=20
> >>> Yeah, that's there.
> >>>=20
> >>>>=20
> >>>>> Signed-off-by: Felipe Franciosi <felipe@nutanix.com>
> >>>>> Signed-off-by: Peter Turschmid <peter.turschm@nutanix.com>
> >>>>> Signed-off-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
> >>>>> ---
> >>>>> block/iscsi.c | 5 +++--
> >>>>> 1 file changed, 3 insertions(+), 2 deletions(-)
> >>>>> diff --git a/block/iscsi.c b/block/iscsi.c
> >>>>> index 2aea7e3f13..cbd57294ab 100644
> >>>>> --- a/block/iscsi.c
> >>>>> +++ b/block/iscsi.c
> >>>>> @@ -701,7 +701,7 @@ static int coroutine_fn iscsi_co_block_status(B=
lockDriverState *bs,
> >>>>>     struct scsi_get_lba_status *lbas =3D NULL;
> >>>>>     struct scsi_lba_status_descriptor *lbasd =3D NULL;
> >>>>>     struct IscsiTask iTask;
> >>>>> -    uint64_t lba;
> >>>>> +    uint64_t lba, max_bytes;
> >>>>>     int ret;
> >>>>>       iscsi_co_init_iscsitask(iscsilun, &iTask);
> >>>>> @@ -721,6 +721,7 @@ static int coroutine_fn iscsi_co_block_status(B=
lockDriverState *bs,
> >>>>>     }
> >>>>>       lba =3D offset / iscsilun->block_size;
> >>>>> +    max_bytes =3D (iscsilun->num_blocks - lba) * iscsilun->block_s=
ize;
> >>>>>       qemu_mutex_lock(&iscsilun->mutex);
> >>>>> retry:
> >>>>> @@ -764,7 +765,7 @@ retry:
> >>>>>         goto out_unlock;
> >>>>>     }
> >>>>> -    *pnum =3D (int64_t) lbasd->num_blocks * iscsilun->block_size;
> >>>>> +    *pnum =3D MIN((int64_t) lbasd->num_blocks * iscsilun->block_si=
ze, max_bytes);
> >>>>>       if (lbasd->provisioning =3D=3D SCSI_PROVISIONING_TYPE_DEALLOC=
ATED ||
> >>>>>         lbasd->provisioning =3D=3D SCSI_PROVISIONING_TYPE_ANCHORED)=
 {
> >>>>=20
> >>>> What about this?
> >>>>=20
> >>>> -- >8 --
> >>>> diff --git a/block/iscsi.c b/block/iscsi.c
> >>>> index 2aea7e3f13..25598accbb 100644
> >>>> --- a/block/iscsi.c
> >>>> +++ b/block/iscsi.c
> >>>> @@ -506,6 +506,11 @@ iscsi_allocmap_update(IscsiLun *iscsilun, int64=
_t offset,
> >>>>    /* shrink to touch only completely contained clusters */
> >>>>    cl_num_shrunk =3D DIV_ROUND_UP(offset, iscsilun->cluster_size);
> >>>>    nb_cls_shrunk =3D (offset + bytes) / iscsilun->cluster_size - cl_=
num_shrunk;
> >>>> +    if (nb_cls_expanded >=3D iscsilun->allocmap_size
> >>>> +        || nb_cls_shrunk >=3D iscsilun->allocmap_size) {
> >>>> +        error_report("iSCSI invalid request: ..." /* TODO */);
> >>>> +        return;
> >>>> +    }
> >>>>    if (allocated) {
> >>>>        bitmap_set(iscsilun->allocmap, cl_num_expanded, nb_cls_expand=
ed);
> >>>>    } else {
> >>>> ---
> >>>=20
> >>> I'm not sure the above is correct because (if I read this right)
> >>> nb_cls_* represents the number of clusters, not the last cluster.
> >>>=20
> >>> Personally, I would have the checks (or "trim"s) closer to where they
> >>> were issued (to fail sooner) and assert()s closer to bitmap (as no oo=
b
> >>> accesses should be happening at this point). There were also
> >>> discussions about using safer (higher level) bitmaps for this. I'm
> >>> always in favour of adding all reasonable checks. :)
> >> I would add assertions that cl_num + nb_cls <=3D allocmap_size before
> >> every set and clear.

This makes sense to me. Do you want to send this as a follow-up patch?
I'd like to keep the CVE fix itself minimal.

> > The description starts with "A malicious guest in control of the
> > iSCSI server ..." so asserting (and killing the VM) doesn't seem
> > correct...

assert() isn't an error check, but it means that we deem it impossible
for the assertion to fail. This would be the case because we fixed (in
this patch) the only code path that we think could cause the problem.

We would only add it to find other buggy code paths that we missed or
that are added later.

> Correct. That's why I would have the proper checks (or "trim"s) closer
> to where they were issued to fail sooner. What I meant is that if a
> guest issues any operation that spans past the end of the drive, then
> the operation stops there and an error is returned accordingly.

Guests can't issue operations that span past the end of the drive. They
would return an error befor the iscsi driver is even called.

The only reason why we get such a request here is because of an internal
call with BDRV_REQUEST_MAX_BYTES. Maybe this should actually be changed
into MIN(BDRV_REQUEST_MAX_BYTES, bs->total_sectors * BDRV_SECTOR_SIZE),
and then iscsi_co_block_status() could assert that the request doesn't
span past the end of the drive.

> This means nothing should ever try to touch these bitmaps out of
> bounds. Nevertheless, and further to that, assert()s can be used
> closer to where the bitmap is touched to catch programming errors.
>=20
> > I suppose the iSCSI protocol has some error to return for invalid
> > requests.
>=20
> Which invalid you are referring to? From the initiator or the target?
> AFAICT the problem is that the SCSI SPEC doesn't limit a target to
> respond provisioning status past the (current) end of the LUN (either
> because this was not deemed important to stress, was forgotten, or is
> intentionally allowed).

In any case, we don't get an invalid request here. We are who made the
request. It's an unexpected response that we got.

> > Also shouldn't we report some warning in case of such invalid
> > request? So the management side can look at the 'malicious iSCSI
> > server'?
>=20
> I think having the option to do so is a good idea. There are two cases
> I can think of that you run into a "malicious" storage server:
> 1) Someone hacked your storage server
> 2) Your control plane allows your compute to connect to a user
> provided storage service
>=20
> Thinking as an admin, if I only allow storage servers I provide, then
> I want to see such warnings. If I let people point the VMM to dodgy
> servers, then I probably don't want the log spam.

For this reason, we generally don't log things for failed I/O requests.
If we wanted to introduce it, we'd better find a way to do so
consistently everywhere and not just in a single place with a one-off
option.

Kevin


