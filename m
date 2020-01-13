Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECFDBC33CAE
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 13:03:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8A262080D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 13:03:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SEKYH2Wz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8A262080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iqzMx-0001Ms-Ng
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 08:02:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41974)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iqzLx-0000iy-LL
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 08:01:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iqzLw-0002kA-8Z
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 08:01:57 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:56652
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iqzLw-0002ix-4g
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 08:01:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578920515;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8nV55N2bximzjFw9QgGWwwlqTPvHoSSccKkK3tYiGks=;
 b=SEKYH2Wzc5jwg+fddDDgFpOgEbqSPQV518OdMnGGv29WW7i4lNy7DFh/Tc/FhHs/J9skxS
 6+8CMrqphlF8jxfGRZSOSrnTMCkT7IEy2lFQBZcnZY4Y/1DUefd/G24hSGDFHiXEnGBlgv
 WAYDJZtv1jkzj+fzdgvY2kE21S3S2bg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-dyZK9AgdNvCeVyvmNu0jFg-1; Mon, 13 Jan 2020 08:01:54 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 037C1801E72;
 Mon, 13 Jan 2020 13:01:53 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-131.ams2.redhat.com
 [10.36.116.131])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C735687EC6;
 Mon, 13 Jan 2020 13:01:52 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3D1381138600; Mon, 13 Jan 2020 14:01:51 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH 10/21] hw/core: Fix latent fit_load_fdt() error handling
 bug
References: <20191130194240.10517-1-armbru@redhat.com>
 <20191130194240.10517-11-armbru@redhat.com>
 <b42438de-3f05-a949-9304-29c051bc4444@virtuozzo.com>
 <87tv6dnbfl.fsf@dusky.pond.sub.org>
 <cce60ff4-254d-85df-cd7a-b3b373d17173@virtuozzo.com>
 <52a3810e-0805-d368-ec2a-7e6265f494d6@virtuozzo.com>
Date: Mon, 13 Jan 2020 14:01:51 +0100
In-Reply-To: <52a3810e-0805-d368-ec2a-7e6265f494d6@virtuozzo.com> (Vladimir
 Sementsov-Ogievskiy's message of "Fri, 10 Jan 2020 20:06:02 +0000")
Message-ID: <87zherzf0g.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: dyZK9AgdNvCeVyvmNu0jFg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:

> 06.12.2019 13:53, Vladimir Sementsov-Ogievskiy wrote:
>> 06.12.2019 10:46, Markus Armbruster wrote:
>>> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
[...]
>>>> So much attention to that function :)
>>>>
>>>> I'd also propose the following:
[...]
>>>
>>> Looks like a sensible separate cleanup patch to me.=C2=A0 Care to post =
it?
>>>
>>=20
>> Yes, I'll send
>>=20
>
>
> Hm, it doesn't compile, as fit_load_image_alloc return type is const poin=
ter..
> So, I just don't understand the logic of the code (for me it's strange to
> free pointer, returned by function, returning const pointer)
>
> And what are the reasons, to make return type of fit_load_image_alloc con=
stant,
> I don't see.. IMHO, there are no reasons.
> Same thing with .fdt_filter ...
>
> I don't want to dig in, so, sorry, I'll not send :)

That's okay.


