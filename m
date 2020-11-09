Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC79C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 16:57:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E901020789
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 16:57:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V7V/dn4O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E901020789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kcAUP-0007Ug-VP
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 11:57:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57248)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kcATb-00070e-33
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 11:57:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27874)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kcATY-0003LA-EZ
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 11:57:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604941023;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tz7wesDdESI9Xp5DWYK+XUFRaKUdQGyEF5v91jwYI9o=;
 b=V7V/dn4Oy2zmsGSdTcFKB6IFlUgXZINd7Kk2zai4Cl7lCyhclx+CteLmzGVwIimXVURxU7
 BDRLl3W3Ja+fyi5a3g+ppuP8OaO06LOiIJcw547S73R0fTFf52nSOSQkPFmP5AfvwrvAND
 pp7Ke2J5XD1XJFlAAI9vo7lUYGeJuJE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-491-u92d63bNMIyYiWaQ1gmWOg-1; Mon, 09 Nov 2020 11:57:01 -0500
X-MC-Unique: u92d63bNMIyYiWaQ1gmWOg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 978421891E89
 for <qemu-devel@nongnu.org>; Mon,  9 Nov 2020 16:57:00 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-103.ams2.redhat.com
 [10.36.112.103])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3C0CF55761;
 Mon,  9 Nov 2020 16:57:00 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9C4871132BD6; Mon,  9 Nov 2020 17:56:58 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 4/6] qemu-option: clean up id vs. list->merge_lists
References: <20201109133931.979563-1-pbonzini@redhat.com>
 <20201109133931.979563-5-pbonzini@redhat.com>
Date: Mon, 09 Nov 2020 17:56:58 +0100
In-Reply-To: <20201109133931.979563-5-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Mon, 9 Nov 2020 08:39:29 -0500")
Message-ID: <87wnyu4gf9.fsf@dusky.pond.sub.org>
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

> Forbid ids if the option is intended to be a singleton, as indicated by
> list->merge_lists.

Well, ->merge_lists need not imply singleton.  Perhaps we only ever use
it that way.  Careful review is called for.

>                     This avoids that "./qemu-system-x86_64 -M q35,id=ff"
> uses a "pc" machine type.

Just like any other QemuOptsList, "machine" may have any number of
QemuOpts.  The ones with non-null ID happen to be ignored silently.
Known[*] trap for the unwary.

>                            Instead it errors out.  The affected options
> are "qemu-img reopen -o",

reopen_opts in qemu-io-cmds.c

>                           "qemu-io open -o",

empty_opts in qemu-io.c

>                                              -rtc, -M, -boot, -name,
> -m, -icount, -smp,

qemu_rtc_opts, qemu_machine_opts, qemu_boot_opts, qemu_name_opts,
qemu_mem_opts, qemu_icount_opts, qemu_smp_opts in vl.c

>                    -spice.

qemu_spice_opts in spice-core.c.

Are these all singletons?

There's also machine_opts in qemu-config.c, but that's only to make
query-command-line-options lie backward-compatibly.

>
> qemu_opts_create's fail_if_exists parameter is now unnecessary:
>
> - it is unused if id is NULL
>
> - opts_parse only passes false if reached from qemu_opts_set_defaults,
> in which case this patch enforces that id must be NULL
>
> - other callers that can pass a non-NULL id always set it to true
>
> Assert that it is true in the only case where "fail_if_exists" matters,
> i.e. "id && !lists->merge_lists".  This means that if an id is present,
> duplicates are always forbidden, which was already the status quo.

Sounds like you're specializing the code (which might be good).

> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  util/qemu-option.c | 27 ++++++++++++++-------------
>  1 file changed, 14 insertions(+), 13 deletions(-)
>
> diff --git a/util/qemu-option.c b/util/qemu-option.c
> index c88e159f18..91f4120ce1 100644
> --- a/util/qemu-option.c
> +++ b/util/qemu-option.c
> @@ -619,7 +619,17 @@ QemuOpts *qemu_opts_create(QemuOptsList *list, const char *id,
>  {
>      QemuOpts *opts = NULL;
>  
> -    if (id) {
> +    if (list->merge_lists) {
> +        if (id) {
> +            error_setg(errp, QERR_INVALID_PARAMETER, "id");
> +            return NULL;
> +        }
> +        opts = qemu_opts_find(list, NULL);
> +        if (opts) {
> +            return opts;
> +        }

If lists>merge_lists, you no longer check id_wellformed().  Easy enough
to fix: lift the check before this conditional.

> +    } else if (id) {
> +        assert(fail_if_exists);
>          if (!id_wellformed(id)) {
>              error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "id",
>                         "an identifier");
> @@ -629,17 +639,8 @@ QemuOpts *qemu_opts_create(QemuOptsList *list, const char *id,
>          }
>          opts = qemu_opts_find(list, id);
>          if (opts != NULL) {
> -            if (fail_if_exists && !list->merge_lists) {
> -                error_setg(errp, "Duplicate ID '%s' for %s", id, list->name);
> -                return NULL;
> -            } else {
> -                return opts;
> -            }
> -        }
> -    } else if (list->merge_lists) {
> -        opts = qemu_opts_find(list, NULL);
> -        if (opts) {
> -            return opts;
> +            error_setg(errp, "Duplicate ID '%s' for %s", id, list->name);
> +            return NULL;
>          }
>      }
>      opts = g_malloc0(sizeof(*opts));

Paths through the function before the patch:

    id        fail_if_exists  merge_lists  |  return
    null      don't care      false        |  new opts
    null      don't care      true         |  existing or else new opts
    non-null  false           don't care   |  existing or else new opts
    non-null  true            true         |  existing or else new opts
    non-null  true            false        |  new opts / fail if exist

Too many cases.

After the patch:

    id        fail_if_exists  merge_lists  |  return
    non-null  don't care      true         |  fail
    null      don't care      true         |  existing or else new opts
    non-null  false           false        |  abort
    non-null  true            false        |  new opts / fail if exist
    null      don't care      false        |  new opts

Still too many :)

I'm running out of time for today, and I still need to convince myself
that the changes in behavior are all okay.

> @@ -893,7 +894,7 @@ static QemuOpts *opts_parse(QemuOptsList *list, const char *params,
>       * (if unlikely) future misuse:
>       */
>      assert(!defaults || list->merge_lists);
> -    opts = qemu_opts_create(list, id, !defaults, errp);
> +    opts = qemu_opts_create(list, id, !list->merge_lists, errp);
>      g_free(id);
>      if (opts == NULL) {
>          return NULL;



[*] Known to the QemuOpts cognoscenti, whose number could be
embarrasingly close to one.


