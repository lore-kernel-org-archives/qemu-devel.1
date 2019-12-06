Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E0AC43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 16:21:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A40A2464E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 16:21:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="grFYvvlk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A40A2464E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idGMe-0007ss-T3
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 11:21:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40768)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1idF6p-0000uQ-T4
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 10:01:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1idF6k-00075w-FD
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 10:01:31 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53030
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1idF6j-00074K-RX
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 10:01:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575644485;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8bFdHkvEJe5jck4uEKZdxjc1onJEQxJM/7zmIC1qTHk=;
 b=grFYvvlkwQ0stbTHDfmkuDplmg67/9tuxxAUDcX+gE2FcUEB2+hULVIEf3G5wyJJMPGNtz
 b8Jxugr7ShMCYDwponReuOYUuHsQxGg497m5w65MbOoW6sWm3JjWgZQFIlxggbVE95QyrX
 GEXhWaMK72h/jwDm3vXWhhltE5ggqS4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149-UafSOqVwNCirLDk2Lndvbw-1; Fri, 06 Dec 2019 02:58:52 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EFD07DBA5;
 Fri,  6 Dec 2019 07:58:50 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A78C15C1C3;
 Fri,  6 Dec 2019 07:58:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 384041138606; Fri,  6 Dec 2019 08:58:49 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH 12/21] qga: Fix latent guest-get-fsinfo error handling bug
References: <20191130194240.10517-1-armbru@redhat.com>
 <20191130194240.10517-13-armbru@redhat.com>
 <c6fef374-f62f-5909-8e3e-d928abba19b2@virtuozzo.com>
Date: Fri, 06 Dec 2019 08:58:49 +0100
In-Reply-To: <c6fef374-f62f-5909-8e3e-d928abba19b2@virtuozzo.com> (Vladimir
 Sementsov-Ogievskiy's message of "Thu, 5 Dec 2019 16:29:50 +0000")
Message-ID: <87lfrpnava.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: UafSOqVwNCirLDk2Lndvbw-1
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:

> 30.11.2019 22:42, Markus Armbruster wrote:
>> build_guest_fsinfo_for_virtual_device() crashes when
>> build_guest_fsinfo_for_device() fails and its @errp argument is null.
>> Messed up in commit 46d4c5723e "qga: Add guest-get-fsinfo command".
>>=20
>> The bug can't bite as no caller actually passes null.  Fix it anyway.
>>=20
>> Cc: Michael Roth <mdroth@linux.vnet.ibm.com>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>
>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>
> Actually, all such bugs should be fixed by my auto-generated series..

I see.  I didn't consider that.

One advantage of my manual fixing is a clearer record of the flaws in
git.  It should also keep your work simpler, which is always a good idea
for massive, mechanical patches.

> And, if fixing by hand, it may be better to teach this function to return
> int, than propagation is not needed.

I went for the minimal fix.

I believe returning something useful is better.  It also matches the
GError conventions.  Deviating from them in this point was a mistake.

Touching up functions to return something useful by hand is a lot of
work, though: functions have many returns, and we have many functions in
need of this touch-up.  Some clever Coccinellery might be able to pull
it off.  I haven't tried.

However, your clever "auto propagation" Coccinellery makes such a change
less compelling, because it hides the propagation.

Thanks!


