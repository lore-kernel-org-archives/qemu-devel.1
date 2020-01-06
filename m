Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 382DFC33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 17:31:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 045F220731
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 17:31:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i5zSuDfT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 045F220731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioWDS-0004Q6-NP
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 12:30:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58005)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1ioWAs-00023s-Lr
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 12:28:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1ioWAr-0004uP-DP
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 12:28:18 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55824
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ioWAq-0004no-6l
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 12:28:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578331692;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OHS2sduA76AI3c1sKnI5Jfj8g0QTHHvPGmPTRd3rBaM=;
 b=i5zSuDfTRSsstgORRz+wj+Sim9Vj36BrCuM8Xm/g5d6hiPfpI99vccYeltDkLl9lMcHM8h
 eD1ZO1N7vsCqAsN+vNlrbT6Xof+MkzVeUE2iBSeNbK+n3U0on/GPZ9KdfL6yZR4td3a1cK
 CUDdg+uaqbUFkeZUSPlSHqBjMz2EKFQ=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-eVyVzuSyPOafGdLM2h8GUA-1; Mon, 06 Jan 2020 12:28:11 -0500
Received: by mail-qv1-f71.google.com with SMTP id u11so27653804qvo.8
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2020 09:28:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=eAfBAUuLMDhgJE01vSyz3TXKZTqVIvYbqzCR1E6koZo=;
 b=TeZHYoyAEICHIK4jaA78mwDeeavgh1cfDOEahPQygcHQl3FQutsD3tlXoDGMOVtnWO
 wkAhbymMfGj0rpj4ndxGjrUn/ekzTscaKnmNSDfT28OGHvpAa+fLal8nXE0k6//ysV77
 Zai2/7n0J6STjy7fpr/IapEm7mqYMBAytt6ZjniDu1/Srr+nx6VTE1JwYD07ZCGkvDkv
 JLcGb2dZtVEiSy8gP0bTAMTY2aTIqHUpMg7En4RJiZvBtXmtPpAAdXZCQhY2q4ZgWbYp
 /YWMhHB+b5txnVzf1KZZIWiB1O3rtDL7D146DmYBtAPNfRx+1KhRjrqILUmV4jb8Dsuf
 WBBA==
X-Gm-Message-State: APjAAAUVSMPpONtu6C0enGKr2w6dx+YZtj36MA9ZjKVGZZSwYhVbiEi+
 +3BWDOiTNH1xgyjF+YmJGyiISq9fdlaE6Ut/h5zXFY2EayBEcasX/S9hPoAjSGUxAal5CC05haM
 +kXT67giiFdrD8/E=
X-Received: by 2002:ac8:7155:: with SMTP id h21mr71831563qtp.95.1578331691207; 
 Mon, 06 Jan 2020 09:28:11 -0800 (PST)
X-Google-Smtp-Source: APXvYqx5eB5lw+sDX7Syl6Et2xEbvORhqZX08ffiqo8uSHPD0Av7eguNZ8YBZqRXsRLl3fyocCwLdQ==
X-Received: by 2002:ac8:7155:: with SMTP id h21mr71831544qtp.95.1578331690869; 
 Mon, 06 Jan 2020 09:28:10 -0800 (PST)
Received: from xz-x1 ([104.156.64.74])
 by smtp.gmail.com with ESMTPSA id w21sm24232143qth.17.2020.01.06.09.28.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2020 09:28:10 -0800 (PST)
Date: Mon, 6 Jan 2020 12:28:08 -0500
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] tests/iothread: Always connect iothread GSource to a
 GMainContext
Message-ID: <20200106172808.GB219677@xz-x1>
References: <20200106144552.7205-1-peter.maydell@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20200106144552.7205-1-peter.maydell@linaro.org>
X-MC-Unique: eVyVzuSyPOafGdLM2h8GUA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jan 06, 2020 at 02:45:52PM +0000, Peter Maydell wrote:
> On older versions of glib (anything prior to glib commit 0f056ebe
> from May 2019), the implementation of g_source_ref() and
> g_source_unref() is not threadsafe for a GSource which is not
> attached to a GMainContext.
>=20
> QEMU's real iothread.c implementation always attaches its
> iothread->ctx's GSource to a GMainContext created for that iothread,
> so it is OK, but the simple test framework implementation in
> tests/iothread.c was not doing this.  This was causing intermittent
> assertion failures in the test-aio-multithread subtest
> "/aio/multi/mutex/contended" test on the BSD hosts.  (It's unclear
> why only BSD seems to have been affected -- perhaps a combination of
> the specific glib version being used in the VMs and their happening
> to run on a host with a lot of CPUs).
>=20
> Borrow the iothread_init_gcontext() from the real iothread.c
> and add the corresponding cleanup code and the calls to
> g_main_context_push/pop_thread_default() so we actually use
> the GMainContext we create.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

I've no idea on the g_source_ref() issue, but if so then a patch like
this makes sense to me especially if it fixes up test failures.

Reviewed-by: Peter Xu <peterx@redhat.com>

Still a few comments below.

> ---
> I don't really have a good understanding of the glib APIs here,
> so I'm mostly just cribbing code from the real iothread.c;
> review by people who do know the glib/iothread stuff better
> welcomed. It does seem to fix the intermittent test failure
> on NetBSD, at least, where we were running into an assertion
> failure because a g_source_unref() incorrectly thought it
> had decremented the refcount to 0 and should delete a context
> that was actually still in use.
>=20
>  tests/iothread.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>=20
> diff --git a/tests/iothread.c b/tests/iothread.c
> index 13c9fdcd8df..d3a2ee9a014 100644
> --- a/tests/iothread.c
> +++ b/tests/iothread.c
> @@ -21,6 +21,8 @@
> =20
>  struct IOThread {
>      AioContext *ctx;
> +    GMainContext *worker_context;
> +    GMainLoop *main_loop;
> =20
>      QemuThread thread;
>      QemuMutex init_done_lock;
> @@ -35,6 +37,17 @@ AioContext *qemu_get_current_aio_context(void)
>      return my_iothread ? my_iothread->ctx : qemu_get_aio_context();
>  }
> =20
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

IIUC the main_loop is not required because in this case we only use
the aio context to run rather than the main context itself.

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
> +     */
> +    g_main_context_push_thread_default(iothread->worker_context);

IMHO if all the users of tests/iothread.c are block layers who only
uses the aio context directly, then I think this is not needed too.

Thanks,

> +
>      qemu_cond_signal(&iothread->init_done_cond);
>      qemu_mutex_unlock(&iothread->init_done_lock);
> =20
> @@ -51,6 +78,7 @@ static void *iothread_run(void *opaque)
>          aio_poll(iothread->ctx, true);
>      }
> =20
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
> --=20
> 2.20.1
>=20

--=20
Peter Xu


