Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC3E8C4360C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 09:10:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C587206C2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 09:10:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C587206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHlW3-00035r-MV
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 05:10:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33640)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@pond.sub.org>) id 1iHlUP-0001yR-1f
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 05:09:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@pond.sub.org>) id 1iHlUN-0007Jj-3N
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 05:09:04 -0400
Received: from oxygen.pond.sub.org ([2a01:4f8:13b:3ad0:1::3]:37786)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@pond.sub.org>) id 1iHlUM-0007ER-PX
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 05:09:03 -0400
Received: from blackfin.pond.sub.org
 (p200300D36F484800DACB8AFFFEE0C842.dip0.t-ipconnect.de
 [IPv6:2003:d3:6f48:4800:dacb:8aff:fee0:c842])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (Client did not present a certificate)
 by oxygen.pond.sub.org (Postfix) with ESMTPSA id 3902B47E93;
 Tue,  8 Oct 2019 11:08:58 +0200 (CEST)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 021391138648; Tue,  8 Oct 2019 11:08:55 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v4 01/31] errp: rename errp to errp_in where it is
 IN-argument
References: <20191001155319.8066-1-vsementsov@virtuozzo.com>
 <20191001155319.8066-2-vsementsov@virtuozzo.com>
Date: Tue, 08 Oct 2019 11:08:55 +0200
Message-ID: <878spvmwns.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a01:4f8:13b:3ad0:1::3
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
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:

> Error **errp is almost always OUT-argument: it's assumed to be NULL, or
> pointer to NULL-initialized pointer, or pointer to error_abort or
> error_fatal, for callee to report error.

Yes.

> But very few functions instead get Error **errp as IN-argument:
> it's assumed to be set, and callee should clean it.

What do you mean by "callee should clean"?  Let's see below.

> In such cases, rename errp to errp_in.

I acknowledge that errp arguments that don't have the usual meaning can
be confusing.

Naming can help, comments can help, but perhaps we can tweak the code to
avoid the problem instead.  Let's see:

> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>  include/monitor/hmp.h |  2 +-
>  include/qapi/error.h  |  2 +-
>  ui/vnc.h              |  2 +-
>  monitor/hmp-cmds.c    |  8 ++++----
>  ui/vnc.c              | 10 +++++-----
>  util/error.c          |  8 ++++----
>  6 files changed, 16 insertions(+), 16 deletions(-)
>
> diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
> index a0e9511440..f929814f1a 100644
> --- a/include/monitor/hmp.h
> +++ b/include/monitor/hmp.h
> @@ -16,7 +16,7 @@
>  
>  #include "qemu/readline.h"
>  
> -void hmp_handle_error(Monitor *mon, Error **errp);
> +void hmp_handle_error(Monitor *mon, Error **errp_in);
>  
>  void hmp_info_name(Monitor *mon, const QDict *qdict);
>  void hmp_info_version(Monitor *mon, const QDict *qdict);
> diff --git a/include/qapi/error.h b/include/qapi/error.h
> index 3f95141a01..9376f59c35 100644
> --- a/include/qapi/error.h
> +++ b/include/qapi/error.h
> @@ -283,7 +283,7 @@ void error_free(Error *err);
>  /*
>   * Convenience function to assert that *@errp is set, then silently free it.
>   */
> -void error_free_or_abort(Error **errp);
> +void error_free_or_abort(Error **errp_in);
>  
>  /*
>   * Convenience function to warn_report() and free @err.
> diff --git a/ui/vnc.h b/ui/vnc.h
> index fea79c2fc9..00e0b48f2f 100644
> --- a/ui/vnc.h
> +++ b/ui/vnc.h
> @@ -547,7 +547,7 @@ uint32_t read_u32(uint8_t *data, size_t offset);
>  
>  /* Protocol stage functions */
>  void vnc_client_error(VncState *vs);
> -size_t vnc_client_io_error(VncState *vs, ssize_t ret, Error **errp);
> +size_t vnc_client_io_error(VncState *vs, ssize_t ret, Error **errp_in);
>  
>  void start_client_init(VncState *vs);
>  void start_auth_vnc(VncState *vs);
> diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
> index b2551c16d1..941d5d0a45 100644
> --- a/monitor/hmp-cmds.c
> +++ b/monitor/hmp-cmds.c
> @@ -60,11 +60,11 @@
>  #include <spice/enums.h>
>  #endif
>  
> -void hmp_handle_error(Monitor *mon, Error **errp)
> +void hmp_handle_error(Monitor *mon, Error **errp_in)
>  {
> -    assert(errp);
> -    if (*errp) {
> -        error_reportf_err(*errp, "Error: ");
> +    assert(errp_in);
> +    if (*errp_in) {
> +        error_reportf_err(*errp_in, "Error: ");
>      }
>  }

This functions frees the error.  It leaves nothing for the caller to
clean up.

All callers pass &ERR, where ERR is a local variable.  Perhaps a more
robust way to signal "@errp is not the usual out-argument" would be
peeling off an indirection: pass ERR, drop the assertion.

>  
> diff --git a/ui/vnc.c b/ui/vnc.c
> index 87b8045afe..9d6384d9b1 100644
> --- a/ui/vnc.c
> +++ b/ui/vnc.c
> @@ -1312,7 +1312,7 @@ void vnc_disconnect_finish(VncState *vs)
>      g_free(vs);
>  }
>  
> -size_t vnc_client_io_error(VncState *vs, ssize_t ret, Error **errp)
> +size_t vnc_client_io_error(VncState *vs, ssize_t ret, Error **errp_in)
>  {
>      if (ret <= 0) {
>          if (ret == 0) {
> @@ -1320,14 +1320,14 @@ size_t vnc_client_io_error(VncState *vs, ssize_t ret, Error **errp)
>              vnc_disconnect_start(vs);
>          } else if (ret != QIO_CHANNEL_ERR_BLOCK) {
>              trace_vnc_client_io_error(vs, vs->ioc,
> -                                      errp ? error_get_pretty(*errp) :
> +                                      errp_in ? error_get_pretty(*errp_in) :
>                                        "Unknown");
>              vnc_disconnect_start(vs);
>          }
>  
> -        if (errp) {
> -            error_free(*errp);
> -            *errp = NULL;
> +        if (errp_in) {
> +            error_free(*errp_in);
> +            *errp_in = NULL;
>          }
>          return 0;
>      }

This function isn't trivial, and lacks a contract, so let's figure out
what it does and how it's used.

@ret can be:

* Zero

  Trace EOF, call vnc_disconnect_start(), free the error, return zero.

  Aside: freeing the error without looking at it feels odd.  Can this
  happen?

* Negative other than QIO_CHANNEL_ERR_BLOCK

  Trace the error if any, else "Unknown" error, call
  vnc_disconnect_start(), free the error if any, return zero.

  Note that we can't have errp && !*errp here, or else tracing crashes
  in error_get_pretty().

* QIO_CHANNEL_ERR_BLOCK

  Free the error, return zero

* Positive

  Do nothing, return @ret

Callers pass one of the following:

* ret = -1 and errp = NULL

  This uses case "Negative other than QIO_CHANNEL_ERR_BLOCK".  Since
  error is null, it traces an "Unknown" error.

* ret and &err, where ret = FUN(..., &err), and FUN is
  qio_channel_read() or qio_channel_write().

  qio_channel_read(), _write() are documented to return non-negative on
  success, QIO_CHANNEL_ERR_BLOCK on "would block", and -1 on other
  error.  By convention, they set an error exactly when they fail,
  i.e. when they return a negative value.

  When qio_channel_read() / _write() succeed, we use case "Positive" or
  "Zero".  We don't free the error, which is fine, as none was returned.
  Aside: I *guess* the channel is non-blocking, and "zero" can happen
  only when read hits EOF.

  When qio_channel_read() / _write() fail, we use one of the error
  cases.

Looks like vnc_client_io_error() takes an error code @ret and an
optional error object in @errp with additional details.  If @ret is
non-negative, @errp must be null or point to null.  If @ret is negative,
@errp must be null or point to non-null.

vnc_client_io_error() frees the error.  It leaves nothing for the caller
to clean up.

I think we can again peel off an indirection.  The two kinds of calls
become:

* ret = -1 and err = NULL

  No textual change, but the NULL gets converted to Error * instead of
  Error **.

* ret and err

  Pass the (possibly null) error object instead of a pointer to the
  local variable.

> diff --git a/util/error.c b/util/error.c
> index d4532ce318..b3ff3832d6 100644
> --- a/util/error.c
> +++ b/util/error.c
> @@ -271,11 +271,11 @@ void error_free(Error *err)
>      }
>  }
>  
> -void error_free_or_abort(Error **errp)
> +void error_free_or_abort(Error **errp_in)
>  {
> -    assert(errp && *errp);
> -    error_free(*errp);
> -    *errp = NULL;
> +    assert(errp_in && *errp_in);
> +    error_free(*errp_in);
> +    *errp_in = NULL;
>  }
>  
>  void error_propagate(Error **dst_errp, Error *local_err)

This functions frees the error.  It leaves nothing for the caller to
clean up.

All callers pass &ERR, where ERR is a local variable.  We can peel off
an indirection.


I figure your commit message's "But very few functions instead get Error
**errp as IN-argument: it's assumed to be set, and callee should clean
it" is to be read as "a few functions take Error **errp as IN-argument,
and free it".

You found three instances of confusing Error **errp.  How?  I'm asking
because I wonder whether there are more.

We can avoid the confusing Error **errp in all three cases by peeling
off an indirection.  What do you think?

