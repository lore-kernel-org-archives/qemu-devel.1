Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18405C83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 16:22:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6E292054F
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 16:22:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Drq6di1q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6E292054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTT0P-0002J1-Pj
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 12:22:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60638)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jTSyi-0008Vv-6z
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 12:21:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jTSwk-0000nc-Qi
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 12:20:59 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:36959
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jTSwk-0000mt-Bc
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 12:18:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588090735;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EkMpkezgR4QSFgDt2sZtIiNtlyYDPYNkLeHh5N/e944=;
 b=Drq6di1q7B5Q/JbcQQdL0T9J6kw2w4c4wNn6ahiS/G8/i59R4wR4lx/BbpwClcO8zPzxtl
 OLZY6dx3Aa0zwDY/AOFSgTrEFCuRgZQJJT0ntTO5k4NQTi/NJwqftMD3XlrS74BW68bRgS
 IrKXgxSCfwLq1UoGucVST2xh7M4rVfo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-430-1cDQUrtRO9m82mb3sH26fQ-1; Tue, 28 Apr 2020 12:18:51 -0400
X-MC-Unique: 1cDQUrtRO9m82mb3sH26fQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1F90580058A;
 Tue, 28 Apr 2020 16:18:50 +0000 (UTC)
Received: from [10.10.116.80] (ovpn-116-80.rdu2.redhat.com [10.10.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2ED775D9E8;
 Tue, 28 Apr 2020 16:18:49 +0000 (UTC)
Subject: Re: backing chain & block status & filters
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
References: <a1c1b734-34dc-f8d3-b6a0-43b136e237e2@virtuozzo.com>
 <20e6c43f-c1a7-57db-58b9-3cb70f0e637f@redhat.com>
 <20200428112853.GC5789@linux.fritz.box>
 <2e3eab55-4a1d-f1a9-ab28-3f9399c57bfe@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <25f6278c-466d-c663-73e0-ef2d256b326d@redhat.com>
Date: Tue, 28 Apr 2020 11:18:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <2e3eab55-4a1d-f1a9-ab28-3f9399c57bfe@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
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
 qemu-devel <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/28/20 10:13 AM, Vladimir Sementsov-Ogievskiy wrote:

>>> Hm.=C2=A0 I could imagine that there are formats that have non-zero hol=
es
>>> (e.g. 0xff or just garbage).=C2=A0 It would be a bit wrong for them to =
return
>>> ZERO or DATA then.
>>>
>>> But OTOH we don=E2=80=99t care about such cases, do we?=C2=A0 We need t=
o know whether
>>> ranges are zero, data, or unallocated.=C2=A0 If they aren=E2=80=99t zer=
o, we only
>>> care about whether reading from it will return data from this layer=20
>>> or not.
>>>
>>> So I suppose that anything that doesn=E2=80=99t support backing files (=
or
>>> filtered children) should always return ZERO and/or DATA.
>>
>> I'm not sure I agree with the notion that everything should be
>> BDRV_BLOCK_ALLOCATED at the lowest layer. It's not what it means today
>> at least. If we want to change this, we will have to check all callers
>> of bdrv_is_allocated() and friends who might use this to find holes in
>> the file.
>=20
> Yes. Because they are doing incorrect (or at least undocumented and=20
> unreliable) thing.

Here's some previous mails discussing the same question about what=20
block_status should actually mean.  At the time, I was so scared of the=20
prospect of something breaking if I changed things that I ended up=20
keeping status quo, so here we are revisiting the topic several years=20
later, still asking the same questions.

https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg00069.html
https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg03757.html

>=20
>>
>> Basically, the way bdrv_is_allocated() works today is that we assume an
>> implicit zeroed backing layer even for block drivers that don't support
>> backing files.
>=20
> But read doesn't work so: it will read data from the bottom layer, not fr=
om
> this implicit zeroed backing layer. And it is inconsistent. On read data
> comes exactly from this layer, not from its implicit backing. So it shoul=
d
> return BDRV_BLOCK_ALLOCATED, accordingly to its definition..
>=20
> Or, we should at least document current behavior:
>=20
>  =C2=A0 BDRV_BLOCK_ALLOCATED: the content of the block is determined by t=
his
>  =C2=A0 layer rather than any backing, set by block. Attention: it may no=
t be=20
> set
>  =C2=A0 for drivers without backing support, still data is of course read=
 from
>  =C2=A0 this layer. Note, that for such drivers BDRV_BLOCK_ALLOCATED may =
mean
>  =C2=A0 allocation on fs level, which occupies real space on disk.. So, f=
or=20
> such drivers
>=20
>  =C2=A0 ZERO | ALLOCATED means that, read as zero, data may be allocated =
on=20
> fs, or
>  =C2=A0 (most probably) not,
>  =C2=A0 don't look at ALLOCATED flag, as it is added by generic layer for=
=20
> another logic,
>  =C2=A0 not related to fs-allocation.
>=20
>  =C2=A0 0 means that, most probably, data doesn't occupy space on fs,=20
> zero-status is
>  =C2=A0 unknown (most probably non-zero)
>=20

That may be right in describing the current situation, but again, needs=20
a GOOD audit of what we are actually using it for, and whether it is=20
what we really WANT to be using it for.  If we're going to=20
audit/refactor the code, we might as well get semantics that are=20
actually useful, rather than painfully contorted to documentation that=20
happens to match our current contorted code.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


