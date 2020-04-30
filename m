Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D3BC8300A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 09:32:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BB2B20838
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 09:32:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h1JBSD8d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BB2B20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU5Yr-0002YS-Hr
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 05:32:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47586)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jU5Wn-0001IN-JB
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 05:31:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jU5WX-00010p-3r
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 05:30:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56166
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jU5WW-00010W-Ko
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 05:30:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588239027;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F3fCZktjjq2rMu9TA7upBfpDadKn5I1vKVOUdj2w/Io=;
 b=h1JBSD8dlSQYYnsxmaiwEPFjttGLDMqrcWdOsIbP+ngF7cKhgxrUQHep06FN2x+aH9ShH4
 4uppaGj75EftWUQMzV39EretbuuUK2iCmeg4AWPIEK7yl0BavWSq1ervqlne/FxvB6lLr6
 erfDcVAMFggXap3mRqA9miAkixgIay8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-YMe9dNEkPNOCKi19KI-vVg-1; Thu, 30 Apr 2020 05:30:25 -0400
X-MC-Unique: YMe9dNEkPNOCKi19KI-vVg-1
Received: by mail-wm1-f69.google.com with SMTP id n17so358478wmi.3
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 02:30:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=F3fCZktjjq2rMu9TA7upBfpDadKn5I1vKVOUdj2w/Io=;
 b=QtU2RfiufPhyOEGwfNVeI1NYWZsKsrkBBGG6T0kvYkJTNPi26rSalex6egP3MBAMN/
 UZGzzJDigwj5Do0e2G/Qlro0YtraC8L8rZU6Iqz0RqZhfsMXOj1haH7gXao9Rj/4dpT0
 ZACwVsjFShO/mPgrdiiu+tgKgs0QXsJpqiQC3MDO6oWud6ZD25rlfNTcZC7in6G+pFwX
 SwvuuzqjYd2s2HDfPkqpOm4Qo3stEEqO/VJM1FOZq+KAtYzWCZ0kSsntK0SgExf+V5yv
 T/hLbIRDBbIzQB63rM+XLxrEDXVrenhjApAch3JO98gm513F1+FqWNPkJ+g74uSG4t6c
 iy9Q==
X-Gm-Message-State: AGi0PubfuCGN6CctkytngwcQGaaq9c6hDKJEvaj3wS9iGL6m3SuckX98
 jshooEYMGPhkb/NSLVs+RRsImaHgHyb9CYCQw6hpexLWfXuAvgb7UvcHqYqm9Hn65l+Hoiv2cK9
 StzJ/R3Ri3RkJxmo=
X-Received: by 2002:a5d:498b:: with SMTP id r11mr2839991wrq.368.1588239023824; 
 Thu, 30 Apr 2020 02:30:23 -0700 (PDT)
X-Google-Smtp-Source: APiQypL2N9tDEy9dhXg7MPseIQivY/WyNsIAG9915zwR6aWZ4uY5YI7TRwJSH+vgMsx6Rz8YFklzUA==
X-Received: by 2002:a5d:498b:: with SMTP id r11mr2839969wrq.368.1588239023571; 
 Thu, 30 Apr 2020 02:30:23 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ac19:d1fb:3f5f:d54f?
 ([2001:b07:6468:f312:ac19:d1fb:3f5f:d54f])
 by smtp.gmail.com with ESMTPSA id b2sm3592217wrn.6.2020.04.30.02.30.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Apr 2020 02:30:23 -0700 (PDT)
Subject: Re: [PATCH] replay: implement fair mutex
To: Pavel Dovgalyuk <Pavel.Dovgaluk@gmail.com>, qemu-devel@nongnu.org
References: <158823802979.28101.9340462887738957616.stgit@pasha-ThinkPad-X280>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <564674ea-77a8-2ca9-2874-3210c3ea87b2@redhat.com>
Date: Thu, 30 Apr 2020 11:30:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <158823802979.28101.9340462887738957616.stgit@pasha-ThinkPad-X280>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 23:34:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: dovgaluk@ispras.ru, pavel.dovgaluk@ispras.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 30/04/20 11:13, Pavel Dovgalyuk wrote:
> In record/replay icount mode main loop thread and vCPU thread
> do not perform simultaneously. They take replay mutex to synchronize
> the actions. Sometimes vCPU thread waits for locking the mutex for
> very long time, because main loop releases the mutex and takes it
> back again. Standard qemu mutex do not provide the ordering
> capabilities.
> 
> This patch adds a "queue" for replay mutex. Therefore thread ordering
> becomes more "fair". Threads are executed in the same order as
> they are trying to take the mutex.
> 
> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> ---
>  replay/replay-internal.c |   15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/replay/replay-internal.c b/replay/replay-internal.c
> index eba8246aae..2e8a3e947a 100644
> --- a/replay/replay-internal.c
> +++ b/replay/replay-internal.c
> @@ -22,6 +22,9 @@
>     It also protects replay events queue which stores events to be
>     written or read to the log. */
>  static QemuMutex lock;
> +/* Condition and queue for fair ordering of mutex lock requests. */
> +static QemuCond mutex_cond;
> +static unsigned long mutex_head, mutex_tail;
>  
>  /* File for replay writing */
>  static bool write_error;
> @@ -197,9 +200,10 @@ static __thread bool replay_locked;
>  void replay_mutex_init(void)
>  {
>      qemu_mutex_init(&lock);
> +    qemu_cond_init(&mutex_cond);
>      /* Hold the mutex while we start-up */
> -    qemu_mutex_lock(&lock);
>      replay_locked = true;
> +    ++mutex_tail;
>  }
>  
>  bool replay_mutex_locked(void)
> @@ -211,10 +215,16 @@ bool replay_mutex_locked(void)
>  void replay_mutex_lock(void)
>  {
>      if (replay_mode != REPLAY_MODE_NONE) {
> +        unsigned long id;
>          g_assert(!qemu_mutex_iothread_locked());
>          g_assert(!replay_mutex_locked());
>          qemu_mutex_lock(&lock);
> +        id = mutex_tail++;
> +        while (id != mutex_head) {
> +            qemu_cond_wait(&mutex_cond, &lock);
> +        }
>          replay_locked = true;
> +        qemu_mutex_unlock(&lock);
>      }
>  }
>  
> @@ -222,7 +232,10 @@ void replay_mutex_unlock(void)
>  {
>      if (replay_mode != REPLAY_MODE_NONE) {
>          g_assert(replay_mutex_locked());
> +        qemu_mutex_lock(&lock);
> +        ++mutex_head;
>          replay_locked = false;
> +        qemu_cond_broadcast(&mutex_cond);
>          qemu_mutex_unlock(&lock);
>      }
>  }
> 

Queued, thanks.

Paolo


