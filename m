Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 407C7C388F7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 13:27:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5791E20867
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 13:27:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WcwxGf/k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5791E20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaIop-0007sk-Sm
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 08:27:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54916)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kaInW-0006wg-Gt
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 08:25:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55164)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kaInR-0000rI-Qx
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 08:25:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604496351;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CgmsmeFh9Ge4BqXdyjV9vBkxj4CH5NT44HwoHFwPmag=;
 b=WcwxGf/kyf1CsvsFX6M4yA3W82WFfPUr1EaS11mmLrcx+2MAa73VFMYVuwllMPWNi9eA2b
 p7T6ClME1CdodpZ+/+hfaUkQd9pmOTz7cN1chv4zWgevNNJ9IFG4ehwxTX7B9SfFI+6S7M
 4whqJ/U6OVpR3hXqZNK51h5vEErj/dY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-522-hTOWeEHjON6WccPo_0bIxQ-1; Wed, 04 Nov 2020 08:25:48 -0500
X-MC-Unique: hTOWeEHjON6WccPo_0bIxQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6316A1891E82
 for <qemu-devel@nongnu.org>; Wed,  4 Nov 2020 13:25:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-103.ams2.redhat.com
 [10.36.112.103])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D7F201A3D7;
 Wed,  4 Nov 2020 13:25:46 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 664371132BD6; Wed,  4 Nov 2020 14:25:45 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] qapi, qemu-options: make all parsing visitors parse
 boolean options the same
References: <20201104114937.520288-1-pbonzini@redhat.com>
Date: Wed, 04 Nov 2020 14:25:45 +0100
In-Reply-To: <20201104114937.520288-1-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Wed, 4 Nov 2020 06:49:37 -0500")
Message-ID: <87zh3xw8x2.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 22:09:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: "Daniel P . =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is v3.

Paolo Bonzini <pbonzini@redhat.com> writes:

> OptsVisitor, StringInputVisitor and the keyval visitor have
> three different ideas of how a human could write the value of
> a boolean option.  Pay homage to the backwards-compatibility
> gods and make the new common helper accept all four sets (on/off,
> true/false, y/n and yes/no), but remove case-insensitivity.
>
> Since OptsVisitor is supposed to match qemu-options, adjust
> it as well.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> Message-Id: <20201103161339.447118-1-pbonzini@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Message-Id and double-SoB are odd.  Accident?

> ---
>  include/qapi/util.h           |  2 ++
>  qapi/opts-visitor.c           | 14 +-------------
>  qapi/qapi-util.c              | 23 +++++++++++++++++++++++
>  qapi/qobject-input-visitor.c  |  6 +-----
>  qapi/string-input-visitor.c   | 17 +----------------
>  tests/qemu-iotests/051.out    |  6 +++---
>  tests/qemu-iotests/051.pc.out |  6 +++---
>  tests/qemu-iotests/133.out    |  8 ++++----
>  tests/qemu-iotests/137.out    |  4 ++--
>  util/qemu-option.c            | 20 ++------------------
>  10 files changed, 42 insertions(+), 64 deletions(-)
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
> =20
>  int parse_qapi_name(const char *name, bool complete);
> =20
> diff --git a/qapi/opts-visitor.c b/qapi/opts-visitor.c
> index 7781c23a42..587f31baf6 100644
> --- a/qapi/opts-visitor.c
> +++ b/qapi/opts-visitor.c
> @@ -368,7 +368,6 @@ opts_type_str(Visitor *v, const char *name, char **ob=
j, Error **errp)
>  }
> =20
> =20
> -/* mimics qemu-option.c::parse_option_bool() */
>  static bool
>  opts_type_bool(Visitor *v, const char *name, bool *obj, Error **errp)
>  {
> @@ -379,19 +378,8 @@ opts_type_bool(Visitor *v, const char *name, bool *o=
bj, Error **errp)
>      if (!opt) {
>          return false;
>      }
> -
>      if (opt->str) {
> -        if (strcmp(opt->str, "on") =3D=3D 0 ||
> -            strcmp(opt->str, "yes") =3D=3D 0 ||
> -            strcmp(opt->str, "y") =3D=3D 0) {
> -            *obj =3D true;
> -        } else if (strcmp(opt->str, "off") =3D=3D 0 ||
> -            strcmp(opt->str, "no") =3D=3D 0 ||
> -            strcmp(opt->str, "n") =3D=3D 0) {
> -            *obj =3D false;
> -        } else {
> -            error_setg(errp, QERR_INVALID_PARAMETER_VALUE, opt->name,
> -                       "on|yes|y|off|no|n");
> +        if (!qapi_bool_parse(opt->name, opt->str, obj, errp)) {

Error message changes from

    $ qemu-system-x86_64 -netdev user,id=3Dnet0,ipv4=3D
    qemu-system-x86_64: Parameter 'ipv4' expects on|yes|y|off|no|n

to

    qemu-system-x86_64: Parameter 'ipv4' expects boolean (on/off)

Intentional (but see below).

>              return false;
>          }
>      } else {
> diff --git a/qapi/qapi-util.c b/qapi/qapi-util.c
> index 29a6c98b53..dfc0bde497 100644
> --- a/qapi/qapi-util.c
> +++ b/qapi/qapi-util.c
> @@ -13,6 +13,7 @@
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
>  #include "qemu/ctype.h"
> +#include "qapi/qmp/qerror.h"
> =20
>  const char *qapi_enum_lookup(const QEnumLookup *lookup, int val)
>  {
> @@ -40,6 +41,28 @@ int qapi_enum_parse(const QEnumLookup *lookup, const c=
har *buf,
>      return def;
>  }
> =20
> +bool qapi_bool_parse(const char *name, const char *value, bool *obj, Err=
or **errp)
> +{
> +    if (g_str_equal(value, "on") ||
> +        g_str_equal(value, "yes") ||
> +        g_str_equal(value, "true") ||
> +        g_str_equal(value, "y")) {
> +        *obj =3D true;
> +        return true;
> +    }
> +    if (g_str_equal(value, "off") ||
> +        g_str_equal(value, "no") ||
> +        g_str_equal(value, "false") ||
> +        g_str_equal(value, "n")) {
> +        *obj =3D false;
> +        return true;
> +    }
> +
> +    error_setg(errp, QERR_INVALID_PARAMETER_VALUE, name,
> +               "boolean (on/off)");
> +    return false;
> +}
> +
>  /*
>   * Parse a valid QAPI name from @str.
>   * A valid name consists of letters, digits, hyphen and underscore.
> diff --git a/qapi/qobject-input-visitor.c b/qapi/qobject-input-visitor.c
> index 7b184b50a7..23843b242e 100644
> --- a/qapi/qobject-input-visitor.c
> +++ b/qapi/qobject-input-visitor.c
> @@ -512,11 +512,7 @@ static bool qobject_input_type_bool_keyval(Visitor *=
v, const char *name,
>          return false;
>      }
> =20
> -    if (!strcmp(str, "on")) {
> -        *obj =3D true;
> -    } else if (!strcmp(str, "off")) {
> -        *obj =3D false;
> -    } else {
> +    if (!qapi_bool_parse(name, str, obj, NULL)) {
>          error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
>                     full_name(qiv, name), "'on' or 'off'");
>          return false;

Error message stays the same:

    $ qemu-system-x86_64 -display gtk,full-screen=3D
    qemu-system-x86_64: -display gtk,full-screen=3D: Parameter 'full-screen=
' expects 'on' or 'off'

Good.

> diff --git a/qapi/string-input-visitor.c b/qapi/string-input-visitor.c
> index 6e53396ea3..197139c1c0 100644
> --- a/qapi/string-input-visitor.c
> +++ b/qapi/string-input-visitor.c
> @@ -332,22 +332,7 @@ static bool parse_type_bool(Visitor *v, const char *=
name, bool *obj,
>      StringInputVisitor *siv =3D to_siv(v);
> =20
>      assert(siv->lm =3D=3D LM_NONE);
> -    if (!strcasecmp(siv->string, "on") ||
> -        !strcasecmp(siv->string, "yes") ||
> -        !strcasecmp(siv->string, "true")) {
> -        *obj =3D true;
> -        return true;
> -    }
> -    if (!strcasecmp(siv->string, "off") ||
> -        !strcasecmp(siv->string, "no") ||
> -        !strcasecmp(siv->string, "false")) {
> -        *obj =3D false;
> -        return true;
> -    }
> -
> -    error_setg(errp, QERR_INVALID_PARAMETER_TYPE, name ? name : "null",
> -               "boolean");
> -    return false;
> +    return qapi_bool_parse(name ? name : "null", siv->string, obj, errp)=
;

Error message changes from

    $ qemu-system-x86_64 -nodefaults -global isa-serial.wakeup=3D -device i=
sa-serial
    qemu-system-x86_64: -device isa-serial: can't apply global isa-serial.w=
akeup=3D: Invalid parameter type for 'wakeup', expected: boolean

to

    qemu-system-x86_64: -device isa-serial: can't apply global isa-serial.w=
akeup=3D: Parameter 'wakeup' expects boolean (on/off)

Okay (but see below).

>  }
> =20
>  static bool parse_type_str(Visitor *v, const char *name, char **obj,
> diff --git a/tests/qemu-iotests/051.out b/tests/qemu-iotests/051.out
> index de4771bcb3..21d2dbec4c 100644
> --- a/tests/qemu-iotests/051.out
> +++ b/tests/qemu-iotests/051.out
> @@ -110,13 +110,13 @@ QEMU X.Y.Z monitor - type 'help' for more informati=
on
>  (qemu) quit
> =20
>  Testing: -drive file=3DTEST_DIR/t.qcow2,format=3Dqcow2,lazy-refcounts=3D
> -QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,format=3Dqcow2,lazy-refcounts=
=3D: Parameter 'lazy-refcounts' expects 'on' or 'off'
> +QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,format=3Dqcow2,lazy-refcounts=
=3D: Parameter 'lazy-refcounts' expects boolean (on/off)
> =20
>  Testing: -drive file=3DTEST_DIR/t.qcow2,format=3Dqcow2,lazy-refcounts=3D=
42
> -QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,format=3Dqcow2,lazy-refcounts=
=3D42: Parameter 'lazy-refcounts' expects 'on' or 'off'
> +QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,format=3Dqcow2,lazy-refcounts=
=3D42: Parameter 'lazy-refcounts' expects boolean (on/off)
> =20
>  Testing: -drive file=3DTEST_DIR/t.qcow2,format=3Dqcow2,lazy-refcounts=3D=
foo
> -QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,format=3Dqcow2,lazy-refcounts=
=3Dfoo: Parameter 'lazy-refcounts' expects 'on' or 'off'
> +QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,format=3Dqcow2,lazy-refcounts=
=3Dfoo: Parameter 'lazy-refcounts' expects boolean (on/off)
> =20
> =20
>  =3D=3D=3D With version 2 images enabling lazy refcounts must fail =3D=3D=
=3D
> diff --git a/tests/qemu-iotests/051.pc.out b/tests/qemu-iotests/051.pc.ou=
t
> index f707471fb0..d814b83871 100644
> --- a/tests/qemu-iotests/051.pc.out
> +++ b/tests/qemu-iotests/051.pc.out
> @@ -110,13 +110,13 @@ QEMU X.Y.Z monitor - type 'help' for more informati=
on
>  (qemu) quit
> =20
>  Testing: -drive file=3DTEST_DIR/t.qcow2,format=3Dqcow2,lazy-refcounts=3D
> -QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,format=3Dqcow2,lazy-refcounts=
=3D: Parameter 'lazy-refcounts' expects 'on' or 'off'
> +QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,format=3Dqcow2,lazy-refcounts=
=3D: Parameter 'lazy-refcounts' expects boolean (on/off)
> =20
>  Testing: -drive file=3DTEST_DIR/t.qcow2,format=3Dqcow2,lazy-refcounts=3D=
42
> -QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,format=3Dqcow2,lazy-refcounts=
=3D42: Parameter 'lazy-refcounts' expects 'on' or 'off'
> +QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,format=3Dqcow2,lazy-refcounts=
=3D42: Parameter 'lazy-refcounts' expects boolean (on/off)
> =20
>  Testing: -drive file=3DTEST_DIR/t.qcow2,format=3Dqcow2,lazy-refcounts=3D=
foo
> -QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,format=3Dqcow2,lazy-refcounts=
=3Dfoo: Parameter 'lazy-refcounts' expects 'on' or 'off'
> +QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,format=3Dqcow2,lazy-refcounts=
=3Dfoo: Parameter 'lazy-refcounts' expects boolean (on/off)
> =20
> =20
>  =3D=3D=3D With version 2 images enabling lazy refcounts must fail =3D=3D=
=3D
> diff --git a/tests/qemu-iotests/133.out b/tests/qemu-iotests/133.out
> index d70c2e8041..75431c2594 100644
> --- a/tests/qemu-iotests/133.out
> +++ b/tests/qemu-iotests/133.out
> @@ -35,8 +35,8 @@ qemu-io: Cannot set both -c and the cache options
> =20
>  =3D=3D=3D Check that invalid options are handled correctly =3D=3D=3D
> =20
> -qemu-io: Parameter 'read-only' expects 'on' or 'off'
> -qemu-io: Parameter 'cache.no-flush' expects 'on' or 'off'
> -qemu-io: Parameter 'cache.direct' expects 'on' or 'off'
> -qemu-io: Parameter 'auto-read-only' expects 'on' or 'off'
> +qemu-io: Parameter 'read-only' expects boolean (on/off)
> +qemu-io: Parameter 'cache.no-flush' expects boolean (on/off)
> +qemu-io: Parameter 'cache.direct' expects boolean (on/off)
> +qemu-io: Parameter 'auto-read-only' expects boolean (on/off)
>  *** done
> diff --git a/tests/qemu-iotests/137.out b/tests/qemu-iotests/137.out
> index 86377c80cd..a420db61d5 100644
> --- a/tests/qemu-iotests/137.out
> +++ b/tests/qemu-iotests/137.out
> @@ -15,7 +15,7 @@ read 33554432/33554432 bytes at offset 0
> =20
>  =3D=3D=3D Try setting some invalid values =3D=3D=3D
> =20
> -qemu-io: Parameter 'lazy-refcounts' expects 'on' or 'off'
> +qemu-io: Parameter 'lazy-refcounts' expects boolean (on/off)
>  qemu-io: cache-size, l2-cache-size and refcount-cache-size may not be se=
t at the same time
>  qemu-io: l2-cache-size may not exceed cache-size
>  qemu-io: refcount-cache-size may not exceed cache-size
> @@ -38,7 +38,7 @@ wrote 512/512 bytes at offset 0
>  ./common.rc: Killed                  ( VALGRIND_QEMU=3D"${VALGRIND_QEMU_=
IO}" _qemu_proc_exec "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS "$=
@" )
>  OK: Dirty bit not set
>  Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
> -qemu-io: Parameter 'lazy-refcounts' expects 'on' or 'off'
> +qemu-io: Parameter 'lazy-refcounts' expects boolean (on/off)
>  qcow2: Marking image as corrupt: Preventing invalid allocation of L2 tab=
le at offset 0; further corruption events will be suppressed
>  write failed: Input/output error
>  *** done
> diff --git a/util/qemu-option.c b/util/qemu-option.c
> index b9f93a7f8b..acefbc23fa 100644
> --- a/util/qemu-option.c
> +++ b/util/qemu-option.c
> @@ -96,21 +96,6 @@ const char *get_opt_value(const char *p, char **value)
>      return offset;
>  }
> =20
> -static bool parse_option_bool(const char *name, const char *value, bool =
*ret,
> -                              Error **errp)
> -{
> -    if (!strcmp(value, "on")) {
> -        *ret =3D 1;
> -    } else if (!strcmp(value, "off")) {
> -        *ret =3D 0;
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
> @@ -363,7 +348,7 @@ static bool qemu_opt_get_bool_helper(QemuOpts *opts, =
const char *name,
>      if (opt =3D=3D NULL) {
>          def_val =3D find_default_by_name(opts, name);
>          if (def_val) {
> -            parse_option_bool(name, def_val, &ret, &error_abort);
> +            qapi_bool_parse(name, def_val, &ret, &error_abort);
>          }
>          return ret;
>      }
> @@ -471,8 +456,7 @@ static bool qemu_opt_parse(QemuOpt *opt, Error **errp=
)
>          /* nothing */
>          return true;
>      case QEMU_OPT_BOOL:
> -        return parse_option_bool(opt->name, opt->str, &opt->value.boolea=
n,
> -                                 errp);
> +        return qapi_bool_parse(opt->name, opt->str, &opt->value.boolean,=
 errp);
>      case QEMU_OPT_NUMBER:
>          return parse_option_number(opt->name, opt->str, &opt->value.uint=
,
>                                     errp);

Error message changes from

    $ qemu-system-x86_64 -smbios type=3D0,uefi=3D
    qemu-system-x86_64: -smbios type=3D0,uefi=3D: Parameter 'uefi' expects =
'on' or 'off'

to

    qemu-system-x86_64: -smbios type=3D0,uefi=3D: Parameter 'uefi' expects =
boolean (on/off)

Not an improvement.

I recommend to refrain from messing with the error message.  "expects
'on' or 'off'" is just fine in all cases.

Bonus: saves us the trouble of updating expected test output.


Tested-by: Markus Armbruster <armbru@redhat.com>


