Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 103B0C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 15:10:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFF7B21774
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 15:10:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OP1oniUT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFF7B21774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaLRL-000622-2E
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 10:10:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57112)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iaKhm-0007lu-Ld
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 09:23:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iaKhc-0001Cb-Nt
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 09:23:30 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:34073
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iaKhc-0000xU-9x
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 09:23:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574951004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n55yfGwqi/E9VRMSQZAQuHoWvoS4cFOOxoJ0yeFXHOA=;
 b=OP1oniUTlmFNj6x8WRdOinvysiaPLA9IKcoYol7QrZxRzD1DB+b4vRA87SBvOspybsswSi
 oeo4QVXslMtkaamzmCBSDiiz6AVpnCWlNQuakiQKKnRon3CspIZoORhYXWOH/aluV1+13r
 toFvIyF8pkjRanC5QdTOGYj+tbckqP8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-367-UWPY5eG4PFW46-_DNvuj_Q-1; Thu, 28 Nov 2019 09:23:21 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 25958107AD26;
 Thu, 28 Nov 2019 14:23:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 72478608BF;
 Thu, 28 Nov 2019 14:23:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 00B7A1138606; Thu, 28 Nov 2019 15:23:17 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v6] error: rename errp to errp_in where it is IN-argument
References: <20191127183704.14825-1-vsementsov@virtuozzo.com>
Date: Thu, 28 Nov 2019 15:23:17 +0100
In-Reply-To: <20191127183704.14825-1-vsementsov@virtuozzo.com> (Vladimir
 Sementsov-Ogievskiy's message of "Wed, 27 Nov 2019 21:37:04 +0300")
Message-ID: <878so05bca.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: UWPY5eG4PFW46-_DNvuj_Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
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
Cc: qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:

> Error **errp is almost always OUT-argument: it's assumed to be NULL, or
> pointer to NULL-initialized pointer, or pointer to error_abort or
> error_fatal, for callee to report error.
>
> But very few functions instead get Error **errp as IN-argument:
> it's assumed to be set (or, maybe, NULL), and callee should clean it,
> or add some information.
>
> In such cases, rename errp to errp_in.

Missing: why is the rename useful?

It's useful if it helps readers recognize unusual Error ** parameters,
and recognizing unusual Error ** parameters is actually a problem.  I'm
not sure it is, but my familiarity with the Error interface may blind
me.

How many functions have unusual Error **parameters?  How are they used?
Any calls that could easily be mistaken as the usual case?  See [*]
below.

You effectively propose a naming convention.  error.h should spell it
out.  Let me try:

    Any Error ** parameter meant for passing an error to the caller must
    be named @errp.  No other Error ** parameter may be named @errp.

Observe:

* I refrain from stipulating how other Error ** parameters are to be
  named.  You use @errp_in, because the ones you rename are actually
  "IN-arguments".  However, different uses are conceivable, where
  @errp_in would be misleading.

* If I understand your ERRP_AUTO_PROPAGATE() idea correctly, many
  functions that take an Error ** to pass an error to the caller will
  also use ERRP_AUTO_PROPAGATE, but not all.  Thus, presence of
  ERRP_AUTO_PROPAGATE() won't be a reliable indicator of "the Error **
  parameter is for passing an error to the caller".

* I can't see machinery to help us catch violations of the convention.

> This patch updates only error API functions. There still a few
> functions with errp-in semantics, they will be updated in further
> commits.

Splitting the series into individual patches was a bad idea :)

First, it really needs review as a whole.  I'll do that, but now I have
to hunt down the parts.  Found so far:

    [PATCH v6] error: rename errp to errp_in where it is IN-argument
    [PATCH v6] hmp: drop Error pointer indirection in hmp_handle_error
    [PATCH v6] vnc: drop Error pointer indirection in vnc_client_io_error
    [PATCH v6] qdev-monitor: well form error hint helpers
    [PATCH v6] nbd: well form nbd_iter_channel_error errp handler
    [PATCH v6] ppc: well form kvmppc_hint_smt_possible error hint helper
    [PATCH v6] 9pfs: well form error hint helpers
    [PATCH v6] hw/core/qdev: cleanup Error ** variables
    [PATCH v6] block/snapshot: rename Error ** parameter to more common err=
p
    [PATCH v6] hw/i386/amd_iommu: rename Error ** parameter to more common =
errp
    [PATCH v6] qga: rename Error ** parameter to more common errp
    [PATCH v6] monitor/qmp-cmds: rename Error ** parameter to more common e=
rrp
    [PATCH v6] hw/s390x: rename Error ** parameter to more common errp
    [PATCH v6] hw/sd: drop extra whitespace in sdhci_sysbus_realize() heade=
r
    [PATCH v6] hw/tpm: rename Error ** parameter to more common errp
    [PATCH v6] hw/usb: rename Error ** parameter to more common errp
    [PATCH v6] include/qom/object.h: rename Error ** parameter to more comm=
on errp
    [PATCH v6] backends/cryptodev: drop local_err from cryptodev_backend_co=
mplete()
    [PATCH v6] hw/vfio/ap: drop local_err from vfio_ap_realize

[*] The information I asked for above is buried in these patches.  I'll
try to dig it up as I go reviewing them.

Second, it risks some of these "further patches" overtake this one, and
then its commit message will be misleading.  Moreover, the other commits
will lack context.

> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>
> v6: fix s/errp/errp_in/ in comments corresponding to changed functions
>     [Eric]
>     add Eric's r-b
>
>  include/qapi/error.h | 16 ++++++++--------
>  util/error.c         | 30 +++++++++++++++---------------
>  2 files changed, 23 insertions(+), 23 deletions(-)
>
> diff --git a/include/qapi/error.h b/include/qapi/error.h
> index 3f95141a01..df518644fc 100644
> --- a/include/qapi/error.h
> +++ b/include/qapi/error.h
> @@ -230,16 +230,16 @@ void error_propagate_prepend(Error **dst_errp, Erro=
r *local_err,
>                               const char *fmt, ...);
> =20
>  /*
> - * Prepend some text to @errp's human-readable error message.
> + * Prepend some text to @errp_in's human-readable error message.
>   * The text is made by formatting @fmt, @ap like vprintf().
>   */
> -void error_vprepend(Error **errp, const char *fmt, va_list ap);
> +void error_vprepend(Error **errp_in, const char *fmt, va_list ap);
> =20
>  /*
> - * Prepend some text to @errp's human-readable error message.
> + * Prepend some text to @errp_in's human-readable error message.
>   * The text is made by formatting @fmt, ... like printf().
>   */
> -void error_prepend(Error **errp, const char *fmt, ...)
> +void error_prepend(Error **errp_in, const char *fmt, ...)
>      GCC_FMT_ATTR(2, 3);
> =20
>  /*
> @@ -250,13 +250,13 @@ void error_prepend(Error **errp, const char *fmt, .=
..)
>   * Intended use is adding helpful hints on the human user interface,
>   * e.g. a list of valid values.  It's not for clarifying a confusing
>   * error message.
> - * @errp may be NULL, but not &error_fatal or &error_abort.
> + * @errp_in may be NULL, but not &error_fatal or &error_abort.

That's because the function modifies the error object.

Hmm, so do error_prepend() and error_vprepend().  I figure we better
update their contract accordingly, and copy the "not &error_fatal or
&error_abort" assertion.  Not in this patch.  Maybe not even in this
series.

>   * Trivially the case if you call it only after error_setg() or
>   * error_propagate().
>   * May be called multiple times.  The resulting hint should end with a
>   * newline.
>   */
> -void error_append_hint(Error **errp, const char *fmt, ...)
> +void error_append_hint(Error **errp_in, const char *fmt, ...)
>      GCC_FMT_ATTR(2, 3);
> =20
>  /*
> @@ -281,9 +281,9 @@ Error *error_copy(const Error *err);
>  void error_free(Error *err);
> =20
>  /*
> - * Convenience function to assert that *@errp is set, then silently free=
 it.
> + * Convenience function to assert that *@errp_in is set, then silently f=
ree it.
Long line.  Suggest:

    * Assert that *@errp_in is set, then silently free it.
    * This is a convenience function for use in tests.

>   */
> -void error_free_or_abort(Error **errp);
> +void error_free_or_abort(Error **errp_in);
> =20
>  /*
>   * Convenience function to warn_report() and free @err.
> diff --git a/util/error.c b/util/error.c
> index d4532ce318..275586faa8 100644
> --- a/util/error.c
> +++ b/util/error.c
> @@ -121,41 +121,41 @@ void error_setg_file_open_internal(Error **errp,
>                                "Could not open '%s'", filename);
>  }
> =20
> -void error_vprepend(Error **errp, const char *fmt, va_list ap)
> +void error_vprepend(Error **errp_in, const char *fmt, va_list ap)
>  {
>      GString *newmsg;
> =20
> -    if (!errp) {
> +    if (!errp_in) {
>          return;
> =20
>      newmsg =3D g_string_new(NULL);
>      g_string_vprintf(newmsg, fmt, ap);
> -    g_string_append(newmsg, (*errp)->msg);
> -    g_free((*errp)->msg);
> -    (*errp)->msg =3D g_string_free(newmsg, 0);
> +    g_string_append(newmsg, (*errp_in)->msg);
> +    g_free((*errp_in)->msg);
> +    (*errp_in)->msg =3D g_string_free(newmsg, 0);
>  }
> =20
> -void error_prepend(Error **errp, const char *fmt, ...)
> +void error_prepend(Error **errp_in, const char *fmt, ...)
>  {
>      va_list ap;
> =20
>      va_start(ap, fmt);
> -    error_vprepend(errp, fmt, ap);
> +    error_vprepend(errp_in, fmt, ap);
>      va_end(ap);
>  }
> =20
> -void error_append_hint(Error **errp, const char *fmt, ...)
> +void error_append_hint(Error **errp_in, const char *fmt, ...)
>  {
>      va_list ap;
>      int saved_errno =3D errno;
>      Error *err;
> =20
> -    if (!errp) {
> +    if (!errp_in) {
>          return;
>      }
> -    err =3D *errp;
> -    assert(err && errp !=3D &error_abort && errp !=3D &error_fatal);
> +    err =3D *errp_in;
> +    assert(err && errp_in !=3D &error_abort && errp_in !=3D &error_fatal=
);
> =20
>      if (!err->hint) {
>          err->hint =3D g_string_new(NULL);
> @@ -271,11 +271,11 @@ void error_free(Error *err)
>      }
>  }
> =20
> -void error_free_or_abort(Error **errp)
> +void error_free_or_abort(Error **errp_in)
>  {
> -    assert(errp && *errp);
> -    error_free(*errp);
> -    *errp =3D NULL;
> +    assert(errp_in && *errp_in);
> +    error_free(*errp_in);
> +    *errp_in =3D NULL;
>  }
> =20
>  void error_propagate(Error **dst_errp, Error *local_err)


