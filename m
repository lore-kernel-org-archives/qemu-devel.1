Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D8B6C3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 09:27:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA23D20CC7
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 09:27:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RKZNuKtX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA23D20CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQSi8-0005ee-47
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 05:27:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40726 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jQSgz-0004uY-Lj
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 05:26:18 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jQSgz-0003Xz-54
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 05:26:17 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29313
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jQSgy-0003X0-Ng
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 05:26:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587374775;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DNMCPgs2H1hCFQn+6uWtbBENPnuKBiumsZadFSWdcjc=;
 b=RKZNuKtX4F3ZKs9TGqR/XHuVFuVHlkJDff+zrsUIMDyD8JQciKg7il/VDuZOkOCzhynNPO
 WU6HfjqcZkLmYlYvrXivciZRP3WA8syVutEc7en8N9gXRrA+2Vk3DbZwQeAU0Kl3H4u2Uf
 MFMwEJTUc+FMBKmO1jQ50EGdRcIR+xQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-3gH7miqjMaunFfCqcG8ixQ-1; Mon, 20 Apr 2020 05:26:13 -0400
X-MC-Unique: 3gH7miqjMaunFfCqcG8ixQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F3D9018C43E1;
 Mon, 20 Apr 2020 09:26:11 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.47])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AC1FE28987;
 Mon, 20 Apr 2020 09:26:03 +0000 (UTC)
Date: Mon, 20 Apr 2020 10:26:00 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
Subject: Re: [PATCH v2] chardev/char-socket: Properly make qio connections
 non blocking
Message-ID: <20200420092600.GG346737@redhat.com>
References: <1587289900-29485-1-git-send-email-sai.pavan.boddu@xilinx.com>
MIME-Version: 1.0
In-Reply-To: <1587289900-29485-1-git-send-email-sai.pavan.boddu@xilinx.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs1p.gnu.org: First seen = 2020/04/20
 03:29:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 edgari@xilinx.com, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Apr 19, 2020 at 03:21:40PM +0530, Sai Pavan Boddu wrote:
> In tcp_chr_sync_read function, there is a possibility of socket
> disconnection during blocking read, then tcp_chr_hup function would clean=
 up
> the qio channel pointers(i.e ioc, sioc).
>=20
> Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
> ---
> Changes for V2:
> =09Place the guard around 'qio_channel_set_blocking' call to check connec=
tion status
> =09This fix is simpler than v1 and explains better about the issue.
>=20
>  chardev/char-socket.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index 185fe38..e56b2f0 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -549,7 +549,9 @@ static int tcp_chr_sync_read(Chardev *chr, const uint=
8_t *buf, int len)
> =20
>      qio_channel_set_blocking(s->ioc, true, NULL);
>      size =3D tcp_chr_recv(chr, (void *) buf, len);
> -    qio_channel_set_blocking(s->ioc, false, NULL);
> +    if (s->state !=3D TCP_CHARDEV_STATE_DISCONNECTED) {
> +        qio_channel_set_blocking(s->ioc, false, NULL);
> +    }
>      if (size =3D=3D 0) {
>          /* connection closed */
>          tcp_chr_disconnect(chr);

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


