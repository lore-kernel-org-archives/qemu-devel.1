Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B69C432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 05:08:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DA34214AF
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 05:08:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TtZfvn5Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DA34214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibdwx-0007wB-EV
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 00:08:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50830)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1ibdwK-0007Kd-Oh
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 00:08:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1ibdwJ-0000aL-Nq
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 00:08:04 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41396
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ibdwJ-0000aA-KH
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 00:08:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575263282;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ClvC82Jj9ZyitY4j1TGg26xYAJaz5J/a60ARIsROMms=;
 b=TtZfvn5Z7xzUVIf2T3LggWUbuF/wOCGlGIioUh1FkzgCjkaogD3Zunhh4SZqmxb4iyJrs6
 ly1uPjZJ+2JK3bt4Las9DCdvbte6r2g0JinswWLkE1nWtGptCrk2TGhzSDrrHhGFCjApGl
 ZzcJ5NSk0fjm8yKprnt9q2wqH6Ala8Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-28-kWp8L399N0aAC57jC0_mSQ-1; Mon, 02 Dec 2019 00:07:59 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 42EEC800D4C;
 Mon,  2 Dec 2019 05:07:58 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 949D660BFB;
 Mon,  2 Dec 2019 05:07:55 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 12BF21138606; Mon,  2 Dec 2019 06:07:54 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 13/21] memory-device: Fix latent memory pre-plug error
 handling bugs
References: <20191130194240.10517-1-armbru@redhat.com>
 <20191130194240.10517-14-armbru@redhat.com>
 <5306b8e8-fea3-c482-badb-9b78891d7e27@redhat.com>
Date: Mon, 02 Dec 2019 06:07:54 +0100
In-Reply-To: <5306b8e8-fea3-c482-badb-9b78891d7e27@redhat.com> (David
 Hildenbrand's message of "Sun, 1 Dec 2019 15:15:33 +0100")
Message-ID: <87h82jnwlx.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: kWp8L399N0aAC57jC0_mSQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: vsementsov@virtuozzo.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

David Hildenbrand <david@redhat.com> writes:

> On 30.11.19 20:42, Markus Armbruster wrote:
>> memory_device_get_free_addr() crashes when
>> memory_device_check_addable() fails and its @errp argument is null.
>> Messed up in commit 1b6d6af21b "pc-dimm: factor out capacity and slot
>> checks into MemoryDevice".
>>=20
>> The bug can't bite as no caller actually passes null.  Fix it anyway.
>>=20
>> Cc: David Hildenbrand <david@redhat.com>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  hw/mem/memory-device.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
>> index aef148c1d7..4bc9cf0917 100644
>> --- a/hw/mem/memory-device.c
>> +++ b/hw/mem/memory-device.c
>> @@ -99,6 +99,7 @@ static uint64_t memory_device_get_free_addr(MachineSta=
te *ms,
>>                                              uint64_t align, uint64_t si=
ze,
>>                                              Error **errp)
>>  {
>> +    Error *err =3D NULL;
>>      GSList *list =3D NULL, *item;
>>      Range as, new =3D range_empty;
>> =20
>> @@ -123,8 +124,9 @@ static uint64_t memory_device_get_free_addr(MachineS=
tate *ms,
>>          return 0;
>>      }
>> =20
>> -    memory_device_check_addable(ms, size, errp);
>> -    if (*errp) {
>> +    memory_device_check_addable(ms, size, &err);
>> +    if (err) {
>> +        error_propagate(errp, err);
>>          return 0;
>>      }
>
> I remember that some time ago, the best practice was to use "local_err",
> what is the latest state of that?

Hundreds of local Error * variables are named @local_err, and hundreds
more are named @err.

For what it's worth, the big comment in error.h uses @err, except in one
place where it needs two of them.

> I still disagree that these are BUGs or even latent BUGs. If somebody
> things these are BUGs and not cleanups, then we should probably have
> proper "Fixes: " tags instead.

Let's continue that discussion in the sub-thread where you first raised
this objection.

> Reviewed-by: David Hildenbrand <david@redhat.com>

Thanks!


