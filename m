Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8315BC54FCB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 17:42:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D08720736
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 17:42:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LWQtEU8q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D08720736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRfs2-00044P-E2
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 13:42:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52264)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jRfrB-0003IK-JG
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 13:41:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jRfrA-00060H-S6
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 13:41:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57409
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jRfrA-0005wk-FB
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 13:41:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587663707;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z/cy06ZgYPwipgpfZq2y7z+/hre090Excv1poYQfl/E=;
 b=LWQtEU8qv957Rnv05JySRihOE+qMl2dH7BINy0JvqrsqlSKcMWpI0+NKTLZNQKvn0Jwmxo
 /FsG8BK+XiRzNQyIH9PcH6fAHr66biRrKoe2gh9qN3fvILCaXeL1tq2Hp+7yTmuaFhxGPY
 x3Ahmw4UoWFYnwVstVNBwxlxf2/5KqA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-191-E5ZUFtRMMMGae62AREvAug-1; Thu, 23 Apr 2020 13:41:44 -0400
X-MC-Unique: E5ZUFtRMMMGae62AREvAug-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E145818FF661;
 Thu, 23 Apr 2020 17:41:43 +0000 (UTC)
Received: from [10.10.116.80] (ovpn-116-80.rdu2.redhat.com [10.10.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 41369196AE;
 Thu, 23 Apr 2020 17:41:43 +0000 (UTC)
Subject: Re: [PATCH] qcow2: Allow resize of images with internal snapshots
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
References: <20200422205355.274706-1-eblake@redhat.com>
 <af50e0f6-3d78-ee51-5540-97fb0fc08f9b@redhat.com>
 <cee813a7-1540-aaa3-b8e1-98dbc84e90ff@redhat.com>
 <0c3d69a7-9095-9f03-f83a-c527e0751880@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <ade97dfc-a9c7-4f5d-7211-6a80f736e11d@redhat.com>
Date: Thu, 23 Apr 2020 12:41:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <0c3d69a7-9095-9f03-f83a-c527e0751880@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 06:43:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, "open list:qcow2" <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/23/20 12:21 PM, Max Reitz wrote:

>>> The previous comment was incorrect as well, but actually
>>> qcow2_truncate_bitmaps_check() doesn=E2=80=99t return an error when the=
re is any
>>> bitmap, but only if there are non-active bitmaps, or active bitmaps tha=
t
>>> cannot be modified.=C2=A0 So for non-disabled bitmaps, we generally do
>>> happily proceed.
>>
>> The comment change is collateral (only because I noticed it in the
>> diff); but I could indeed reword it slightly more accurately as:
>>
>> Check if bitmaps prevent a resize.=C2=A0 Although bitmaps can be resized=
,
>> there are situations where we don't know whether to set or clear new
>> bits, so for now it's easiest to just prevent resize in those cases.
>=20
> But I don=E2=80=99t know whether that explanation is actually correct.  I=
 mean,
> that would apply for enabled active bitmaps just as well.  But we do
> allow resizing an image with such bitmaps so it seems clear that we have
> some idea on what to do.  (Or at least we pretend we do, for better or
> worse).
>=20
> (Which is that bdrv_dirty_bitmap_truncate() just calls
> hbitmap_truncate(), which fills the new space with zeroes.)
>=20
> The real reason we can=E2=80=99t resize with certain kinds of bitmaps pre=
sent
> seems more like:
> (1) There are some bitmaps that can=E2=80=99t be written to, but we=E2=80=
=99d have to if
> we wanted to resize the image and they=E2=80=99re persistent,
> (2) The second case are bitmaps that are persistent but present in
> memory; we just haven=E2=80=99t implemented that case, I presume.
>=20
> So it seems less like a case of =E2=80=9CWe don=E2=80=99t know what to do=
=E2=80=9D, but more a
> combination of =E2=80=9CWe can=E2=80=99t=E2=80=9C and =E2=80=9CWe haven=
=E2=80=98t implemented this case, but
> it=E2=80=99s clear what to do if we did=E2=80=9D.

Indeed. So definitely a reason to split this change to a separate patch=20
(and/or fix the code to finally implement it)


>>> Speaking of the image size.=C2=A0 Is it intentional that the size is ch=
anged
>>> to 32 MB?=C2=A0 Should amend work more like a transaction, in that we s=
hould
>>> at least do a loose check on whether the options can be changed before
>>> we touch the image?
>>
>> Yes, the commit message tried to call it out.=C2=A0 It's a pre-existing
>> problem - during amend, we DO make changes to the disk in one step, with
>> no way to roll back those changes, even if a later step fails.
>>
>> Pre-patch, if you request an upgrade to v3 as well as a resize, but
>> resize fails, you still end up with the image being changed to v3.
>> That's no different from post-patch where if you request a resize and a
>> downgrade to v2, the resize happens but not the downgrade.=C2=A0 On the
>> bright side, our current failure scenarios at least leave the resulting
>> image viable, even if it is not the same as it was pre-attempt.
>=20
> Yes.  OK.

Okay, v2 will have a better commit message.


> Yeah.  I don=E2=80=99t think anyone even would have realistic use for
> transactional amends.  I suppose all users can easily split their amend
> calls with multiple options into multiple amends in the order that would
> be most likely reversible, if something went wrong along the way.  (And
> that also works.  I.e., downgrading/upgrading is probably the most easy
> to revert, but maybe you can only downgrade if your image has the
> correct size, so you potentially need to truncate it first.  OTOH, I
> can=E2=80=99t imagine many people actually use qemu-img amend to downgrad=
e qcow2
> images anyway...)

Indeed - any time that you worry that an interaction of multiple changes=20
might fail half-way through, you can always serialize those changes=20
yourself instead of hoping the tool sequences them correctly ;)


> I feel very much reminded of the LUKS keyslot discussion...
>=20
> (That is to say, my thoughts on this have little to do with this
> specific patch at this point.)

Too true !

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


