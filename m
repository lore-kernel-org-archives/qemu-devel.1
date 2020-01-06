Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A5FFC33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 14:20:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41B2220731
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 14:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FU/R05bG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41B2220731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioTEf-00015u-Dh
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 09:20:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33792)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1ioTDt-0000VJ-94
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 09:19:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1ioTDr-0003IT-IO
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 09:19:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29426
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ioTDr-0003HU-79
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 09:19:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578320349;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FAZRYO9KdqkOU9sP0+c8qcaQEfXX0yBjWmzn5cFofEc=;
 b=FU/R05bGspa0OcFGWYMHM1bWsUTBaBW526AWBKESP6XtzlrjRLLKNH6ssy+8yaa+Xrz40d
 9NOynf8ReYxf6+9XuLL7tUOBxTdBG5lCNCXPBO3O6i9FielNCMJV/AIVMQLx7O199sX0a0
 NUblQrnwl0kLpuKzhdvkC2Bpb3eUYAc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-L_eAGCRbMZep0ATOiWrz8Q-1; Mon, 06 Jan 2020 09:19:07 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C4D58107ACC9
 for <qemu-devel@nongnu.org>; Mon,  6 Jan 2020 14:19:05 +0000 (UTC)
Received: from redhat.com (unknown [10.42.16.105])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3C8F477FFD;
 Mon,  6 Jan 2020 14:19:00 +0000 (UTC)
Date: Mon, 6 Jan 2020 14:19:00 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Subject: Re: [PATCH 028/104] virtiofsd: make -f (foreground) the default
Message-ID: <20200106141900.GG2930416@redhat.com>
References: <20191212163904.159893-1-dgilbert@redhat.com>
 <20191212163904.159893-29-dgilbert@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191212163904.159893-29-dgilbert@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: L_eAGCRbMZep0ATOiWrz8Q-1
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
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Dec 12, 2019 at 04:37:48PM +0000, Dr. David Alan Gilbert (git) wrot=
e:
> From: Stefan Hajnoczi <stefanha@redhat.com>
>=20
> According to vhost-user.rst "Backend program conventions", backend
> programs should run in the foregound by default.  Follow the
> conventions so libvirt and other management tools can control virtiofsd
> in a standard way.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  tools/virtiofsd/helper.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>


>=20
> diff --git a/tools/virtiofsd/helper.c b/tools/virtiofsd/helper.c
> index 48e38a7963..d4fff4fa53 100644
> --- a/tools/virtiofsd/helper.c
> +++ b/tools/virtiofsd/helper.c
> @@ -28,6 +28,11 @@
>      {                                               \
>          t, offsetof(struct fuse_cmdline_opts, p), 1 \
>      }
> +#define FUSE_HELPER_OPT_VALUE(t, p, v)              \
> +    {                                               \
> +        t, offsetof(struct fuse_cmdline_opts, p), v \
> +    }
> +
> =20
>  static const struct fuse_opt fuse_helper_opts[] =3D {
>      FUSE_HELPER_OPT("-h", show_help),
> @@ -41,6 +46,7 @@ static const struct fuse_opt fuse_helper_opts[] =3D {
>      FUSE_OPT_KEY("-d", FUSE_OPT_KEY_KEEP),
>      FUSE_OPT_KEY("debug", FUSE_OPT_KEY_KEEP),
>      FUSE_HELPER_OPT("-f", foreground),
> +    FUSE_HELPER_OPT_VALUE("--daemonize", foreground, 0),
>      FUSE_HELPER_OPT("-s", singlethread),
>      FUSE_HELPER_OPT("fsname=3D", nodefault_subtype),
>      FUSE_OPT_KEY("fsname=3D", FUSE_OPT_KEY_KEEP),
> @@ -132,6 +138,7 @@ void fuse_cmdline_help(void)
>             "    -V   --version             print version\n"
>             "    -d   -o debug              enable debug output (implies =
-f)\n"
>             "    -f                         foreground operation\n"
> +           "    --daemonize                run in background\n"

Wonder if there is sense in documenting '--daemonize' as a standard
for backend programs, even if QEMU/libvirt don't need it.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


