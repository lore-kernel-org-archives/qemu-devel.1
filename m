Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21EF3C33CAF
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 09:43:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E59EA24686
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 09:43:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HUnpo+mq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E59EA24686
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuCXS-00019R-18
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 04:43:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53445)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iuCWp-0000hy-Cm
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 04:42:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iuCWn-0007Yt-Pz
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 04:42:27 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22073
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iuCWn-0007YW-MG
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 04:42:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579686145;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C7mPuvb7JtXlkS1jpOB4N9vhcOmdRWmGBBKmZ8KNHBY=;
 b=HUnpo+mqh91Bq9giujXnp5ughOuAx+s+MY7Mn1FOxuu4LiHEzRhSvAmcbv9n1Zg68s+eNO
 hN8xSSxe+7PXXb2XRlbl+qe7kVJq0VYhQgL4R3CtHpw14K4tWc1vZIE/wqmvJ21mkyfglp
 HQgh26WodpJP/GM7TPUxMPDaM6qRo7U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-DCF5huuZMe6ar_I20yZTqA-1; Wed, 22 Jan 2020 04:42:23 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 84292A0CBF;
 Wed, 22 Jan 2020 09:42:21 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-131.ams2.redhat.com
 [10.36.116.131])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6BA2989D02;
 Wed, 22 Jan 2020 09:42:18 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D94C01138600; Wed, 22 Jan 2020 10:42:16 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Yury Kotov <yury-kotov@yandex-team.ru>
Subject: Re: [PATCH 2/2] monitor: Add an input buffer for QMP reading
References: <20191219160756.22389-1-yury-kotov@yandex-team.ru>
 <20191219160756.22389-3-yury-kotov@yandex-team.ru>
Date: Wed, 22 Jan 2020 10:42:16 +0100
In-Reply-To: <20191219160756.22389-3-yury-kotov@yandex-team.ru> (Yury Kotov's
 message of "Thu, 19 Dec 2019 19:07:56 +0300")
Message-ID: <87y2tzx1xj.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: DCF5huuZMe6ar_I20yZTqA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>, yc-core@yandex-team.ru, "Denis
 V. Lunev" <den@openvz.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Long delay, compliments of the season.  My apologies!

Yury Kotov <yury-kotov@yandex-team.ru> writes:

> The monitor_qmp_can_read (as a callback of qemu_chr_fe_set_handlers)
> should return size of buffer which monitor_qmp_read can process.
> Currently, monitor_can_read returns 1, because it guarantees that
> only one QMP command can be handled at a time.
> Thus, for each QMP command, len(QMD) iterations of the main loop
> are required to handle a command.
>
> This patch adds an input buffer to speed up reading and to keep
> the guarantee of executing one command at a time.
>
> Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
> ---
>  monitor/monitor-internal.h | 11 +++++++++++
>  monitor/monitor.c          | 27 +++++++++++++++++++++++++++
>  monitor/qmp.c              | 17 +++++++++++++++--
>  3 files changed, 53 insertions(+), 2 deletions(-)
>
> diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
> index c0ba29abf1..22983b9dda 100644
> --- a/monitor/monitor-internal.h
> +++ b/monitor/monitor-internal.h
> @@ -32,6 +32,8 @@
>  #include "qemu/readline.h"
>  #include "sysemu/iothread.h"
> =20
> +#define MON_INPUT_BUFFER_SIZE   1024
> +
>  /*
>   * Supported types:
>   *
> @@ -93,6 +95,11 @@ struct Monitor {
>      gchar *mon_cpu_path;
>      QTAILQ_ENTRY(Monitor) entry;
> =20
> +    /* Must be accessed only by monitor's iothread */

Uh, a QMP monitor need not use an iothread!  More on this below at [*].

> +    char inbuf[MON_INPUT_BUFFER_SIZE];

This is the only use of macro MON_INPUT_BUFFER_SIZE.  Let's scratch the
macro.

> +    int inbuf_pos;
> +    int inbuf_len;

Not immediately obvious: this is a ring buffer.  Stating it in the
comment would help.

@input_pos is the ring buffer's read index, @inbuf_len is the amount of
data.  I prefer storing the write index instead of the amount of data
myself.  Matter of taste, okay as it is.  I wonder how many open-coded
ring buffers we have in the tree...

Why is the ring buffer in struct Monitor?  Isn't it just for QMP
monitors?

We should explain somewhere in the code *why* we buffer input.

> +
>      /*
>       * The per-monitor lock. We can't access guest memory when holding
>       * the lock.
> @@ -169,9 +176,13 @@ void monitor_data_destroy(Monitor *mon);
>  void monitor_list_append(Monitor *mon);
>  void monitor_fdsets_cleanup(void);
> =20
> +void monitor_inbuf_write(Monitor *mon, const char *buf, int size);
> +int monitor_inbuf_read(Monitor *mon, char *buf, int size);
> +
>  void qmp_send_response(MonitorQMP *mon, const QDict *rsp);
>  void monitor_data_destroy_qmp(MonitorQMP *mon);
>  void monitor_qmp_bh_dispatcher(void *data);
> +void monitor_qmp_handle_inbuf(Monitor *mon);
> =20
>  int get_monitor_def(int64_t *pval, const char *name);
>  void help_cmd(Monitor *mon, const char *name);
> diff --git a/monitor/monitor.c b/monitor/monitor.c
> index d25cc8ea4a..9eb258ac2f 100644
> --- a/monitor/monitor.c
> +++ b/monitor/monitor.c
> @@ -440,6 +440,29 @@ static gboolean qapi_event_throttle_equal(const void=
 *a, const void *b)
>      return TRUE;
>  }
> =20
> +void monitor_inbuf_write(Monitor *mon, const char *buf, int size)
> +{
> +    int pos =3D mon->inbuf_pos + mon->inbuf_len;
> +
> +    assert(size <=3D sizeof(mon->inbuf) - mon->inbuf_len);
> +    while (size-- > 0) {
> +        mon->inbuf[pos++ % sizeof(mon->inbuf)] =3D *buf++;
> +        mon->inbuf_len++;
> +    }
> +}
> +
> +int monitor_inbuf_read(Monitor *mon, char *buf, int size)
> +{
> +    int read_bytes =3D 0;
> +
> +    while (read_bytes < size && mon->inbuf_len > 0) {
> +        buf[read_bytes++] =3D mon->inbuf[mon->inbuf_pos++];
> +        mon->inbuf_pos %=3D sizeof(mon->inbuf);
> +        mon->inbuf_len--;
> +    }
> +    return read_bytes;
> +}
> +

If efficiency was a concern, we'd want to use memcpy().  Okay as it is.

>  int monitor_suspend(Monitor *mon)
>  {
>      if (monitor_is_hmp_non_interactive(mon)) {
> @@ -465,6 +488,10 @@ static void monitor_accept_input(void *opaque)
>      Monitor *mon =3D opaque;
> =20
>      qemu_chr_fe_accept_input(&mon->chr);
> +
> +    if (mon->is_qmp) {
> +        monitor_qmp_handle_inbuf(mon);
> +    }
>  }

Hmm, do we need to adjust when we call qemu_chr_fe_accept_input()?  I'll
discuss this below at [**].

> =20
>  void monitor_resume(Monitor *mon)
> diff --git a/monitor/qmp.c b/monitor/qmp.c
> index 37884c6c43..9d2634eeb3 100644
> --- a/monitor/qmp.c
> +++ b/monitor/qmp.c
> @@ -315,14 +315,27 @@ static int monitor_qmp_can_read(void *opaque)
>  {
>      Monitor *mon =3D opaque;
> =20
> -    return !atomic_mb_read(&mon->suspend_cnt);
> +    return sizeof(mon->inbuf) - mon->inbuf_len;

Can read as much as the ring buffer has space.  Good.

> +}
> +
> +void monitor_qmp_handle_inbuf(Monitor *mon)
> +{
> +    MonitorQMP *mon_qmp =3D container_of(mon, MonitorQMP, common);
> +    char ch;
> +
> +    /* Handle only one byte at a time, because monitor may become suspen=
ed */

Typo, it's "suspended".

I'm afraid the comment doesn't really explain much.  It can serve as
reminder when you already know what the problem is.  When you don't,
you're still lost.

> +    while (!atomic_mb_read(&mon->suspend_cnt) &&
> +           monitor_inbuf_read(mon, &ch, 1)) {
> +        json_message_parser_feed(&mon_qmp->parser, &ch, 1);
> +    }
>  }
> =20
>  static void monitor_qmp_read(void *opaque, const uint8_t *buf, int size)
>  {
>      MonitorQMP *mon =3D opaque;
> =20
> -    json_message_parser_feed(&mon->parser, (const char *) buf, size);
> +    monitor_inbuf_write(&mon->common, (const char *)buf, size);
> +    monitor_qmp_handle_inbuf(&mon->common);
>  }
> =20
>  static QDict *qmp_greeting(MonitorQMP *mon)

Now let's revisit the two issues I postponed.


[*] Ring buffer access rules to ensure thread safety

You state it "must be accessed only by monitor's iothread".

Quick recap of monitor iothread use:

* There is one shared monitor I/O thread @mon_iothread.

* HMP monitors do not use it.

* A QMP monitor uses it when its character device has
  QEMU_CHAR_FEATURE_GCONTEXT.

A QMP monitor that doesn't use the iothread obviously cannot satisfy
"must be accessed only by monitor's iothread".

Does this mean trouble?

Ways to access the ring buffer:

(1) monitor_inbuf_write() called from monitor_qmp_read().

(2) monitor_inbuf_read() called from monitor_qmp_handle_inbuf() called
    from monitor_qmp_read()

(3) monitor_inbuf_read() called from monitor_qmp_handle_inbuf() called
    from monitor_accept_input()

If the monitor uses @mon_iothread, it arranges for its front end char
handlers monitor_qmp_can_read(), monitor_qmp_read() and monitor_qmp_read
to run in @mon_iothread.

If the monitor does not use @mon_iothread, they run in the main thread
instead.

Therefore, any QMP monitor's (1) and (2) either run only in
@mon_iothread, or only in the main thread.

(3) runs in a bottom half scheduled by monitor_resume() to execute in
@mon_iothread's AIO context when the monitor uses @mon_iothread, else in
the main loop's AIO context.

Looks safe to me.  The comment needs fixing, though.


[**] When to call qemu_chr_fe_accept_input()

Before this patch, the monitor can read input only while it's not
suspended.  It calls qemu_chr_fe_accept_input() soon after it comes out
of suspended state: monitor_resume() arranges for it to run in the
appropriate AIO context.

After this patch, the monitor can read input while the ring buffer has
space.  The patch does not adjust when qemu_chr_fe_accept_input() is
called.

Is this okay?

Can we ever come out of suspended state with a full ring buffer?  If
yes, we run qemu_chr_fe_accept_input() even though we can't accept any.
Is that bad?

Can the ring buffer fill up without the monitor becoming suspended?  If
yes, we don't run qemu_chr_fe_accept_input() when we can accept input
again.  Is that bad?


