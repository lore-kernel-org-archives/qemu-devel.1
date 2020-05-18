Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C20E2C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 14:18:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DA9C20674
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 14:18:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eYD2+Y1b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DA9C20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jagbE-0005XK-QX
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 10:18:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40558)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jagab-00052E-Bf
 for qemu-devel@nongnu.org; Mon, 18 May 2020 10:17:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52668
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jagaa-0006EU-EV
 for qemu-devel@nongnu.org; Mon, 18 May 2020 10:17:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589811475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D9Yg9MojHhlMTkJENp2mrc6kyrENhxyWBFVM4B6Hyo4=;
 b=eYD2+Y1bLvSJysOT8ofOg8MbftwZKk0WGm2Zx6NfuVHL2zWXsuI37BUAWwYK5k2ay8C1Xv
 ry8E5x65YPNPDsN7xeynihrlP0Ibowk+cxL7hYFGn65VfUqZo5l/G4Jsa6JyQ1eyz0NFsz
 vsKG1KYIbYxJQpu8DcfoXB6bgYSKkVc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-DyBWQpQVNNKQrqgqq8cn4A-1; Mon, 18 May 2020 10:17:53 -0400
X-MC-Unique: DyBWQpQVNNKQrqgqq8cn4A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3ACD9EC1A2;
 Mon, 18 May 2020 14:17:52 +0000 (UTC)
Received: from gondolin (ovpn-113-28.ams2.redhat.com [10.36.113.28])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2DE21649D6;
 Mon, 18 May 2020 14:17:51 +0000 (UTC)
Date: Mon, 18 May 2020 16:17:48 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Eric Farman <farman@linux.ibm.com>
Subject: Re: [PATCH v2 1/1] vfio-ccw: allow non-prefetch ORBs
Message-ID: <20200518161748.0f12d64e.cohuck@redhat.com>
In-Reply-To: <c354be6e-d451-c332-a070-017f033af1c9@linux.ibm.com>
References: <20200512181535.18630-1-jrossi@linux.ibm.com>
 <20200512181535.18630-2-jrossi@linux.ibm.com>
 <20200514172021.5a66bc56.cohuck@redhat.com>
 <5e5a1a3d037cf3bcbd87da051b09b173@linux.vnet.ibm.com>
 <c354be6e-d451-c332-a070-017f033af1c9@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=cohuck@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/18 00:53:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-s390x@nongnu.org, Jared Rossi <jrossi@linux.ibm.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 15 May 2020 07:06:29 -0400
Eric Farman <farman@linux.ibm.com> wrote:

> On 5/14/20 2:39 PM, Jared Rossi wrote:
> > On 2020-05-14 11:20, Cornelia Huck wrote: =20
> >> On Tue, 12 May 2020 14:15:35 -0400
> >> Jared Rossi <jrossi@linux.ibm.com> wrote:
> >> =20
> >>> Remove the explicit prefetch check when using vfio-ccw devices.
> >>> This check does not trigger in practice as all Linux channel programs
> >>> are intended to use prefetch.
> >>>
> >>> It is no longer required to force the PFCH flag when using vfio-ccw
> >>> devices. =20
> >>
> >> That's not quite true: Only kernels that include the currently-queued
> >> patch do not require it. Maybe
> >>
> >> "Newer Linux kernel versions do not require to force the PFCH flag wit=
h
> >> vfio-ccw devices anymore." =20
>=20
> I like it.
>=20
> >>
> >> ?
> >> =20
> >=20
> > This is a good point and your proposed message is reasonable.

I'll use it, then :)

> >  =20
> >>>
> >>> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
> >>> ---
> >>> =C2=A0hw/vfio/ccw.c | 13 +++----------
> >>> =C2=A01 file changed, 3 insertions(+), 10 deletions(-)
> >>>
> >>> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> >>> index 50cc2ec75c..e649377b68 100644
> >>> --- a/hw/vfio/ccw.c
> >>> +++ b/hw/vfio/ccw.c
> >>> @@ -74,16 +74,9 @@ static IOInstEnding
> >>> vfio_ccw_handle_request(SubchDev *sch)
> >>> =C2=A0=C2=A0=C2=A0=C2=A0 struct ccw_io_region *region =3D vcdev->io_r=
egion;
> >>> =C2=A0=C2=A0=C2=A0=C2=A0 int ret;
> >>>
> >>> -=C2=A0=C2=A0=C2=A0 if (!(sch->orb.ctrl0 & ORB_CTRL0_MASK_PFCH)) {
> >>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!(vcdev->force_orb_pf=
ch)) {
> >>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 w=
arn_once_pfch(vcdev, sch, "requires PFCH flag set");
> >>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s=
ch_gen_unit_exception(sch);
> >>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 c=
ss_inject_io_interrupt(sch);
> >>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
eturn IOINST_CC_EXPECTED;
> >>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
> >>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s=
ch->orb.ctrl0 |=3D ORB_CTRL0_MASK_PFCH;
> >>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 w=
arn_once_pfch(vcdev, sch, "PFCH flag forced");
> >>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >>> +=C2=A0=C2=A0=C2=A0 if (!(sch->orb.ctrl0 & ORB_CTRL0_MASK_PFCH) &&
> >>> vcdev->force_orb_pfch) {
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sch->orb.ctrl0 |=3D ORB_C=
TRL0_MASK_PFCH;
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 warn_once_pfch(vcdev, sch=
, "PFCH flag forced");
> >>> =C2=A0=C2=A0=C2=A0=C2=A0 }
> >>>
> >>> =C2=A0=C2=A0=C2=A0=C2=A0 QEMU_BUILD_BUG_ON(sizeof(region->orb_area) !=
=3D sizeof(ORB)); =20
> >>
> >> Let me spell out what happens:
> >> - PFCH bit set -> no change
> >> - PFCH bit not set, but force_orb_pfch set -> no change
> >> - neither PFCH bit nor force_orb_pfch set:
> >> =C2=A0 - older kernels: QEMU makes the request, the kernel rejects it,=
 guest
> >> =C2=A0=C2=A0=C2=A0 gets a unit exception (same result for the guest as=
 before, only a
> >> =C2=A0=C2=A0=C2=A0 different code flow)
> >> =C2=A0 - newer kernels: QEMU makes the request, the kernel forwards th=
e
> >> =C2=A0=C2=A0=C2=A0 request (logging a rate-limited warning); the resul=
t depends on
> >> =C2=A0=C2=A0=C2=A0 whether the guest actually tries to rewrite the cha=
nnel program or
> >> =C2=A0=C2=A0=C2=A0 not
> >> =20
> >=20
> > This is correct, but I think it is worth noting that while the exceptio=
n
> > is the same in the case of new QEMU + old kernel, the logging is differ=
ent.
> > The old kernel code did not issue any warning if a non-prefetch ORB was
> > rejected, it simply raised the exception. In reality, the old kernel co=
de
> > path was not accessible because QEMU would always reject ORBs before th=
en
> > with the "requires PFCH flag set" message.=C2=A0 The new QEMU code does=
 not
> > issue a warning in this case.
> >=20
> > I considered keeping a warning for the non-prefetch path, but it seemed
> > excessive to me, since it causes a redundant warning when used with the
> > new kernel code (which I expect to be the case normally). Do you think
> > some sort of warning should still be issued by QEMU in this case, even
> > if it is redundant with the kernel warning? =20
>=20
> Hrm...  Keeping the warning out of QEMU might be beneficial.  Sure, when
> running with new kernels the message will be redundant, but if running
> with an old kernel the result will just be a silent error.

I don't think we need to care about that situation that much; I'd hope
that any distribution will pick both patches (or at least not the QEMU
patch without the kernel patch).

>=20
> >  =20
> >> I think that is what we want, and I think I'll queue this patch with
> >> the tweaked commit message, but I'd like a second opinion. =20
>=20
> I don't have a strong opinion of the messaging, but think everything
> else looks fine.  If you'd like to queue this patch with the tweaked
> commit message:

Ok, then I'll just go ahead and queue it.

>=20
> Reviewed-by: Eric Farman <farman@linux.ibm.com>
>=20
> >>
> >> (We should also deprecate force_orb_pfch in the future.) =20
>=20
> +1
>=20


