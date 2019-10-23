Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 763F2CA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 09:36:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BAB321D7B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 09:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yp8ou6+/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BAB321D7B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iND4U-0000a1-DA
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 05:36:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58030)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iND2H-0007pH-NH
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 05:34:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iND2E-0006Sb-8e
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 05:34:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37780
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iND2E-0006RT-4R
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 05:34:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571823266;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rS7fGipoEVWrkJ2+C0kxySBuBbEIf4zAhXGonB589Vs=;
 b=Yp8ou6+/pxMOWD/o0iKnzcefmHmlO9YytBf1xnFco6Rsxyh9OeTA1gWhxZTwHPA3H+aOBd
 EibmWaNwAq8mGJPY1JtIvLt3qdtaP6RLxV2metGhiVlpdTNfyAzp073wAZEUMXrfVWnG4V
 EHuhre8CqNDE+TQchF7o/++PBy/B3AE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-QbLJHT4vPGiDdY7M2-0QTw-1; Wed, 23 Oct 2019 05:34:24 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F07C3800D49
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 09:34:23 +0000 (UTC)
Received: from work-vm (ovpn-117-198.ams2.redhat.com [10.36.117.198])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8751160BE1;
 Wed, 23 Oct 2019 09:34:17 +0000 (UTC)
Date: Wed, 23 Oct 2019 10:34:15 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH 1/2] virtiofsd: move to an empty network namespace
Message-ID: <20191023093415.GA2834@work-vm>
References: <20191016160157.12414-1-stefanha@redhat.com>
 <20191016160157.12414-2-stefanha@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191016160157.12414-2-stefanha@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: QbLJHT4vPGiDdY7M2-0QTw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: virtio-fs@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Stefan Hajnoczi (stefanha@redhat.com) wrote:
> If the process is compromised there should be no network access.  Use an
> empty network namespace to sandbox networking.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  contrib/virtiofsd/passthrough_ll.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>=20
> diff --git a/contrib/virtiofsd/passthrough_ll.c b/contrib/virtiofsd/passt=
hrough_ll.c
> index 84b60d85bd..c27ff7d800 100644
> --- a/contrib/virtiofsd/passthrough_ll.c
> +++ b/contrib/virtiofsd/passthrough_ll.c
> @@ -2736,6 +2736,19 @@ static void setup_shared_versions(struct lo_data *=
lo)
>  =09lo->version_table =3D addr;
>  }
> =20
> +/*
> + * Called after our UNIX domain sockets have been created, now we can mo=
ve to
> + * an empty network namespace to prevent TCP/IP and other network activi=
ty in
> + * case this process is compromised.
> + */
> +static void setup_net_namespace(void)
> +{
> +=09if (unshare(CLONE_NEWNET) !=3D 0) {
> +=09=09fuse_log(FUSE_LOG_ERR, "unshare(CLONE_NEWNET): %m\n");
> +=09=09exit(1);
> +=09}
> +}
> +
>  /* This magic is based on lxc's lxc_pivot_root() */
>  static void setup_pivot_root(const char *source)
>  {
> @@ -2818,6 +2831,7 @@ static void setup_mount_namespace(const char *sourc=
e)
>   */
>  static void setup_sandbox(struct lo_data *lo, bool enable_syslog)
>  {
> +=09setup_net_namespace();
>  =09setup_mount_namespace(lo->source);
>  =09setup_seccomp(enable_syslog);
>  }
> --=20
> 2.21.0
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


