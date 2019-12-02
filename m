Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DFC9C33C99
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 11:41:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BF102084F
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 11:41:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DvsEmO3O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BF102084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibk5U-0007yZ-8U
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 06:41:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44828)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1ibk4k-0007O0-L0
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 06:41:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1ibk4h-0005kU-Qn
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 06:41:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20094
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ibk4h-0005jG-MO
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 06:41:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575286866;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N7tN1ljshIaWvj3z15o+HZC9RxnlV3ttBlasVpXYbOs=;
 b=DvsEmO3Oau1wap0LpZtFb8/WR3nfSuw/TpnVtdmkoq5pYjcnm5Tp8vUZvgDbmd5/HynS4L
 kMVedsAhXhKgYNOjw1/684kuTx7wfQoQuEJ6OzslCPDP7Uo1AGyJs5JmaIwFPoQDCuQXF3
 EuIBPjd7Em6agqV1Wi1fKasaDwsu48U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-303-iR8JQxnbOReXUia8_RGj6Q-1; Mon, 02 Dec 2019 06:41:04 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C82688FDD24
 for <qemu-devel@nongnu.org>; Mon,  2 Dec 2019 11:41:01 +0000 (UTC)
Received: from redhat.com (unknown [10.42.16.105])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 84DE41001281;
 Mon,  2 Dec 2019 11:40:56 +0000 (UTC)
Date: Mon, 2 Dec 2019 11:40:54 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH 2/7] ppm-save: pass opened fd
Message-ID: <20191202114054.GD4184266@redhat.com>
References: <20191127115202.375107-1-marcandre.lureau@redhat.com>
 <20191127115202.375107-3-marcandre.lureau@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191127115202.375107-3-marcandre.lureau@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: iR8JQxnbOReXUia8_RGj6Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Nov 27, 2019 at 03:51:57PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> This will allow to pre-open the file before running the async finish
> handler and avoid potential monitor fdset races.
>=20
> (note: this is preliminary work for asynchronous screendump support)
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  ui/console.c    | 45 ++++++++++++++++++++++-----------------------
>  ui/trace-events |  2 +-
>  2 files changed, 23 insertions(+), 24 deletions(-)

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


