Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF4EEC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 16:07:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D28021D43
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 16:07:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XMycY+dr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D28021D43
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQuvr-0000ze-Dk
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 12:07:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58896)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kQupg-0003RV-Lo
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 12:01:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60551)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kQupc-000169-HP
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 12:01:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602259279;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tjxa3rofeulycW2BydD2ocQU7BSPW5oYkj+yLVafrjI=;
 b=XMycY+drlP84v/2zAGo59vKJmczk66XLe3b6namQ/uojTu1CNefoLq4ukIk+ze+vzmM3eW
 e0twSR+1PLXLsLVI7mctfJVk539xb/ZZa1jiQ6SB3HMlFpXnRFiYMk+62LGRK1WXo56Khl
 ycBUQGA6HcqYCDicOSN0MKtXRaReTT0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-164-1ohjZ7qiM16qD9snpCj_zw-1; Fri, 09 Oct 2020 12:01:16 -0400
X-MC-Unique: 1ohjZ7qiM16qD9snpCj_zw-1
Received: by mail-wm1-f72.google.com with SMTP id l15so4285962wmh.9
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2020 09:01:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Tjxa3rofeulycW2BydD2ocQU7BSPW5oYkj+yLVafrjI=;
 b=WURujFJXxnYg742koXmuqzbyChakWKKZaMTIOUQJSIL+b4ikbAugcIh8aMm55goqfH
 QAhH9YHllz0u2WybdOzf87MDhWI5ys7LKQ5e7IP7ji0QF6yUk/G86jnjeIUWXmKUh+xO
 G5aI21estKJoTQVwPGJxdSs1sTsZrlp4qT5y9Po5Y6lIkIlN11Mdl5pB/VFEpZ4YAmck
 +K8Tzs9JqGO3XMKfnd2BFjbzXkT2AqHcupEP0PEpriL/a3U2DTrFf/H+dtHBt2WzmCMp
 i08H2wzxnL9Q67jKgSLqnCKpJOui+i+SaOqWcQjms5Y4pCU3fJgisnJMOQdBaVAjJ/nc
 OVSg==
X-Gm-Message-State: AOAM531g8oCdxrbCeS/8/DJT4Ul4ldMdJehMJVpmWOZiFao8Pjwiie5o
 g9bKMkDCgDc0C38eKDoy+ePFzR/j6D2HrqM6awOGepduvD2pzbumUpWmqycktyLGwEigoTG05He
 C2m6G7DFFWHO1NHQ=
X-Received: by 2002:a1c:a70d:: with SMTP id q13mr13986814wme.132.1602259274984; 
 Fri, 09 Oct 2020 09:01:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzWziwIWvQeibPncvKyjqzAeEzu9tsqRbyleX+ODDeyYiGo73KbsMz1Ged9RYrgAxKsugZMtQ==
X-Received: by 2002:a1c:a70d:: with SMTP id q13mr13986771wme.132.1602259274644; 
 Fri, 09 Oct 2020 09:01:14 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:cee1:4797:6958:7698?
 ([2001:b07:6468:f312:cee1:4797:6958:7698])
 by smtp.gmail.com with ESMTPSA id y23sm13021953wra.55.2020.10.09.09.01.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Oct 2020 09:01:12 -0700 (PDT)
Subject: Re: [RFC v1 4/4] replay: do not build if TCG is not available
To: Claudio Fontana <cfontana@suse.de>
References: <20201009152108.16120-1-cfontana@suse.de>
 <20201009152108.16120-5-cfontana@suse.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4f4b4f12-0fdb-9c20-da3d-af222a69265e@redhat.com>
Date: Fri, 9 Oct 2020 18:01:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201009152108.16120-5-cfontana@suse.de>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 02:34:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.208, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/10/20 17:21, Claudio Fontana wrote:
> replay requires icount, which needs TCG.
> 
> stub the needed functions in stub/,
> including errors for hmp and qmp commands.
> 
> Signed-off-by: Claudio Fontana <cfontana@suse.de>

Looks plausible, though probably I'd put it in replay/stubs.c and use
if_false to link it.

Paolo

> ---
>  migration/savevm.c         | 11 +++--
>  replay/meson.build         |  2 +-
>  stubs/replay.c             | 99 ++++++++++++++++++++++++++++++++++++++
>  tests/qtest/qmp-cmd-test.c |  3 ++
>  4 files changed, 110 insertions(+), 5 deletions(-)
> 
> diff --git a/migration/savevm.c b/migration/savevm.c
> index d2e141f7b1..d9181ca520 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -63,6 +63,7 @@
>  #include "migration/colo.h"
>  #include "qemu/bitmap.h"
>  #include "net/announce.h"
> +#include "sysemu/tcg.h"
>  
>  const unsigned int postcopy_ram_discard_version = 0;
>  
> @@ -2674,10 +2675,12 @@ int save_snapshot(const char *name, Error **errp)
>          return ret;
>      }
>  
> -    if (!replay_can_snapshot()) {
> -        error_setg(errp, "Record/replay does not allow making snapshot "
> -                   "right now. Try once more later.");
> -        return ret;
> +    if (tcg_enabled()) {
> +        if (!replay_can_snapshot()) {
> +            error_setg(errp, "Record/replay does not allow making snapshot "
> +                       "right now. Try once more later.");
> +            return ret;
> +        }
>      }
>  
>      if (!bdrv_all_can_snapshot(&bs)) {
> diff --git a/replay/meson.build b/replay/meson.build
> index f91163fb1e..cb3207740a 100644
> --- a/replay/meson.build
> +++ b/replay/meson.build
> @@ -1,4 +1,4 @@
> -softmmu_ss.add(files(
> +softmmu_ss.add(when: 'CONFIG_TCG', if_true: files(
>    'replay.c',
>    'replay-internal.c',
>    'replay-events.c',
> diff --git a/stubs/replay.c b/stubs/replay.c
> index 45ebe77fb9..ff35daf198 100644
> --- a/stubs/replay.c
> +++ b/stubs/replay.c
> @@ -103,3 +103,102 @@ bool replay_reverse_continue(void)
>  {
>      return false;
>  }
> +
> +void replay_add_blocker(Error *reason)
> +{
> +}
> +void replay_audio_in(size_t *recorded, void *samples, size_t *wpos, size_t size)
> +{
> +}
> +void replay_audio_out(size_t *played)
> +{
> +}
> +void replay_bh_schedule_event(QEMUBH *bh)
> +{
> +}
> +void replay_breakpoint(void)
> +{
> +}
> +bool replay_can_snapshot(void)
> +{
> +    return false;
> +}
> +void replay_configure(struct QemuOpts *opts)
> +{
> +}
> +void replay_flush_events(void)
> +{
> +}
> +void replay_gdb_attached(void)
> +{
> +}
> +void replay_input_event(QemuConsole *src, InputEvent *evt)
> +{
> +}
> +void replay_input_sync_event(void)
> +{
> +}
> +void replay_net_packet_event(ReplayNetState *rns, unsigned flags,
> +                             const struct iovec *iov, int iovcnt)
> +{
> +}
> +ReplayNetState *replay_register_net(NetFilterState *nfs)
> +{
> +    return NULL;
> +}
> +bool replay_running_debug(void)
> +{
> +    return false;
> +}
> +void replay_shutdown_request(ShutdownCause cause)
> +{
> +}
> +void replay_start(void)
> +{
> +}
> +void replay_unregister_net(ReplayNetState *rns)
> +{
> +}
> +void replay_vmstate_init(void)
> +{
> +}
> +
> +#include "monitor/monitor.h"
> +#include "monitor/hmp.h"
> +#include "qapi/qapi-commands-replay.h"
> +#include "qapi/error.h"
> +#include "qemu/error-report.h"
> +
> +void hmp_info_replay(Monitor *mon, const QDict *qdict)
> +{
> +    error_report("replay support not available\n");
> +}
> +void hmp_replay_break(Monitor *mon, const QDict *qdict)
> +{
> +    error_report("replay support not available\n");
> +}
> +void hmp_replay_delete_break(Monitor *mon, const QDict *qdict)
> +{
> +    error_report("replay support not available\n");
> +}
> +void hmp_replay_seek(Monitor *mon, const QDict *qdict)
> +{
> +    error_report("replay support not available\n");
> +}
> +ReplayInfo *qmp_query_replay(Error **errp)
> +{
> +    error_set(errp, ERROR_CLASS_COMMAND_NOT_FOUND, "replay support not available");
> +    return NULL;
> +}
> +void qmp_replay_break(int64_t icount, Error **errp)
> +{
> +    error_set(errp, ERROR_CLASS_COMMAND_NOT_FOUND, "replay support not available");
> +}
> +void qmp_replay_delete_break(Error **errp)
> +{
> +    error_set(errp, ERROR_CLASS_COMMAND_NOT_FOUND, "replay support not available");
> +}
> +void qmp_replay_seek(int64_t icount, Error **errp)
> +{
> +    error_set(errp, ERROR_CLASS_COMMAND_NOT_FOUND, "replay support not available");
> +}
> diff --git a/tests/qtest/qmp-cmd-test.c b/tests/qtest/qmp-cmd-test.c
> index 8a4c570e83..1c7186e53c 100644
> --- a/tests/qtest/qmp-cmd-test.c
> +++ b/tests/qtest/qmp-cmd-test.c
> @@ -31,6 +31,9 @@ static int query_error_class(const char *cmd)
>  #ifndef CONFIG_SPICE
>          { "query-spice", ERROR_CLASS_COMMAND_NOT_FOUND },
>  #endif
> +#ifndef CONFIG_TCG
> +        { "query-replay", ERROR_CLASS_COMMAND_NOT_FOUND },
> +#endif
>  #ifndef CONFIG_VNC
>          { "query-vnc", ERROR_CLASS_GENERIC_ERROR },
>          { "query-vnc-servers", ERROR_CLASS_GENERIC_ERROR },
> 


