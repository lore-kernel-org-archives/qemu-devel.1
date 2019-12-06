Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A29C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 15:56:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8148A20706
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 15:56:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XI2DyOKq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8148A20706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idFxi-0004Kd-4x
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 10:56:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54746)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1idEtC-0000QD-6c
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:47:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1idEt8-0003mE-1D
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:47:23 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49321
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1idEt6-0003ci-Sc
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:47:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575643627;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vuoIY5n64eIumQ7wojWTzPjLJU4ggum3L4Pg/YymX8Q=;
 b=XI2DyOKqnBjsEYpXflQu9bum+GaLlBHu/Z/dlMimUf4Vlj6ZwAybvngyl5iTGDhY97+LgI
 B2dQWRgF3sA491BwRB1CCi0EvKdWlnPOJbYBaRmI8Rg4BAW4yX17m+NYmHPPbG6B7ZNy2H
 GBWkB7x4ExKfLwYYI6XtZJb6Z+wk0CQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-391-IZEl3wQVOmqAx99OwAt4hw-1; Fri, 06 Dec 2019 03:45:05 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 43A598017DF;
 Fri,  6 Dec 2019 08:45:02 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1B7AD6106B;
 Fri,  6 Dec 2019 08:44:46 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4FE2D1138606; Fri,  6 Dec 2019 09:44:43 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v7 00/21] error: prepare for auto propagated local_err
References: <20191205152019.8454-1-vsementsov@virtuozzo.com>
 <20191205162627.70ffe45c.cohuck@redhat.com>
 <204304ad-3556-9964-0164-0477a97cd4d2@virtuozzo.com>
Date: Fri, 06 Dec 2019 09:44:43 +0100
In-Reply-To: <204304ad-3556-9964-0164-0477a97cd4d2@virtuozzo.com> (Vladimir
 Sementsov-Ogievskiy's message of "Thu, 5 Dec 2019 16:03:49 +0000")
Message-ID: <87y2vplu6c.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: IZEl3wQVOmqAx99OwAt4hw-1
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
Cc: Paul Burton <pburton@wavecomp.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 David Hildenbrand <david@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 "Gonglei \(Arei\)" <arei.gonglei@huawei.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Greg Kurz <groug@kaod.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Tony Krowiak <akrowiak@linux.ibm.com>,
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 Pierre Morel <pmorel@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:

> 05.12.2019 18:26, Cornelia Huck wrote:
>> On Thu,  5 Dec 2019 18:19:58 +0300
>> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> wrote:
>>=20
>>> Hi all!
>>>
>>> This is the first part of the bit series, which contains mostly simple
>>> cleanups.
>>=20
>> What's the plan? Should subsystem maintainers pick up individual
>> patches, or will they be merged in one go?
>>=20
> The latter. Markus will take them all together.

Subsystem maintainers are welcome to take truly independent patches
through their trees if that's more convenient for them, say because it
avoids or reduces the likelihood of conflicts.

Whatever is left I will take through my tree.  Me taking everything is
slightly easier for me, and results in a more coherent git-log.  Neither
is serious enough to justify inconveniencing subsystem maintainers.


