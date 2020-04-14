Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A889C2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 12:36:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 398622076B
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 12:36:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OK2anUE1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 398622076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOKnL-00020d-CD
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 08:36:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34254)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jOKmL-0000qg-3f
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 08:35:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jOKmJ-000204-Sl
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 08:35:00 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:31295
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jOKmJ-0001zi-OZ
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 08:34:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586867699;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q7aQ9iTe3NU3/M6dWeJq70+/jIANGvwMraAvZEZ1/3o=;
 b=OK2anUE1qHn7soQP7+atyIO05o7zKVM+Bdsz3CTjgwUBxeOagfh9FznYYA6xKp9ho8DpPV
 yJT07aJRbAbqhmDHrEDHJoQeROh/T+aibV4lDYE4I8xYi7qpYJsAc0HFPfoICPaFGZXhBb
 lsPphXrHotz4p6+VqbHiZBn1YpXK+VY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-RJvyo4E2OWmoGuaW28sagw-1; Tue, 14 Apr 2020 08:34:57 -0400
X-MC-Unique: RJvyo4E2OWmoGuaW28sagw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5B4ED1088383;
 Tue, 14 Apr 2020 12:34:56 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-1.ams2.redhat.com [10.36.114.1])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5BD1F9F996;
 Tue, 14 Apr 2020 12:34:55 +0000 (UTC)
Date: Tue, 14 Apr 2020 14:34:53 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: qcow2: Zero-initialization of external data files
Message-ID: <20200414123453.GD7747@linux.fritz.box>
References: <db0b4b5c-d564-f003-bbbc-9afdcac07cc4@redhat.com>
 <50080252-ff22-78ed-0002-1742c694471b@redhat.com>
 <8b4bc264-7bce-c9c1-1905-a22b4c61cae4@redhat.com>
 <ad2542f0-1faf-88eb-9dac-36d87a2a795f@redhat.com>
 <ff515dc1-0ac1-08c6-b636-cd50c09cab7d@redhat.com>
 <e91aa2c9-5709-ee1c-d8e9-45f12493613e@redhat.com>
 <cc17fee7-3349-063c-3531-f6239676dc50@redhat.com>
 <713d39ff-29f6-f9e0-bbbc-c9b26ffd28a0@redhat.com>
 <5a8099d6-3885-2bfe-f85a-477c5cc76a45@redhat.com>
 <8c7ba1fe-6995-2465-789b-29212d07bf23@redhat.com>
MIME-Version: 1.0
In-Reply-To: <8c7ba1fe-6995-2465-789b-29212d07bf23@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 09.04.2020 um 17:56 hat Eric Blake geschrieben:
> On 4/9/20 10:46 AM, Eric Blake wrote:
>=20
> > > > We don't support concurrent modification. But if the guest is runni=
ng
> > > > and unmaps things, then shuts off, then we edit the raw file offlin=
e,
> > > > then we restart the guest, the guest should see the results of thos=
e
> > > > offline edits.
> > >=20
> > > Should it?=C2=A0 The specification doesn=E2=80=99t say anything about=
 that.
> > >=20
> > > In fact, I think we have always said we explicitly discourage that
> > > because this might lead to outdated metadata; even though we usually
> > > meant =E2=80=9Cdirty bitmaps=E2=80=9D by that.
> >=20
> > Hmm.=C2=A0 Kevin, I'd really like your opinion here.=C2=A0 The point of=
 the
> > raw-external-data flag is to state that "qemu MUST ensure that whatever
> > is done to this image while the guest is running is reflected through t=
o
> > the raw file, so that after the guest stops, the raw file alone is stil=
l
> > viable to see what the guest saw".=C2=A0 But as you say, there's a diff=
erence
> > between "the raw file will read what the guest saw" and "we can now edi=
t
> > the raw file without regards to the qcow2 wrapper but later reuse of th=
e
> > qcow2 wrapper won't be corrupted by those edits".
>=20
> Another random thought: Should we add a header extension that records the
> timestamps of an external data file?  That way, if the timestamps of the
> file have changed from what we recorded in our optional header, then we c=
an
> flag to the user that our metadata may be stale because of what appears t=
o
> be external edits.  But that's not always going to save us - timestamps o=
n a
> block device don't behave the same as timestamps on a POSIX file, and jus=
t
> because timestamps change (such as when copying a file from one place to
> another) does not imply that contents have changed.  My personal take -
> unless adding such a header can definitely add safety, it may not be wort=
h
> the cost of complicating the standard - this was more just documenting an
> idea I had even if we don't choose to pursue it.

In the context of verifying backing file links, Jeff Cody once brought
up an idea where we would have something like a generation counter in
the header that would be increased every time you open the image
read-write. Then you could store that counter value in the backing file
and external data file links and detect if someone else wrote to the
child image and invalidated it.

Though obviously raw images still won't have a counter, and if they had
one, nobody would increase it when writing to it externally, so it
doesn't actually work for real-world external data files...

I wouldn't rely on file timestamps, you already mentioned some good
reasons.

Kevin


