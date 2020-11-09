Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB2F3C5517A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 21:20:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 270AA206CB
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 21:20:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oi66iwJs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 270AA206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kcEaC-0001C5-2R
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 16:20:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60450)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kcEZW-0000Xm-Kt
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 16:19:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52675)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kcEZT-0004ZC-Hp
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 16:19:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604956765;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ibniibCyePrl0OFBJHIK8U5JdCqwJx9IXhFrQ33Rrok=;
 b=Oi66iwJs3i6aYAa9JZIOh41XFH3Tnr5k61yMS7mpNgRBraoDDPtfiZd34Gw2TRCeuytmGi
 2RIREYR40kJhCvQQRkRsMJb+iaW2RYNZSGZBNabjGdMIQJMuxBWkQeg6SFeMvit7Y5FWMn
 blcgAGeHxL2mjy8MM7zMy1kIdzLQUgk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-83-BkygVOsEOQavNv68kKNqVw-1; Mon, 09 Nov 2020 16:19:23 -0500
X-MC-Unique: BkygVOsEOQavNv68kKNqVw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A8CC91007486
 for <qemu-devel@nongnu.org>; Mon,  9 Nov 2020 21:19:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-103.ams2.redhat.com
 [10.36.112.103])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 50B5E5C1D0;
 Mon,  9 Nov 2020 21:19:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BE0731132BD6; Mon,  9 Nov 2020 22:19:20 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 6/6] qemu-option: warn for short-form boolean options
References: <20201109133931.979563-1-pbonzini@redhat.com>
 <20201109133931.979563-7-pbonzini@redhat.com>
Date: Mon, 09 Nov 2020 22:19:20 +0100
In-Reply-To: <20201109133931.979563-7-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Mon, 9 Nov 2020 08:39:31 -0500")
Message-ID: <87h7py2ppj.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 00:04:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> writes:

> Options such as "server" or "nowait", that are commonly found in -chardev,
> are sugar for "server=on" and "wait=off".  This is quite surprising and
> also does not have any notion of typing attached.  It is even possible to
> do "-device e1000,noid" and get a device with "id=off".
>
> Deprecate it and print a warning when it is encountered.  In general,
> this short form for boolean options only seems to be in wide use for
> -chardev and -spice.
>
> The extra boolean argument is not my favorite.  In 6.0 I plan to remove
> qemu_opts_set_defaults by switching -M to keyval, and therefore quite
> a bit of QemuOpts code will go away.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  docs/system/deprecated.rst |  6 ++++++
>  tests/test-qemu-opts.c     |  2 +-
>  util/qemu-option.c         | 29 ++++++++++++++++++-----------
>  3 files changed, 25 insertions(+), 12 deletions(-)
>
> diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
> index 8c1dc7645d..f45938a5ff 100644
> --- a/docs/system/deprecated.rst
> +++ b/docs/system/deprecated.rst
> @@ -146,6 +146,12 @@ Drives with interface types other than ``if=none`` are for onboard
>  devices.  It is possible to use drives the board doesn't pick up with
>  -device.  This usage is now deprecated.  Use ``if=none`` instead.
>  
> +Short-form boolean options (since 5.2)
> +''''''''''''''''''''''''''''''''''''''
> +
> +Boolean options such as ``share=on``/``share=off`` can be written
> +in short form as ``share`` and ``noshare``.  This is deprecated
> +and will cause a warning.
>  
>  QEMU Machine Protocol (QMP) commands
>  ------------------------------------
> diff --git a/tests/test-qemu-opts.c b/tests/test-qemu-opts.c
> index 322b32871b..e12fb51032 100644
> --- a/tests/test-qemu-opts.c
> +++ b/tests/test-qemu-opts.c
> @@ -519,7 +519,7 @@ static void test_opts_parse(void)
>      error_free_or_abort(&err);
>      g_assert(!opts);
>  
> -    /* Implied value */
> +    /* Implied value (qemu_opts_parse does not warn) */
>      opts = qemu_opts_parse(&opts_list_03, "an,noaus,noaus=",
>                             false, &error_abort);
>      g_assert_cmpuint(opts_count(opts), ==, 3);
> diff --git a/util/qemu-option.c b/util/qemu-option.c
> index 0ddf1f7b45..23238f00ea 100644
> --- a/util/qemu-option.c
> +++ b/util/qemu-option.c
> @@ -756,10 +756,12 @@ void qemu_opts_print(QemuOpts *opts, const char *separator)
>  
>  static const char *get_opt_name_value(const char *params,
>                                        const char *firstname,
> +                                      bool warn_on_flag,
>                                        bool *help_wanted,
>                                        char **name, char **value)
>  {
>      const char *p;
> +    const char *prefix = "";
>      size_t len;
>      bool is_help = false;
>  
> @@ -776,10 +778,15 @@ static const char *get_opt_name_value(const char *params,
>              if (strncmp(*name, "no", 2) == 0) {
>                  memmove(*name, *name + 2, strlen(*name + 2) + 1);
>                  *value = g_strdup("off");
> +                prefix = "no";
>              } else {
>                  *value = g_strdup("on");
>                  is_help = is_help_option(*name);
>              }
> +            if (!is_help && warn_on_flag) {
> +                warn_report("short-form boolean option '%s%s' deprecated", prefix, *name);
> +                error_printf("Please use %s=%s instead\n", *name, *value);
> +            }

If @warn_on_flag, we warn except for "help" and "?".  The exception
applies regardless of @help_wanted.

>          }
>      } else {
>          /* found "foo=bar,more" */
> @@ -801,14 +808,14 @@ static const char *get_opt_name_value(const char *params,
>  
>  static bool opts_do_parse(QemuOpts *opts, const char *params,
>                            const char *firstname, bool prepend,
> -                          bool *help_wanted, Error **errp)
> +                          bool warn_on_flag, bool *help_wanted, Error **errp)
>  {
>      char *option, *value;
>      const char *p;
>      QemuOpt *opt;
>  
>      for (p = params; *p;) {
> -        p = get_opt_name_value(p, firstname, help_wanted, &option, &value);
> +        p = get_opt_name_value(p, firstname, warn_on_flag, help_wanted, &option, &value);

Long line.  Break it before the three output arguments.

>          if (help_wanted && *help_wanted) {
>              return false;
>          }
> @@ -837,7 +844,7 @@ static char *opts_parse_id(const char *params)
>      char *name, *value;
>  
>      for (p = params; *p;) {
> -        p = get_opt_name_value(p, NULL, NULL, &name, &value);
> +        p = get_opt_name_value(p, NULL, false, NULL, &name, &value);

No change (we pass false to warn_on_flag).

>          if (!strcmp(name, "id")) {
>              g_free(name);
>              return value;
> @@ -856,7 +863,7 @@ bool has_help_option(const char *params)
>      bool ret;
>  
>      for (p = params; *p;) {
> -        p = get_opt_name_value(p, NULL, &ret, &name, &value);
> +        p = get_opt_name_value(p, NULL, false, &ret, &name, &value);

Likewise.

>          g_free(name);
>          g_free(value);
>          if (ret) {
> @@ -876,12 +883,12 @@ bool has_help_option(const char *params)
>  bool qemu_opts_do_parse(QemuOpts *opts, const char *params,
>                         const char *firstname, Error **errp)
>  {
> -    return opts_do_parse(opts, params, firstname, false, NULL, errp);
> +    return opts_do_parse(opts, params, firstname, false, false, NULL, errp);

Likewise.

>  }
>  
>  static QemuOpts *opts_parse(QemuOptsList *list, const char *params,
>                              bool permit_abbrev, bool defaults,
> -                            bool *help_wanted, Error **errp)
> +                            bool warn_on_flag, bool *help_wanted, Error **errp)
>  {
>      const char *firstname;
>      char *id = opts_parse_id(params);
> @@ -904,8 +911,8 @@ static QemuOpts *opts_parse(QemuOptsList *list, const char *params,
>          return NULL;
>      }
>  
> -    if (!opts_do_parse(opts, params, firstname, defaults, help_wanted,
> -                       errp)) {
> +    if (!opts_do_parse(opts, params, firstname, defaults,
> +                       warn_on_flag, help_wanted, errp)) {
>          qemu_opts_del(opts);
>          return NULL;
>      }
> @@ -923,7 +930,7 @@ static QemuOpts *opts_parse(QemuOptsList *list, const char *params,
>  QemuOpts *qemu_opts_parse(QemuOptsList *list, const char *params,
>                            bool permit_abbrev, Error **errp)
>  {
> -    return opts_parse(list, params, permit_abbrev, false, NULL, errp);
> +    return opts_parse(list, params, permit_abbrev, false, false, NULL, errp);

Likewise.

>  }
>  
>  /**
> @@ -941,7 +948,7 @@ QemuOpts *qemu_opts_parse_noisily(QemuOptsList *list, const char *params,
>      QemuOpts *opts;
>      bool help_wanted = false;
>  
> -    opts = opts_parse(list, params, permit_abbrev, false,
> +    opts = opts_parse(list, params, permit_abbrev, false, true,
>                        opts_accepts_any(list) ? NULL : &help_wanted,
>                        &err);
>      if (!opts) {

This function now warns, except for "help" and "?".  The exception
applies even when we treat "help" and "?" as sugar for "help=on" and
"?=on" because opts_accepts_any().

> @@ -960,7 +967,7 @@ void qemu_opts_set_defaults(QemuOptsList *list, const char *params,
>  {
>      QemuOpts *opts;
>  
> -    opts = opts_parse(list, params, permit_abbrev, true, NULL, NULL);
> +    opts = opts_parse(list, params, permit_abbrev, true, false, NULL, NULL);
>      assert(opts);
>  }

No change (we pass false to warn_on_flag).

Summary: only qemu_opts_parse_noisily() warns.  This is airtight only if
all user input flows through qemu_opts_parse_noisily().  It's too late
in my day for me to check.


