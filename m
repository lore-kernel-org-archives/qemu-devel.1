Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B39CC2BA19
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 13:33:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E90F02332A
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 13:33:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AE/Q8wP7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E90F02332A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLRsc-0005LP-4S
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 09:33:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50328)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jLRrc-0004Z2-Pz
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 09:32:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jLRrb-0007YL-1Z
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 09:32:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50044
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jLRra-0007XJ-TG
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 09:32:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586179949;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=166AdI31MoDy3Jd//uwsQZX7dQM1UTS5BT1+m1oTWBQ=;
 b=AE/Q8wP7KY25CKDso4vs7juj5drCvB+bRLHDrJuaDwWjfYVOR+y/+T7qJE7D8QiaZ5fWQn
 DqvZi76icykw5IqvvIBMOy+Zki2YxKA2Y2Vc/DWEiSXpv/TIoi09OTjxdhCMmNMcGKN0xi
 6Ca1tkNdCTDkn+Cwhp5gwSHacTSm0+E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-65-JxtHP2nTOUuhEKz6tOsaCA-1; Mon, 06 Apr 2020 09:32:25 -0400
X-MC-Unique: JxtHP2nTOUuhEKz6tOsaCA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9AEE61084431;
 Mon,  6 Apr 2020 13:32:24 +0000 (UTC)
Received: from [10.3.114.49] (ovpn-114-49.phx2.redhat.com [10.3.114.49])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 42D9760C87;
 Mon,  6 Apr 2020 13:32:23 +0000 (UTC)
Subject: Re: [PATCH for-5.0? v2] qcow2: Explicit mention of padding bytes
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20200403181907.878751-1-eblake@redhat.com>
 <8fe869d5-baf5-6d04-78d4-bee89cd7ef47@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <3f720e97-a499-67f9-f85c-1dba29ec9551@redhat.com>
Date: Mon, 6 Apr 2020 08:32:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <8fe869d5-baf5-6d04-78d4-bee89cd7ef47@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>, "open list:qcow2" <qemu-block@nongnu.org>,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/6/20 3:50 AM, Vladimir Sementsov-Ogievskiy wrote:
> 03.04.2020 21:19, Eric Blake wrote:
>> Although we already covered the need for padding bytes with our
>> changes in commit 3ae3fcfa, commit 66fcbca5 just added one byte and
>> relied on the rest of the text for implicitly covering 7 padding
>> bytes.=C2=A0 For consistency with other parts of the header (such as the
>> header extension format listing padding from n - m, or the snapshot
>> table entry mentioning variable padding), we might as well call out
>> the remaining 7 bytes as padding until such time (as any) as they gain
>> another meaning.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---
>>
>> v2: Call out explicit byte range rather than '105 - m' [Max]
>>
>> Safe for 5.0 as it is just a doc fix, but only if we actually want it.
>>
>> =C2=A0 docs/interop/qcow2.txt | 1 +
>> =C2=A0 1 file changed, 1 insertion(+)
>>
>> diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
>> index 640e0eca4000..80728bc2008d 100644
>> --- a/docs/interop/qcow2.txt
>> +++ b/docs/interop/qcow2.txt
>> @@ -210,3 +210,4 @@ version 2.
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Available compressio=
n type values:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 0: zlib <https://www.zlib.net/>
>>
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 105 - 111:=C2=A0 Padding, le=
ave as zero.
>>
>=20
> Looking on this in separate, I'd make a software which will zero this=20
> padding unconditionally. However, if it's an existing image which we=20
> just open, we should keep the content we read.. On the other hand, of=20
> course, if read the whole spec, everything is clear.

Maybe:
   105 - 111: Padding, contents defined below

rather than an explicit mention of setting to 0?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


