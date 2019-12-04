Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB1FC3F68F
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 15:43:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9EBC20862
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 15:43:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yx7LLFKn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9EBC20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icWo3-0005Kh-T0
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 10:43:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54837)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1icWm3-0004Mh-70
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 10:41:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1icWm0-0001WF-Op
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 10:41:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51892
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1icWlu-0000ru-Gt
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 10:41:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575474053;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gsagw1tvNaMmWiyIeAFh8VJmbkqzIfypE6P8HwGxgiI=;
 b=Yx7LLFKnD70Cs9BJORGkA9zdw3Asi2DtzrllTChuwy+yi6iVvvCBEw2aIfmLbaluUlv+zL
 SSHDQ30gDjzGTYqeDAtN2dzcrVeAZlAeY4pDTiaoe0o1nLgzljeH1PZPdtszhP2AgcMAnG
 BUrUY3rF4wcAeg6jrvUNUDmuGz0XdAc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-NHEI3qjlMgakTOqoAHsXfg-1; Wed, 04 Dec 2019 10:40:50 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 151FD108BD15;
 Wed,  4 Dec 2019 15:40:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A751C691A3;
 Wed,  4 Dec 2019 15:40:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 386B61138606; Wed,  4 Dec 2019 16:40:47 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v6] error: rename errp to errp_in where it is IN-argument
References: <20191127183704.14825-1-vsementsov@virtuozzo.com>
 <878so05bca.fsf@dusky.pond.sub.org>
 <f901e0db-61df-898f-ce18-096bfeadf525@virtuozzo.com>
 <87mucf218w.fsf@dusky.pond.sub.org>
 <80e563ee-31fb-da43-ddde-c8666e4b92c6@virtuozzo.com>
 <87eexqda3c.fsf@dusky.pond.sub.org>
 <41f32448-f2b8-1822-25df-f02c61df9bc4@virtuozzo.com>
 <878snybrf7.fsf@dusky.pond.sub.org>
 <87blsob5uq.fsf@dusky.pond.sub.org>
 <d1a58207-604b-e6bc-c2c3-a30e692c880a@virtuozzo.com>
Date: Wed, 04 Dec 2019 16:40:47 +0100
In-Reply-To: <d1a58207-604b-e6bc-c2c3-a30e692c880a@virtuozzo.com> (Vladimir
 Sementsov-Ogievskiy's message of "Wed, 4 Dec 2019 14:59:36 +0000")
Message-ID: <8736e0nlog.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: NHEI3qjlMgakTOqoAHsXfg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mdroth@linux.vnet.ibm.com" <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:

> 04.12.2019 16:03, Markus Armbruster wrote:
>> Markus Armbruster <armbru@redhat.com> writes:
>>=20
>>> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
>>>
>>>> 29.11.2019 17:35, Markus Armbruster wrote:
>> [...]
>>>>> I pushed my fixups to git://repo.or.cz/qemu/armbru.git branch error-p=
rep
>>>>> for your convenience.  The commit messages of the fixed up commits ne=
ed
>>>>> rephrasing, of course.
>>>>>
>>>>
>>>> Looked through fixups, looks OK for me, thanks! What next?
>>>
>>> Let me finish my fixing incorrect dereferences of errp, and then we
>>> figure out what to include in v7.
>>=20
>> Your v6 with my fixups does not conflict with my "[PATCH v2 00/18] Error
>> handling fixes", except for "hw/core/loader-fit: fix freeing errp in
>> fit_load_fdt", which my "[PATCH v2 07/18] hw/core: Fix fit_load_fdt()
>> error handling violations" supersedes.
>>=20
>> Suggest you work in the fixups and post as v7.  I'll merge that in my
>> tree, to give you a base for the remainder of your "auto propagated
>> local_err" work.  While you work on that, I'll work on getting the base
>> merged into master.  Sounds like a plan?
>>=20
>
> Yes, that's good. I'll send v7 tomorrow.
>
> What you suggest to do after it?
> Send in one series a patch with macro + coccinelle +
> subset of autogenerated patches, which were reviewed (but not sending hal=
f
> a subsystem of course)?

Sounds good to me.

Visibility into the complete work is useful, though.  Having the cover
letter point to a branch in your public git repo should do.


