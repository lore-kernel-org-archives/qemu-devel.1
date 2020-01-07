Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5113EC33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 12:43:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A1EC207E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 12:43:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wa23F0w8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A1EC207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iooD8-0002N0-8q
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 07:43:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39271)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iomxO-0005ym-0R
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 06:23:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iomxM-0005zI-Hy
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 06:23:29 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:58110
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iomxM-0005z5-Dx
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 06:23:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578396208;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bQpHBiB77jRLIM/SSzBI+5nIv6lki2GltRFSi+L6sGM=;
 b=Wa23F0w8INJ2Cb048oj3hSwPQIL9855s9+CMlk+YkG/Q3xuxzUOjL60htpSHa0LxcrOtM5
 kaKe0IIA6/FAc2ZcRuQQIyZjkoz/a5qjmFPqqUNRHmBMj9eX3vwWTKGFncz0gJpzLmf5Xv
 j0UwfOYoLF5/Te7ouXcha/ao/jjsZQI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-175-6H0n-0AkN0O8w1fOsE2bVA-1; Tue, 07 Jan 2020 06:23:25 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9FAB9801E72
 for <qemu-devel@nongnu.org>; Tue,  7 Jan 2020 11:23:24 +0000 (UTC)
Received: from redhat.com (ovpn-112-61.ams2.redhat.com [10.36.112.61])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 55D795C21B;
 Tue,  7 Jan 2020 11:23:20 +0000 (UTC)
Date: Tue, 7 Jan 2020 11:23:16 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Subject: Re: [PATCH 068/104] virtiofsd: passthrough_ll: control readdirplus
Message-ID: <20200107112316.GL3368802@redhat.com>
References: <20191212163904.159893-1-dgilbert@redhat.com>
 <20191212163904.159893-69-dgilbert@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191212163904.159893-69-dgilbert@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: 6H0n-0AkN0O8w1fOsE2bVA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

On Thu, Dec 12, 2019 at 04:38:28PM +0000, Dr. David Alan Gilbert (git) wrot=
e:
> From: Miklos Szeredi <mszeredi@redhat.com>
>

What is readdirplus and what do we need a command line option to
control it ? What's the user benefit of changing the setting ?

> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>  tools/virtiofsd/passthrough_ll.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrou=
gh_ll.c
> index 0d70a367bd..c3e8bde5cf 100644
> --- a/tools/virtiofsd/passthrough_ll.c
> +++ b/tools/virtiofsd/passthrough_ll.c
> @@ -118,6 +118,8 @@ struct lo_data {
>      double timeout;
>      int cache;
>      int timeout_set;
> +    int readdirplus_set;
> +    int readdirplus_clear;
>      struct lo_inode root; /* protected by lo->mutex */
>      struct lo_map ino_map; /* protected by lo->mutex */
>      struct lo_map dirp_map; /* protected by lo->mutex */
> @@ -141,6 +143,8 @@ static const struct fuse_opt lo_opts[] =3D {
>      { "cache=3Dauto", offsetof(struct lo_data, cache), CACHE_NORMAL },
>      { "cache=3Dalways", offsetof(struct lo_data, cache), CACHE_ALWAYS },
>      { "norace", offsetof(struct lo_data, norace), 1 },
> +    { "readdirplus", offsetof(struct lo_data, readdirplus_set), 1 },
> +    { "no_readdirplus", offsetof(struct lo_data, readdirplus_clear), 1 }=
,
>      FUSE_OPT_END
>  };
>  static bool use_syslog =3D false;
> @@ -479,7 +483,8 @@ static void lo_init(void *userdata, struct fuse_conn_=
info *conn)
>          fuse_log(FUSE_LOG_DEBUG, "lo_init: activating flock locks\n");
>          conn->want |=3D FUSE_CAP_FLOCK_LOCKS;
>      }
> -    if (lo->cache =3D=3D CACHE_NEVER) {
> +    if ((lo->cache =3D=3D CACHE_NEVER && !lo->readdirplus_set) ||
> +        lo->readdirplus_clear) {
>          fuse_log(FUSE_LOG_DEBUG, "lo_init: disabling readdirplus\n");
>          conn->want &=3D ~FUSE_CAP_READDIRPLUS;
>      }
> --=20
> 2.23.0
>=20
>=20

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


