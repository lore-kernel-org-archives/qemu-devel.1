Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E62CC43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 06:51:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A2F02082E
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 06:51:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DJEYd+DR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A2F02082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih6hx-0007e9-78
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 01:51:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51126)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1ih6NE-0005gV-Cv
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 01:30:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1ih6ND-0007PY-Az
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 01:30:24 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45786
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ih6ND-0007MH-6n
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 01:30:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576564222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RfuzsbUnq49AcQ5FtItokkyTFbIcveErUqTmivAOHUA=;
 b=DJEYd+DRpWuVJjAFLjBUYH5cSDlIpybv6BNTpvlNPrAUt8OQj35mB4S1ylMYWEOOC7M9zA
 OSDH7IvWUzif2xbGfdJ2ktr7/9mr2g5CfTFiKKMfuFKZmIsZqjcj4rsLEO5B+SUpNphQZ5
 FcoeiJ2shfIQFNP9UipUQQR+d37K1FM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-431-y4dKodImM4K76hUCpcEv7A-1; Tue, 17 Dec 2019 01:30:19 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A5F211800D7B;
 Tue, 17 Dec 2019 06:30:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-42.ams2.redhat.com
 [10.36.116.42])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 72B5E7C836;
 Tue, 17 Dec 2019 06:30:16 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 224BB11386A7; Tue, 17 Dec 2019 07:30:15 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Corey Minyard <cminyard@mvista.com>
Subject: Re: [PATCH 11/21] hw/ipmi: Fix latent realize() error handling bugs
References: <20191130194240.10517-1-armbru@redhat.com>
 <20191130194240.10517-12-armbru@redhat.com>
 <20191201182234.GA18195@minyard.net>
 <87mubsfwzf.fsf@dusky.pond.sub.org>
 <20191216141320.GA7049@minyard.net>
Date: Tue, 17 Dec 2019 07:30:15 +0100
In-Reply-To: <20191216141320.GA7049@minyard.net> (Corey Minyard's message of
 "Mon, 16 Dec 2019 08:13:20 -0600")
Message-ID: <878snbpiq0.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: y4dKodImM4K76hUCpcEv7A-1
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
Cc: vsementsov@virtuozzo.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Corey Minyard <cminyard@mvista.com> writes:

> On Mon, Dec 16, 2019 at 10:20:04AM +0100, Markus Armbruster wrote:
>> Corey Minyard <cminyard@mvista.com> writes:
>>=20
>> I've since posted v2 with a revamped commit message, and I'm ready to
>> post a pull request.  I really want the whole thing committed before the
>> Christmas break, so Vladimir can base on it more easily.  Options:
>>=20
>> * You post a pull request before me.
>>=20
>> * Ask me to drop this patch from my pull request, so you can take it
>>   through your tree at your leisure.
>>=20
>> * Post your Reviewed-by or Acked-by for me to include in my pull
>>   request.
>>=20
>> * Do nothing; I'll post my pull request later this week.
>>=20
>
> Since you already have it ready, I'll choose the "do nothing" patch
> and let you post the pull request.  Thanks.

Okay, sent.  Thanks for your quick reply!


