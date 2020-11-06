Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E05ACC2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 16:50:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F20962151B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 16:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dc+Db/fx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F20962151B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kb4wo-00017T-0U
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 11:50:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56728)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kb4vm-0000Rz-6T
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 11:49:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60211)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kb4vk-0005TJ-5J
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 11:49:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604681379;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EKwBoW1HluXPSoUcOpjwyVAabFNpcEPnx6nxdMV5E6U=;
 b=Dc+Db/fxrb4th1UNRUqg9uZ0KdYmTFZBF3aep67mqCabfdcYBVfPWZItDohSMQ7GFUOAqQ
 r7IHd2JmrHndUrmyBImZYGhti4JEWOwsovllVOOzUYORorGltWtTI+pzPVMsVyUmTRAja1
 RMxh2SieHIbUgWPyDFmBQIQNQsJDHgY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-583-ImCE8JwINT624Y2ShBiVgQ-1; Fri, 06 Nov 2020 11:49:37 -0500
X-MC-Unique: ImCE8JwINT624Y2ShBiVgQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A54BF804758
 for <qemu-devel@nongnu.org>; Fri,  6 Nov 2020 16:49:36 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-103.ams2.redhat.com
 [10.36.112.103])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4F64D76640;
 Fri,  6 Nov 2020 16:49:36 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CB1A21132BD6; Fri,  6 Nov 2020 17:49:34 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 2/2] qemu-option: warn for short-form boolean options
References: <20201105142731.623428-1-pbonzini@redhat.com>
 <20201105142731.623428-3-pbonzini@redhat.com>
Date: Fri, 06 Nov 2020 17:49:34 +0100
In-Reply-To: <20201105142731.623428-3-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Thu, 5 Nov 2020 09:27:31 -0500")
Message-ID: <87361mfn1d.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/06 07:11:31
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
Cc: berrange@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> writes:

> Options such as "server" or "nowait", that are commonly found in -chardev,
> are sugar for "server=on" and "wait=off".  This is quite surprising and
> also does not have any notion of typing attached.  It is even possible to
> do "-device e1000,noid" and get a device with "id=off".
>
> Deprecate all this, except for -chardev and -spice where it is in
> wide use.

I consider this a misuse of deprecation, to be frank.  If something is
known to be unused, we just remove it.  Deprecation is precisely for
things that are used.  I'm with Daniel here: let's deprecate this sugar
everywhere.

Wide use may justify extending the deprecation grace period.

> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  chardev/char.c             |  1 +
>  docs/system/deprecated.rst |  7 +++++++
>  include/qemu/option.h      |  1 +
>  tests/test-qemu-opts.c     |  1 +
>  ui/spice-core.c            |  1 +
>  util/qemu-option.c         | 21 ++++++++++++++-------
>  6 files changed, 25 insertions(+), 7 deletions(-)
>
> diff --git a/chardev/char.c b/chardev/char.c
> index 78553125d3..108da615df 100644
> --- a/chardev/char.c
> +++ b/chardev/char.c
> @@ -829,6 +829,7 @@ Chardev *qemu_chr_find(const char *name)
>  
>  QemuOptsList qemu_chardev_opts = {
>      .name = "chardev",
> +    .allow_flag_options = true, /* server, nowait, etc. */
>      .implied_opt_name = "backend",
>      .head = QTAILQ_HEAD_INITIALIZER(qemu_chardev_opts.head),
>      .desc = {
> diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
> index 32a0e620db..0e7edf7e56 100644
> --- a/docs/system/deprecated.rst
> +++ b/docs/system/deprecated.rst
> @@ -146,6 +146,13 @@ Drives with interface types other than ``if=none`` are for onboard
>  devices.  It is possible to use drives the board doesn't pick up with
>  -device.  This usage is now deprecated.  Use ``if=none`` instead.
>  
> +Short-form boolean options (since 5.2)
> +''''''''''''''''''''''''''''''''''''''
> +
> +Boolean options such as ``share=on``/``share=off`` can be written
> +in short form as ``share`` and ``noshare``.  This is deprecated
> +for all command-line options except ``-chardev` and ``-spice``, for
> +which the short form was in wide use.

Unlike the commit message, the text here misleads readers into assuming
the sugar applies only to boolean options.

>  
>  QEMU Machine Protocol (QMP) commands
>  ------------------------------------
> diff --git a/include/qemu/option.h b/include/qemu/option.h
> index ac69352e0e..046ac06a1f 100644
> --- a/include/qemu/option.h
> +++ b/include/qemu/option.h
> @@ -65,6 +65,7 @@ struct QemuOptsList {
>      const char *name;
>      const char *implied_opt_name;
>      bool merge_lists;  /* Merge multiple uses of option into a single list? */
> +    bool allow_flag_options; /* Whether to warn for short-form boolean options */

I disagree with having this option.  I'm reviewing it anyway.

Staying under the 80 characters limit is really, really easy here:

       bool allow_flag_options;    /* Warn on short-form boolean options? */

I had to read ahead to figure out that false means warn, true means
accept silently.  The comment is confusing because "whether to warn"
suggests "warn if true", which is wrong.

Clearer (I think), and even shorter:

       bool allow_bool_sugar;      /* Is boolean option sugar okay? */

>      QTAILQ_HEAD(, QemuOpts) head;
>      QemuOptDesc desc[];
>  };
> diff --git a/tests/test-qemu-opts.c b/tests/test-qemu-opts.c
> index 297ffe79dd..a74c475773 100644
> --- a/tests/test-qemu-opts.c
> +++ b/tests/test-qemu-opts.c
> @@ -77,6 +77,7 @@ static QemuOptsList opts_list_02 = {
>  static QemuOptsList opts_list_03 = {
>      .name = "opts_list_03",
>      .implied_opt_name = "implied",
> +    .allow_flag_options = true,
>      .head = QTAILQ_HEAD_INITIALIZER(opts_list_03.head),
>      .desc = {
>          /* no elements => accept any params */

Can you point me to the tests this hunk affects?

Do we have test coverage for boolean sugar with both values of
allow_flag_options?

If no, why is that okay?

> diff --git a/ui/spice-core.c b/ui/spice-core.c
> index eea52f5389..08f834fa41 100644
> --- a/ui/spice-core.c
> +++ b/ui/spice-core.c
> @@ -397,6 +397,7 @@ static SpiceChannelList *qmp_query_spice_channels(void)
>  
>  static QemuOptsList qemu_spice_opts = {
>      .name = "spice",
> +    .allow_flag_options = true, /* disable-agent-file-xfer, sasl, unix, etc. */
>      .head = QTAILQ_HEAD_INITIALIZER(qemu_spice_opts.head),
>      .merge_lists = true,
>      .desc = {
> diff --git a/util/qemu-option.c b/util/qemu-option.c
> index 61fc96f9dd..858860377b 100644
> --- a/util/qemu-option.c
> +++ b/util/qemu-option.c
> @@ -763,10 +763,12 @@ void qemu_opts_print(QemuOpts *opts, const char *separator)
>  
>  static const char *get_opt_name_value(const char *params,
>                                        const char *firstname,
> +                                      bool warn_on_flag,

Two callers pass false, the other passes !list->allow_flag_options.
Having both allow_flag_options and warn_on_flag with the opposite sense
is confusing.  Please pick one.

>                                        bool *help_wanted,
>                                        char **name, char **value)
>  {
>      const char *p;
> +    const char *prefix = "";
>      size_t len;
>  
>      len = strcspn(params, "=,");
> @@ -784,9 +786,14 @@ static const char *get_opt_name_value(const char *params,
           /* found "foo,more" */
           if (firstname) {
               /* implicitly named first option */
               *name = g_strdup(firstname);
               p = get_opt_value(params, value);
           } else {
               /* option without value, must be a flag */
               p = get_opt_name(params, name, ',');
>              if (strncmp(*name, "no", 2) == 0) {
>                  memmove(*name, *name + 2, strlen(*name + 2) + 1);
>                  *value = g_strdup("off");
> +                prefix = "no";
>              } else {
>                  *value = g_strdup("on");
>              }
> +            if (warn_on_flag) {
> +                error_report("short-form boolean option '%s%s' deprecated", prefix, *name);

warn_report(), please.  error_report() is strictly for error conditions,
i.e. things that fail.

> +                error_printf("Please use %s=%s instead\n", *name, *value);
> +            }
>          }
>      } else {
>          /* found "foo=bar,more" */
> @@ -805,14 +812,14 @@ static const char *get_opt_name_value(const char *params,
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

Long line.  Please break the line before the output arguments:

           p = get_opt_name_value(p, firstname, warn_on_flag,
                                  help_wanted, &option, &value);

>          if (help_wanted && *help_wanted) {
>              return false;
>          }
> @@ -841,7 +848,7 @@ static char *opts_parse_id(const char *params)
>      char *name, *value;
>  
>      for (p = params; *p;) {
> -        p = get_opt_name_value(p, NULL, NULL, &name, &value);
> +        p = get_opt_name_value(p, NULL, false, NULL, &name, &value);
>          if (!strcmp(name, "id")) {
>              g_free(name);
>              return value;

Yes, we want don't want to warn here.

> @@ -860,7 +867,7 @@ bool has_help_option(const char *params)
>      bool ret = false;
>  
>      for (p = params; *p;) {
> -        p = get_opt_name_value(p, NULL, &ret, &name, &value);
> +        p = get_opt_name_value(p, NULL, false, &ret, &name, &value);
>          g_free(name);
>          g_free(value);
>          if (ret) {

Likewise.

> @@ -880,7 +887,7 @@ bool has_help_option(const char *params)
>  bool qemu_opts_do_parse(QemuOpts *opts, const char *params,
>                         const char *firstname, Error **errp)
>  {
> -    return opts_do_parse(opts, params, firstname, false, NULL, errp);
> +    return opts_do_parse(opts, params, firstname, false, false, NULL, errp);

Can you explain why this one doesn't warn?

>  }
>  
>  static QemuOpts *opts_parse(QemuOptsList *list, const char *params,
> @@ -908,8 +915,8 @@ static QemuOpts *opts_parse(QemuOptsList *list, const char *params,
>          return NULL;
>      }
>  
> -    if (!opts_do_parse(opts, params, firstname, defaults, help_wanted,
> -                       errp)) {
> +    if (!opts_do_parse(opts, params, firstname, defaults,
> +                       !list->allow_flag_options, help_wanted, errp)) {
>          qemu_opts_del(opts);
>          return NULL;
>      }

Here's a funny one:

    void qemu_opts_set_defaults(QemuOptsList *list, const char *params,
                                int permit_abbrev)
    {
        QemuOpts *opts;

        opts = opts_parse(list, params, permit_abbrev, true, NULL, NULL);
        assert(opts);
    }

If someone manages to put bool sugar into
machine_class->default_machine_opts, we'll print a confusing warning on
startup.  It's a programming error, which means we should abort().


