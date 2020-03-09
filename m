Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37656C10DCE
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 02:52:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F06C820665
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 02:52:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WSMLi5pn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F06C820665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jB8Wv-0002s7-72
	for qemu-devel@archiver.kernel.org; Sun, 08 Mar 2020 22:52:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33865)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1jB8WJ-0002L9-Hm
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 22:51:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1jB8WH-0007it-QL
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 22:51:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30168
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1jB8WH-0007iH-Lk
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 22:51:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583722312;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vZ+yYr0Xi/9AmWZBxXKkBmg5mAtFHm3+s3MfXAH6Kzc=;
 b=WSMLi5pnisSns+rX36MgT2ARmxhjfgOQWOEz1FZ+4+bbODz2ePjiX0Wu8B0G+t4aAItxzN
 YUHR3Phox0civKPlBLZfVkBNzrLsA54h7+plQ4BLYWVeaddgSq01MDfsJFGiHzclcZDqEF
 FKqmxw7KxQExWrSaFG5q9XrELTK1WIA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-hwJpTLk_MMehStz7L8sHgw-1; Sun, 08 Mar 2020 22:51:50 -0400
X-MC-Unique: hwJpTLk_MMehStz7L8sHgw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B3BF4800D53;
 Mon,  9 Mar 2020 02:51:49 +0000 (UTC)
Received: from [10.72.13.185] (ovpn-13-185.pek2.redhat.com [10.72.13.185])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AE6A138D;
 Mon,  9 Mar 2020 02:51:47 +0000 (UTC)
Subject: Re: [PATCH] dp8393x: Mask EOL bit from descriptor addresses, take 2
To: Laurent Vivier <laurent@vivier.eu>
References: <alpine.LNX.2.22.394.2003041421280.12@nippy.intranet>
 <2116e607-52c8-7e7d-8ac1-c80d4628b2de@vivier.eu>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <d2e80d5b-3c7a-92ad-7371-1cd0800195ca@redhat.com>
Date: Mon, 9 Mar 2020 10:51:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <2116e607-52c8-7e7d-8ac1-c80d4628b2de@vivier.eu>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 peter.maydell@linaro.org, qemu-devel@nongnu.org,
 Finn Thain <fthain@telegraphics.com.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/3/8 =E4=B8=8B=E5=8D=885:52, Laurent Vivier wrote:
> Le 04/03/2020 =C3=A0 04:23, Finn Thain a =C3=A9crit=C2=A0:
>> A portion of a recent patch got lost due to a merge snafu. That patch is
>> now commit 88f632fbb1 ("dp8393x: Mask EOL bit from descriptor addresses"=
).
>> This patch restores the portion that got lost.
>>
>> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
>> ---
>>   hw/net/dp8393x.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
>> index 8a3504d962..81fc13ee9f 100644
>> --- a/hw/net/dp8393x.c
>> +++ b/hw/net/dp8393x.c
>> @@ -525,8 +525,8 @@ static void dp8393x_do_transmit_packets(dp8393xState=
 *s)
>>                                    * (4 + 3 * s->regs[SONIC_TFC]),
>>                                  MEMTXATTRS_UNSPECIFIED, s->data,
>>                                  size);
>> -            s->regs[SONIC_CTDA] =3D dp8393x_get(s, width, 0) & ~0x1;
>> -            if (dp8393x_get(s, width, 0) & SONIC_DESC_EOL) {
>> +            s->regs[SONIC_CTDA] =3D dp8393x_get(s, width, 0);
>> +            if (s->regs[SONIC_CTDA] & SONIC_DESC_EOL) {
>>                   /* EOL detected */
>>                   break;
>>               }
>>
> Jason,
>
> as it's a trivial bug fixes (only a diff between the commit and the
> patch), will you merge it via the network queue or do you want I take it
> via trivial queue?


Hi Laurent:

Please merge it.

Thanks


>
> Thanks,
> Laurent
>


