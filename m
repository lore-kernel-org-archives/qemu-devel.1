Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EED3C433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 15:13:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A400B222BA
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 15:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="idDJEPO2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A400B222BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQu4u-0003PG-Iq
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 11:13:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46990)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kQu2y-0002DC-2j
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 11:11:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39377)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kQu2q-0003BP-Fi
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 11:11:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602256255;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JiCUR7LB67iEqFH2BaCaV4QZZjW4MRV+MkqmRZ9EDtI=;
 b=idDJEPO2KUHUAGm5MKa3SFb5NrauvkcYlKciPIrtu3UZW8NWU9HoZAdRC915vNPexlUJeE
 so0iZupUZDSSO1zvporVFkrl2yKFJnL/RaKCtt/QcqA5wxTAHLcJJ0FAXng8LsAc+vO+R2
 /OKAeOTssxnFlHs8tsTqji5YBzASL3g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-05ue9OYINhCrERMU0FhRqg-1; Fri, 09 Oct 2020 11:10:50 -0400
X-MC-Unique: 05ue9OYINhCrERMU0FhRqg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3FF15107B47E;
 Fri,  9 Oct 2020 15:10:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-182.ams2.redhat.com
 [10.36.112.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6F95476655;
 Fri,  9 Oct 2020 15:10:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DAA8E11329AE; Fri,  9 Oct 2020 17:10:46 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v3 1/4] keyval: Parse help options
References: <20201007164903.282198-1-kwolf@redhat.com>
 <20201007164903.282198-2-kwolf@redhat.com>
Date: Fri, 09 Oct 2020 17:10:46 +0200
In-Reply-To: <20201007164903.282198-2-kwolf@redhat.com> (Kevin Wolf's message
 of "Wed, 7 Oct 2020 18:49:00 +0200")
Message-ID: <87v9fjh1u1.fsf@dusky.pond.sub.org>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 02:34:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: armbru@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Kevin Wolf <kwolf@redhat.com> writes:

> This adds a special meaning for 'help' and '?' as options to the keyval
> parser. Instead of being an error (because of a missing value) or a
> value for an implied key, they now request help, which is a new boolean
> ouput of the parser in addition to the QDict.
>
> A new parameter 'p_help' is added to keyval_parse() that contains on
> return whether help was requested. If NULL is passed, requesting help
> results in an error and all other cases work like before.
>
> Turning previous error cases into help is a compatible extension. The
> behaviour potentially changes for implied keys: They could previously
> get 'help' as their value, which is now interpreted as requesting help.
>
> This is not a problem in practice because 'help' and '?' are not a valid
> values for the implied key of any option parsed with keyval_parse():
>
> * audiodev: union Audiodev, implied key "driver" is enum AudiodevDriver,
>   "help" and "?" are not among its values
>
> * display: union DisplayOptions, implied key "type" is enum
>   DisplayType, "help" and "?" are not among its values
>
> * blockdev: union BlockdevOptions, implied key "driver is enum
>   BlockdevDriver, "help" and "?" are not among its values
>
> * export: union BlockExport, implied key "type" is enum BlockExportType,
>   "help" and "?" are not among its values
>
> * monitor: struct MonitorOptions, implied key "mode"is enum MonitorMode,
>   "help" and "?" are not among its values
>
> * nbd-server: struct NbdServerOptions, no implied key.
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/qemu/help_option.h           |   5 +
>  include/qemu/option.h                |   2 +-
>  qapi/qobject-input-visitor.c         |   2 +-
>  storage-daemon/qemu-storage-daemon.c |   2 +-
>  tests/test-keyval.c                  | 205 +++++++++++++++++++--------
>  util/keyval.c                        |  54 ++++++-
>  6 files changed, 198 insertions(+), 72 deletions(-)
>
> diff --git a/include/qemu/help_option.h b/include/qemu/help_option.h
> index 328d2a89fd..952d628b9d 100644
> --- a/include/qemu/help_option.h
> +++ b/include/qemu/help_option.h
> @@ -19,4 +19,9 @@ static inline bool is_help_option(const char *s)
>      return !strcmp(s, "?") || !strcmp(s, "help");
>  }
>  
> +static inline bool is_help_option_n(const char *s, size_t n)
> +{
> +    return !strncmp(s, "?", n) || !strncmp(s, "help", n);
> +}
> +
>  #endif

Unlike is_help_option(), this also recognizes prefixes of "help":

    $ upstream-qemu-storage-daemon --object secret,hel
    secret options:
      data=<string>
      file=<string>
      format=<QCryptoSecretFormat>
      iv=<string>
      keyid=<string>
      loaded=<bool>
    $ upstream-qemu-storage-daemon --object hel
    upstream-qemu-storage-daemon: Parameter 'id' is missing

> diff --git a/include/qemu/option.h b/include/qemu/option.h
> index 05e8a15c73..ac69352e0e 100644
> --- a/include/qemu/option.h
> +++ b/include/qemu/option.h
> @@ -149,6 +149,6 @@ void qemu_opts_free(QemuOptsList *list);
>  QemuOptsList *qemu_opts_append(QemuOptsList *dst, QemuOptsList *list);
>  
>  QDict *keyval_parse(const char *params, const char *implied_key,
> -                    Error **errp);
> +                    bool *help, Error **errp);
>  
>  #endif
> diff --git a/qapi/qobject-input-visitor.c b/qapi/qobject-input-visitor.c
> index f918a05e5f..7b184b50a7 100644
> --- a/qapi/qobject-input-visitor.c
> +++ b/qapi/qobject-input-visitor.c
> @@ -757,7 +757,7 @@ Visitor *qobject_input_visitor_new_str(const char *str,
>          assert(args);
>          v = qobject_input_visitor_new(QOBJECT(args));
>      } else {
> -        args = keyval_parse(str, implied_key, errp);
> +        args = keyval_parse(str, implied_key, NULL, errp);
>          if (!args) {
>              return NULL;
>          }
> diff --git a/storage-daemon/qemu-storage-daemon.c b/storage-daemon/qemu-storage-daemon.c
> index 1ae1cda481..6f0e0cfb36 100644
> --- a/storage-daemon/qemu-storage-daemon.c
> +++ b/storage-daemon/qemu-storage-daemon.c
> @@ -278,7 +278,7 @@ static void process_options(int argc, char *argv[])
>                  }
>                  qemu_opts_del(opts);
>  
> -                args = keyval_parse(optarg, "qom-type", &error_fatal);
> +                args = keyval_parse(optarg, "qom-type", NULL, &error_fatal);
>                  user_creatable_add_dict(args, true, &error_fatal);
>                  qobject_unref(args);
>                  break;
> diff --git a/tests/test-keyval.c b/tests/test-keyval.c
> index e331a84149..b1433054de 100644
> --- a/tests/test-keyval.c
> +++ b/tests/test-keyval.c
> @@ -27,27 +27,28 @@ static void test_keyval_parse(void)
>      QDict *qdict, *sub_qdict;
>      char long_key[129];
>      char *params;
> +    bool help;
>  
>      /* Nothing */
> -    qdict = keyval_parse("", NULL, &error_abort);
> +    qdict = keyval_parse("", NULL, NULL, &error_abort);
>      g_assert_cmpuint(qdict_size(qdict), ==, 0);
>      qobject_unref(qdict);
>  
>      /* Empty key (qemu_opts_parse() accepts this) */
> -    qdict = keyval_parse("=val", NULL, &err);
> +    qdict = keyval_parse("=val", NULL, NULL, &err);
>      error_free_or_abort(&err);
>      g_assert(!qdict);
>  
>      /* Empty key fragment */
> -    qdict = keyval_parse(".", NULL, &err);
> +    qdict = keyval_parse(".", NULL, NULL, &err);
>      error_free_or_abort(&err);
>      g_assert(!qdict);
> -    qdict = keyval_parse("key.", NULL, &err);
> +    qdict = keyval_parse("key.", NULL, NULL, &err);
>      error_free_or_abort(&err);
>      g_assert(!qdict);
>  
>      /* Invalid non-empty key (qemu_opts_parse() doesn't care) */
> -    qdict = keyval_parse("7up=val", NULL, &err);
> +    qdict = keyval_parse("7up=val", NULL, NULL, &err);
>      error_free_or_abort(&err);
>      g_assert(!qdict);
>  
> @@ -56,25 +57,25 @@ static void test_keyval_parse(void)
>      long_key[127] = 'z';
>      long_key[128] = 0;
>      params = g_strdup_printf("k.%s=v", long_key);
> -    qdict = keyval_parse(params + 2, NULL, &err);
> +    qdict = keyval_parse(params + 2, NULL, NULL, &err);
>      error_free_or_abort(&err);
>      g_assert(!qdict);
>  
>      /* Overlong key fragment */
> -    qdict = keyval_parse(params, NULL, &err);
> +    qdict = keyval_parse(params, NULL, NULL, &err);
>      error_free_or_abort(&err);
>      g_assert(!qdict);
>      g_free(params);
>  
>      /* Long key (qemu_opts_parse() accepts and truncates silently) */
>      params = g_strdup_printf("k.%s=v", long_key + 1);
> -    qdict = keyval_parse(params + 2, NULL, &error_abort);
> +    qdict = keyval_parse(params + 2, NULL, NULL, &error_abort);
>      g_assert_cmpuint(qdict_size(qdict), ==, 1);
>      g_assert_cmpstr(qdict_get_try_str(qdict, long_key + 1), ==, "v");
>      qobject_unref(qdict);
>  
>      /* Long key fragment */
> -    qdict = keyval_parse(params, NULL, &error_abort);
> +    qdict = keyval_parse(params, NULL, NULL, &error_abort);
>      g_assert_cmpuint(qdict_size(qdict), ==, 1);
>      sub_qdict = qdict_get_qdict(qdict, "k");
>      g_assert(sub_qdict);
> @@ -84,25 +85,25 @@ static void test_keyval_parse(void)
>      g_free(params);
>  
>      /* Crap after valid key */
> -    qdict = keyval_parse("key[0]=val", NULL, &err);
> +    qdict = keyval_parse("key[0]=val", NULL, NULL, &err);
>      error_free_or_abort(&err);
>      g_assert(!qdict);
>  
>      /* Multiple keys, last one wins */
> -    qdict = keyval_parse("a=1,b=2,,x,a=3", NULL, &error_abort);
> +    qdict = keyval_parse("a=1,b=2,,x,a=3", NULL, NULL, &error_abort);
>      g_assert_cmpuint(qdict_size(qdict), ==, 2);
>      g_assert_cmpstr(qdict_get_try_str(qdict, "a"), ==, "3");
>      g_assert_cmpstr(qdict_get_try_str(qdict, "b"), ==, "2,x");
>      qobject_unref(qdict);
>  
>      /* Even when it doesn't in qemu_opts_parse() */
> -    qdict = keyval_parse("id=foo,id=bar", NULL, &error_abort);
> +    qdict = keyval_parse("id=foo,id=bar", NULL, NULL, &error_abort);
>      g_assert_cmpuint(qdict_size(qdict), ==, 1);
>      g_assert_cmpstr(qdict_get_try_str(qdict, "id"), ==, "bar");
>      qobject_unref(qdict);
>  
>      /* Dotted keys */
> -    qdict = keyval_parse("a.b.c=1,a.b.c=2,d=3", NULL, &error_abort);
> +    qdict = keyval_parse("a.b.c=1,a.b.c=2,d=3", NULL, NULL, &error_abort);
>      g_assert_cmpuint(qdict_size(qdict), ==, 2);
>      sub_qdict = qdict_get_qdict(qdict, "a");
>      g_assert(sub_qdict);
> @@ -115,48 +116,48 @@ static void test_keyval_parse(void)
>      qobject_unref(qdict);
>  
>      /* Inconsistent dotted keys */
> -    qdict = keyval_parse("a.b=1,a=2", NULL, &err);
> +    qdict = keyval_parse("a.b=1,a=2", NULL, NULL, &err);
>      error_free_or_abort(&err);
>      g_assert(!qdict);
> -    qdict = keyval_parse("a.b=1,a.b.c=2", NULL, &err);
> +    qdict = keyval_parse("a.b=1,a.b.c=2", NULL, NULL, &err);
>      error_free_or_abort(&err);
>      g_assert(!qdict);
>  
>      /* Trailing comma is ignored */
> -    qdict = keyval_parse("x=y,", NULL, &error_abort);
> +    qdict = keyval_parse("x=y,", NULL, NULL, &error_abort);
>      g_assert_cmpuint(qdict_size(qdict), ==, 1);
>      g_assert_cmpstr(qdict_get_try_str(qdict, "x"), ==, "y");
>      qobject_unref(qdict);
>  
>      /* Except when it isn't */
> -    qdict = keyval_parse(",", NULL, &err);
> +    qdict = keyval_parse(",", NULL, NULL, &err);
>      error_free_or_abort(&err);
>      g_assert(!qdict);
>  
>      /* Value containing ,id= not misinterpreted as qemu_opts_parse() does */
> -    qdict = keyval_parse("x=,,id=bar", NULL, &error_abort);
> +    qdict = keyval_parse("x=,,id=bar", NULL, NULL, &error_abort);
>      g_assert_cmpuint(qdict_size(qdict), ==, 1);
>      g_assert_cmpstr(qdict_get_try_str(qdict, "x"), ==, ",id=bar");
>      qobject_unref(qdict);
>  
>      /* Anti-social ID is left to caller (qemu_opts_parse() rejects it) */
> -    qdict = keyval_parse("id=666", NULL, &error_abort);
> +    qdict = keyval_parse("id=666", NULL, NULL, &error_abort);
>      g_assert_cmpuint(qdict_size(qdict), ==, 1);
>      g_assert_cmpstr(qdict_get_try_str(qdict, "id"), ==, "666");
>      qobject_unref(qdict);
>  
>      /* Implied value not supported (unlike qemu_opts_parse()) */
> -    qdict = keyval_parse("an,noaus,noaus=", NULL, &err);
> +    qdict = keyval_parse("an,noaus,noaus=", NULL, NULL, &err);
>      error_free_or_abort(&err);
>      g_assert(!qdict);
>  
>      /* Implied value, key "no" (qemu_opts_parse(): negated empty key) */
> -    qdict = keyval_parse("no", NULL, &err);
> +    qdict = keyval_parse("no", NULL, NULL, &err);
>      error_free_or_abort(&err);
>      g_assert(!qdict);
>  
>      /* Implied key */
> -    qdict = keyval_parse("an,aus=off,noaus=", "implied", &error_abort);
> +    qdict = keyval_parse("an,aus=off,noaus=", "implied", NULL, &error_abort);
>      g_assert_cmpuint(qdict_size(qdict), ==, 3);
>      g_assert_cmpstr(qdict_get_try_str(qdict, "implied"), ==, "an");
>      g_assert_cmpstr(qdict_get_try_str(qdict, "aus"), ==, "off");
> @@ -164,7 +165,7 @@ static void test_keyval_parse(void)
>      qobject_unref(qdict);
>  
>      /* Implied dotted key */
> -    qdict = keyval_parse("val", "eins.zwei", &error_abort);
> +    qdict = keyval_parse("val", "eins.zwei", NULL, &error_abort);
>      g_assert_cmpuint(qdict_size(qdict), ==, 1);
>      sub_qdict = qdict_get_qdict(qdict, "eins");
>      g_assert(sub_qdict);
> @@ -173,19 +174,100 @@ static void test_keyval_parse(void)
>      qobject_unref(qdict);
>  
>      /* Implied key with empty value (qemu_opts_parse() accepts this) */
> -    qdict = keyval_parse(",", "implied", &err);
> +    qdict = keyval_parse(",", "implied", NULL, &err);
>      error_free_or_abort(&err);
>      g_assert(!qdict);
>  
>      /* Likewise (qemu_opts_parse(): implied key with comma value) */
> -    qdict = keyval_parse(",,,a=1", "implied", &err);
> +    qdict = keyval_parse(",,,a=1", "implied", NULL, &err);
>      error_free_or_abort(&err);
>      g_assert(!qdict);
>  
>      /* Empty key is not an implied key */
> -    qdict = keyval_parse("=val", "implied", &err);
> +    qdict = keyval_parse("=val", "implied", NULL, &err);
>      error_free_or_abort(&err);
>      g_assert(!qdict);
> +
> +    /* "help" is only a help option if it has no value */
> +    qdict = keyval_parse("help=on", NULL, &help, &error_abort);
> +    g_assert_cmpuint(qdict_size(qdict), ==, 1);
> +    g_assert_cmpstr(qdict_get_try_str(qdict, "help"), ==, "on");
> +    g_assert_false(help);
> +    qobject_unref(qdict);
> +
> +    /* Double comma after "help" in an implied key is not a help option */
> +    qdict = keyval_parse("help,,abc", "implied", &help, &error_abort);
> +    g_assert_cmpuint(qdict_size(qdict), ==, 1);
> +    g_assert_cmpstr(qdict_get_try_str(qdict, "implied"), ==, "help,abc");
> +    g_assert_false(help);
> +    qobject_unref(qdict);
> +
> +    /* Without implied key and without value, it's an error */
> +    qdict = keyval_parse("help,,abc", NULL, &help, &err);
> +    error_free_or_abort(&err);
> +    g_assert(!qdict);
> +
> +    /* "help" as the only option */
> +    qdict = keyval_parse("help", NULL, &help, &error_abort);
> +    g_assert_cmpuint(qdict_size(qdict), ==, 0);
> +    g_assert_true(help);

No clearer than g_assert(help) (but it shows off knowledge of GLib).

> +    qobject_unref(qdict);
> +
> +    /* "help" is an error when passing NULL for p_help */
> +    qdict = keyval_parse("help", NULL, NULL, &err);
> +    error_free_or_abort(&err);
> +    g_assert(!qdict);
> +
> +    /* "help" as the first part of the key */
> +    qdict = keyval_parse("help.abc", NULL, &help, &err);
> +    error_free_or_abort(&err);
> +    g_assert(!qdict);
> +
> +    /* "help" as the last part of the key */
> +    qdict = keyval_parse("abc.help", NULL, &help, &err);
> +    error_free_or_abort(&err);
> +    g_assert(!qdict);
> +
> +    /* "help" is not a value for the implied key */
> +    qdict = keyval_parse("help", "implied", &help, &error_abort);
> +    g_assert_cmpuint(qdict_size(qdict), ==, 0);
> +    g_assert_true(help);
> +    qobject_unref(qdict);
> +
> +    /* "help" is not a value for the implied key even with NULL for p_help */
> +    qdict = keyval_parse("help", "implied", NULL, &err);
> +    error_free_or_abort(&err);
> +    g_assert(!qdict);
> +
> +    /* "help.abc" is a value for the implied key */
> +    qdict = keyval_parse("help.abc", "implied", &help, &err);
> +    g_assert_cmpuint(qdict_size(qdict), ==, 1);
> +    g_assert_cmpstr(qdict_get_try_str(qdict, "implied"), ==, "help.abc");
> +    g_assert_false(help);

No clearer than g_assert(!help).

> +    qobject_unref(qdict);
> +
> +    /* "abc.help" is a value for the implied key */
> +    qdict = keyval_parse("abc.help", "implied", &help, &err);
> +    g_assert_cmpuint(qdict_size(qdict), ==, 1);
> +    g_assert_cmpstr(qdict_get_try_str(qdict, "implied"), ==, "abc.help");
> +    g_assert_false(help);
> +    qobject_unref(qdict);
> +
> +    /* Other keys before and after help are still parsed normally */
> +    qdict = keyval_parse("number=42,help,foo=bar", NULL, &help, &error_abort);
> +    g_assert_cmpuint(qdict_size(qdict), ==, 2);
> +    g_assert_cmpstr(qdict_get_try_str(qdict, "number"), ==, "42");
> +    g_assert_cmpstr(qdict_get_try_str(qdict, "foo"), ==, "bar");
> +    g_assert_true(help);
> +    qobject_unref(qdict);
> +
> +    /* ...even with an implied key */
> +    qdict = keyval_parse("val,help,foo=bar", "implied", &help, &error_abort);
> +    g_assert_cmpuint(qdict_size(qdict), ==, 2);
> +    g_assert_cmpstr(qdict_get_try_str(qdict, "implied"), ==, "val");
> +    g_assert_cmpstr(qdict_get_try_str(qdict, "foo"), ==, "bar");
> +    g_assert_true(help);
> +    qobject_unref(qdict);
>  }
>  
>  static void check_list012(QList *qlist)
> @@ -210,26 +292,26 @@ static void test_keyval_parse_list(void)
>      QDict *qdict, *sub_qdict;
>  
>      /* Root can't be a list */
> -    qdict = keyval_parse("0=1", NULL, &err);
> +    qdict = keyval_parse("0=1", NULL, NULL, &err);
>      error_free_or_abort(&err);
>      g_assert(!qdict);
>  
>      /* List elements need not be in order */
> -    qdict = keyval_parse("list.0=null,list.2=zwei,list.1=eins",
> -                         NULL, &error_abort);
> +    qdict = keyval_parse("list.0=null,list.2=zwei,list.1=eins", NULL, NULL,
> +                         &error_abort);
>      g_assert_cmpint(qdict_size(qdict), ==, 1);
>      check_list012(qdict_get_qlist(qdict, "list"));
>      qobject_unref(qdict);
>  
>      /* Multiple indexes, last one wins */
>      qdict = keyval_parse("list.1=goner,list.0=null,list.01=eins,list.2=zwei",
> -                         NULL, &error_abort);
> +                         NULL, NULL, &error_abort);
>      g_assert_cmpint(qdict_size(qdict), ==, 1);
>      check_list012(qdict_get_qlist(qdict, "list"));
>      qobject_unref(qdict);
>  
>      /* List at deeper nesting */
> -    qdict = keyval_parse("a.list.1=eins,a.list.00=null,a.list.2=zwei",
> +    qdict = keyval_parse("a.list.1=eins,a.list.00=null,a.list.2=zwei", NULL,
>                           NULL, &error_abort);
>      g_assert_cmpint(qdict_size(qdict), ==, 1);
>      sub_qdict = qdict_get_qdict(qdict, "a");
> @@ -238,18 +320,19 @@ static void test_keyval_parse_list(void)
>      qobject_unref(qdict);
>  
>      /* Inconsistent dotted keys: both list and dictionary */
> -    qdict = keyval_parse("a.b.c=1,a.b.0=2", NULL, &err);
> +    qdict = keyval_parse("a.b.c=1,a.b.0=2", NULL, NULL, &err);
>      error_free_or_abort(&err);
>      g_assert(!qdict);
> -    qdict = keyval_parse("a.0.c=1,a.b.c=2", NULL, &err);
> +    qdict = keyval_parse("a.0.c=1,a.b.c=2", NULL, NULL, &err);
>      error_free_or_abort(&err);
>      g_assert(!qdict);
>  
>      /* Missing list indexes */
> -    qdict = keyval_parse("list.1=lonely", NULL, &err);
> +    qdict = keyval_parse("list.1=lonely", NULL, NULL, &err);
>      error_free_or_abort(&err);
>      g_assert(!qdict);
> -    qdict = keyval_parse("list.0=null,list.2=eins,list.02=zwei", NULL, &err);
> +    qdict = keyval_parse("list.0=null,list.2=eins,list.02=zwei", NULL, NULL,
> +                         &err);
>      error_free_or_abort(&err);
>      g_assert(!qdict);
>  }
> @@ -261,7 +344,7 @@ static void test_keyval_visit_bool(void)
>      QDict *qdict;
>      bool b;
>  
> -    qdict = keyval_parse("bool1=on,bool2=off", NULL, &error_abort);
> +    qdict = keyval_parse("bool1=on,bool2=off", NULL, NULL, &error_abort);
>      v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
>      qobject_unref(qdict);
>      visit_start_struct(v, NULL, NULL, 0, &error_abort);
> @@ -273,7 +356,7 @@ static void test_keyval_visit_bool(void)
>      visit_end_struct(v, NULL);
>      visit_free(v);
>  
> -    qdict = keyval_parse("bool1=offer", NULL, &error_abort);
> +    qdict = keyval_parse("bool1=offer", NULL, NULL, &error_abort);
>      v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
>      qobject_unref(qdict);
>      visit_start_struct(v, NULL, NULL, 0, &error_abort);
> @@ -291,7 +374,7 @@ static void test_keyval_visit_number(void)
>      uint64_t u;
>  
>      /* Lower limit zero */
> -    qdict = keyval_parse("number1=0", NULL, &error_abort);
> +    qdict = keyval_parse("number1=0", NULL, NULL, &error_abort);
>      v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
>      qobject_unref(qdict);
>      visit_start_struct(v, NULL, NULL, 0, &error_abort);
> @@ -302,7 +385,7 @@ static void test_keyval_visit_number(void)
>      visit_free(v);
>  
>      /* Upper limit 2^64-1 */
> -    qdict = keyval_parse("number1=18446744073709551615,number2=-1",
> +    qdict = keyval_parse("number1=18446744073709551615,number2=-1", NULL,
>                           NULL, &error_abort);
>      v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
>      qobject_unref(qdict);
> @@ -316,8 +399,8 @@ static void test_keyval_visit_number(void)
>      visit_free(v);
>  
>      /* Above upper limit */
> -    qdict = keyval_parse("number1=18446744073709551616",
> -                         NULL, &error_abort);
> +    qdict = keyval_parse("number1=18446744073709551616", NULL, NULL,
> +                         &error_abort);
>      v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
>      qobject_unref(qdict);
>      visit_start_struct(v, NULL, NULL, 0, &error_abort);
> @@ -327,8 +410,8 @@ static void test_keyval_visit_number(void)
>      visit_free(v);
>  
>      /* Below lower limit */
> -    qdict = keyval_parse("number1=-18446744073709551616",
> -                         NULL, &error_abort);
> +    qdict = keyval_parse("number1=-18446744073709551616", NULL, NULL,
> +                         &error_abort);
>      v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
>      qobject_unref(qdict);
>      visit_start_struct(v, NULL, NULL, 0, &error_abort);
> @@ -338,8 +421,7 @@ static void test_keyval_visit_number(void)
>      visit_free(v);
>  
>      /* Hex and octal */
> -    qdict = keyval_parse("number1=0x2a,number2=052",
> -                         NULL, &error_abort);
> +    qdict = keyval_parse("number1=0x2a,number2=052", NULL, NULL, &error_abort);
>      v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
>      qobject_unref(qdict);
>      visit_start_struct(v, NULL, NULL, 0, &error_abort);
> @@ -352,8 +434,7 @@ static void test_keyval_visit_number(void)
>      visit_free(v);
>  
>      /* Trailing crap */
> -    qdict = keyval_parse("number1=3.14,number2=08",
> -                         NULL, &error_abort);
> +    qdict = keyval_parse("number1=3.14,number2=08", NULL, NULL, &error_abort);
>      v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
>      qobject_unref(qdict);
>      visit_start_struct(v, NULL, NULL, 0, &error_abort);
> @@ -373,7 +454,7 @@ static void test_keyval_visit_size(void)
>      uint64_t sz;
>  
>      /* Lower limit zero */
> -    qdict = keyval_parse("sz1=0", NULL, &error_abort);
> +    qdict = keyval_parse("sz1=0", NULL, NULL, &error_abort);
>      v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
>      qobject_unref(qdict);
>      visit_start_struct(v, NULL, NULL, 0, &error_abort);
> @@ -389,7 +470,7 @@ static void test_keyval_visit_size(void)
>      qdict = keyval_parse("sz1=9007199254740991,"
>                           "sz2=9007199254740992,"
>                           "sz3=9007199254740993",
> -                         NULL, &error_abort);
> +                         NULL, NULL, &error_abort);
>      v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
>      qobject_unref(qdict);
>      visit_start_struct(v, NULL, NULL, 0, &error_abort);
> @@ -406,7 +487,7 @@ static void test_keyval_visit_size(void)
>      /* Close to signed upper limit 0x7ffffffffffffc00 (53 msbs set) */
>      qdict = keyval_parse("sz1=9223372036854774784," /* 7ffffffffffffc00 */
>                           "sz2=9223372036854775295", /* 7ffffffffffffdff */
> -                         NULL, &error_abort);
> +                         NULL, NULL, &error_abort);
>      v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
>      qobject_unref(qdict);
>      visit_start_struct(v, NULL, NULL, 0, &error_abort);
> @@ -421,7 +502,7 @@ static void test_keyval_visit_size(void)
>      /* Close to actual upper limit 0xfffffffffffff800 (53 msbs set) */
>      qdict = keyval_parse("sz1=18446744073709549568," /* fffffffffffff800 */
>                           "sz2=18446744073709550591", /* fffffffffffffbff */
> -                         NULL, &error_abort);
> +                         NULL, NULL, &error_abort);
>      v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
>      qobject_unref(qdict);
>      visit_start_struct(v, NULL, NULL, 0, &error_abort);
> @@ -436,7 +517,7 @@ static void test_keyval_visit_size(void)
>      /* Beyond limits */
>      qdict = keyval_parse("sz1=-1,"
>                           "sz2=18446744073709550592", /* fffffffffffffc00 */
> -                         NULL, &error_abort);
> +                         NULL, NULL, &error_abort);
>      v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
>      qobject_unref(qdict);
>      visit_start_struct(v, NULL, NULL, 0, &error_abort);
> @@ -449,7 +530,7 @@ static void test_keyval_visit_size(void)
>  
>      /* Suffixes */
>      qdict = keyval_parse("sz1=8b,sz2=1.5k,sz3=2M,sz4=0.1G,sz5=16777215T",
> -                         NULL, &error_abort);
> +                         NULL, NULL, &error_abort);
>      v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
>      qobject_unref(qdict);
>      visit_start_struct(v, NULL, NULL, 0, &error_abort);
> @@ -468,7 +549,7 @@ static void test_keyval_visit_size(void)
>      visit_free(v);
>  
>      /* Beyond limit with suffix */
> -    qdict = keyval_parse("sz1=16777216T", NULL, &error_abort);
> +    qdict = keyval_parse("sz1=16777216T", NULL, NULL, &error_abort);
>      v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
>      qobject_unref(qdict);
>      visit_start_struct(v, NULL, NULL, 0, &error_abort);
> @@ -478,7 +559,7 @@ static void test_keyval_visit_size(void)
>      visit_free(v);
>  
>      /* Trailing crap */
> -    qdict = keyval_parse("sz1=0Z,sz2=16Gi", NULL, &error_abort);
> +    qdict = keyval_parse("sz1=0Z,sz2=16Gi", NULL, NULL, &error_abort);
>      v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
>      qobject_unref(qdict);
>      visit_start_struct(v, NULL, NULL, 0, &error_abort);
> @@ -497,7 +578,7 @@ static void test_keyval_visit_dict(void)
>      QDict *qdict;
>      int64_t i;
>  
> -    qdict = keyval_parse("a.b.c=1,a.b.c=2,d=3", NULL, &error_abort);
> +    qdict = keyval_parse("a.b.c=1,a.b.c=2,d=3", NULL, NULL, &error_abort);
>      v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
>      qobject_unref(qdict);
>      visit_start_struct(v, NULL, NULL, 0, &error_abort);
> @@ -515,7 +596,7 @@ static void test_keyval_visit_dict(void)
>      visit_end_struct(v, NULL);
>      visit_free(v);
>  
> -    qdict = keyval_parse("a.b=", NULL, &error_abort);
> +    qdict = keyval_parse("a.b=", NULL, NULL, &error_abort);
>      v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
>      qobject_unref(qdict);
>      visit_start_struct(v, NULL, NULL, 0, &error_abort);
> @@ -537,7 +618,7 @@ static void test_keyval_visit_list(void)
>      QDict *qdict;
>      char *s;
>  
> -    qdict = keyval_parse("a.0=,a.1=I,a.2.0=II", NULL, &error_abort);
> +    qdict = keyval_parse("a.0=,a.1=I,a.2.0=II", NULL, NULL, &error_abort);
>      /* TODO empty list */
>      v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
>      qobject_unref(qdict);
> @@ -561,7 +642,7 @@ static void test_keyval_visit_list(void)
>      visit_end_struct(v, NULL);
>      visit_free(v);
>  
> -    qdict = keyval_parse("a.0=,b.0.0=head", NULL, &error_abort);
> +    qdict = keyval_parse("a.0=,b.0.0=head", NULL, NULL, &error_abort);
>      v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
>      qobject_unref(qdict);
>      visit_start_struct(v, NULL, NULL, 0, &error_abort);
> @@ -590,7 +671,7 @@ static void test_keyval_visit_optional(void)
>      bool present;
>      int64_t i;
>  
> -    qdict = keyval_parse("a.b=1", NULL, &error_abort);
> +    qdict = keyval_parse("a.b=1", NULL, NULL, &error_abort);
>      v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
>      qobject_unref(qdict);
>      visit_start_struct(v, NULL, NULL, 0, &error_abort);
> @@ -626,7 +707,7 @@ static void test_keyval_visit_alternate(void)
>       * the string variant if there is one, else an error.
>       * TODO make it work for unambiguous cases like AltEnumBool below
>       */
> -    qdict = keyval_parse("a=1,b=2,c=on", NULL, &error_abort);
> +    qdict = keyval_parse("a=1,b=2,c=on", NULL, NULL, &error_abort);
>      v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
>      qobject_unref(qdict);
>      visit_start_struct(v, NULL, NULL, 0, &error_abort);
> @@ -650,7 +731,7 @@ static void test_keyval_visit_any(void)
>      QList *qlist;
>      QString *qstr;
>  
> -    qdict = keyval_parse("a.0=null,a.1=1", NULL, &error_abort);
> +    qdict = keyval_parse("a.0=null,a.1=1", NULL, NULL, &error_abort);
>      v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
>      qobject_unref(qdict);
>      visit_start_struct(v, NULL, NULL, 0, &error_abort);
> diff --git a/util/keyval.c b/util/keyval.c
> index 13def4af54..5929c9dba2 100644
> --- a/util/keyval.c
> +++ b/util/keyval.c
> @@ -14,7 +14,7 @@
>   * KEY=VALUE,... syntax:
>   *
>   *   key-vals     = [ key-val { ',' key-val } [ ',' ] ]
> - *   key-val      = key '=' val
> + *   key-val      = 'help' | key '=' val
>   *   key          = key-fragment { '.' key-fragment }
>   *   key-fragment = / [^=,.]* /
>   *   val          = { / [^,]* / | ',,' }
> @@ -73,10 +73,14 @@
>   *
>   * Additional syntax for use with an implied key:
>   *
> - *   key-vals-ik  = val-no-key [ ',' key-vals ]
> + *   key-vals-ik  = 'help' | val-no-key [ ',' key-vals ]
>   *   val-no-key   = / [^=,]* /
>   *
>   * where no-key is syntactic sugar for implied-key=val-no-key.
> + *
> + * 'help' for key-val or key-vals-ik is not interpreted as part of the
> + * JSON object, but instead requests help, which is a separate boolean
> + * output of the parser.
>   */
>  
>  #include "qemu/osdep.h"
> @@ -85,6 +89,7 @@
>  #include "qapi/qmp/qlist.h"
>  #include "qapi/qmp/qstring.h"
>  #include "qemu/cutils.h"
> +#include "qemu/help_option.h"
>  #include "qemu/option.h"
>  
>  /*
> @@ -166,7 +171,7 @@ static QObject *keyval_parse_put(QDict *cur,
>   * On failure, return NULL.
>   */

Contract needs an update.

>  static const char *keyval_parse_one(QDict *qdict, const char *params,
> -                                    const char *implied_key,
> +                                    const char *implied_key, bool *help,
>                                      Error **errp)
>  {
>      const char *key, *key_end, *s, *end;
> @@ -238,13 +243,20 @@ static const char *keyval_parse_one(QDict *qdict, const char *params,
>      if (key == implied_key) {
>          assert(!*s);
>          s = params;
> +    } else if (*s == '=') {
> +        s++;
>      } else {
> -        if (*s != '=') {
> +        if (is_help_option_n(key, s - key)) {
> +            *help = true;
> +            if (*s) {
> +                s++;
> +            }
> +            return s;
> +        } else {
>              error_setg(errp, "Expected '=' after parameter '%.*s'",
>                         (int)(s - key), key);
>              return NULL;
>          }
> -        s++;
>      }
>  
>      val = qstring_new();
> @@ -260,6 +272,15 @@ static const char *keyval_parse_one(QDict *qdict, const char *params,
>          qstring_append_chr(val, *s++);
>      }
>  
> +    if (key == implied_key) {
> +        const char *str_val = qstring_get_str(val);
> +        if (is_help_option(str_val)) {
> +            *help = true;
> +            qobject_unref(val);
> +            return s;
> +        }
> +    }
> +
>      if (!keyval_parse_put(cur, key_in_cur, val, key, key_end, errp)) {
>          return NULL;
>      }

The patch is minimal, and I believe works except for one corner case
(search for Bug: below).  But it makes the code even more subtle than it
already is.

Code before the patch:

       key = params;
       len = strcspn(params, "=,");

Both key and val-no-key are / [^=,]* /.  The former is followed by '=',
the latter is not.  This lets us distinguish the two.

       if (implied_key && len && key[len] != '=') {
           /* Desugar implied key */
           key = implied_key;
           len = strlen(implied_key);
       }
       key_end = key + len;

@key, @key_end now bracket what must be the key.

       [parse from @key to @key_end...]

       if (key == implied_key) {
           assert(!*s);
           s = params;

We're parsing val-no-key, and @s points to it.

       } else {
           if (*s != '=') {
               error_setg(errp, "Expected '=' after parameter '%.*s'",
                          (int)(s - key), key);
               return NULL;
           }
           s++;

We're parsing key '=' val, and @s points to val.

       }

       [parse from @s to unescaped ',' or to '\0'... into @val]

       if (!keyval_parse_put(cur, key_in_cur, val, key, key_end, errp)) {
           return NULL;
       }
       return s;

The patch adds parsing of help.  How it is parsed depends on
@implied_key.

Without implied_key:

       key = params;
       len = strcspn(params, "=,");
       if (implied_key && len && key[len] != '=') {
           [not reached...]
       }
       key_end = key + len;

@key, @key_end now bracket what must be the key or help.

       [parse from @key to @key_end...]

Bug: parsing help as if it was a key works for 'help' (which parses okay
as key), but not for '?' (which doesn't).  Reproducer:

    $ upstream-qemu-storage-daemon --nbd-server help
    upstream-qemu-storage-daemon: Help is not available for this option
    $ upstream-qemu-storage-daemon --nbd-server '?'
    upstream-qemu-storage-daemon: Invalid parameter '?'

       if (key == implied_key) {
           [not reached...]
       } else if (*s == '=') {
           s++;

We're parsing key '=' val, and @s points to val.

       } else {

We're parsing help (if we survived parsing help as key).

           if (is_help_option_n(key, s - key)) {
               *help = true;
               if (*s) {
                   s++;
               }
               return s;
           } else {
               error_setg(errp, "Expected '=' after parameter '%.*s'",
                          (int)(s - key), key);
               return NULL;
           }
       }

       [parse from @s to unescaped ',' or to '\0'... into @val]

       if (key == implied_key) {
           [not reached...]
       }

       if (!keyval_parse_put(cur, key_in_cur, val, key, key_end, errp)) {
           return NULL;
       }
       return s;

With implied_key:

       key = params;
       len = strcspn(params, "=,");
       if (implied_key && len && key[len] != '=') {
           /* Desugar implied key */

help takes this branch, too.

           key = implied_key;
           len = strlen(implied_key);
       }
       key_end = key + len;

@key, @key_end now bracket what must be the key.  If we're looking at
help, it's the implied key, and it'll be ignored, but ...

       [parse from @key to @key_end...]

... we parse it all the same.  No harm in doing that.

       if (key == implied_key) {
           assert(!*s);
           s = params;

We're parsing val-no-key | help, and @s points to it.

       } else if (*s == '=') {
           s++;

We're parsing key '=' val, and @s points to val.

       } else {

Nothing left to parse; we're going to error no matter what.

           if (is_help_option_n(key, s - key)) {
               [not reached...]
           } else {
               error_setg(errp, "Expected '=' after parameter '%.*s'",
                          (int)(s - key), key);
               return NULL;
           }
       }

       [parse from @s to unescaped ',' or to '\0'... into @val]

       if (key == implied_key) {

We parsed val-no-key | help.

           const char *str_val = qstring_get_str(val);
           if (is_help_option(str_val)) {

It's help.

               *help = true;
               qobject_unref(val);
               return s;
           }
       }

       if (!keyval_parse_put(cur, key_in_cur, val, key, key_end, errp)) {
           return NULL;
       }
       return s;

Your v1 was much simpler.  Eric asked "what if the user typed "help,,"
to get "help," as the value of the implied key?"  Good question, but the
correct answer is that the value of an implied key cannot contain ',',
which means v1 wasn't actually flawed.

I'd like to tighten up grammar, code, and tests in a patch that goes
first.  Then I adjust this one, and post the whole as v4.  Okay?

[...]


