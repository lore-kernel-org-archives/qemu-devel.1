Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C841C388F7
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 19:41:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D621E206A1
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 19:41:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EYJZv3R6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D621E206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kcD2s-0002iR-Of
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 14:41:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39264)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kcD1f-0002BG-9x
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 14:40:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48335)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kcD1c-00019q-Ng
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 14:40:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604950822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TAbcw1Q/KotuiE/b/MRTpoDbgnXm0Bnl6bvnEEV6JY4=;
 b=EYJZv3R6Z+7adSXKafd3cw5Mc+YQC4sjL+A1SW9VVAPg0yvp0V9Az5xs61Lr97b1rjul29
 pB5DkAE+mJcx4RN1zI/0hsTYix4fwymvaFA3h0FnRY81D52WVS3J1Bxct1ZDib1NyjpORm
 nr1ayqLSQky+3UEK3e8f9CfYNP1QeJ0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-591-s5-7iSnWMrireJjP6XqfjA-1; Mon, 09 Nov 2020 14:40:18 -0500
X-MC-Unique: s5-7iSnWMrireJjP6XqfjA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3D211800688
 for <qemu-devel@nongnu.org>; Mon,  9 Nov 2020 19:40:17 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-103.ams2.redhat.com
 [10.36.112.103])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DB79C5D9CC;
 Mon,  9 Nov 2020 19:40:16 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4869F1132BD6; Mon,  9 Nov 2020 20:40:15 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 5/6] qemu-option: move help handling to
 get_opt_name_value
References: <20201109133931.979563-1-pbonzini@redhat.com>
 <20201109133931.979563-6-pbonzini@redhat.com>
Date: Mon, 09 Nov 2020 20:40:15 +0100
In-Reply-To: <20201109133931.979563-6-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Mon, 9 Nov 2020 08:39:30 -0500")
Message-ID: <87lffa2uao.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> writes:

> Right now, help options are parsed normally and then checked
> specially in opt_validate, but only if coming from
> qemu_opts_parse_noisily.  has_help_option does the check on its own.
>
> Move the check from opt_validate to the parsing workhorse of QemuOpts,
> get_opt_name_value.  This will come in handy in the next patch, which
> will raise a warning for "-object memory-backend-ram,share" ("flag" option
> with no =on/=off part) but not for "-object memory-backend-ram,help".
>
> As a result:
>
> - opts_parse and opts_do_parse do not return an error anymore
>   when help is requested; qemu_opts_parse_noisily does not have
>   to work around that anymore.
>
> - various crazy ways to request help are not recognized anymore:
>   - "help=..."
>   - "nohelp" (sugar for "help=off")
>   - "?=..."
>   - "no?" (sugar for "?=off")
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  util/qemu-option.c | 34 ++++++++++++++++++++--------------
>  1 file changed, 20 insertions(+), 14 deletions(-)
>
> diff --git a/util/qemu-option.c b/util/qemu-option.c
> index 91f4120ce1..0ddf1f7b45 100644
> --- a/util/qemu-option.c
> +++ b/util/qemu-option.c
> @@ -496,8 +496,7 @@ static QemuOpt *opt_create(QemuOpts *opts, const char *name, char *value,
>      return opt;
>  }
>  
> -static bool opt_validate(QemuOpt *opt, bool *help_wanted,
> -                         Error **errp)
> +static bool opt_validate(QemuOpt *opt, Error **errp)
>  {
>      const QemuOptDesc *desc;
>      const QemuOptsList *list = opt->opts->list;
> @@ -505,9 +504,6 @@ static bool opt_validate(QemuOpt *opt, bool *help_wanted,
>      desc = find_desc_by_name(list->desc, opt->name);
>      if (!desc && !opts_accepts_any(list)) {
>          error_setg(errp, QERR_INVALID_PARAMETER, opt->name);
> -        if (help_wanted && is_help_option(opt->name)) {
> -            *help_wanted = true;
> -        }
>          return false;
>      }
>  
> @@ -524,7 +520,7 @@ bool qemu_opt_set(QemuOpts *opts, const char *name, const char *value,
>  {
>      QemuOpt *opt = opt_create(opts, name, g_strdup(value), false);
>  
> -    if (!opt_validate(opt, NULL, errp)) {
> +    if (!opt_validate(opt, errp)) {
>          qemu_opt_del(opt);
>          return false;
>      }
> @@ -760,10 +756,12 @@ void qemu_opts_print(QemuOpts *opts, const char *separator)
>  
>  static const char *get_opt_name_value(const char *params,
>                                        const char *firstname,
> +                                      bool *help_wanted,
>                                        char **name, char **value)
>  {
>      const char *p;
>      size_t len;
> +    bool is_help = false;
>  
>      len = strcspn(params, "=,");
>      if (params[len] != '=') {
> @@ -780,6 +778,7 @@ static const char *get_opt_name_value(const char *params,
>                  *value = g_strdup("off");
>              } else {
>                  *value = g_strdup("on");
> +                is_help = is_help_option(*name);
>              }
>          }
>      } else {
> @@ -791,6 +790,9 @@ static const char *get_opt_name_value(const char *params,
>      }
>  
>      assert(!*p || *p == ',');
> +    if (help_wanted && is_help) {
> +        *help_wanted = true;
> +    }

Note [1] for later: we only ever set *help_wanted to true.

>      if (*p == ',') {
>          p++;
>      }

Note [2] for later: we always set *name and *value, even when we set
*help_wanted = true.

> @@ -806,7 +808,10 @@ static bool opts_do_parse(QemuOpts *opts, const char *params,
>      QemuOpt *opt;
>  
>      for (p = params; *p;) {
> -        p = get_opt_name_value(p, firstname, &option, &value);
> +        p = get_opt_name_value(p, firstname, help_wanted, &option, &value);
> +        if (help_wanted && *help_wanted) {
> +            return false;

Doesn't this leak @option and @value?  Remember, [2]
get_opt_name_value() always sets *name and *value.

> +        }
>          firstname = NULL;
>  
>          if (!strcmp(option, "id")) {
> @@ -817,7 +822,7 @@ static bool opts_do_parse(QemuOpts *opts, const char *params,
>  
>          opt = opt_create(opts, option, value, prepend);
>          g_free(option);
> -        if (!opt_validate(opt, help_wanted, errp)) {
> +        if (!opt_validate(opt, errp)) {
>              qemu_opt_del(opt);
>              return false;
>          }
> @@ -832,7 +837,7 @@ static char *opts_parse_id(const char *params)
>      char *name, *value;
>  
>      for (p = params; *p;) {
> -        p = get_opt_name_value(p, NULL, &name, &value);
> +        p = get_opt_name_value(p, NULL, NULL, &name, &value);
>          if (!strcmp(name, "id")) {
>              g_free(name);
>              return value;

This is one of two callers that passes null to help_wanted.

If both callers can pass non-null, we can simplify get_opt_name_value()
slightly.

This one could just as well pass &dummy.  Removes doubt that
opts_parse_id() could parse differently than opts_do_parse().
opts_parse() relies on the two parsing the same.

> @@ -851,8 +856,7 @@ bool has_help_option(const char *params)
>      bool ret;
>  
>      for (p = params; *p;) {
> -        p = get_opt_name_value(p, NULL, &name, &value);
> -        ret = is_help_option(name);
> +        p = get_opt_name_value(p, NULL, &ret, &name, &value);

If @p doesn't contain a help request, &ret remains uninitialized.
Remember, [1] get_opt_name_value() only ever sets *help_wanted to true.

Suggest to make it set *help_wanted like this instead:

       if (help_wanted) {
           *help_wanted = is_help;
       }

>          g_free(name);
>          g_free(value);
>          if (ret) {
> @@ -937,11 +941,13 @@ QemuOpts *qemu_opts_parse_noisily(QemuOptsList *list, const char *params,
>      QemuOpts *opts;
>      bool help_wanted = false;
>  
> -    opts = opts_parse(list, params, permit_abbrev, false, &help_wanted, &err);
> -    if (err) {
> +    opts = opts_parse(list, params, permit_abbrev, false,
> +                      opts_accepts_any(list) ? NULL : &help_wanted,

This recognizes help requests only when !opts_accepts_any().

Recall my review of v1 on opt_validate()'s behavior before the patch:

    * A request for help is recognized only when the option name is not
      recognized.  Two cases:

      - When @opts accepts anything, we ignore cries for help.

You recreate this here.  Why here?

opt_validate() has two callers: qemu_opt_set(), which passes null and is
therefore unaffected, and opts_do_parse(), which is affected.

opts_do_parse() is called by qemu_opts_do_parse(), which passes null and
is therefore unaffected, and opts_parse().

opts_parse() is called by qemu_opts_parse() and
qemu_opts_set_defaults(), which pass null and are therefore unaffected,
and qemu_opts_parse_noisily().

Okay.  A more verbose commit message could've saved me the digging.

      - Else, we recognize it only when there is no option named "help".

You now recognize it even when there is an option named "help".  No
change as long as no such option exists.  That's the case to the best of
my knowledge.  But the argument belongs into the commit message.

> +                      &err);
> +    if (!opts) {
> +        assert(!!err + !!help_wanted == 1);

Either err or help_wanted.  This is logical inequality.  I'd write it as

           assert(!err != !help_wanted);

or maybe as

           assert(!err ^ !help_wanted);

>          if (help_wanted) {
>              qemu_opts_print_help(list, true);
> -            error_free(err);
>          } else {
>              error_report_err(err);
>          }

I think we could pass &help_wanted unconditionally, then ignore the
value of help_wanted if opts_accepts_any().


