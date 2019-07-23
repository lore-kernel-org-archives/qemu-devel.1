Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9998BC76190
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 05:54:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 710B72238E
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 05:54:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 710B72238E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpnlD-0001iW-Hv
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 01:54:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46970)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dovgaluk@ispras.ru>) id 1hpnl2-0001Ja-Fa
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 01:54:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dovgaluk@ispras.ru>) id 1hpnl0-0002W1-L9
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 01:54:40 -0400
Received: from mail.ispras.ru ([83.149.199.45]:47916)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <dovgaluk@ispras.ru>) id 1hpnl0-0002R8-89
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 01:54:38 -0400
Received: from PASHAISP (unknown [85.142.117.226])
 by mail.ispras.ru (Postfix) with ESMTPSA id 854AA54006A;
 Tue, 23 Jul 2019 08:54:34 +0300 (MSK)
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
To: "'Dr. David Alan Gilbert \(git\)'" <dgilbert@redhat.com>,
 <qemu-devel@nongnu.org>, <pbonzini@redhat.com>, <pavel.dovgaluk@ispras.ru>
References: <20190722150717.10564-1-dgilbert@redhat.com>
 <20190722150717.10564-4-dgilbert@redhat.com>
In-Reply-To: <20190722150717.10564-4-dgilbert@redhat.com>
Date: Tue, 23 Jul 2019 08:54:35 +0300
Message-ID: <000901d5411b$1b7e1d70$527a5850$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: ru
Thread-Index: AdVAny3Rgot+9aqYSsGIwCt/0zy39wAepTzw
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 83.149.199.45
Subject: Re: [Qemu-devel] [for 4.2 PATCH 3/3] timer: last,
 remove last bits of last
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello!

> From: Dr. David Alan Gilbert (git) [mailto:dgilbert@redhat.com]
> The reset notifiers kept a 'last' counter to notice jumps;
> now that we've remove the notifier we don't need to keep 'last'.
> replay used to save/restore 'last' (presumably to avoid triggering
> the notifier);  make it store the current time instead which avoids
> changing it's migration format.

If you are removing 'last' field, you also should drop 'host_clock_last'
from ReplayState, because it is used only for restoring host clock
'last' field. And that was useful only in record/replay mode.

> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  include/qemu/timer.h     | 13 -------------
>  replay/replay-snapshot.c |  3 +--
>  util/qemu-timer.c        | 22 +---------------------
>  3 files changed, 2 insertions(+), 36 deletions(-)
> 
> diff --git a/include/qemu/timer.h b/include/qemu/timer.h
> index 6817c78ef4..5bcab935f6 100644
> --- a/include/qemu/timer.h
> +++ b/include/qemu/timer.h
> @@ -248,19 +248,6 @@ bool qemu_clock_run_timers(QEMUClockType type);
>   */
>  bool qemu_clock_run_all_timers(void);
> 
> -/**
> - * qemu_clock_get_last:
> - *
> - * Returns last clock query time.
> - */
> -uint64_t qemu_clock_get_last(QEMUClockType type);
> -/**
> - * qemu_clock_set_last:
> - *
> - * Sets last clock query time.
> - */
> -void qemu_clock_set_last(QEMUClockType type, uint64_t last);
> -
> 
>  /*
>   * QEMUTimerList
> diff --git a/replay/replay-snapshot.c b/replay/replay-snapshot.c
> index 756f48bc02..ca6d4adcc0 100644
> --- a/replay/replay-snapshot.c
> +++ b/replay/replay-snapshot.c
> @@ -24,7 +24,7 @@ static int replay_pre_save(void *opaque)
>  {
>      ReplayState *state = opaque;
>      state->file_offset = ftell(replay_file);
> -    state->host_clock_last = qemu_clock_get_last(QEMU_CLOCK_HOST);
> +    state->host_clock_last = get_clock_realtime();
> 
>      return 0;
>  }
> @@ -34,7 +34,6 @@ static int replay_post_load(void *opaque, int version_id)
>      ReplayState *state = opaque;
>      if (replay_mode == REPLAY_MODE_PLAY) {
>          fseek(replay_file, state->file_offset, SEEK_SET);
> -        qemu_clock_set_last(QEMU_CLOCK_HOST, state->host_clock_last);
>          /* If this was a vmstate, saved in recording mode,
>             we need to initialize replay data fields. */
>          replay_fetch_data_kind();
> diff --git a/util/qemu-timer.c b/util/qemu-timer.c
> index 2faaaf9926..b73041df4e 100644
> --- a/util/qemu-timer.c
> +++ b/util/qemu-timer.c
> @@ -48,8 +48,6 @@ typedef struct QEMUClock {
>      /* We rely on BQL to protect the timerlists */
>      QLIST_HEAD(, QEMUTimerList) timerlists;
> 
> -    int64_t last;
> -
>      QEMUClockType type;
>      bool enabled;
>  } QEMUClock;
> @@ -130,7 +128,6 @@ static void qemu_clock_init(QEMUClockType type, QEMUTimerListNotifyCB
> *notify_cb
> 
>      clock->type = type;
>      clock->enabled = (type == QEMU_CLOCK_VIRTUAL ? false : true);
> -    clock->last = INT64_MIN;
>      QLIST_INIT(&clock->timerlists);
>      main_loop_tlg.tl[type] = timerlist_new(type, notify_cb, NULL);
>  }
> @@ -628,9 +625,6 @@ int64_t timerlistgroup_deadline_ns(QEMUTimerListGroup *tlg)
> 
>  int64_t qemu_clock_get_ns(QEMUClockType type)
>  {
> -    int64_t now;
> -    QEMUClock *clock = qemu_clock_ptr(type);
> -
>      switch (type) {
>      case QEMU_CLOCK_REALTIME:
>          return get_clock();
> @@ -642,26 +636,12 @@ int64_t qemu_clock_get_ns(QEMUClockType type)
>              return cpu_get_clock();
>          }
>      case QEMU_CLOCK_HOST:
> -        now = REPLAY_CLOCK(REPLAY_CLOCK_HOST, get_clock_realtime());
> -        clock->last = now;
> -        return now;
> +        return REPLAY_CLOCK(REPLAY_CLOCK_HOST, get_clock_realtime());
>      case QEMU_CLOCK_VIRTUAL_RT:
>          return REPLAY_CLOCK(REPLAY_CLOCK_VIRTUAL_RT, cpu_get_clock());
>      }
>  }
> 
> -uint64_t qemu_clock_get_last(QEMUClockType type)
> -{
> -    QEMUClock *clock = qemu_clock_ptr(type);
> -    return clock->last;
> -}
> -
> -void qemu_clock_set_last(QEMUClockType type, uint64_t last)
> -{
> -    QEMUClock *clock = qemu_clock_ptr(type);
> -    clock->last = last;
> -}
> -
>  void init_clocks(QEMUTimerListNotifyCB *notify_cb)
>  {
>      QEMUClockType type;
> --
> 2.21.0


Pavel Dovgalyuk


