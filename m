Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B87D0C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 08:33:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80F8E2067D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 08:33:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hPmsOVII"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80F8E2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtoSt-0004w7-RK
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 04:33:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59946)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jtoS5-0003nK-4Y
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 04:32:13 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:32790
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jtoS2-0005TL-ER
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 04:32:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594369929;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SYJ/VAYrAwaFcMyJdgWlLBh/VD/rjzhGETyCE1zeK5M=;
 b=hPmsOVIIc1WvzwFsziGfn9rStNdWPRXwHENANlFWBYWXoOLaVx+HayviZpTUbEXta8qdaK
 /qKEFoV/Tdmc1uAvQJ8vFM9sOJn8Sd32qaBE50MncWr0OxeBYiI2Xq6U+XRbRrd64IKOjk
 pM8FCyf1OuWzqXsgllUh7avt/6LVNNM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-489-s1bM4tggNCy5aHTZA-IqZA-1; Fri, 10 Jul 2020 04:31:48 -0400
X-MC-Unique: s1bM4tggNCy5aHTZA-IqZA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 98655107ACCA;
 Fri, 10 Jul 2020 08:31:46 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.42])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7AE1519D7D;
 Fri, 10 Jul 2020 08:31:38 +0000 (UTC)
Date: Fri, 10 Jul 2020 09:31:35 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH 09/13] nbd: add GUri-based URI parsing version
Message-ID: <20200710083135.GB4017912@redhat.com>
References: <20200709194234.2117650-1-marcandre.lureau@redhat.com>
 <20200709194234.2117650-10-marcandre.lureau@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200709194234.2117650-10-marcandre.lureau@redhat.com>
User-Agent: Mutt/1.14.3 (2020-06-14)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 23:35:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>, integration@gluster.org,
 sheepdog@lists.wpkg.org, qemu-block@nongnu.org, Peter Lieven <pl@kamp.de>,
 qemu-devel@nongnu.org, "Richard W.M. Jones" <rjones@redhat.com>,
 Liu Yuan <namei.unix@gmail.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 09, 2020 at 11:42:30PM +0400, Marc-André Lureau wrote:
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  block/nbd.c        | 86 +++++++++++++++++++++++++++++++++++-----------
>  util/Makefile.objs |  2 +-
>  2 files changed, 66 insertions(+), 22 deletions(-)
> 
> diff --git a/block/nbd.c b/block/nbd.c
> index faadcab442b..fdc4a53a98f 100644
> --- a/block/nbd.c
> +++ b/block/nbd.c
> @@ -31,7 +31,10 @@
>  #include "qemu/osdep.h"
>  
>  #include "trace.h"
> +#ifndef HAVE_GLIB_GURI
>  #include "qemu/uri.h"
> +#endif
> +#include "qemu/error-report.h"
>  #include "qemu/option.h"
>  #include "qemu/cutils.h"
>  #include "qemu/main-loop.h"
> @@ -1513,71 +1516,112 @@ static int nbd_client_connect(BlockDriverState *bs, Error **errp)
>  /*
>   * Parse nbd_open options
>   */
> -
>  static int nbd_parse_uri(const char *filename, QDict *options)
>  {
> +    const char *p, *scheme, *server, *socket = NULL;
> +    int port;
> +    bool is_unix;
> +
> +#ifdef HAVE_GLIB_GURI
> +    g_autoptr(GUri) uri = NULL;
> +    g_autoptr(GHashTable) params = NULL;
> +    g_autoptr(GError) err = NULL;
> +
> +    uri = g_uri_parse(filename, G_URI_FLAGS_ENCODED_QUERY, &err);
> +    if (!uri) {
> +        error_report("Failed to parse NBD URI: %s", err->message);
> +        return -EINVAL;
> +    }
> +
> +    p = g_uri_get_path(uri);
> +    scheme = g_uri_get_scheme(uri);
> +    server = g_uri_get_host(uri);
> +    port = g_uri_get_port(uri);

I would have expected this code to fail to compile as we're setting
GLIB_VERSION_MAX_ALLOWED == GLIB_VERSION_2_48  and GUri is tagged
as newer than that.

In any case, having this conditonal code in all callers is definitely
not a desirable approach. If we want to use it, then I think we need to
pull a copy of GUri into QEMU and expose it via glib-compat.h, so that
callers can use it unconditionally.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


