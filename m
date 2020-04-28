Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A51DC83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 12:51:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6596A206D9
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 12:51:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JIyFOfyE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6596A206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTPi0-0001cC-8L
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 08:51:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57928)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jTPgW-0008JG-GU
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 08:50:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jTPdy-0007oE-IN
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 08:49:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29459
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jTPdy-0007mT-1A
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 08:47:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588078040;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P0MtAqu5xNFOcVJd3FQQ8jsNnQoMfQAODcu5hfuKpVM=;
 b=JIyFOfyEsehQXlJ2yzSqHxmYHyVZcSvsBPseGqsSumyoIx0YFCvbEbdUBkWWrZqHfw8lCQ
 5/dxMl6muOmCaSByJPBib8jWwu2XeeEcAjg3lCjX+8WyMDtSFjItn75UXGY8HD7nNX3WRe
 Xm3fHhWuRmIf0LrJEvsKgzg8YvlbOks=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-213-FyQQWoHKPOW-ShW1VIifyQ-1; Tue, 28 Apr 2020 08:47:15 -0400
X-MC-Unique: FyQQWoHKPOW-ShW1VIifyQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2DC3E464;
 Tue, 28 Apr 2020 12:47:13 +0000 (UTC)
Received: from [10.10.116.80] (ovpn-116-80.rdu2.redhat.com [10.10.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 35AD95D750;
 Tue, 28 Apr 2020 12:47:06 +0000 (UTC)
Subject: Re: [PATCH v3 1/3] block: Add blk_new_with_bs() helper
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
References: <20200424190903.522087-1-eblake@redhat.com>
 <20200424190903.522087-2-eblake@redhat.com>
 <ba31b83c-538a-0f3f-9bab-7aadb2f99ea9@redhat.com>
 <5d70074f-ef06-31f6-f694-ef4c4517472c@redhat.com>
 <59352c54-2d9c-5bde-9f5b-541f2ae5cccc@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <dbfc6e21-834f-01a7-b62c-dc445a0eed82@redhat.com>
Date: Tue, 28 Apr 2020 07:47:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <59352c54-2d9c-5bde-9f5b-541f2ae5cccc@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 04:15:05
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 "open list:Sheepdog" <sheepdog@lists.wpkg.org>, qemu-block@nongnu.org,
 Jeff Cody <codyprime@gmail.com>, Stefan Weil <sw@weilnetz.de>,
 Markus Armbruster <armbru@redhat.com>, stefanha@redhat.com,
 Liu Yuan <namei.unix@gmail.com>, "Denis V. Lunev" <den@openvz.org>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/28/20 1:34 AM, Max Reitz wrote:

>>>> block_crypto_co_create_generic(BlockDriverState *bs,
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PreallocMode prealloc,
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Error **errp)
>>>>  =C2=A0 {
>>>> -=C2=A0=C2=A0=C2=A0 int ret;
>>>> +=C2=A0=C2=A0=C2=A0 int ret =3D -EPERM;
>>>
>>> I=E2=80=99m not sure I=E2=80=99m a fan of this, because I feel like it =
makes the code
>>> harder to read, due to having to look in three places (here, around the
>>> blk_new_with_bs() call, and under the cleanup label) instead of in two
>>> (not here) to verify that the error handling code is correct.
>>>
>>> There=E2=80=99s also the fact that this is not really a default return =
value,
>>> but one very specific error code for if one very specific function call
>>> fails.
>>>
>>> I suppose it comes down to whether one considers LoC a complexity
>>> problem.=C2=A0 (I don=E2=80=99t, necessarily.)
>>>
>>> (Also I realize it seems rather common in the kernel to set error retur=
n
>>> variables before the function call, but I think the more common pattern
>>> in qemu is to set it in the error path.)
>>
>> I'm fine with either style.=C2=A0 Setting it up front is handy if that
>> particular error makes a good default, but in many of the functions I
>> touched, we were returning a variety of errors (-EIO, -EINVAL, -EPERM,
>> etc) such that there was no good default, and thus no reason to set a
>> default up front.=C2=A0 Is this something that would go through your tre=
e,
>> and if so, are you okay making that tweak, or do I need to send v4?
>=20
> I suppose I can do that, this is what I=E2=80=99d squash in, OK?

Yes, that change looks correct to me.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


