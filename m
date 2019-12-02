Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 050CAC432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 12:24:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D9F42146E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 12:24:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fw0FenTB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D9F42146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibkkr-00062O-Ei
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 07:24:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50062)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1ibkjN-0005Yh-Qd
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 07:23:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1ibkjM-00006z-Tm
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 07:23:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44302
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1ibkjM-00006k-QM
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 07:23:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575289387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4fHZTV1tnzMteBc2YDBSMM0lUXZYDDPgZNp8PjASAws=;
 b=fw0FenTBpqGnSORDBV0XjRGQOzvi9Uscs7IDOtrvF7+NGMe6u/Lkw2ZlQIH1tF6kZwaHAZ
 gSUKGoarAA+refJHkY2So4fo8HK9T9Mj4k1EY/PlcZotD55hvGLc1Fp2v7HlQDhJkk8gWO
 cQZwb4omjNyGVrO4+1a5iDd/xxjREmQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-Gl_An-YTNpuuI7axKwjL8A-1; Mon, 02 Dec 2019 07:23:03 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3B0F1DB20;
 Mon,  2 Dec 2019 12:23:02 +0000 (UTC)
Received: from linux.fritz.box (ovpn-116-121.ams2.redhat.com [10.36.116.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EFFF05C290;
 Mon,  2 Dec 2019 12:23:00 +0000 (UTC)
Date: Mon, 2 Dec 2019 13:22:59 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 03/21] block/file-posix: Fix laio_init() error handling
 crash bug
Message-ID: <20191202122259.GB5929@linux.fritz.box>
References: <20191130194240.10517-1-armbru@redhat.com>
 <20191130194240.10517-4-armbru@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191130194240.10517-4-armbru@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: Gl_An-YTNpuuI7axKwjL8A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: vsementsov@virtuozzo.com, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Nishanth Aravamudan <naravamudan@digitalocean.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 30.11.2019 um 20:42 hat Markus Armbruster geschrieben:
> raw_aio_attach_aio_context() passes uninitialized Error *local_err by
> reference to laio_init() via aio_setup_linux_aio().  When laio_init()
> fails, it passes it on to error_setg_errno(), tripping error_setv()'s
> assertion unless @local_err is null by dumb luck.
>=20
> Fix by initializing @local_err properly.
>=20
> Fixes: ed6e2161715c527330f936d44af4c547f25f687e
> Cc: Nishanth Aravamudan <naravamudan@digitalocean.com>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Cc: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Kevin Wolf <kwolf@redhat.com>


