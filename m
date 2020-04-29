Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93228C83000
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 14:39:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FEDA21D7B
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 14:39:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZSX0POzj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FEDA21D7B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTnsB-0007Il-Cb
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 10:39:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49656)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vgoyal@redhat.com>) id 1jTnqs-0006g2-25
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 10:38:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vgoyal@redhat.com>) id 1jTnon-0003cP-2h
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 10:38:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41537
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1jTnom-0003b7-JL
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 10:36:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588170967;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YpoFvNm55vWZsr9GeHIpjJNZY4wxUjaz77J3T0rz2O8=;
 b=ZSX0POzjlLqdgkkjKbOag8o57w/gqzofE767t8Pv3mvo5Rv4LvaydYcLk1QiHSWxlNRO9I
 Nys/Ki90xMtUC1bl9dlTVjD/NiPeskQ32AOOPooFCQnlxIyR41BGWy6diqdIG2Gj2pQQrQ
 J7yzxgEfUDzDRTXh73CLKqkQw46WJ2o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-94-hebWJlhVN0qdahm2x8Q9wA-1; Wed, 29 Apr 2020 10:36:05 -0400
X-MC-Unique: hebWJlhVN0qdahm2x8Q9wA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9932CA0BDA
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 14:36:04 +0000 (UTC)
Received: from horse.redhat.com (ovpn-114-168.rdu2.redhat.com [10.10.114.168])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 783915D785;
 Wed, 29 Apr 2020 14:36:01 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id E8EE9222EB9; Wed, 29 Apr 2020 10:36:00 -0400 (EDT)
Date: Wed, 29 Apr 2020 10:36:00 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Miklos Szeredi <mszeredi@redhat.com>
Subject: Re: [Virtio-fs] [PATCH] virtiofsd: jail lo->proc_self_fd
Message-ID: <20200429143600.GE231284@redhat.com>
References: <20200429124733.22488-1-mszeredi@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200429124733.22488-1-mszeredi@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=vgoyal@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 01:42:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: virtio-fs@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Apr 29, 2020 at 02:47:33PM +0200, Miklos Szeredi wrote:
> While it's not possible to escape the proc filesystem through
> lo->proc_self_fd, it is possible to escape to the root of the proc
> filesystem itself through "../..".

Hi Miklos,

So this attack will work with some form of *at(lo->proc_self_fd, "../..")
call?

>=20
> Use a temporary mount for opening lo->proc_self_fd, that has it's root at
> /proc/self/fd/, preventing access to the ancestor directories.

Does this mean that now similar attack can happen using "../.." on tmpdir
fd instead and be able to look at peers of tmpdir. Or it is blocked
due to mount point or something else.=20

Thanks
Vivek

>=20
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
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
> _______________________________________________
> Virtio-fs mailing list
> Virtio-fs@redhat.com
> https://www.redhat.com/mailman/listinfo/virtio-fs


