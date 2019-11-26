Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9782BC432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 22:11:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EE8C2064B
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 22:11:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PZwtMGG6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EE8C2064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZj3J-0002ka-HT
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 17:11:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55741)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iZj1w-00021H-Eu
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 17:09:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iZj1u-0002jk-M3
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 17:09:56 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27928
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iZj1u-0002jF-GS
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 17:09:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574806193;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cfRYAvXPi4l2cq1FV+ujK2jJmKkdSYUR/qCAuiWb+jQ=;
 b=PZwtMGG6hi8zuRFw4m8CPx+loZSr+kDhAPzSKWANIIa4QR5148gcQiiDAbBvatGLmw5RBV
 PKS6ANbri5iWYMoCB1X+5j4UJdwSKxRiAeP0Kqipe31oVvx+Zty0M1/Vfe8KDIHqXTiTyv
 k/sUDihWwHK6pljUx5aMqAXnLuNQUVE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-G2LUe2hFP_O3kjnG7JXuRw-1; Tue, 26 Nov 2019 17:09:50 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E1F8E1803817;
 Tue, 26 Nov 2019 22:09:48 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-171.ams2.redhat.com [10.36.117.171])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2B0D05C241;
 Tue, 26 Nov 2019 22:09:37 +0000 (UTC)
Date: Tue, 26 Nov 2019 23:09:36 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Alexander Popov <alex.popov@linux.com>
Subject: Re: [PATCH v2 1/1] ide: check DMA transfer size in ide_dma_cb() to
 prevent qemu DoS from quests
Message-ID: <20191126220936.GF5889@linux.fritz.box>
References: <20191114172531.10644-1-alex.popov@linux.com>
 <20191121150352.GH6007@linux.fritz.box>
 <214785dc-d4b3-598f-4c48-c5703a28b8c4@linux.com>
MIME-Version: 1.0
In-Reply-To: <214785dc-d4b3-598f-4c48-c5703a28b8c4@linux.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: G2LUe2hFP_O3kjnG7JXuRw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Andrea Arcangeli <aarcange@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>, sstabellini@kernel.org,
 pmatouse@redhat.com, mdroth@linux.vnet.ibm.com, qemu-block@nongnu.org,
 "Michael S . Tsirkin" <mst@redhat.com>, qemu-stable@nongnu.org,
 qemu-devel@nongnu.org, Kashyap Chamarthy <kashyap.cv@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 pjp@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 26.11.2019 um 22:24 hat Alexander Popov geschrieben:
> Hello Kevin,
>=20
> Thanks for your review,
>=20
> On 21.11.2019 18:03, Kevin Wolf wrote:
> > Am 14.11.2019 um 18:25 hat Alexander Popov geschrieben:
> >> The commit a718978ed58a from July 2015 introduced the assertion which
> >> implies that the size of successful DMA transfers handled in ide_dma_c=
b()
> >> should be multiple of 512 (the size of a sector). But guest systems ca=
n
> >> initiate DMA transfers that don't fit this requirement.
> >>
> >> PoC for Linux that uses SCSI_IOCTL_SEND_COMMAND to perform such an ATA
> >> command and crash qemu:
> ...
> >=20
> > It would be nicer to turn the reproducer into a test case for
> > tests/ide-test.c.
>=20
> Yes, I can do that.
>=20
> >> For fixing that let's check the number of bytes prepared for the trans=
fer
> >> by the prepare_buf() handler. If it is not a multiple of 512 then end
> >> the DMA transfer with an error.
> >>
> >> That also fixes the I/O stall in guests after a DMA transfer request
> >> for less than the size of a sector.
> >>
> >> Signed-off-by: Alexander Popov <alex.popov@linux.com>
> >=20
> > This patch makes ide-test fail:
> >=20
> >   TEST    check-qtest-x86_64: tests/ide-test
> > **
> > ERROR:tests/ide-test.c:469:test_bmdma_short_prdt: assertion failed (sta=
tus =3D=3D 0): (0x00000004 =3D=3D 0x00000000)
> > ERROR - Bail out! ERROR:tests/ide-test.c:469:test_bmdma_short_prdt: ass=
ertion failed (status =3D=3D 0): (0x00000004 =3D=3D 0x00000000)
>=20
> Thanks for the notice.
> Yes, I can reproduce it too with `make check-qtest-i386`.
>=20
> >> diff --git a/hw/ide/core.c b/hw/ide/core.c
> >> index 754ff4dc34..85aac614f0 100644
> >> --- a/hw/ide/core.c
> >> +++ b/hw/ide/core.c
> >> @@ -849,6 +849,7 @@ static void ide_dma_cb(void *opaque, int ret)
> >>      int64_t sector_num;
> >>      uint64_t offset;
> >>      bool stay_active =3D false;
> >> +    int32_t prepared =3D 0;
> >> =20
> >>      if (ret =3D=3D -EINVAL) {
> >>          ide_dma_error(s);
> >> @@ -892,12 +893,10 @@ static void ide_dma_cb(void *opaque, int ret)
> >>      n =3D s->nsector;
> >>      s->io_buffer_index =3D 0;
> >>      s->io_buffer_size =3D n * 512;
> >> -    if (s->bus->dma->ops->prepare_buf(s->bus->dma, s->io_buffer_size)=
 < 512) {
> >> -        /* The PRDs were too short. Reset the Active bit, but don't r=
aise an
> >> -         * interrupt. */
> >> -        s->status =3D READY_STAT | SEEK_STAT;
> >> -        dma_buf_commit(s, 0);
> >> -        goto eot;
> >> +    prepared =3D s->bus->dma->ops->prepare_buf(s->bus->dma, s->io_buf=
fer_size);
> >> +    if (prepared % 512) {
> >> +        ide_dma_error(s);
> >=20
> > Which I assume is because you changed the error mode here compared to
> > the old version.
>=20
> Yes, you are right.
>=20
> > I'm not sure offhand what the correct behaviour is for non-aligned
> > values > 512. I think we actually have two cases here: Either a short o=
r
> > a long PRD. The commit message should explain this with spec references
> > and a test case should be added for both cases.
>=20
> I've found the "Programming Interface for Bus Master IDE Controller" (rev=
ision
> 1.0 5/16/94). The chapter 3.1 (Status Bit Interpretation) provides some a=
nswers.

Yes, I think that's the same that I've used before. I assume it's the
relevant spec.

> It says that:
>   1. If PRD's specified a smaller size than the IDE transfer size, then t=
he
> Interrupt and Active bits in the Controller status register are not set.

>   2. If the size of the physical memory regions was larger than the IDE d=
evice
> transfer size, the Interrupt and Active bits in the Controller status reg=
ister
> are both set to 1.
>=20
> So my changing of the error mode in short PRD's case was wrong, and the
> test_bmdma_short_prdt() is correct.

Yes, I think 1. is implemented correctly for PRDs that are too small and
smaller than a sector.

I think the assumption may have been that if the PRDT contains at least
one more full sector, we'll do that one sector before coming back to the
same place and hitting the code path for a too short PRDT.

However, the code neglects to actually use the return value of
.prepare_buf() to limit the number of sectors accessed. So if we ask for
a scatter/gather list for 5 sectors and we get 3 sectors, we still
assume we can write to all 5. This is obviously wrong.

> Now let's think about the proper fix of the qemu crash.
>=20
> Currently I don't really understand how ide_dma_cb() emulates the logic
> described in Status Bit Interpretation chapter. I don't see any compariso=
n
> between the DMA transfer size and PRD's size.
>=20
> We only have this check against the size of a sector (512 bytes), which d=
oesn't
> catch all short PRD's cases (PRD in my PoC is 1337 bytes).

I think for making the above assumption work, we'd have to check the
return value, which gets us something like:

    ret =3D s->bus->dma->ops->prepare_buf()
    if (ret < 512) {
        ... short PRDT code ...
    } else if (ret < n * 512) {
        n =3D ret / 512;
    }

Instead of doing the extra iteration and executing I/O for the first
part of the request, maybe this would work, too:

    ret =3D s->bus->dma->ops->prepare_buf()
    if (ret < n * 512) {
        ... short PRDT code ...
    }

We need to check in the spec whether we're supposed to actually do
partial I/O for short PRDTs. I couldn't find a clear answer with a quick
look, but I'm leaning towards doing the partial I/O (i.e. implementing
the first pseudo-code piece above).


As for handling long PRDTs, we have code that looks like it's meant to
handle the case:

    n =3D s->io_buffer_size >> 9;
    if (n > s->nsector) {
        /* The PRDs were longer than needed for this request. Shorten them =
so
         * we don't get a negative remainder. The Active bit must remain se=
t
         * after the request completes. */
        n =3D s->nsector;
        stay_active =3D true;
    }

bmdma_prepare_buf() does potentially set s->io_buffer_size to a value
larger than the passed limit, so maybe this is already correct. We have
a basic test for it in test_bmdma_long_prdt(), but I can't rule out that
there are more complicated cases where it fails.

I'm pretty sure we must handle the long PRDT case only after doing I/O
(like we currently do) because the operation is supposed to have
completed by the time we signal that the PRDT was long, so the guest can
trust that a read has actually read something and a write has reached
the disk. The spec says "This is a valid completion case".


Does this make sense to you?

Kevin


