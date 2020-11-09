Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F57C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 15:28:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68407206C0
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 15:28:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YQm5wK3h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68407206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc96B-0000hS-Ey
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 10:28:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59500)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kc95T-0000EZ-2s
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 10:28:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55188)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kc95P-0004ky-9L
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 10:28:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604935680;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8ZUB/VviRwJOJdOTLHNTPzuXwwo4o3y4jieRm4Pr98k=;
 b=YQm5wK3h1CB1pP1ofqu4hrJ/IRRPA0CN/EzmCrlXZaHFS8N382kcc9bsxsmEkmdpxQJmqI
 aaY7/ADP+9cf72vyBj6EIp5zHbnB9gMALGilGve9CmUTxoqFU55t/wOBfuewdOBHK5YwRr
 JOWgaR/l5fLzoqJTKbMui0Hoio4BVCs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-57-7NFbBBKBMeqyWKooHr1STQ-1; Mon, 09 Nov 2020 10:27:58 -0500
X-MC-Unique: 7NFbBBKBMeqyWKooHr1STQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CA90A18FE863
 for <qemu-devel@nongnu.org>; Mon,  9 Nov 2020 15:27:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-103.ams2.redhat.com
 [10.36.112.103])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6AE371001901;
 Mon,  9 Nov 2020 15:27:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D77D11132BD6; Mon,  9 Nov 2020 16:27:55 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 2/6] qemu-option: pass QemuOptsList to opts_accepts_any
References: <20201109133931.979563-1-pbonzini@redhat.com>
 <20201109133931.979563-3-pbonzini@redhat.com>
Date: Mon, 09 Nov 2020 16:27:55 +0100
In-Reply-To: <20201109133931.979563-3-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Mon, 9 Nov 2020 08:39:27 -0500")
Message-ID: <871rh27dok.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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

> A QemuOptsList can be of one of two kinds: either it is pre-validated, or
> it accepts any key and validation happens somewhere else (typically in
> a Visitor or against a list of QOM properties).

For a value of "typically" :)

>                                                  opts_accepts_any
> returns true if a QemuOpts instance was created from a QemuOptsList of
> the latter kind, but there is no function to do the check on a QemuOptsList.
>
> We will need it in the next patch; since almost all callers of
> opts_accepts_any use opts->list anyway,

I'm not sure I get the "since" part.  Peeking ahead...  you're lifting
the first -> into the callers, which is obviously safe.  I *guess*
you're trying to say it's also not ugly: most callers already contain
the ->, which you reuse, so there's hardly any code duplication.

>                                         simply repurpose it instead
> of adding a new function.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  util/qemu-option.c | 23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)
>
> diff --git a/util/qemu-option.c b/util/qemu-option.c
> index ab3b58599e..59be4f9d21 100644
> --- a/util/qemu-option.c
> +++ b/util/qemu-option.c
> @@ -460,16 +460,16 @@ static bool qemu_opt_parse(QemuOpt *opt, Error **errp)
>      }
>  }
>  
> -static bool opts_accepts_any(const QemuOpts *opts)
> +static bool opts_accepts_any(const QemuOptsList *list)
>  {
> -    return opts->list->desc[0].name == NULL;
> +    return list->desc[0].name == NULL;
>  }
>  
>  int qemu_opt_unset(QemuOpts *opts, const char *name)
>  {
>      QemuOpt *opt = qemu_opt_find(opts, name);
>  
> -    assert(opts_accepts_any(opts));
> +    assert(opts_accepts_any(opts->list));
>  
>      if (opt == NULL) {
>          return -1;

Here, it's a straighforward lift of opts->.

> @@ -500,9 +500,10 @@ static bool opt_validate(QemuOpt *opt, bool *help_wanted,
>                           Error **errp)
>  {
>      const QemuOptDesc *desc;
> +    const QemuOptsList *list = opt->opts->list;
>  
> -    desc = find_desc_by_name(opt->opts->list->desc, opt->name);
> -    if (!desc && !opts_accepts_any(opt->opts)) {
> +    desc = find_desc_by_name(list->desc, opt->name);
> +    if (!desc && !opts_accepts_any(list)) {
>          error_setg(errp, QERR_INVALID_PARAMETER, opt->name);
>          if (help_wanted && is_help_option(opt->name)) {
>              *help_wanted = true;

Here, you reuse the existing opts-> by splicing in a variable.

This isn't as obvious as the straighforward lift, and I guess this is
what made you mention "since" in the commit message.

> @@ -535,9 +536,10 @@ bool qemu_opt_set_bool(QemuOpts *opts, const char *name, bool val,
>  {
>      QemuOpt *opt;
>      const QemuOptDesc *desc;
> +    const QemuOptsList *list = opts->list;
>  
> -    desc = find_desc_by_name(opts->list->desc, name);
> -    if (!desc && !opts_accepts_any(opts)) {
> +    desc = find_desc_by_name(list->desc, name);
> +    if (!desc && !opts_accepts_any(list)) {
>          error_setg(errp, QERR_INVALID_PARAMETER, name);
>          return false;
>      }
> @@ -557,9 +559,10 @@ bool qemu_opt_set_number(QemuOpts *opts, const char *name, int64_t val,
>  {
>      QemuOpt *opt;
>      const QemuOptDesc *desc;
> +    const QemuOptsList *list = opts->list;
>  
> -    desc = find_desc_by_name(opts->list->desc, name);
> -    if (!desc && !opts_accepts_any(opts)) {
> +    desc = find_desc_by_name(list->desc, name);
> +    if (!desc && !opts_accepts_any(list)) {
>          error_setg(errp, QERR_INVALID_PARAMETER, name);
>          return false;
>      }
> @@ -1110,7 +1113,7 @@ bool qemu_opts_validate(QemuOpts *opts, const QemuOptDesc *desc, Error **errp)
>  {
>      QemuOpt *opt;
>  
> -    assert(opts_accepts_any(opts));
> +    assert(opts_accepts_any(opts->list));
>  
>      QTAILQ_FOREACH(opt, &opts->head, next) {
>          opt->desc = find_desc_by_name(desc, opt->name);

The commit message confused me a bit.  Regardless:

Reviewed-by: Markus Armbruster <armbru@redhat.com>


