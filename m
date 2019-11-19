Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13583C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 13:30:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D347A222C7
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 13:30:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EesYJZvJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D347A222C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX3a0-0002jZ-Qk
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 08:30:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35866)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iX3Z8-0002Cx-5v
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 08:29:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iX3Z5-0002zT-H2
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 08:29:08 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:57123
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iX3Z5-0002yj-47
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 08:29:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574170146;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vhoktl710ry/nv8UC2vlGgQiruiGewe8/ZJ5NWl3BoA=;
 b=EesYJZvJwzlk+ejxADrnXqbzyitqhuYQzSApcGgeYA4NwHYraaNN4uy6DUXfq40H1wYhV8
 uQBTGdiXaajCs/HXlpn6398E22MoJOXCAdScVCtWC6eujhRzjj/CY7dcOmR99IJzVkyf7r
 QhCxWlu/OfiIwA5URIGoUOzxeOWsycI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-143-oBtK3aKaObamttp1AUolGQ-1; Tue, 19 Nov 2019 08:29:02 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 423D01005500;
 Tue, 19 Nov 2019 13:29:01 +0000 (UTC)
Received: from linux.fritz.box (ovpn-116-75.ams2.redhat.com [10.36.116.75])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DE1E95E243;
 Tue, 19 Nov 2019 13:28:56 +0000 (UTC)
Date: Tue, 19 Nov 2019 14:28:55 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH 0/4] fix & merge block_status_above and is_allocated_above
Message-ID: <20191119132855.GD5910@linux.fritz.box>
References: <20191116163410.12129-1-vsementsov@virtuozzo.com>
 <09d0bab1-ed7d-4fd7-555d-93075f10d497@redhat.com>
 <6b0811ec-822e-1c4a-1512-d6f3945645d2@openvz.org>
 <5c894f55-71ec-6ef2-856d-d2f0b859144b@redhat.com>
 <6cb1ffd6-3fa2-7828-fdf1-42d31974c85c@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <6cb1ffd6-3fa2-7828-fdf1-42d31974c85c@virtuozzo.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: oBtK3aKaObamttp1AUolGQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: "fam@euphon.net" <fam@euphon.net>, Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 19.11.2019 um 13:30 hat Vladimir Sementsov-Ogievskiy geschrieben:
> 19.11.2019 15:20, Max Reitz wrote:
> > On 19.11.19 13:02, Denis V. Lunev wrote:
> >> On 11/19/19 1:22 PM, Max Reitz wrote:
> >>> On 16.11.19 17:34, Vladimir Sementsov-Ogievskiy wrote:
> >>>> Hi all!
> >>>>
> >>>> I wanted to understand, what is the real difference between bdrv_blo=
ck_status_above
> >>>> and bdrv_is_allocated_above, IMHO bdrv_is_allocated_above should wor=
k through
> >>>> bdrv_block_status_above..
> >>>>
> >>>> And I found the problem: bdrv_is_allocated_above considers space aft=
er EOF as
> >>>> UNALLOCATED for intermediate nodes..
> >>>>
> >>>> UNALLOCATED is not about allocation at fs level, but about should we=
 go to backing or
> >>>> not.. And it seems incorrect for me, as in case of short backing fil=
e, we'll read
> >>>> zeroes after EOF, instead of going further by backing chain.
> >>> Should we, though?  It absolutely makes sense to me to consider post-=
EOF
> >>> space as unallocated because, well, it is as unallocated as it gets.
> >>>
> >>> So from my POV it would make more sense to fall back to the backing f=
ile
> >>> for post-EOF reads.
> >>>
> >>> OTOH, I don=E2=80=99t know whether changing that behavior would quali=
fy as a
> >>> possible security issue now, because maybe someone has sensitive
> >>> information in the tail of some disk and then truncated the overlay s=
o
> >>> as to hide it?  But honestly, that seems ridiculous and I can=E2=80=
=99t imagine
> >>> people to do that.  (It would work only for the tail, and why not jus=
t
> >>> write zeroes there, which works everywhere?)  So in practice I don=E2=
=80=99t
> >>> believe that to be a problem.
> >>>
> >>> Max
> >>
> >> That seems to be wrong from my POW. Once we get block device truncated=
,
> >> it exposed that tail to the guest with all zeroes.
> >>
> >> Let us assume that we have virtual disk of length L. We create new top
> >> delta of
> >> length X (less then L) and new top delta after with length Y (more tha=
n L),
> >> like the following:
> >>
> >> [.........................] Y
> >> [........] X
> >> [...................] L
> >>
> >> Once the guest creates FS=C2=A0 on state Y it relies on the fact that =
data from X
> >> to Y is all zeroes.
> >>
> >> Any operations with backing chain must keep guest content to be tha sa=
me,
> >> i.e. if we commit from Y to L, virtual disk content should be preserve=
d,
> >> i.e.
> >> read as all zero even if there is some data in L from X to L.
> >>
> >> If we commit from X to Y, the range from X to L should remain all zero=
es.
> >>
> >> This is especially valid for backups, which can not be changed and are
> >> validated by the software from time to time.
> >>
> >> Does this makes sense?
> >=20
> > All right then.  But then there=E2=80=99s the case of commit not shrink=
ing the
> > backing file, so the guest content won=E2=80=99t be the same if you com=
mit a
> > short overlay into a longer backing file.
>=20
> Hmm. Isn't commit target truncated to source before operation?

Only if the target is smaller than the source.

Maybe we should change that, because I don't think it's expected that a
guest sees a larger disk, where old data reappears, after resizing
(shrinking) the active layer and then commiting it to the backing file.

Kevin


