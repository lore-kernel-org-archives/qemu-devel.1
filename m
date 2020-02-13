Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 452E5C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 13:11:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10D0F218AC
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 13:11:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IGdZgbnk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10D0F218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2EHL-0000xA-7q
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 08:11:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45792)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j2EGa-0000QX-93
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 08:10:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j2EGY-00052U-J8
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 08:10:51 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43265
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j2EGY-00052O-Eq
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 08:10:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581599450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1SBsrdgb5ofnGmWqIt3nsWq1DLdwGxYr7lksCuflN7I=;
 b=IGdZgbnkpOSxX46SZGBE1p6Doso/MmpPrtSKdFMTw6buiieVcMfq4SwqkkTuKjdIvFRCkZ
 QJH87Hk5BNxDIVDyto27cVFLfWgg9KVcSVJP4c54KWsydl2w2wFEqMt9H/OQWR/qoVsR33
 bFNuvBgMxYhFIDWUpdEhyFp/PkIyqAI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-dBhP9g3jOdi0iHKpAfdVKw-1; Thu, 13 Feb 2020 08:10:48 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1A8591800D6B
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 13:10:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-234.ams2.redhat.com
 [10.36.117.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 82EEC5DA83;
 Thu, 13 Feb 2020 13:10:41 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C461511385C9; Thu, 13 Feb 2020 14:10:39 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH] console: make QMP screendump use coroutine
References: <20200113144848.2168018-1-marcandre.lureau@redhat.com>
 <20200212122945.uaq4cbeyhbssr4cs@sirius.home.kraxel.org>
Date: Thu, 13 Feb 2020 14:10:39 +0100
In-Reply-To: <20200212122945.uaq4cbeyhbssr4cs@sirius.home.kraxel.org> (Gerd
 Hoffmann's message of "Wed, 12 Feb 2020 13:29:45 +0100")
Message-ID: <875zga63ao.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: dBhP9g3jOdi0iHKpAfdVKw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Gerd Hoffmann <kraxel@redhat.com> writes:

>   Hi,
>
>> Thanks to the QMP coroutine support, the screendump handler can
>> trigger a graphic_hw_update(), yield and let the main loop run until
>> update is done. Then the handler is resumed, and the ppm_save() will
>> write the screen image to disk in the coroutine context (thus
>> non-blocking).
>>=20
>> For now, HMP doesn't have coroutine support, so it remains potentially
>> outdated or glitched.
>>=20
>> Fixes:
>> https://bugzilla.redhat.com/show_bug.cgi?id=3D1230527
>>=20
>> Based-on: <20200109183545.27452-2-kwolf@redhat.com>
>
> What is the status here?  Tried to apply (worked) and build (failed),
> seems Kevins patches are not merged yet?

I reviewed v3, Kevin worked in improvements promptly, and I failed to
review v4 promptly.  Sorry about that.


