Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DAB3C35247
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 19:05:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22B032082E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 19:05:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d56E4vp/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22B032082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iz3Vx-0006NC-6i
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 14:05:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36793)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iz3V9-0005oW-9E
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 14:04:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iz3V6-0006eM-FY
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 14:04:46 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:47484
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iz3V5-0006Uu-VE
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 14:04:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580843082;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ap3r5w6g6n+TNs2N87YLAmUHyR9kSI1zTQEnnNY/oWM=;
 b=d56E4vp/HJOZdqI0Q/HbzpGQ1Gs6YIhdTt5GCuRum5o9BFWMzSUKQXX51JH8Q71Ckv1743
 31Iozrzg5RzY+zPhsoIT9S7KbaJGeFhuo3Cwv64Gl8kqEd5tLLNgxAkJMPXZR/iXh8Ot9s
 zeIz6JInCW4h9zs7/22cb3gRELad3RI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-393-lu_ejQRIPJq5j33h9JYotQ-1; Tue, 04 Feb 2020 14:04:03 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4764C190D37A;
 Tue,  4 Feb 2020 19:04:01 +0000 (UTC)
Received: from [10.3.116.181] (ovpn-116-181.phx2.redhat.com [10.3.116.181])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9FC3E87B0B;
 Tue,  4 Feb 2020 19:03:54 +0000 (UTC)
Subject: Re: [PATCH 09/17] block: Refactor bdrv_has_zero_init{,_truncate}
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
References: <20200131174436.2961874-1-eblake@redhat.com>
 <20200131174436.2961874-10-eblake@redhat.com>
 <a857dce1-ef71-d62b-016e-ff9486af361b@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <ab03b053-5caa-7316-25ed-d6103889d06e@redhat.com>
Date: Tue, 4 Feb 2020 13:03:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <a857dce1-ef71-d62b-016e-ff9486af361b@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: lu_ejQRIPJq5j33h9JYotQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 "open list:Sheepdog" <sheepdog@lists.wpkg.org>, qemu-block@nongnu.org,
 Jeff Cody <codyprime@gmail.com>, Stefan Weil <sw@weilnetz.de>,
 Peter Lieven <pl@kamp.de>, "Richard W.M. Jones" <rjones@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, david.edmondson@oracle.com,
 Stefan Hajnoczi <stefanha@redhat.com>, Liu Yuan <namei.unix@gmail.com>,
 "Denis V. Lunev" <den@openvz.org>, Jason Dillaman <dillaman@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/4/20 11:53 AM, Max Reitz wrote:
> On 31.01.20 18:44, Eric Blake wrote:
>> Having two slightly-different function names for related purposes is
>> unwieldy, especially since I envision adding yet another notion of
>> zero support in an upcoming patch.  It doesn't help that
>> bdrv_has_zero_init() is a misleading name (I originally thought that a
>> driver could only return 1 when opening an already-existing image
>> known to be all zeroes; but in reality many drivers always return 1
>> because it only applies to a just-created image).
>=20
> I don=E2=80=99t find it misleading, I just find it meaningless, which the=
n makes
> it open to interpretation (or maybe rather s/interpretation/wishful
> thinking/).
>=20
>> Refactor all uses
>> to instead have a single function that returns multiple bits of
>> information, with better naming and documentation.
>=20
> It doesn=E2=80=99t make sense to me.  How exactly is it unwieldy?  In the=
 sense
> that we have to deal with multiple rather small implementation functions
> rather than a big one per driver?  Actually, multiple small functions
> sounds better to me =E2=80=93 unless the three implementations share comm=
on code.

Common code for dealing with encryption, backing files, and so on.  It=20
felt like I had a lot of code repetition when keeping functions separate.

>=20
> As for the callers, they only want a single flag out of the three, don=E2=
=80=99t
> they?  If so, it doesn=E2=80=99t really matter for them.

The qemu-img.c caller in patch 10 checks ZERO_CREATE | ZERO_OPEN, so we=20
DO have situations of checking more than one bit, vs. needing two=20
function calls.

>=20
> In fact, I can imagine that drivers can trivially return
> BDRV_ZERO_TRUNCATE information (because the preallocation mode is
> fixed), whereas BDRV_ZERO_CREATE can be a bit more involved, and
> BDRV_ZERO_OPEN could take even more time because some (constant-time)
> inquiries have to be done.

In looking at the rest of the series, drivers were either completely=20
trivial (in which case, declaring:

.bdrv_has_zero_init =3D bdrv_has_zero_init_1,
.bdrv_has_zero_init_truncate =3D bdrv_has_zero_init_1,

was a lot wordier than the new:

.bdrv_known_zeroes =3D bdrv_known_zeroes_truncate,

), or completely spelled out but where both creation and truncation were=20
determined in the same amount of effort.


>=20
> And thus callers which just want the trivially obtainable
> BDRV_ZERO_TRUNCATE info have to wait for the BDRV_ZERO_OPEN inquiry,
> even though they don=E2=80=99t care about that flag.

True, but only to a minor extent; and the documentation mentions that=20
the BDRV_ZERO_OPEN calculation MUST NOT be as expensive as a blind=20
block_status loop.  Meanwhile, callers tend to only care about=20
bdrv_known_zeroes() right after opening an image or right before=20
resizing (not repeatedly during runtime); and you also argued elsewhere=20
in this thread that it may be worth having the block layer cache=20
BDRV_ZERO_OPEN and update the cache on any write, at which point, the=20
expense in the driver callback really is a one-time call during=20
bdrv_co_open().  And in that case, whether the one-time expense is done=20
via a single function call or via three driver callbacks, the amount of=20
work is the same; but the driver callback interface is easier if there=20
is only one callback (similar to how bdrv_unallocated_blocks_are_zero()=20
calls bdrv_get_info() only for bdi.unallocated_blocks_are_zero, even=20
though BlockDriverInfo tracks much more than that boolean).

In fact, it may be worth consolidating known zeroes support into=20
BlockDriverInfo.

>=20
> So I=E2=80=99d leave it as separate functions so drivers can feel free to=
 have
> implementations for BDRV_ZERO_OPEN that take more than mere microseconds
> but that are more accurate.
>=20
> (Or maybe if you really want it to be a single functions, callers could
> pass the mask of flags they care about.  If all flags are trivially
> obtainable, the implementations would then simply create their result
> mask and & it with the caller-given mask.  For implementations where
> some branches could take a bit more time, those branches are only taken
> when the caller cares about the given flag.  But again, I don=E2=80=99t
> necessarily think having a single function is more easily handleable
> than three smaller ones.)

Those are still viable options, but before I repaint the bikeshed along=20
those lines, I'd at least like a review of whether the overall idea of=20
having a notion of 'reads-all-zeroes' is indeed useful enough,=20
regardless of how we implement it as one vs. three driver callbacks.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


