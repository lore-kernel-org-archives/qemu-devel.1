Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2CC4C83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 18:38:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72DB620575
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 18:38:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VMb/g54A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72DB620575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTV7y-0001X9-Fv
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 14:38:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51538)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jTV6q-0008JA-Rk
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 14:37:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jTV6p-0003qF-Jn
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 14:37:32 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:39137
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jTV6p-0003pp-2c
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 14:37:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588099049;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aiP2KdiMkklN7fG8XUhADL9D8SER+SrTaCY9lNiJvps=;
 b=VMb/g54ADvq8HcN70Vcms+rVD+pKrwJcS4XArnZdEcckS2yKyst0A6qDhH4d4OEcVl9GQa
 xr4Q5LnKgYKoQ20dVyIwdc5RRDuxwUvLznCtOE0KDjCxyryNChFtGAaUISgJW3h30HiCWJ
 WBXUQH/Y+WrkO52N1dXIQhK9cTch9qk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-494-wGZrxFxyPJ-DGK1G_L0mgg-1; Tue, 28 Apr 2020 14:37:23 -0400
X-MC-Unique: wGZrxFxyPJ-DGK1G_L0mgg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 168C8800C78;
 Tue, 28 Apr 2020 18:37:22 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-37.ams2.redhat.com [10.36.114.37])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B08B85C1BD;
 Tue, 28 Apr 2020 18:37:20 +0000 (UTC)
Date: Tue, 28 Apr 2020 20:37:19 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: backing chain & block status & filters
Message-ID: <20200428183719.GO5789@linux.fritz.box>
References: <a1c1b734-34dc-f8d3-b6a0-43b136e237e2@virtuozzo.com>
 <20e6c43f-c1a7-57db-58b9-3cb70f0e637f@redhat.com>
 <20200428112853.GC5789@linux.fritz.box>
 <2e3eab55-4a1d-f1a9-ab28-3f9399c57bfe@virtuozzo.com>
 <25f6278c-466d-c663-73e0-ef2d256b326d@redhat.com>
 <04dd8365-7077-766a-6d42-1aac26abbdeb@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <04dd8365-7077-766a-6d42-1aac26abbdeb@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 02:06:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 qemu-devel <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 28.04.2020 um 18:46 hat Vladimir Sementsov-Ogievskiy geschrieben:
> 28.04.2020 19:18, Eric Blake wrote:
> > On 4/28/20 10:13 AM, Vladimir Sementsov-Ogievskiy wrote:
> >=20
> > > > > Hm.=C2=A0 I could imagine that there are formats that have non-ze=
ro holes
> > > > > (e.g. 0xff or just garbage).=C2=A0 It would be a bit wrong for th=
em to return
> > > > > ZERO or DATA then.
> > > > >=20
> > > > > But OTOH we don=E2=80=99t care about such cases, do we?=C2=A0 We =
need to know whether
> > > > > ranges are zero, data, or unallocated.=C2=A0 If they aren=E2=80=
=99t zero, we only
> > > > > care about whether reading from it will return data from this lay=
er or not.
> > > > >=20
> > > > > So I suppose that anything that doesn=E2=80=99t support backing f=
iles (or
> > > > > filtered children) should always return ZERO and/or DATA.
> > > >=20
> > > > I'm not sure I agree with the notion that everything should be
> > > > BDRV_BLOCK_ALLOCATED at the lowest layer. It's not what it means to=
day
> > > > at least. If we want to change this, we will have to check all call=
ers
> > > > of bdrv_is_allocated() and friends who might use this to find holes=
 in
> > > > the file.
> > >=20
> > > Yes. Because they are doing incorrect (or at least undocumented and u=
nreliable) thing.
> >=20
> > Here's some previous mails discussing the same question about what bloc=
k_status should actually mean.=C2=A0 At the time, I was so scared of the pr=
ospect of something breaking if I changed things that I ended up keeping st=
atus quo, so here we are revisiting the topic several years later, still as=
king the same questions.
> >=20
> > https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg00069.html
> > https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg03757.html
> >=20
> > >=20
> > > >=20
> > > > Basically, the way bdrv_is_allocated() works today is that we assum=
e an
> > > > implicit zeroed backing layer even for block drivers that don't sup=
port
> > > > backing files.
> > >=20
> > > But read doesn't work so: it will read data from the bottom layer, no=
t from
> > > this implicit zeroed backing layer. And it is inconsistent. On read d=
ata
> > > comes exactly from this layer, not from its implicit backing. So it s=
hould
> > > return BDRV_BLOCK_ALLOCATED, accordingly to its definition..
> > >=20
> > > Or, we should at least document current behavior:
> > >=20
> > > =C2=A0=C2=A0 BDRV_BLOCK_ALLOCATED: the content of the block is determ=
ined by this
> > > =C2=A0=C2=A0 layer rather than any backing, set by block. Attention: =
it may not be set
> > > =C2=A0=C2=A0 for drivers without backing support, still data is of co=
urse read from
> > > =C2=A0=C2=A0 this layer. Note, that for such drivers BDRV_BLOCK_ALLOC=
ATED may mean
> > > =C2=A0=C2=A0 allocation on fs level, which occupies real space on dis=
k.. So, for such drivers
> > >=20
> > > =C2=A0=C2=A0 ZERO | ALLOCATED means that, read as zero, data may be a=
llocated on fs, or
> > > =C2=A0=C2=A0 (most probably) not,
> > > =C2=A0=C2=A0 don't look at ALLOCATED flag, as it is added by generic =
layer for another logic,
> > > =C2=A0=C2=A0 not related to fs-allocation.
> > >=20
> > > =C2=A0=C2=A0 0 means that, most probably, data doesn't occupy space o=
n fs, zero-status is
> > > =C2=A0=C2=A0 unknown (most probably non-zero)
> > >=20
> >=20
> > That may be right in describing the current situation, but again,
> > needs a GOOD audit of what we are actually using it for, and whether
> > it is what we really WANT to be using it for.=C2=A0 If we're going to
> > audit/refactor the code, we might as well get semantics that are
> > actually useful, rather than painfully contorted to documentation
> > that happens to match our current contorted code.
> >=20
>=20
> Honest enough:) I'll try to make a table.
>=20
> I don't think that reporting fs-allocation status is a bad thing. But
> I'm sure that it should be separated from backing-chain-allocated
> concept.

I think we could easily agree on what would be a good concept.

My concern is just that existing code probably uses existing semantics
and not what we consider more logical now. So if we change it, we must
make sure that we change all places that expect the old semantics.

Kevin


