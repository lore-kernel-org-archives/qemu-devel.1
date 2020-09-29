Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A610FC4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 18:10:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E447B208B8
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 18:10:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hjk3z6sI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E447B208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNK5V-0002vD-UD
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 14:10:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56634)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kNJzP-00071Q-DH
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 14:04:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28825)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kNJzK-0001NE-OT
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 14:04:35 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601402669;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nlFwm7RI0lGLNdRGb5CgeXYS5DP1WyoDb7YAGdFDbKE=;
 b=hjk3z6sIUaQieUG/6ETtdLe0vyDxTNnpZfOSNUQRH9+k1WtThHzO7vv9TKtdTlTfoinHcg
 u5iikXuEunY81xrOxyowIYDsDybJN0hrEUJDrlqBrjnP14FE4rfSEA33rNXZWykJdqN1qH
 A/AaeOvhlm+FNaM3x8Uck+MQR1Q/iL4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-230-93IfcqofMWyrsMSfs4q6Ow-1; Tue, 29 Sep 2020 14:04:27 -0400
X-MC-Unique: 93IfcqofMWyrsMSfs4q6Ow-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 492A11018724;
 Tue, 29 Sep 2020 18:04:26 +0000 (UTC)
Received: from [10.10.119.140] (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B40725C1CF;
 Tue, 29 Sep 2020 18:04:25 +0000 (UTC)
Subject: Re: [PATCH] job: delete job_{lock, unlock} functions and replace them
 with lock guard
To: Elena Afanasova <eafanasova@gmail.com>
References: <20200929134214.4103-1-eafanasova@gmail.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <b055221b-c436-1ff3-b986-5a522178fde8@redhat.com>
Date: Tue, 29 Sep 2020 14:04:25 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200929134214.4103-1-eafanasova@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 22:47:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/29/20 9:42 AM, Elena Afanasova wrote:
> Signed-off-by: Elena Afanasova <eafanasova@gmail.com>

Hi, can I have a commit message here, please?

> ---
>   job.c | 46 +++++++++++++++++-----------------------------
>   1 file changed, 17 insertions(+), 29 deletions(-)
> 
> diff --git a/job.c b/job.c
> index 8fecf38960..89ceb53434 100644
> --- a/job.c
> +++ b/job.c
> @@ -79,16 +79,6 @@ struct JobTxn {
>    * job_enter. */
>   static QemuMutex job_mutex;
>   
> -static void job_lock(void)
> -{
> -    qemu_mutex_lock(&job_mutex);
> -}
> -
> -static void job_unlock(void)
> -{
> -    qemu_mutex_unlock(&job_mutex);
> -}
> -
>   static void __attribute__((__constructor__)) job_init(void)
>   {
>       qemu_mutex_init(&job_mutex);
> @@ -437,21 +427,19 @@ void job_enter_cond(Job *job, bool(*fn)(Job *job))
>           return;
>       }
>   
> -    job_lock();
> -    if (job->busy) {
> -        job_unlock();
> -        return;
> -    }
> +    WITH_QEMU_LOCK_GUARD(&job_mutex) {
> +        if (job->busy) {
> +            return;
> +        }
>   
> -    if (fn && !fn(job)) {
> -        job_unlock();
> -        return;
> -    }
> +        if (fn && !fn(job)) {
> +            return;
> +        }
>   
> -    assert(!job->deferred_to_main_loop);
> -    timer_del(&job->sleep_timer);
> -    job->busy = true;
> -    job_unlock();
> +        assert(!job->deferred_to_main_loop);
> +        timer_del(&job->sleep_timer);
> +        job->busy = true;
> +    }
>       aio_co_enter(job->aio_context, job->co);
>   }
>   
> @@ -468,13 +456,13 @@ void job_enter(Job *job)
>    * called explicitly. */
>   static void coroutine_fn job_do_yield(Job *job, uint64_t ns)
>   {
> -    job_lock();
> -    if (ns != -1) {
> -        timer_mod(&job->sleep_timer, ns);
> +    WITH_QEMU_LOCK_GUARD(&job_mutex) {
> +        if (ns != -1) {
> +            timer_mod(&job->sleep_timer, ns);
> +        }
> +        job->busy = false;
> +        job_event_idle(job);

Is this new macro safe to use in a coroutine context?

>       }
> -    job->busy = false;
> -    job_event_idle(job);
> -    job_unlock();
>       qemu_coroutine_yield();
>   
>       /* Set by job_enter_cond() before re-entering the coroutine.  */
> 

I haven't looked into WITH_QEMU_LOCK_GUARD before, I assume it's new. If 
it works like I think it does, this change seems good.

(I'm assuming it works like a Python context manager and it drops the 
lock when it leaves the scope of the macro using GCC/Clang language 
extensions.)


