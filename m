Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3171CC4BA10
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 12:49:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF03D2467F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 12:49:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aiJJP1As"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF03D2467F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6w8O-0003uJ-1u
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 07:49:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42081)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1j6w7n-0003JS-3n
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 07:49:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1j6w7m-0001rm-27
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 07:49:15 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:42338
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1j6w7l-0001r2-V8
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 07:49:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582721353;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bRyGkK/CrkeYoqJ1WgOBtP3V7MvLai0QK0NfAkqvHdU=;
 b=aiJJP1As0NTBUbWpT+0wnWvpmU1ixl0gDOTov4naFCoh21jhTRWRXb8DJOs7Sgf6tHlc5P
 DM+3ieXb5MB2phorVxgI6VOwO5H2eHc25Mb122oIUN2qjaPgro3VdrlBaI3fv0KgDVjKNp
 b87zpKAuqcXQTVsPmACmer8ujrxMnyA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-76-D6PwVNRYOy2ki0BK6UFOuA-1; Wed, 26 Feb 2020 07:49:09 -0500
X-MC-Unique: D6PwVNRYOy2ki0BK6UFOuA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6881018A8C81;
 Wed, 26 Feb 2020 12:49:08 +0000 (UTC)
Received: from [10.3.116.57] (ovpn-116-57.phx2.redhat.com [10.3.116.57])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6D7C692966;
 Wed, 26 Feb 2020 12:49:05 +0000 (UTC)
Subject: Re: [PATCH] iotests: Fix nonportable use of od --endian
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
References: <20200219144103.2919292-1-eblake@redhat.com>
 <4a50da40-5a01-e597-b136-1be62994b2a2@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <a4b352d5-e05f-885d-705e-b4b28a43518f@redhat.com>
Date: Wed, 26 Feb 2020 06:49:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <4a50da40-5a01-e597-b136-1be62994b2a2@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Cc: qemu-trivial@nongnu.org, andrey.shinkevich@virtuozzo.com,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/25/20 11:43 AM, Max Reitz wrote:
> On 19.02.20 15:41, Eric Blake wrote:
>> Tests 261 and 272 fail on RHEL 7 with coreutils 8.22, since od
>> --endian was not added until coreutils 8.23.  Fix this by manually
>> constructing the final value one byte at a time.
>>
>> Fixes: fc8ba423
>> Reported-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---
>>   tests/qemu-iotests/common.rc | 22 +++++++++++++++++-----
>>   1 file changed, 17 insertions(+), 5 deletions(-)
>>
>> diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
>> index 8a6366c09daf..b77ef3d22cd1 100644
>> --- a/tests/qemu-iotests/common.rc
>> +++ b/tests/qemu-iotests/common.rc
>> @@ -56,6 +56,12 @@ poke_file()
>=20
> I don=E2=80=99t know how you did it, but something in your workflow broke=
 this
> patch.  This should be -56,18 +56,30.

I'm not sure, either.  Would me sending a v2 make it easier?

>=20
> (Note that git accepts this patch without error, but it drops everything
> after the first part.  I noticed because your squash-in failed to apply.
>   I suppose I might have noticed later when reviewing, because only
> peek_file_le() was touched, but who knows.)
>=20

>=20
> With the patch format fixed, and your proposed to-be-squashed patch
> squashed in, there isn=E2=80=99t anything wrong, so:
>=20
> Reviewed-by: Max Reitz <mreitz@redhat.com>
>=20
> But if I=E2=80=99m already about to squash something in, would you allow =
me to
> rename all instances of =E2=80=9Ci=E2=80=9D to e.g. =E2=80=9Cbyte=E2=80=
=9D?

I'll do that on a v2.


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


