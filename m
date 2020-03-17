Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D89AC10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 15:53:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 678CD20663
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 15:53:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NWrn9G3L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 678CD20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEEXT-0008Cg-Ih
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 11:53:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54079)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jEEJk-0002jL-SY
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:39:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jEEJj-0006a7-Kn
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:39:44 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:27183)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jEEJj-0006Wa-Fw
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:39:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584459581;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5J5/Eot8UDfcBCNSY5pgpL72A3tFXA/1EcwfGOtPqlk=;
 b=NWrn9G3L03BWO5W+onzvLXFnGP4HP8BwrSH9V7ARI8gv1KYCAYLlUDFgnUWZPnzUIY2AZY
 4c3FUx46TnwY2Pfp7HmDZYnyngTVv2+Gd0beTsLYf+YxtvA3gdp32hZcQ5NAdo98Fia9iA
 2jQ97kF1hB4izIUmdn+CxH9N6f3koYE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-JaRjdJIvPKGZwKmtHZ5abQ-1; Tue, 17 Mar 2020 11:39:39 -0400
X-MC-Unique: JaRjdJIvPKGZwKmtHZ5abQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C1FAE100550D;
 Tue, 17 Mar 2020 15:39:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-130.ams2.redhat.com
 [10.36.112.130])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 912E95DA83;
 Tue, 17 Mar 2020 15:39:38 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 112CA1138404; Tue, 17 Mar 2020 16:39:37 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v10 4/3] hw/sd/ssi-sd: fix error handling in ssi_sd_realize
References: <20200313170517.22480-1-armbru@redhat.com>
 <20200317125741.15301-1-vsementsov@virtuozzo.com>
Date: Tue, 17 Mar 2020 16:39:37 +0100
In-Reply-To: <20200317125741.15301-1-vsementsov@virtuozzo.com> (Vladimir
 Sementsov-Ogievskiy's message of "Tue, 17 Mar 2020 15:57:41 +0300")
Message-ID: <87zhcf56ti.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
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
Cc: alxndr@bu.edu, ashijeetacharya@gmail.com, philmd@redhat.com,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:

> It's wrong to use same err object as errp parameter for several
> function calls without intermediate checking for error: we'll crash if
> try to set err object twice. Fix that.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>
> Forgive me for sending this into your series, but seems it is very
> appropriate.
>
> It's rephrasing  of my
>  [PATCH v9 03/10] hw/sd/ssi-sd: fix error handling in ssi_sd_realize
> for partI series but but without use of ERRP_AUTO_PROPAGATE.

Forgive?  Thank you for extracting a bug fix for 5.0!  Got more?  :)


