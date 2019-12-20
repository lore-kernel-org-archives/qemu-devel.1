Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7702C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 13:15:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B598D218AC
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 13:15:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RHcrMwSL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B598D218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiI7s-0002Oc-Qn
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 08:15:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33646)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iiI6m-0001K3-Ho
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 08:14:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iiI6i-0003ld-Cy
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 08:14:18 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40335
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iiI6i-0003ga-2M
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 08:14:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576847654;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fvldj3HAqRYkY9iKnZPQmFx1EHHN8wBHYulbC168P0c=;
 b=RHcrMwSLLmSC7z+XqDWGgO0y4/YksS8J5EgUzp4AoveFN1LAi14vX1DtBqnQ+DPtaaiFW9
 nCw/nPST2rc6Ra8g7zL1CrikBdAUWjQ6zfePCho89urlHhN9Ff7OiA8zHNp/z6h4Ee2jM+
 j3luZivVbwcG948VU3SOmZ2wDpwII0Q=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-k4lrosPvOfasrdDvZC2_YA-1; Fri, 20 Dec 2019 08:14:11 -0500
Received: by mail-wr1-f70.google.com with SMTP id u12so3768553wrt.15
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 05:14:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Fvldj3HAqRYkY9iKnZPQmFx1EHHN8wBHYulbC168P0c=;
 b=eNlaNh4DtyFl4HOxduK6cFIpZCu2jpveMi8PIg33vBZxgLEUCOGnulASN6M0Lt9KZ1
 KbVKv8LMoSLPNVoGVKY3QbPgJir9R7D8FbCdheGKkQW9lm2sW09v4UhaZgiRZYWB6wam
 HQikZLYqAU4vuCcARkuj2NoFonsP5BBXMIry8dHbolwtFzHhuvxC4HNFM9q7SssYAZ7f
 aSv11TGz3n3PgXl5DDq8tO6lF/ICv//1O81I/EVFnnvy64Z0TG4jTVqfJ/T4iEx7NsBW
 n7gWffk9KLg3T3tDZOsj2Pb5Dg7Dcr27RTvJ+HUlZzIDMrA5jZKfBkDY0cwqyjMvE6jr
 7aKA==
X-Gm-Message-State: APjAAAVsqiR0kIUh+JQANo7KYTlTBAshsqj8lejsglaDxvfh76Wzk9GR
 ftY5gIrZuFqOHkgxrxmvp5D+5Fz5QbuQIwePPnLrzHAtmjxbgpLSxSiqqIOKHIrI1CjCR+hRjD4
 qTTYiG5X2KflLHKA=
X-Received: by 2002:a5d:494b:: with SMTP id r11mr15339279wrs.184.1576847650208; 
 Fri, 20 Dec 2019 05:14:10 -0800 (PST)
X-Google-Smtp-Source: APXvYqySMwvkodOMCipUz/Y8+rGCT29MYwlvBgNUNdq14FsNzI9lPClryKz/rE20mqK/UYu6TtgCmg==
X-Received: by 2002:a5d:494b:: with SMTP id r11mr15339253wrs.184.1576847649864; 
 Fri, 20 Dec 2019 05:14:09 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:ac09:bce1:1c26:264c?
 ([2001:b07:6468:f312:ac09:bce1:1c26:264c])
 by smtp.gmail.com with ESMTPSA id g23sm9634442wmk.14.2019.12.20.05.14.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Dec 2019 05:14:08 -0800 (PST)
Subject: Re: [PATCH] replay: record and replay random number sources
To: Pavel Dovgalyuk <pavel.dovgaluk@gmail.com>, qemu-devel@nongnu.org
References: <157675984852.14505.15709141760677102489.stgit@pasha-Precision-3630-Tower>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <be3912ff-43d6-02fa-58f3-7b9931eea74e@redhat.com>
Date: Fri, 20 Dec 2019 14:14:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <157675984852.14505.15709141760677102489.stgit@pasha-Precision-3630-Tower>
Content-Language: en-US
X-MC-Unique: k4lrosPvOfasrdDvZC2_YA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: dovgaluk@ispras.ru, pavel.dovgaluk@ispras.ru, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19/12/19 13:50, Pavel Dovgalyuk wrote:
> Record/replay feature of icount allows deterministic running of execution
> scenarios. Some CPUs and peripheral devices read random numbers from
> external sources making deterministic execution impossible.
> This patch adds recording and replaying of random read operations
> into guest-random module, which is used by the virtual hardware.
> 
> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> ---
>  docs/replay.txt          |    1 +
>  include/sysemu/replay.h  |    7 +++++++
>  replay/Makefile.objs     |    3 ++-
>  replay/replay-internal.h |    2 ++
>  replay/replay-random.c   |   44 ++++++++++++++++++++++++++++++++++++++++++++
>  replay/replay.c          |    2 +-
>  stubs/replay.c           |    9 +++++++++
>  util/guest-random.c      |   13 +++++++++++--
>  8 files changed, 77 insertions(+), 4 deletions(-)
>  create mode 100644 replay/replay-random.c
> 
> diff --git a/docs/replay.txt b/docs/replay.txt
> index ce97c3f72f..f4619a62a3 100644
> --- a/docs/replay.txt
> +++ b/docs/replay.txt
> @@ -67,6 +67,7 @@ Modifications of qemu include:
>   * network filter for recording and replaying the packets
>   * block driver for making block layer deterministic
>   * serial port input record and replay
> + * recording of random numbers obtained from the external sources
>  
>  Locking and thread synchronisation
>  ----------------------------------
> diff --git a/include/sysemu/replay.h b/include/sysemu/replay.h
> index 8df517298c..5471bb514d 100644
> --- a/include/sysemu/replay.h
> +++ b/include/sysemu/replay.h
> @@ -117,6 +117,13 @@ int64_t replay_read_clock(ReplayClockKind kind);
>              ? replay_save_clock((clock), (value), cpu_get_icount_raw_locked()) \
>          : (value))
>  
> +/* Processing data from random generators */
> +
> +/* Saves the values from the random number generator */
> +void replay_save_random(int ret, void *buf, size_t len);
> +/* Loads the saved values for the random number generator */
> +int replay_read_random(void *buf, size_t len);
> +
>  /* Events */
>  
>  /*! Called when qemu shutdown is requested. */
> diff --git a/replay/Makefile.objs b/replay/Makefile.objs
> index cee6539a23..939be964a9 100644
> --- a/replay/Makefile.objs
> +++ b/replay/Makefile.objs
> @@ -6,4 +6,5 @@ common-obj-y += replay-input.o
>  common-obj-y += replay-char.o
>  common-obj-y += replay-snapshot.o
>  common-obj-y += replay-net.o
> -common-obj-y += replay-audio.o
> \ No newline at end of file
> +common-obj-y += replay-audio.o
> +common-obj-y += replay-random.o
> diff --git a/replay/replay-internal.h b/replay/replay-internal.h
> index 55fca1ac6b..33ac551e78 100644
> --- a/replay/replay-internal.h
> +++ b/replay/replay-internal.h
> @@ -34,6 +34,8 @@ enum ReplayEvents {
>      EVENT_AUDIO_OUT,
>      /* for audio in event */
>      EVENT_AUDIO_IN,
> +    /* for random number generator */
> +    EVENT_RANDOM,
>      /* for clock read/writes */
>      /* some of greater codes are reserved for clocks */
>      EVENT_CLOCK,
> diff --git a/replay/replay-random.c b/replay/replay-random.c
> new file mode 100644
> index 0000000000..afc7a0fccc
> --- /dev/null
> +++ b/replay/replay-random.c
> @@ -0,0 +1,44 @@
> +/*
> + * replay-random.c
> + *
> + * Copyright (c) 2010-2020 Institute for System Programming
> + *                         of the Russian Academy of Sciences.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/error-report.h"
> +#include "sysemu/replay.h"
> +#include "replay-internal.h"
> +
> +void replay_save_random(int ret, void *buf, size_t len)
> +{
> +    g_assert(replay_mutex_locked());
> +
> +    replay_save_instructions();
> +    replay_put_event(EVENT_RANDOM);
> +    replay_put_dword(ret);
> +    replay_put_array(buf, len);
> +}
> +
> +int replay_read_random(void *buf, size_t len)
> +{
> +    int ret = 0;
> +    g_assert(replay_mutex_locked());
> +
> +    replay_account_executed_instructions();
> +    if (replay_next_event_is(EVENT_RANDOM)) {
> +        size_t buf_size = 0;
> +        ret = replay_get_dword();
> +        replay_get_array(buf, &buf_size);
> +        replay_finish_event();
> +        g_assert(buf_size == len);
> +    } else {
> +        error_report("Missing random event in the replay log");
> +        exit(1);
> +    }
> +    return ret;
> +}
> diff --git a/replay/replay.c b/replay/replay.c
> index 5cc25bd2f8..706c7b4f4b 100644
> --- a/replay/replay.c
> +++ b/replay/replay.c
> @@ -22,7 +22,7 @@
>  
>  /* Current version of the replay mechanism.
>     Increase it when file format changes. */
> -#define REPLAY_VERSION              0xe02008
> +#define REPLAY_VERSION              0xe02009
>  /* Size of replay log header */
>  #define HEADER_SIZE                 (sizeof(uint32_t) + sizeof(uint64_t))
>  
> diff --git a/stubs/replay.c b/stubs/replay.c
> index 10b3925e2f..5974ec1f50 100644
> --- a/stubs/replay.c
> +++ b/stubs/replay.c
> @@ -79,3 +79,12 @@ void replay_mutex_lock(void)
>  void replay_mutex_unlock(void)
>  {
>  }
> +
> +void replay_save_random(int ret, void *buf, size_t len)
> +{
> +}
> +
> +int replay_read_random(void *buf, size_t len)
> +{
> +    return 0;
> +}
> diff --git a/util/guest-random.c b/util/guest-random.c
> index 9453968bd7..086115bd67 100644
> --- a/util/guest-random.c
> +++ b/util/guest-random.c
> @@ -14,6 +14,7 @@
>  #include "qapi/error.h"
>  #include "qemu/guest-random.h"
>  #include "crypto/random.h"
> +#include "sysemu/replay.h"
>  
>  
>  static __thread GRand *thread_rand;
> @@ -44,13 +45,21 @@ static int glib_random_bytes(void *buf, size_t len)
>  
>  int qemu_guest_getrandom(void *buf, size_t len, Error **errp)
>  {
> +    int ret;
> +    if (replay_mode == REPLAY_MODE_PLAY) {
> +        return replay_read_random(buf, len);
> +    }
>      if (unlikely(deterministic)) {
>          /* Deterministic implementation using Glib's Mersenne Twister.  */
> -        return glib_random_bytes(buf, len);
> +        ret = glib_random_bytes(buf, len);
>      } else {
>          /* Non-deterministic implementation using crypto routines.  */
> -        return qcrypto_random_bytes(buf, len, errp);
> +        ret = qcrypto_random_bytes(buf, len, errp);
> +    }
> +    if (replay_mode == REPLAY_MODE_RECORD) {
> +        replay_save_random(ret, buf, len);
>      }
> +    return ret;
>  }
>  
>  void qemu_guest_getrandom_nofail(void *buf, size_t len)
> 

Queued, thanks.

Paolo


