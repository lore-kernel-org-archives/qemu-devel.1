Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C357BC33C9E
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 15:41:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 921EC2146E
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 15:41:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KdfrxoBj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 921EC2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioUVB-0001PG-Pv
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 10:41:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34521)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1ioUDJ-0007cV-9O
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 10:22:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1ioUDI-0003xc-0Z
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 10:22:41 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:55119)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1ioUDH-0003uQ-QO
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 10:22:39 -0500
Received: by mail-wm1-x342.google.com with SMTP id b19so15309147wmj.4
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2020 07:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=LShIjmc7MPKNcJQC0b7I/MFUevn2g2qSUoYMEt41DTg=;
 b=KdfrxoBj27XeMPo+opeMRQJUtyY9NxfBqqU2OimW6EgdIRvQ4LU9nd4BN0W1M0uEoo
 EEqvwNBVStpqh+FDp++mZeSqHpcXcWOsftXCBGGorevYJf6PpsRbY+9Vp8vLfykUxo14
 YoTafOtOdyU2X/c2OzCM3zC7q4/eaPfQE3VKapUqrYUCYJjbGgd4jwiniHfjHrPSKJqm
 0SxqrfanPg6BGC0uHW2TaLuKovp6RYvhKb7+OtQjX0pXrrj0yU7hEqSBI4B6xJlaK1tJ
 iSUC7dxpr8OiXALvDExLeZFGQNnvwI8Aeh+okc9GJ5QzdL2u4OjP62vtr3ZSPonLF5Bx
 q2eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=LShIjmc7MPKNcJQC0b7I/MFUevn2g2qSUoYMEt41DTg=;
 b=d0UtqWB1IabK3B+HXs59mt/33VOPc2whH7PWCBkSwRihD6ATvxjKjWUx4nWffopf7z
 vmDQUPkCsCPFW3QjbVRRMXm0bNo2TciPEt1vBCsKCevMPwwNcwBfFEBZ7v+Sb5FRQr3E
 b/5sW6bLpQyxdd3GPxA6QPzst++9XCuXKnamuBXekVCQEJLjXW054vxKlTsmz+4bduyt
 ZUdR1IcEGkH5X+8yCoOmxIPPns4AcKMW5WcXbFVzbue4SUkN24yy0ZKRMD00wdqZYEqF
 UyeYgnHgbssSLYHc1wuqLp3JQgVz4Lr+yvUnY2hRMYdnEOzHjid2mLjC7aQwHzcF5hwH
 t3uA==
X-Gm-Message-State: APjAAAVWKIedL0OzwD/wBbgC1GeEu93qgHmv9vLC5iJr8btE63/T+dGo
 o5IJqvfbKC0xpEboICUyIGKCRQh4QwuZdMyMo8s=
X-Google-Smtp-Source: APXvYqwBo7+IDOjta5MmpBIWV5eIJPOe+3FLooG9pwI1yc5wunIVwIvfL3vN6om4Q5GqxxXf3r4/GYHVPiDKLiVVEQM=
X-Received: by 2002:a7b:c407:: with SMTP id k7mr35801878wmi.46.1578324156699; 
 Mon, 06 Jan 2020 07:22:36 -0800 (PST)
MIME-Version: 1.0
References: <20200106144552.7205-1-peter.maydell@linaro.org>
In-Reply-To: <20200106144552.7205-1-peter.maydell@linaro.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 6 Jan 2020 19:22:23 +0400
Message-ID: <CAJ+F1C+PcER4eQhJwwE6Q-xrfn4+rTr=z+otyg2O=ZQA+sD4FQ@mail.gmail.com>
Subject: Re: [PATCH] tests/iothread: Always connect iothread GSource to a
 GMainContext
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>, QEMU <qemu-devel@nongnu.org>,
 Peter Xu <peterx@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Mon, Jan 6, 2020 at 7:03 PM Peter Maydell <peter.maydell@linaro.org> wro=
te:
>
> On older versions of glib (anything prior to glib commit 0f056ebe
> from May 2019), the implementation of g_source_ref() and
> g_source_unref() is not threadsafe for a GSource which is not
> attached to a GMainContext.
>
> QEMU's real iothread.c implementation always attaches its
> iothread->ctx's GSource to a GMainContext created for that iothread,
> so it is OK, but the simple test framework implementation in
> tests/iothread.c was not doing this.  This was causing intermittent
> assertion failures in the test-aio-multithread subtest
> "/aio/multi/mutex/contended" test on the BSD hosts.  (It's unclear
> why only BSD seems to have been affected -- perhaps a combination of
> the specific glib version being used in the VMs and their happening
> to run on a host with a lot of CPUs).
>
> Borrow the iothread_init_gcontext() from the real iothread.c
> and add the corresponding cleanup code and the calls to
> g_main_context_push/pop_thread_default() so we actually use
> the GMainContext we create.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> I don't really have a good understanding of the glib APIs here,
> so I'm mostly just cribbing code from the real iothread.c;
> review by people who do know the glib/iothread stuff better
> welcomed. It does seem to fix the intermittent test failure
> on NetBSD, at least, where we were running into an assertion
> failure because a g_source_unref() incorrectly thought it
> had decremented the refcount to 0 and should delete a context
> that was actually still in use.
>
>  tests/iothread.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>
> diff --git a/tests/iothread.c b/tests/iothread.c
> index 13c9fdcd8df..d3a2ee9a014 100644
> --- a/tests/iothread.c
> +++ b/tests/iothread.c
> @@ -21,6 +21,8 @@
>
>  struct IOThread {
>      AioContext *ctx;
> +    GMainContext *worker_context;
> +    GMainLoop *main_loop;
>
>      QemuThread thread;
>      QemuMutex init_done_lock;
> @@ -35,6 +37,17 @@ AioContext *qemu_get_current_aio_context(void)
>      return my_iothread ? my_iothread->ctx : qemu_get_aio_context();
>  }
>
> +static void iothread_init_gcontext(IOThread *iothread)
> +{
> +    GSource *source;
> +
> +    iothread->worker_context =3D g_main_context_new();
> +    source =3D aio_get_g_source(iothread_get_aio_context(iothread));
> +    g_source_attach(source, iothread->worker_context);
> +    g_source_unref(source);
> +    iothread->main_loop =3D g_main_loop_new(iothread->worker_context, TR=
UE);
> +}
> +
>  static void *iothread_run(void *opaque)
>  {
>      IOThread *iothread =3D opaque;
> @@ -44,6 +57,20 @@ static void *iothread_run(void *opaque)
>      my_iothread =3D iothread;
>      qemu_mutex_lock(&iothread->init_done_lock);
>      iothread->ctx =3D aio_context_new(&error_abort);
> +
> +    /*
> +     * We must connect the ctx to a GMainContext, because in older versi=
ons
> +     * of glib the g_source_ref()/unref() functions are not threadsafe
> +     * on sources without a context.
> +     */
> +    iothread_init_gcontext(iothread);
> +
> +    /*
> +     * g_main_context_push_thread_default() must be called before anythi=
ng
> +     * in this new thread uses glib.

in/if, I suppose

> +     */
> +    g_main_context_push_thread_default(iothread->worker_context);
> +
>      qemu_cond_signal(&iothread->init_done_cond);
>      qemu_mutex_unlock(&iothread->init_done_lock);
>
> @@ -51,6 +78,7 @@ static void *iothread_run(void *opaque)
>          aio_poll(iothread->ctx, true);
>      }
>
> +    g_main_context_pop_thread_default(iothread->worker_context);
>      rcu_unregister_thread();
>      return NULL;
>  }
> @@ -66,6 +94,8 @@ void iothread_join(IOThread *iothread)
>  {
>      aio_bh_schedule_oneshot(iothread->ctx, iothread_stop_bh, iothread);
>      qemu_thread_join(&iothread->thread);
> +    g_main_context_unref(iothread->worker_context);
> +    g_main_loop_unref(iothread->main_loop);
>      qemu_cond_destroy(&iothread->init_done_cond);
>      qemu_mutex_destroy(&iothread->init_done_lock);
>      aio_context_unref(iothread->ctx);
> --
> 2.20.1
>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


--=20
Marc-Andr=C3=A9 Lureau

