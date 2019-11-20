Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E84DC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 10:13:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BA6422311
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 10:13:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vwet87FE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BA6422311
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXMz6-0003JP-J4
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 05:13:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52892)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iXMxx-0002S4-My
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 05:12:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iXMxw-0004zN-D1
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 05:12:05 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23574
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1iXMxw-0004yV-9I
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 05:12:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574244723;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rbR9xK1Q5g4Fbi1Dg/t3OaeBigbTDLPMO0VADo5Ts4I=;
 b=Vwet87FEdfC6Ts2ep1BmjdLlFLFhamZjKc+iSK9chHAU+ZYZ3CZRSg8oWPxVK16wscPTjG
 AJJgMizGdKDrwwBVfILC3POHZl9BhbXvuZAGVpBpsPJAiSg++B9/Lv1QC5FLBufJLWchWI
 8b1pzI3GuvSDgMksp7a8Uo62AgQh9ZM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-njz0YyswMFiUdhOu2YNqQg-1; Wed, 20 Nov 2019 05:12:00 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0E22D80269F;
 Wed, 20 Nov 2019 10:11:59 +0000 (UTC)
Received: from gondolin (dhcp-192-218.str.redhat.com [10.33.192.218])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F37F46CE46;
 Wed, 20 Nov 2019 10:11:57 +0000 (UTC)
Date: Wed, 20 Nov 2019 11:11:55 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [RFC PATCH v1 1/8] vfio-ccw: Return IOINST_CC_NOT_OPERATIONAL
 for EIO
Message-ID: <20191120111155.200b3a2c.cohuck@redhat.com>
In-Reply-To: <20191119185911.0ccec0c9.pasic@linux.ibm.com>
References: <20191115033437.37926-1-farman@linux.ibm.com>
 <20191115033437.37926-2-farman@linux.ibm.com>
 <20191118191334.001f9343.cohuck@redhat.com>
 <20191119122340.41c77c5b.pasic@linux.ibm.com>
 <20191119130220.7c0eef35.cohuck@redhat.com>
 <20191119185911.0ccec0c9.pasic@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: njz0YyswMFiUdhOu2YNqQg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: qemu-s390x@nongnu.org, Jason Herne <jjherne@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, qemu-devel@nongnu.org,
 Jared Rossi <jrossi@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 19 Nov 2019 18:59:11 +0100
Halil Pasic <pasic@linux.ibm.com> wrote:

> On Tue, 19 Nov 2019 13:02:20 +0100
> Cornelia Huck <cohuck@redhat.com> wrote:
>=20
> > On Tue, 19 Nov 2019 12:23:40 +0100
> > Halil Pasic <pasic@linux.ibm.com> wrote:
> >  =20
> > > On Mon, 18 Nov 2019 19:13:34 +0100
> > > Cornelia Huck <cohuck@redhat.com> wrote:
> > >  =20
> > > > > EIO is returned by vfio-ccw mediated device when the backing
> > > > > host subchannel is not operational anymore. So return cc=3D3
> > > > > back to the guest, rather than returning a unit check.
> > > > > This way the guest can take appropriate action such as
> > > > > issue an 'stsch'.     =20
> > > >=20
> > > > Hnm, I'm trying to recall whether that was actually a conscious cho=
ice,
> > > > but I can't quite remember... the change does make sense at a glanc=
e,
> > > > however.   =20
> > >=20
> > > Is EIO returned if and only if the host subchannel/device is not
> > > operational any more, or are there cases as well?  =20
> >=20
> > Ok, I walked through the kernel code, and it seems -EIO can happen =20
>=20
> Thanks Connie for having a look.
>=20
> > - when we try to do I/O while in the NOT_OPER or STANDBY states... cc 3
> >   makes sense in those cases =20
>=20
> I do understand NOT_OPER, but I'm not sure about STANDBY.
>=20
> Here is what the PoP says about cc 3 for SSCH.
> """
> Condition code 3 is set, and no other action is
> taken, when the subchannel is not operational for
> START SUBCHANNEL. A subchannel is not opera-
> tional for START SUBCHANNEL if the subchannel is
> not provided in the channel subsystem, has no valid
> device number associated with it, or is not enabled.
> """
>=20
> Are we guaranteed to reflect one of these conditions back?
>=20
> Under what circumstances do we expect that our request will
> find the device in STANDBY?

IIRC, the subchannel is not enabled when the device is in STANDBY?

Anyway, it seems the check here is more like a safety measure, in case
we messed up.

>=20
> > - when the cp is not initialized when trying to fetch the orb... which
> >   is an internal vfio-ccw kernel module error =20
>=20
>=20
> So the answer seems to be, no EIO is also used for something else than
> 'device not operational' in a sense of the s390 IO architecture (cc=3D3
> and stuff).
>=20
> AFAIR the idea was that EIO means something is broken, and we decided
> to reflect that as an unit check (because the broader device -- the
> actual device + our pass-through code =3D=3D device for the guest) is bro=
ken.
> So I think it was a conscious choice.

Hm, if you put it like that... maybe leaving it as -EIO makes more sense.

The main question is: What happens if userspace triggers I/O to be
started and we find the device to have become not operational? Can we
even switch the state to NOT_OPER before we try the ssch (which will
fail with cc 3)? If not, it's probably safe to leave the -EIO in place.


