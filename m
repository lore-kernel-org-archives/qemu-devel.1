Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE123C2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 16:01:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54A0B2080C
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 16:01:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UDwIFbnK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54A0B2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZykQ-0004pb-C4
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 11:01:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60244)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kZyjF-0003Qo-VN
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 11:00:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52077)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kZyjC-0002Vm-VW
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 11:00:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604419209;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IeBEkZ3rPPd3tykenEV5yTcAv5+AKEtQKdvPy2HzDwc=;
 b=UDwIFbnKW4PhyTv3lJgX1c843B5Q5G3VJiLlTRB1n+y40TG/v65CmqxLzwyqrt/HiUKEVf
 PhqMuIJllAu4VtdW1o7kQq8Nek8No+c6jejsVJE9OOo6602jGsQe0sZVTlogrD3Bd0SWPJ
 QUrmn3xuOg0MYNcPaR7d7/KamQJ10WI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-183-lwe-oJdYNd2sAYfs9ZcLOg-1; Tue, 03 Nov 2020 11:00:07 -0500
X-MC-Unique: lwe-oJdYNd2sAYfs9ZcLOg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 487B218BA283
 for <qemu-devel@nongnu.org>; Tue,  3 Nov 2020 16:00:06 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-103.ams2.redhat.com
 [10.36.112.103])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D52F27512A;
 Tue,  3 Nov 2020 16:00:05 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4DA3A1132BD6; Tue,  3 Nov 2020 17:00:04 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] qapi: make all parsing visitors parse boolean options
 the same
References: <20201103142344.402353-1-pbonzini@redhat.com>
Date: Tue, 03 Nov 2020 17:00:04 +0100
In-Reply-To: <20201103142344.402353-1-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Tue, 3 Nov 2020 09:23:44 -0500")
Message-ID: <871rhajurf.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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
> gods and make the new common helper accept all four sets: on/off,
> true/false, y/n and yes/no.

Mention the match is now case-insensitive?

>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  include/qapi/util.h          |  2 ++
>  qapi/opts-visitor.c          | 13 +------------
>  qapi/qapi-util.c             | 23 +++++++++++++++++++++++
>  qapi/qobject-input-visitor.c | 11 +----------
>  qapi/string-input-visitor.c  | 17 +----------------
>  5 files changed, 28 insertions(+), 38 deletions(-)
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
> index 7781c23a42..9b3a735e6d 100644
> --- a/qapi/opts-visitor.c
> +++ b/qapi/opts-visitor.c

Oh no, the options visitor!

> @@ -379,19 +379,8 @@ opts_type_bool(Visitor *v, const char *name, bool *obj, Error **errp)
   /* mimics qemu-option.c::parse_option_bool() */

This comment becomes wrong.

   static bool
   opts_type_bool(Visitor *v, const char *name, bool *obj, Error **errp)
   {
       OptsVisitor *ov = to_ov(v);
       const QemuOpt *opt;

       opt = lookup_scalar(ov, name, errp);
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
> +        if (!qapi_bool_parse(name, opt->str, obj, errp)) {

Exploits lookup_name() ensures name == opt->name.

Obviously true when ov->list_mode == LM_NONE: lookup_name() returns the
last QemuOpt of that name.

We don't get here when ov->list_mode == LM_TRAVERSED: lookup_name()
fails.

"Obviously" true when ov->list_mode == LM_IN_PROGRESS: lookup_name()
returns the next remaining QemuOpt of that name (I think).

>              return false;
>          }
>      } else {
> diff --git a/qapi/qapi-util.c b/qapi/qapi-util.c
> index 29a6c98b53..8a98813e42 100644
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

I'd prefer breaking the lines before the || operator (Knuth style).

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
> +    error_setg(errp, QERR_INVALID_PARAMETER_VALUE, name ? name : "null",
> +               "boolean (on/off, yes/no, true/false, y/n)");
> +    return false;

Baroque.  Not this patch's fault.  I'm half-tempted to deprecate
everything but 'on' and 'off', case-sensitive.

Recommend to have the error message only mention the preferred form.  I
like the laconic "'on' or 'off'".  It's really all the user needs to
know.

You copied the name ?: "null" from the string input visitor.  It's bad
there (but nobody cares), and it's bad here (where I care).  I think it
should be left to callers.  See also next hunk.

> +}
> +
>  /*
>   * Parse a valid QAPI name from @str.
>   * A valid name consists of letters, digits, hyphen and underscore.
> diff --git a/qapi/qobject-input-visitor.c b/qapi/qobject-input-visitor.c
> index 7b184b50a7..183472e5e4 100644
> --- a/qapi/qobject-input-visitor.c
> +++ b/qapi/qobject-input-visitor.c
> @@ -512,16 +512,7 @@ static bool qobject_input_type_bool_keyval(Visitor *v, const char *name,
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
> +    return qapi_bool_parse(name, str, obj, errp);

Error message regresses from full_name(), which is never null, to name
?: "null".

Test case:

    $ qemu-storage-daemon --blockdev qcow2,node-name=node0,file.driver=file,file.filename=tmp.qcow2,file.x-check-cache-dropped=xxx
    qemu-storage-daemon: --blockdev qcow2,node-name=node0,file.driver=file,file.filename=tmp.qcow2,file.x-check-cache-dropped=xxx: Parameter 'file.x-check-cache-dropped' expects 'on' or 'off'

!name happens for ['bool'].  The error message is user-hostile then.  No
test case, because ['bool'] occurs only in tests/ right now.

>  }
>  
>  static bool qobject_input_type_str(Visitor *v, const char *name, char **obj,
> diff --git a/qapi/string-input-visitor.c b/qapi/string-input-visitor.c
> index 6e53396ea3..ba2697d70f 100644
> --- a/qapi/string-input-visitor.c
> +++ b/qapi/string-input-visitor.c

Oh no, the string visitor!

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
> +    return qapi_bool_parse(name, siv->string, obj, errp);
>  }
>  
>  static bool parse_type_str(Visitor *v, const char *name, char **obj,

Puh!


