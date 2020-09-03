Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E20BC433E9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 11:49:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CC48206EB
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 11:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E+MHF/mw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CC48206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDnjg-0007FD-By
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 07:49:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42402)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kDnj4-0006fL-Ik
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 07:48:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52495)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kDnj0-0002Gn-SW
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 07:48:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599133696;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mzNSoeywjXO6rdCV2kJtu7Hk8SJX50hh0HmN1ZRX/Wk=;
 b=E+MHF/mwwG6vH2Y2VPzLqIw/x8aRjHjub8ngKHnATUMqoBZ+ydoq0tA0ReAs/ABUxPSgp0
 z0apTUoYYNHL+5478Quk0AK2vpppIpg3BrMK2CtyjvRPtzTt/BgNepmy3DFtcuECj7K1j2
 Urm9nLVNipB9MF4JZRUoPjEYjJkNtrw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-gTXyq0w9OxaV4EmhoTRceQ-1; Thu, 03 Sep 2020 07:48:15 -0400
X-MC-Unique: gTXyq0w9OxaV4EmhoTRceQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 31DD881CBEB;
 Thu,  3 Sep 2020 11:48:14 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-68.ams2.redhat.com
 [10.36.113.68])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D70507EECB;
 Thu,  3 Sep 2020 11:48:10 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 51C3D113865F; Thu,  3 Sep 2020 13:48:09 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: duboisj@gmail.com
Subject: Re: [PATCH] trace/simple: Enable tracing on startup only if the
 user specifies a trace option
References: <20200816174610.20253-1-josh@joshdubois.com>
Date: Thu, 03 Sep 2020 13:48:09 +0200
In-Reply-To: <20200816174610.20253-1-josh@joshdubois.com> (duboisj@gmail.com's
 message of "Sun, 16 Aug 2020 12:46:10 -0500")
Message-ID: <87r1rjkrnq.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 04:23:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: qemu-trivial@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-devel@nongnu.org, Josh DuBois <josh@joshdubois.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

duboisj@gmail.com writes:

> From: Josh DuBois <josh@joshdubois.com>
>
> Tracing can be enabled at the command line or via the
> monitor. Command-line trace options are recorded during
> trace_opt_parse(), but tracing is not enabled until the various
> front-ends later call trace_init_file(). If the user passes a trace
> option on the command-line, remember that and enable tracing during
> trace_init_file().  Otherwise, trace_init_file() should record the
> trace file specified by the frontend and avoid enabling traces
> until the user requests them via the monitor.
>
> This fixes 1b7157be3a8c4300fc8044d40f4b2e64a152a1b4 and also
> db25d56c014aa1a96319c663e0a60346a223b31e, by allowing the user
> to enable traces on the command line and also avoiding
> unwanted trace-<pid> files when the user has not asked for them.
>
> Fixes: 1b7157be3a8c4300fc8044d40f4b2e64a152a1b4
> Signed-off-by: Josh DuBois <josh@joshdubois.com>
> ---
>  trace/control.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/trace/control.c b/trace/control.c
> index 6558b5c906..8f94f09444 100644
> --- a/trace/control.c
> +++ b/trace/control.c
> @@ -39,6 +39,7 @@ static TraceEventGroup *event_groups;
>  static size_t nevent_groups;
>  static uint32_t next_id;
>  static uint32_t next_vcpu_id;
> +static bool init_trace_on_startup;
>  
>  QemuOptsList qemu_trace_opts = {
>      .name = "trace",
> @@ -225,7 +226,9 @@ void trace_init_file(const char *file)
>  {
>  #ifdef CONFIG_TRACE_SIMPLE
>      st_set_trace_file(file);
> -    st_set_trace_file_enabled(true);
> +    if (init_trace_on_startup) {
> +        st_set_trace_file_enabled(true);
> +    }
>  #elif defined CONFIG_TRACE_LOG
>      /*
>       * If both the simple and the log backends are enabled, "--trace file"
> @@ -299,6 +302,7 @@ char *trace_opt_parse(const char *optarg)
>      }
>      trace_init_events(qemu_opt_get(opts, "events"));
>      trace_file = g_strdup(qemu_opt_get(opts, "file"));
> +    init_trace_on_startup = true;
>      qemu_opts_del(opts);
>  
>      return trace_file;

Stops the littering for me.

Stefan, please have a closer look.


