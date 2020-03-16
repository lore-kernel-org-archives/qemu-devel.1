Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3A43C2BB1D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 19:02:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B06E520663
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 19:02:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jIXRKxgN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B06E520663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDv0n-0004kW-UQ
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 15:02:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48540)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jDuHK-0004ca-Go
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:15:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jDuHI-0006Qy-5J
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:15:54 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:40111)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jDuHH-0006Ly-WE
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:15:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584382551;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wZ5gqEEj5mv41TOfu0h/zgYu/cE4DSNhk06IWwCQB+g=;
 b=jIXRKxgNrq+qvVgeW7cWgPJgYeatWwAU0K/Z1ESSnBiWhA3p6OTjWxao0iT88JlKr4r5Fx
 F5Do4SsbHNEcUX15K5DGTSt8A5c3LHU+kBUaZ++AvCc9rP9oet6QYWmAHTEUPZVHRlvUnR
 V3t4c7YPDRN6dagcmtpH6HDG3Yk1bdU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-442-7P-45U1NNiWd-2tnOHv24g-1; Mon, 16 Mar 2020 14:15:45 -0400
X-MC-Unique: 7P-45U1NNiWd-2tnOHv24g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 19A388E444B;
 Mon, 16 Mar 2020 18:15:44 +0000 (UTC)
Received: from [10.3.118.63] (ovpn-118-63.phx2.redhat.com [10.3.118.63])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D680A9352B;
 Mon, 16 Mar 2020 18:15:35 +0000 (UTC)
Subject: Re: [PATCH 1/2] migration: avoid suspicious strncpy() use
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
References: <20200316160702.478964-1-stefanha@redhat.com>
 <20200316160702.478964-2-stefanha@redhat.com>
 <24d36e90-5880-02ad-fa24-761eb3d9074f@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <62dbe165-8311-71f0-fcf6-d020d7e93fd8@redhat.com>
Date: Mon, 16 Mar 2020 13:15:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <24d36e90-5880-02ad-fa24-761eb3d9074f@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Juan Quintela <quintela@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/16/20 1:09 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 3/16/20 5:07 PM, Stefan Hajnoczi wrote:
>> gcc (GCC) 9.2.1 20190827 (Red Hat 9.2.1-1) with sanitizers enabled
>> reports the following error:
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0 CC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 migration/glob=
al_state.o
>> =C2=A0=C2=A0 In file included from /usr/include/string.h:495,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 from /home/stefanha/qemu/include=
/qemu/osdep.h:101,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 from migration/global_state.c:13=
:
>> =C2=A0=C2=A0 In function =E2=80=98strncpy=E2=80=99,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inlined from =E2=80=98global_state_=
store_running=E2=80=99 at=20
>> migration/global_state.c:47:5:
>> =C2=A0=C2=A0 /usr/include/bits/string_fortified.h:106:10: error:=20
>> =E2=80=98__builtin_strncpy=E2=80=99 specified bound 100 equals destinati=
on size=20
>> [-Werror=3Dstringop-truncation]
>> =C2=A0=C2=A0=C2=A0=C2=A0 106 |=C2=A0=C2=A0 return __builtin___strncpy_ch=
k (__dest, __src, __len,=20
>> __bos (__dest));
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |         =20
>> ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>
>> Use pstrcpy() instead of strncpy().=C2=A0 It is guaranteed to NUL-termin=
ate
>> strings.
>=20
> There was a long discussion 1 year ago with it, and Eric suggested to=20
> use strpadcpy after the assert() and I sent this patch:
> https://www.mail-archive.com/qemu-block@nongnu.org/msg44925.html
> Not sure what's best.

strncpy() pads the tail, guaranteeing that for our fixed-size buffer, we=20
guarantee the contents of all bytes in the buffer.  pstrcpy() does not=20
(but pstrcpy() can be followed up with a memset() to emulate the=20
remaining effects of strncpy() - at which point you have reimplemented=20
strpadcpy).

>=20
>>
>> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>> ---
>> =C2=A0 migration/global_state.c | 4 ++--
>> =C2=A0 1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/migration/global_state.c b/migration/global_state.c
>> index 25311479a4..cbe07f21a8 100644
>> --- a/migration/global_state.c
>> +++ b/migration/global_state.c
>> @@ -44,8 +44,8 @@ void global_state_store_running(void)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char *state =3D RunState_str(RUN_ST=
ATE_RUNNING);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 assert(strlen(state) < sizeof(global_stat=
e.runstate));
>> -=C2=A0=C2=A0=C2=A0 strncpy((char *)global_state.runstate,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 state, siz=
eof(global_state.runstate));
>> +=C2=A0=C2=A0=C2=A0 pstrcpy((char *)global_state.runstate,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size=
of(global_state.runstate), state);

Can we guarantee that the padding bytes have been previously set to 0,=20
or do we need to go the extra mile with a memset() or strpadcpy() to=20
guarantee that we have set the entire buffer?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


