Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90552C4724C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 17:48:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6149420857
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 17:48:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MzQrkbmS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6149420857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUZlv-00031M-Jv
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 13:48:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42734)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jUZl6-00021E-V7
 for qemu-devel@nongnu.org; Fri, 01 May 2020 13:47:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jUZl5-0000m7-Th
 for qemu-devel@nongnu.org; Fri, 01 May 2020 13:47:32 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:32253
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jUZl5-0000gu-Cx
 for qemu-devel@nongnu.org; Fri, 01 May 2020 13:47:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588355249;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zjs5VsLRSSGwjDjK19b0om/9nnHIaKz2fAMLKvxfYCo=;
 b=MzQrkbmSBetDdj8GOn1xkJJovtJiBHZOE7XLA1+74eP2uKS0ESimKyOtp7heIVsMXpL77a
 hoGw1Bjdi5lso3LeAX0a3I4FZsYjBSDxjMdn6df9OTTW2L9gqne1HAvEkzYFeeiseJcNiQ
 LA8oorWHuzk8wtunZ+j736Qw3p/C0os=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-nbj7IYUsPx2_RBeeEsCCvw-1; Fri, 01 May 2020 13:47:27 -0400
X-MC-Unique: nbj7IYUsPx2_RBeeEsCCvw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 152E2107ACCA
 for <qemu-devel@nongnu.org>; Fri,  1 May 2020 17:47:27 +0000 (UTC)
Received: from work-vm (ovpn-112-191.ams2.redhat.com [10.36.112.191])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A4DBA10013BD;
 Fri,  1 May 2020 17:47:23 +0000 (UTC)
Date: Fri, 1 May 2020 18:47:21 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Miklos Szeredi <mszeredi@redhat.com>
Subject: Re: [PATCH] virtiofsd: jail lo->proc_self_fd
Message-ID: <20200501174721.GB38251@work-vm>
References: <20200429124733.22488-1-mszeredi@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200429124733.22488-1-mszeredi@redhat.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/01 12:40:15
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
Cc: virtio-fs@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Miklos Szeredi (mszeredi@redhat.com) wrote:
> While it's not possible to escape the proc filesystem through
> lo->proc_self_fd, it is possible to escape to the root of the proc
> filesystem itself through "../..".
>=20
> Use a temporary mount for opening lo->proc_self_fd, that has it's root at
> /proc/self/fd/, preventing access to the ancestor directories.
>=20
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>

Queued

> ---
>  tools/virtiofsd/passthrough_ll.c | 27 +++++++++++++++++++++++++--
>  1 file changed, 25 insertions(+), 2 deletions(-)
>=20
> diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrou=
gh_ll.c
> index 4c35c95b256c..bc9c44c760f4 100644
> --- a/tools/virtiofsd/passthrough_ll.c
> +++ b/tools/virtiofsd/passthrough_ll.c
> @@ -2536,6 +2536,8 @@ static void print_capabilities(void)
>  static void setup_namespaces(struct lo_data *lo, struct fuse_session *se=
)
>  {
>      pid_t child;
> +    char template[] =3D "virtiofsd-XXXXXX";
> +    char *tmpdir;
> =20
>      /*
>       * Create a new pid namespace for *child* processes.  We'll have to
> @@ -2597,12 +2599,33 @@ static void setup_namespaces(struct lo_data *lo, =
struct fuse_session *se)
>          exit(1);
>      }
> =20
> +    tmpdir =3D mkdtemp(template);
> +    if (!tmpdir) {
> +        fuse_log(FUSE_LOG_ERR, "tmpdir(%s): %m\n", template);
> +        exit(1);
> +    }
> +
> +    if (mount("/proc/self/fd", tmpdir, NULL, MS_BIND, NULL) < 0) {
> +        fuse_log(FUSE_LOG_ERR, "mount(/proc/self/fd, %s, MS_BIND): %m\n"=
,
> +                 tmpdir);
> +        exit(1);
> +    }
> +
>      /* Now we can get our /proc/self/fd directory file descriptor */
> -    lo->proc_self_fd =3D open("/proc/self/fd", O_PATH);
> +    lo->proc_self_fd =3D open(tmpdir, O_PATH);
>      if (lo->proc_self_fd =3D=3D -1) {
> -        fuse_log(FUSE_LOG_ERR, "open(/proc/self/fd, O_PATH): %m\n");
> +        fuse_log(FUSE_LOG_ERR, "open(%s, O_PATH): %m\n", tmpdir);
>          exit(1);
>      }
> +
> +    if (umount2(tmpdir, MNT_DETACH) < 0) {
> +        fuse_log(FUSE_LOG_ERR, "umount2(%s, MNT_DETACH): %m\n", tmpdir);
> +        exit(1);
> +    }
> +
> +    if (rmdir(tmpdir) < 0) {
> +        fuse_log(FUSE_LOG_ERR, "rmdir(%s): %m\n", tmpdir);
> +    }
>  }
> =20
>  /*
> --=20
> 2.21.1
>=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


