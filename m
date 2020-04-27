Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A8BAC54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 14:05:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF1DD2064C
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 14:05:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UZlLfaCq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF1DD2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT4OS-0000VC-FV
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 10:05:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50676)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jT4Mq-00083y-1G
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 10:04:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jT4Mp-0001t2-1t
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 10:04:15 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:54946
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jT4Mo-0001mX-IW
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 10:04:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587996253;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VddvxvUFZDtCG/2vP6SI5WXByNHnuCX2lqxisVWlYUk=;
 b=UZlLfaCq2vxX1RAHecfp9nmDev/N0xdTuh9Zpq7OqYFJZE9jpEoHzoiGJXF2kEaMy8Uiq8
 FdD0sJD7nLuj2ETeZzcUAZ4AlpbTxCusmc5bMrHXGamC2O5rIXh7j1gwhpt39r32LbycrW
 MgqcqXShGWwKrY4yq/aoFh1USHLZ1hA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-Fs02GU82OqKPE0afS50M6A-1; Mon, 27 Apr 2020 10:04:09 -0400
X-MC-Unique: Fs02GU82OqKPE0afS50M6A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AEEBC19200C2;
 Mon, 27 Apr 2020 14:04:07 +0000 (UTC)
Received: from [10.10.116.80] (ovpn-116-80.rdu2.redhat.com [10.10.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 349355D753;
 Mon, 27 Apr 2020 14:04:00 +0000 (UTC)
Subject: Re: [PATCH v3 1/3] block: Add blk_new_with_bs() helper
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
References: <20200424190903.522087-1-eblake@redhat.com>
 <20200424190903.522087-2-eblake@redhat.com>
 <ba31b83c-538a-0f3f-9bab-7aadb2f99ea9@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <5d70074f-ef06-31f6-f694-ef4c4517472c@redhat.com>
Date: Mon, 27 Apr 2020 09:03:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <ba31b83c-538a-0f3f-9bab-7aadb2f99ea9@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/26 23:32:35
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 "open list:Sheepdog" <sheepdog@lists.wpkg.org>, qemu-block@nongnu.org,
 Jeff Cody <codyprime@gmail.com>, Stefan Weil <sw@weilnetz.de>,
 Markus Armbruster <armbru@redhat.com>, stefanha@redhat.com,
 Liu Yuan <namei.unix@gmail.com>, "Denis V. Lunev" <den@openvz.org>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/27/20 5:00 AM, Max Reitz wrote:
> On 24.04.20 21:09, Eric Blake wrote:
>> There are several callers that need to create a new block backend from
>> an existing BDS; make the task slightly easier with a common helper
>> routine.
>>
>> Suggested-by: Max Reitz <mreitz@redhat.com>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---

>> +++ b/block/crypto.c
>> @@ -256,16 +256,14 @@ static int block_crypto_co_create_generic(BlockDri=
verState *bs,
>>                                             PreallocMode prealloc,
>>                                             Error **errp)
>>   {
>> -    int ret;
>> +    int ret =3D -EPERM;
>=20
> I=E2=80=99m not sure I=E2=80=99m a fan of this, because I feel like it ma=
kes the code
> harder to read, due to having to look in three places (here, around the
> blk_new_with_bs() call, and under the cleanup label) instead of in two
> (not here) to verify that the error handling code is correct.
>=20
> There=E2=80=99s also the fact that this is not really a default return va=
lue,
> but one very specific error code for if one very specific function call
> fails.
>=20
> I suppose it comes down to whether one considers LoC a complexity
> problem.  (I don=E2=80=99t, necessarily.)
>=20
> (Also I realize it seems rather common in the kernel to set error return
> variables before the function call, but I think the more common pattern
> in qemu is to set it in the error path.)

I'm fine with either style.  Setting it up front is handy if that=20
particular error makes a good default, but in many of the functions I=20
touched, we were returning a variety of errors (-EIO, -EINVAL, -EPERM,=20
etc) such that there was no good default, and thus no reason to set a=20
default up front.  Is this something that would go through your tree,=20
and if so, are you okay making that tweak, or do I need to send v4?

>=20
> But it does look like you got all cases covered this time.

Good to hear.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


