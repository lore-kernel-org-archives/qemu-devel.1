Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B701C33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 15:31:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC2BB207FD
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 15:31:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f4kRGsXO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC2BB207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioULd-0003Ju-GX
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 10:31:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58406)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1ioU1v-00007k-Oe
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 10:10:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1ioU1u-0004sy-B0
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 10:10:55 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38696
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ioU1u-0004sk-5m
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 10:10:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578323453;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b6a9/L/sDMMzB76t2DlJYnTmorkmgIGfU6nsbeViToA=;
 b=f4kRGsXOT6uF5U8lwNmBEYHPlQTxE9hDoRjdEC/EDVP4T5W0Fb69FbKD4YVpk4QWMI56vn
 d3l4bwzvcrmsMd6h1WcKOKsfU5MZUVq7GtMIEf4Lq5ec0YEvIsn7U0BF6I5yugi8si6/FA
 qdEspzsV+5Nb2XJUtUoVKNcGU3jN9R0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-8HUe2dIKPDa4TM9ZCtkKSQ-1; Mon, 06 Jan 2020 10:10:52 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 90600109012E
 for <qemu-devel@nongnu.org>; Mon,  6 Jan 2020 15:10:51 +0000 (UTC)
Received: from redhat.com (unknown [10.42.16.105])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 57323858B1;
 Mon,  6 Jan 2020 15:10:48 +0000 (UTC)
Date: Mon, 6 Jan 2020 15:10:48 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Subject: Re: [PATCH 058/104] virtiofsd: print log only when priority is high
 enough
Message-ID: <20200106151048.GV2930416@redhat.com>
References: <20191212163904.159893-1-dgilbert@redhat.com>
 <20191212163904.159893-59-dgilbert@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191212163904.159893-59-dgilbert@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 8HUe2dIKPDa4TM9ZCtkKSQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Dec 12, 2019 at 04:38:18PM +0000, Dr. David Alan Gilbert (git) wrot=
e:
> From: Eryu Guan <eguan@linux.alibaba.com>
>=20
> Introduce "-o log_level=3D" command line option to specify current log
> level (priority), valid values are "debug info warn err", e.g.
>=20
>     ./virtiofsd -o log_level=3Ddebug ...
>=20
> So only log priority higher than "debug" will be printed to
> stderr/syslog. And the default level is info.
>=20
> The "-o debug"/"-d" options are kept, and imply debug log level.
>=20
> Signed-off-by: Eryu Guan <eguan@linux.alibaba.com>
> dgilbert: Reworked for libfuse's log_func
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  tools/virtiofsd/fuse_log.c       |   4 ++
>  tools/virtiofsd/fuse_lowlevel.c  |  75 ++++++++------------
>  tools/virtiofsd/fuse_lowlevel.h  |   1 +
>  tools/virtiofsd/helper.c         |  10 ++-
>  tools/virtiofsd/passthrough_ll.c | 118 +++++++++++++------------------
>  5 files changed, 92 insertions(+), 116 deletions(-)

> diff --git a/tools/virtiofsd/fuse_log.c b/tools/virtiofsd/fuse_log.c
> index 11345f9ec8..79a18a7aaa 100644
> --- a/tools/virtiofsd/fuse_log.c
> +++ b/tools/virtiofsd/fuse_log.c
> @@ -8,6 +8,10 @@
>   * See the file COPYING.LIB
>   */
> =20
> +#include <stdbool.h>
> +#include <stdio.h>
> +#include <stdarg.h>
> +#include <syslog.h>
>  #include "fuse_log.h"
> =20
>  #include <stdarg.h>

Why do we need to add these headers if there are no code changes in this
file ?

> diff --git a/tools/virtiofsd/fuse_lowlevel.c b/tools/virtiofsd/fuse_lowle=
vel.c
> index f3c8bdf7cb..0abb369b3d 100644
> --- a/tools/virtiofsd/fuse_lowlevel.c
> +++ b/tools/virtiofsd/fuse_lowlevel.c
> @@ -158,19 +158,17 @@ static int fuse_send_msg(struct fuse_session *se, s=
truct fuse_chan *ch,
>      struct fuse_out_header *out =3D iov[0].iov_base;
> =20
>      out->len =3D iov_length(iov, count);
> -    if (se->debug) {
> -        if (out->unique =3D=3D 0) {
> -            fuse_log(FUSE_LOG_DEBUG, "NOTIFY: code=3D%d length=3D%u\n", =
out->error,
> -                     out->len);
> -        } else if (out->error) {
> -            fuse_log(FUSE_LOG_DEBUG,
> -                     "   unique: %llu, error: %i (%s), outsize: %i\n",
> -                     (unsigned long long)out->unique, out->error,
> -                     strerror(-out->error), out->len);
> -        } else {
> -            fuse_log(FUSE_LOG_DEBUG, "   unique: %llu, success, outsize:=
 %i\n",
> -                     (unsigned long long)out->unique, out->len);
> -        }
> +    if (out->unique =3D=3D 0) {
> +        fuse_log(FUSE_LOG_DEBUG, "NOTIFY: code=3D%d length=3D%u\n", out-=
>error,
> +                 out->len);
> +    } else if (out->error) {
> +        fuse_log(FUSE_LOG_DEBUG,
> +                 "   unique: %llu, error: %i (%s), outsize: %i\n",
> +                 (unsigned long long)out->unique, out->error,
> +                 strerror(-out->error), out->len);
> +    } else {
> +        fuse_log(FUSE_LOG_DEBUG, "   unique: %llu, success, outsize: %i\=
n",
> +                 (unsigned long long)out->unique, out->len);
>      }

Removing all the 'if (se->debug)' checks means that we take the
performance hit of calling many logging functions in the common
case where debug is disabled. Hopefully 'fuse_log' is smart
enough to avoid printf formatting of the msg + args unless
it is actually goiing to output the message


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


