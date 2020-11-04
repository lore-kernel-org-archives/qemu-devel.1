Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A4AC388F9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 07:37:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 784B42080D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 07:37:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eaqe5edX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 784B42080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaDM5-0001kg-2Z
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 02:37:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59458)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kaDKk-0001KL-M9
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 02:35:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45327)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kaDKi-0005sb-7q
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 02:35:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604475348;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3PkTaQgfKvgm32uXWwRw1Hjgsr3TCVL5k58rAv+qyYM=;
 b=eaqe5edXHPdpv+LXUekWV1/jD0ZukH+a7r63Xh3P9pWbZjJIq+FkXq4Z4WjUDa3aTLD40m
 VEOtXFtzBJDWOhUjmGfS2/t6XXa6NWTOtcj2AAHrsNhsDYuRrKJeFHEahsNn9+GWf8yDub
 3KEpFnazshpvhJ6gQlql6WxPbvyutqQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-lfxmEGqWPTmlkbLaIyJIAQ-1; Wed, 04 Nov 2020 02:35:46 -0500
X-MC-Unique: lfxmEGqWPTmlkbLaIyJIAQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 54D3B1009E2D
 for <qemu-devel@nongnu.org>; Wed,  4 Nov 2020 07:35:45 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-103.ams2.redhat.com
 [10.36.112.103])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F395A5C1D0;
 Wed,  4 Nov 2020 07:35:44 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6831F1132BD6; Wed,  4 Nov 2020 08:35:43 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2] qapi, qemu-options: make all parsing visitors parse
 boolean options the same
References: <20201103161339.447118-1-pbonzini@redhat.com>
Date: Wed, 04 Nov 2020 08:35:43 +0100
In-Reply-To: <20201103161339.447118-1-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Tue, 3 Nov 2020 11:13:39 -0500")
Message-ID: <87h7q51smo.fsf@dusky.pond.sub.org>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
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

> OptsVisitor, StringInputVisitor and the keyval visitor have
> three different ideas of how a human could write the value of
> a boolean option.  Pay homage to the backwards-compatibility
> gods and make the new common helper accept all four sets (on/off,
> true/false, y/n and yes/no), and case-insensitive at that.
>
> Since OptsVisitor is supposed to match qemu-options, adjust
> it as well.

For clarity: s/it/the latter/

> Supersedes: <20201103142344.402353-1-pbonzini@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  include/qapi/util.h          |  2 ++
>  qapi/opts-visitor.c          | 14 +-------------
>  qapi/qapi-util.c             | 23 +++++++++++++++++++++++
>  qapi/qobject-input-visitor.c | 15 +++++----------
>  qapi/string-input-visitor.c  | 17 +----------------
>  util/qemu-option.c           | 20 ++------------------
>  6 files changed, 34 insertions(+), 57 deletions(-)
>
> diff --git a/include/qapi/util.h b/include/qapi/util.h
> index bc312e90aa..6178e98e97 100644
> --- a/include/qapi/util.h
> +++ b/include/qapi/util.h
> @@ -19,6 +19,8 @@ typedef struct QEnumLookup {
>  const char *qapi_enum_lookup(const QEnumLookup *lookup, int val);
>  int qapi_enum_parse(const QEnumLookup *lookup, const char *buf,
>                      int def, Error **errp);
> +bool qapi_bool_parse(const char *name, const char *value, bool *obj,
> +                     Error **errp);
>  
>  int parse_qapi_name(const char *name, bool complete);
>  
> diff --git a/qapi/opts-visitor.c b/qapi/opts-visitor.c
> index 7781c23a42..587f31baf6 100644
> --- a/qapi/opts-visitor.c
> +++ b/qapi/opts-visitor.c
> @@ -368,7 +368,6 @@ opts_type_str(Visitor *v, const char *name, char **obj, Error **errp)
>  }
>  
>  
> -/* mimics qemu-option.c::parse_option_bool() */
>  static bool
>  opts_type_bool(Visitor *v, const char *name, bool *obj, Error **errp)
>  {
> @@ -379,19 +378,8 @@ opts_type_bool(Visitor *v, const char *name, bool *obj, Error **errp)
>      if (!opt) {
>          return false;
>      }
> -
>      if (opt->str) {
> -        if (strcmp(opt->str, "on") == 0 ||
> -            strcmp(opt->str, "yes") == 0 ||
> -            strcmp(opt->str, "y") == 0) {
> -            *obj = true;
> -        } else if (strcmp(opt->str, "off") == 0 ||
> -            strcmp(opt->str, "no") == 0 ||
> -            strcmp(opt->str, "n") == 0) {
> -            *obj = false;
> -        } else {
> -            error_setg(errp, QERR_INVALID_PARAMETER_VALUE, opt->name,
> -                       "on|yes|y|off|no|n");
> +        if (!qapi_bool_parse(opt->name, opt->str, obj, errp)) {
>              return false;
>          }
>      } else {
> diff --git a/qapi/qapi-util.c b/qapi/qapi-util.c
> index 29a6c98b53..4dd8f6c313 100644
> --- a/qapi/qapi-util.c
> +++ b/qapi/qapi-util.c
> @@ -13,6 +13,7 @@
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
>  #include "qemu/ctype.h"
> +#include "qapi/qmp/qerror.h"
>  
>  const char *qapi_enum_lookup(const QEnumLookup *lookup, int val)
>  {
> @@ -40,6 +41,28 @@ int qapi_enum_parse(const QEnumLookup *lookup, const char *buf,
>      return def;
>  }
>  
> +bool qapi_bool_parse(const char *name, const char *value, bool *obj, Error **errp)
> +{
> +    if (!strcasecmp(value, "on") ||
> +        !strcasecmp(value, "yes") ||
> +        !strcasecmp(value, "true") ||
> +        !strcasecmp(value, "y")) {
> +        *obj = true;
> +        return true;
> +    }
> +    if (!strcasecmp(value, "off") ||
> +        !strcasecmp(value, "no") ||
> +        !strcasecmp(value, "false") ||
> +        !strcasecmp(value, "n")) {
> +        *obj = false;
> +        return true;
> +    }
> +
> +    error_setg(errp, QERR_INVALID_PARAMETER_VALUE, name,
> +               "boolean (on/off, yes/no, true/false, y/n)");

Recommend to have the error message only mention the preferred form.  I
like the laconic "'on' or 'off'".  It's really all the user needs to
know.

> +    return false;
> +}
> +
>  /*
>   * Parse a valid QAPI name from @str.
>   * A valid name consists of letters, digits, hyphen and underscore.
> diff --git a/qapi/qobject-input-visitor.c b/qapi/qobject-input-visitor.c
> index 7b184b50a7..f4541a4fdd 100644
> --- a/qapi/qobject-input-visitor.c
> +++ b/qapi/qobject-input-visitor.c
> @@ -512,16 +512,11 @@ static bool qobject_input_type_bool_keyval(Visitor *v, const char *name,
>          return false;
>      }
>  
> -    if (!strcmp(str, "on")) {
> -        *obj = true;
> -    } else if (!strcmp(str, "off")) {
> -        *obj = false;
> -    } else {
> -        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
> -                   full_name(qiv, name), "'on' or 'off'");
> -        return false;
> -    }
> -    return true;
> +    /*
> +     * Calling full_name is a bit slow, but keyval (human/CLI) parsing
> +     * is not a hot path.
> +     */
> +    return qapi_bool_parse(full_name(qiv, name), str, obj, errp);

Avoiding the full_name() on success isn't hard:

       if (!qapi_bool_parse(name, str, obj, NULL)) {
           error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
                      full_name(qiv, name), "'on' or 'off'");
           return false;
       }
       return true;

A callback to build the name only on error would be overkill.

By the way: related qapi_enum_parse() also takes an @errp parameter, and
several of its callers pass NULL and call error_setg() themselves.
Sometimes one doesn't fit all.  I've been tempted more than once to
provide two functions: one that doesn't take @errp, and the obvious
wrapper that does.

>  }
>  
>  static bool qobject_input_type_str(Visitor *v, const char *name, char **obj,
> diff --git a/qapi/string-input-visitor.c b/qapi/string-input-visitor.c
> index 6e53396ea3..197139c1c0 100644
> --- a/qapi/string-input-visitor.c
> +++ b/qapi/string-input-visitor.c
> @@ -332,22 +332,7 @@ static bool parse_type_bool(Visitor *v, const char *name, bool *obj,
>      StringInputVisitor *siv = to_siv(v);
>  
>      assert(siv->lm == LM_NONE);
> -    if (!strcasecmp(siv->string, "on") ||
> -        !strcasecmp(siv->string, "yes") ||
> -        !strcasecmp(siv->string, "true")) {
> -        *obj = true;
> -        return true;
> -    }
> -    if (!strcasecmp(siv->string, "off") ||
> -        !strcasecmp(siv->string, "no") ||
> -        !strcasecmp(siv->string, "false")) {
> -        *obj = false;
> -        return true;
> -    }
> -
> -    error_setg(errp, QERR_INVALID_PARAMETER_TYPE, name ? name : "null",
> -               "boolean");
> -    return false;
> +    return qapi_bool_parse(name ? name : "null", siv->string, obj, errp);
>  }
>  
>  static bool parse_type_str(Visitor *v, const char *name, char **obj,
> diff --git a/util/qemu-option.c b/util/qemu-option.c
> index b9f93a7f8b..acefbc23fa 100644
> --- a/util/qemu-option.c
> +++ b/util/qemu-option.c
> @@ -96,21 +96,6 @@ const char *get_opt_value(const char *p, char **value)
>      return offset;
>  }
>  
> -static bool parse_option_bool(const char *name, const char *value, bool *ret,
> -                              Error **errp)
> -{
> -    if (!strcmp(value, "on")) {
> -        *ret = 1;
> -    } else if (!strcmp(value, "off")) {
> -        *ret = 0;
> -    } else {
> -        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
> -                   name, "'on' or 'off'");
> -        return false;
> -    }
> -    return true;
> -}
> -
>  static bool parse_option_number(const char *name, const char *value,
>                                  uint64_t *ret, Error **errp)
>  {
> @@ -363,7 +348,7 @@ static bool qemu_opt_get_bool_helper(QemuOpts *opts, const char *name,
>      if (opt == NULL) {
>          def_val = find_default_by_name(opts, name);
>          if (def_val) {
> -            parse_option_bool(name, def_val, &ret, &error_abort);
> +            qapi_bool_parse(name, def_val, &ret, &error_abort);
>          }
>          return ret;
>      }
> @@ -471,8 +456,7 @@ static bool qemu_opt_parse(QemuOpt *opt, Error **errp)
>          /* nothing */
>          return true;
>      case QEMU_OPT_BOOL:
> -        return parse_option_bool(opt->name, opt->str, &opt->value.boolean,
> -                                 errp);
> +        return qapi_bool_parse(opt->name, opt->str, &opt->value.boolean, errp);

Please break the line the same way as before.

>      case QEMU_OPT_NUMBER:
>          return parse_option_number(opt->name, opt->str, &opt->value.uint,
>                                     errp);

Nothing wrong, so:
Reviewed-by: Markus Armbruster <armbru@redhat.com>

Please consider my review comments anyway.


