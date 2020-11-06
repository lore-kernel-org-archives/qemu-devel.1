Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E0B9C2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 15:11:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C15D22227
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 15:11:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GC1J57pi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C15D22227
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kb3OT-0003Sx-0R
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 10:11:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60824)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kb3No-0002vc-7U
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 10:10:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50508)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kb3Nl-00030G-1R
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 10:10:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604675427;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vGkWco6g7+up3af1ra+603CpgaGhwt9hM22epxrowhI=;
 b=GC1J57piu1kmAJPIge5ZZbtk2upPDiX3sKRW4iXTykVEWGN+pIxlGCL+6z0zioNiR+8na7
 mgftzAxk8J2OQyReIPdBmkjJkprlFf19nd21cRmip85G6G3SlILWqNWy2jxS8O6DRQNcGs
 /mi8XSdTR37e8wE8KirhYmftga0KbFo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-593-QsRbJxJTM3WDUBvOB1gsxw-1; Fri, 06 Nov 2020 10:10:25 -0500
X-MC-Unique: QsRbJxJTM3WDUBvOB1gsxw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7CB5357202
 for <qemu-devel@nongnu.org>; Fri,  6 Nov 2020 15:10:24 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-103.ams2.redhat.com
 [10.36.112.103])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 271D351575;
 Fri,  6 Nov 2020 15:10:24 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8D7E31132BD6; Fri,  6 Nov 2020 16:10:21 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 1/2] qemu-option: move help handling to get_opt_name_value
References: <20201105142731.623428-1-pbonzini@redhat.com>
 <20201105142731.623428-2-pbonzini@redhat.com>
Date: Fri, 06 Nov 2020 16:10:21 +0100
In-Reply-To: <20201105142731.623428-2-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Thu, 5 Nov 2020 09:27:30 -0500")
Message-ID: <87eel6ikrm.fsf@dusky.pond.sub.org>
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

> Right now, help options are parsed normally and then checked
> specially in opt_validate. but only if coming from
> qemu_opts_parse or qemu_opts_parse_noisily.
> Move the check from opt_validate to the common workhorses
> of qemu_opts_parse and qemu_opts_parse_noisily, opts_do_parse
> and get_opt_name_value.
>
> As a result, opts_parse and opts_do_parse do not return an error anymore
> when help is requested---just like qemu_opts_parse_noisily.
>
> This will come in handy in the next patch, which will
> raise a warning for "-object memory-backend-ram,share"
> ("flag" option with no =on/=off part) but not for
> "-object memory-backend-ram,help".
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  util/qemu-option.c | 40 ++++++++++++++++++++--------------------
>  1 file changed, 20 insertions(+), 20 deletions(-)
>
> diff --git a/util/qemu-option.c b/util/qemu-option.c
> index acefbc23fa..61fc96f9dd 100644
> --- a/util/qemu-option.c
> +++ b/util/qemu-option.c
> @@ -504,17 +504,13 @@ static QemuOpt *opt_create(QemuOpts *opts, const char *name, char *value,
>      return opt;
>  }
>  
> -static bool opt_validate(QemuOpt *opt, bool *help_wanted,
> -                         Error **errp)
> +static bool opt_validate(QemuOpt *opt, Error **errp)
>  {
>      const QemuOptDesc *desc;
>  
>      desc = find_desc_by_name(opt->opts->list->desc, opt->name);
>      if (!desc && !opts_accepts_any(opt->opts)) {
>          error_setg(errp, QERR_INVALID_PARAMETER, opt->name);
> -        if (help_wanted && is_help_option(opt->name)) {
> -            *help_wanted = true;
> -        }
>          return false;
>      }

Two callers, one passes null (trivial: no change), one non-null (more
interesting).

Behavior before the patch is rather peculiar:

* The caller needs to opt into the help syntax by passing non-null
  @help_wanted.

* A request for help is recognized only when the option name is not
  recognized.  Two cases:

  - When @opts accepts anything, we ignore cries for help.

  - Else, we recognize it only when there is no option named "help".

* A help request is an ordinary option parameter (possibly sugared)
  where the parameter name is a "help option" (i.e. "help" or "?"), and
  the value doesn't matter.

  Examples:
  - "help=..."
  - "help" (sugar for "help=on")
  - "nohelp" (sugar for "help=off")
  - "?=..."
  - "?" (sugar for "?=on")
  - "no?" (sugar for "?=off")

* A request for help is treated as an error: we set @errp and return
  false.

>  
> @@ -531,7 +527,7 @@ bool qemu_opt_set(QemuOpts *opts, const char *name, const char *value,
>  {
>      QemuOpt *opt = opt_create(opts, name, g_strdup(value), false);
>  
> -    if (!opt_validate(opt, NULL, errp)) {
> +    if (!opt_validate(opt, errp)) {
>          qemu_opt_del(opt);
>          return false;

This is the trivial caller.

>      }
> @@ -767,16 +763,18 @@ void qemu_opts_print(QemuOpts *opts, const char *separator)
>  
>  static const char *get_opt_name_value(const char *params,
>                                        const char *firstname,
> +                                      bool *help_wanted,
>                                        char **name, char **value)
>  {
> -    const char *p, *pe, *pc;
> -
> -    pe = strchr(params, '=');
> -    pc = strchr(params, ',');
> +    const char *p;
> +    size_t len;
>  
> -    if (!pe || (pc && pc < pe)) {
> +    len = strcspn(params, "=,");
> +    if (params[len] != '=') {
>          /* found "foo,more" */
> -        if (firstname) {
> +        if (help_wanted && starts_with_help_option(params) == len) {
> +            *help_wanted = true;
> +        } else if (firstname) {
>              /* implicitly named first option */
>              *name = g_strdup(firstname);
>              p = get_opt_value(params, value);

This function parses one parameter from @params into @name, @value, and
returns a pointer to the next parameter, or else to the terminating
'\0'.

Funny: it cannot fail.  QemuOpts is an indiscriminate omnivore ;)

The patch does two separate things:

1. It streamlines how we look ahead to '=', ',' or '\0'.

   Three cases: '=' comes first, '-' comes first, '\0' comes first.

   Before the patch: !pe || (pc && pc < pe) means there is no '=', or
   else there is ',' and it's before '='.  In other words, '=' does not
   come first.

   After the patch: params[len] != '=' where len = strcspn(params, "=,")
   means '=' does not come first.

   Okay, but make it a separate patch, please.

   The ,more in both comments is slightly misleading.  Observation, not
   demand.

2. Optional parsing of help (opt in by passing non-null @help_wanted).

   I wonder why this is opt-in.  I trust that'll become clear further
   down.

   If @params starts with "help option", and it's followed by ',' or
   '\0', set *help_wanted instead of *name and *value.  Okay.

   The function needed a written contract before, and now it needs it
   more.  Observation, not demand.

> @@ -814,7 +812,10 @@ static bool opts_do_parse(QemuOpts *opts, const char *params,
>      QemuOpt *opt;
>  
>      for (p = params; *p;) {
> -        p = get_opt_name_value(p, firstname, &option, &value);
> +        p = get_opt_name_value(p, firstname, help_wanted, &option, &value);
> +        if (help_wanted && *help_wanted) {
> +            return false;
> +        }
>          firstname = NULL;
>  
>          if (!strcmp(option, "id")) {
> @@ -825,7 +826,7 @@ static bool opts_do_parse(QemuOpts *opts, const char *params,
>  
>          opt = opt_create(opts, option, value, prepend);
>          g_free(option);
> -        if (!opt_validate(opt, help_wanted, errp)) {
> +        if (!opt_validate(opt, errp)) {
>              qemu_opt_del(opt);
>              return false;
>          }

This is the interesting caller.

Before the patch:

* Success: add an option paramter to @opts, return true.

* Help wanted (only if caller opts in): set *help_wanted, set error,
  return false

* Error: set error, return false.

The patch changes two things:

1. We no longer set an error when the user asks for help.  Checking the
   callers:

   - qemu_opts_do_parse() is not affected, because it passes null
     @help_wanted.

   - opts_parse() passes on the change to its callers:

     * qemu_opts_parse() is not affected, because it passes null
       @help_wanted.

     * qemu_opts_parse_noisily() is affected; see below.

2. We only recognize "help" and "?".  We no longer recognize
   "help=...". "?=...", "nohelp", and "no?".  I'm okay with the change,
   but it needs to be explained in the commit message.  You decide
   whether to cover it in release notes.

> @@ -840,7 +841,7 @@ static char *opts_parse_id(const char *params)
>      char *name, *value;
>  
>      for (p = params; *p;) {
> -        p = get_opt_name_value(p, NULL, &name, &value);
> +        p = get_opt_name_value(p, NULL, NULL, &name, &value);
>          if (!strcmp(name, "id")) {
>              g_free(name);
>              return value;

opts_parse() parses an entire option argument.  It returns the value of
option parameter "id".  Everything else gets thrown away.

Note for later: your patch makes it opt out of help syntax.

> @@ -856,11 +857,10 @@ bool has_help_option(const char *params)
>  {
>      const char *p;
>      char *name, *value;
> -    bool ret;
> +    bool ret = false;
>  
>      for (p = params; *p;) {
> -        p = get_opt_name_value(p, NULL, &name, &value);
> -        ret = is_help_option(name);
> +        p = get_opt_name_value(p, NULL, &ret, &name, &value);
>          g_free(name);
>          g_free(value);
>          if (ret) {

has_help_option() parses an entire option argument.

Same syntax change as in opts_do_parse().

> @@ -946,10 +946,10 @@ QemuOpts *qemu_opts_parse_noisily(QemuOptsList *list, const char *params,
>      bool help_wanted = false;
>  
>      opts = opts_parse(list, params, permit_abbrev, false, &help_wanted, &err);
> -    if (err) {
> +    if (!opts) {
> +        assert(!!err + !!help_wanted == 1);
>          if (help_wanted) {
>              qemu_opts_print_help(list, true);
> -            error_free(err);
>          } else {
>              error_report_err(err);
>          }

Since opts_parse() no longer sets an error when the user asks for help,
this function needs an update.  Okay.


Now let's get back to "I wonder why this is opt-in?"

Only one caller does not opt in: opts_parse_id().  I'd try making the
help syntax unconditional.  get_opt_name_value() gets a bit simpler,
opts_parse_id() may get a bit more complex.  I'd expect that to be a
good trade.


QemuOpts patches tend to look more innocent than they are.  This one's
no exception :)


