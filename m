Return-Path: <SRS0=dCqM=2Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE36C2D0C2
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 12:19:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A94E5215A4
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 12:19:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VsIy0mZB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A94E5215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inLvO-0006Z6-Q3
	for qemu-devel@archiver.kernel.org; Fri, 03 Jan 2020 07:19:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43462)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1inLuq-0006Ac-7k
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 07:18:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1inLuo-0000Dp-Vc
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 07:18:56 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:39754
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1inLuo-0000Ah-Q7
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 07:18:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578053934;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z4IZcjkEzioVorGgLmpMzf8nw68XVoGLkhBum0CP594=;
 b=VsIy0mZBs1eYWJiLzO0V5iGT34VqQmkD9k485QOx//oanSo9BjI5fIf7VDDpYgJ0o6MjuE
 AN3H/nM96ZrCqPCPsAI26k1LNF/ZEZfYh0lE9hAxGmLmPQW6zB45R+eryMMIaUs/pjYSOb
 TEsmO95jd17mfWtnM70Nsllu9txCqX8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-HBAoFgryOM-M_n_6nt5mPw-1; Fri, 03 Jan 2020 07:18:53 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5BEE71800D42
 for <qemu-devel@nongnu.org>; Fri,  3 Jan 2020 12:18:52 +0000 (UTC)
Received: from redhat.com (ovpn-112-41.ams2.redhat.com [10.36.112.41])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 32EC77BA32;
 Fri,  3 Jan 2020 12:18:47 +0000 (UTC)
Date: Fri, 3 Jan 2020 12:18:44 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Subject: Re: [PATCH 010/104] virtiofsd: Fix fuse_daemonize ignored return
 values
Message-ID: <20200103121844.GP2753983@redhat.com>
References: <20191212163904.159893-1-dgilbert@redhat.com>
 <20191212163904.159893-11-dgilbert@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191212163904.159893-11-dgilbert@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: HBAoFgryOM-M_n_6nt5mPw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Dec 12, 2019 at 04:37:30PM +0000, Dr. David Alan Gilbert (git) wrot=
e:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>=20
> QEMU's compiler enables warnings/errors for ignored values
> and the (void) trick used in the fuse code isn't enough.
> Turn all the return values into a return value on the function.
>=20
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  tools/virtiofsd/helper.c | 33 ++++++++++++++++++++++-----------
>  1 file changed, 22 insertions(+), 11 deletions(-)

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

> diff --git a/tools/virtiofsd/helper.c b/tools/virtiofsd/helper.c
> index d8c42401a7..8afccfc15e 100644
> --- a/tools/virtiofsd/helper.c
> +++ b/tools/virtiofsd/helper.c
> @@ -10,12 +10,10 @@
>   * See the file COPYING.LIB.
>   */
> =20
> -#include "config.h"
>  #include "fuse_i.h"
>  #include "fuse_lowlevel.h"
>  #include "fuse_misc.h"
>  #include "fuse_opt.h"
> -#include "mount_util.h"
> =20
>  #include <errno.h>
>  #include <limits.h>
> @@ -177,6 +175,7 @@ int fuse_parse_cmdline(struct fuse_args *args, struct=
 fuse_cmdline_opts *opts)
> =20
>  int fuse_daemonize(int foreground)

Yay, 4th implementation of "daemonize" logic in QEMU codebase :-)

One day in the future it would be a nice idea to have a helper for
this that we can share across the system emulator, qemu guest agent,
qemu-nbd and virtiofsd. Not a requirement for this initial merge.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


