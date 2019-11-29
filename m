Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E1A1C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 08:29:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDAAB21774
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 08:29:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GdbqrsS/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDAAB21774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iabet-0001jr-Rw
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 03:29:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53025)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iabXW-0007WN-0o
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 03:22:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iabXM-00050L-Ml
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 03:22:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43833
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iabXM-0004ll-4u
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 03:22:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575015716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cNauFT7i5u+Z6u8QzkkV/kr9N3eZtM7Wz+4Sx5j2UAQ=;
 b=GdbqrsS/Kng9OveQgBE/EbqMMmV+zMf70v5DzwQHFtzUHR9SyWXkaFlrIffLD+Ex5qkJJD
 sWQVW8P5EklvzrhaQMFUNKkm9ABqwIXmOoRW7CyGdG9VNRHkiRAVEMtTq2iC41D3SolxeA
 s0UX1u5T7zA/ygpF0gy3pKMzNBnOpTI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-F43G1dH-OUW8cQHVDrOjLw-1; Fri, 29 Nov 2019 03:21:55 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A49A0DB8F;
 Fri, 29 Nov 2019 08:21:53 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 49E4D5D6D4;
 Fri, 29 Nov 2019 08:21:49 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CFD721138606; Fri, 29 Nov 2019 09:21:47 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Yury Kotov <yury-kotov@yandex-team.ru>
Subject: Re: [PATCH] monitor: Fix slow reading
References: <20191122092347.28309-1-yury-kotov@yandex-team.ru>
Date: Fri, 29 Nov 2019 09:21:47 +0100
In-Reply-To: <20191122092347.28309-1-yury-kotov@yandex-team.ru> (Yury Kotov's
 message of "Fri, 22 Nov 2019 12:23:47 +0300")
Message-ID: <87v9r3w0ro.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: F43G1dH-OUW8cQHVDrOjLw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
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
Cc: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, "Dr. David Alan
 Gilbert" <dgilbert@redhat.com>, Denis Plotnikov <dplotnikov@virtuozzo.com>,
 yc-core@yandex-team.ru,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 "Denis V. Lunev" <den@openvz.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Yury Kotov <yury-kotov@yandex-team.ru> writes:

> The monitor_can_read (as a callback of qemu_chr_fe_set_handlers)
> should return size of buffer which monitor_qmp_read or monitor_read
> can process.
> Currently, monitor_can_read returns 1 as a result of logical not.
> Thus, for each QMP command, len(QMD) iterations of the main loop
> are required to handle a command.
> In fact, these both functions can process any buffer size.
> So, return 1024 as a reasonable size which is enough to process
> the most QMP commands, but not too big to block the main loop for
> a long time.
>
> Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
> ---
>  monitor/monitor.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/monitor/monitor.c b/monitor/monitor.c
> index 12898b6448..cac3f39727 100644
> --- a/monitor/monitor.c
> +++ b/monitor/monitor.c
> @@ -50,6 +50,13 @@ typedef struct {
>      int64_t rate;       /* Minimum time (in ns) between two events */
>  } MonitorQAPIEventConf;
> =20
> +/*
> + * The maximum buffer size which the monitor can process in one iteratio=
n
> + * of the main loop. We don't want to block the loop for a long time
> + * because of JSON parser, so use a reasonable value.
> + */
> +#define MONITOR_READ_LEN_MAX 1024
> +
>  /* Shared monitor I/O thread */
>  IOThread *mon_iothread;
> =20
> @@ -498,7 +505,7 @@ int monitor_can_read(void *opaque)
>  {
>      Monitor *mon =3D opaque;
> =20
> -    return !atomic_mb_read(&mon->suspend_cnt);
> +    return atomic_mb_read(&mon->suspend_cnt) ? 0 : MONITOR_READ_LEN_MAX;
>  }
> =20
>  void monitor_list_append(Monitor *mon)

Prior attempt:
[PATCH 1/1] monitor: increase amount of data for monitor to read
Message-Id: <1493732857-10721-1-git-send-email-den@openvz.org>
https://lists.nongnu.org/archive/html/qemu-devel/2017-05/msg00206.html

Review concluded that it breaks HMP command migrate without -d.  QMP is
probably okay.  Sadly, no v2.

Next one:
Subject: [PATCH] monitor: increase amount of data for monitor to read
Message-Id: <20190610105906.28524-1-dplotnikov@virtuozzo.com>
https://lists.nongnu.org/archive/html/qemu-devel/2019-06/msg01912.html

Same patch, with a second, suspicious-looking hunk thrown in.  I didn't
make the connection to the prior attempt back then.  I wrote "I think I
need to (re-)examine how QMP reads input, with special consideration to
its OOB feature."

This patch is a cleaner variation on the same theme.  Its ramifications
are as unobvious as ever.

I figure the HMP situation is unchanged: not safe, although we could
probably make it safe if we wanted to (Daniel sketched how).  My simpler
suggestion stands: separate f_can_read() callbacks for HMP and QMP
[PATCH 1], then change only the one for QMP [PATCH 2].

The QMP situation is also unchanged: we still need to think through how
this affects reading of QMP input, in particular OOB.


