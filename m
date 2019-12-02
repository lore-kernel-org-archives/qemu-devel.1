Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46018C432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 17:44:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1138820640
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 17:44:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="f8utoL2d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1138820640
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibpkF-0003QQ-72
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 12:44:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53479)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yury-kotov@yandex-team.ru>) id 1ibpjR-0002X7-I1
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 12:43:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yury-kotov@yandex-team.ru>) id 1ibpjO-0002UW-08
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 12:43:31 -0500
Received: from forwardcorp1o.mail.yandex.net ([2a02:6b8:0:1a2d::193]:45202)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yury-kotov@yandex-team.ru>)
 id 1ibpjN-0002TS-BI
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 12:43:29 -0500
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net
 [IPv6:2a02:6b8:0:1619::162])
 by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id BD2772E098C;
 Mon,  2 Dec 2019 20:43:22 +0300 (MSK)
Received: from localhost (localhost [::1])
 by mxbackcorp1j.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id
 NP05IZlEk4-hM3qJFnD; Mon, 02 Dec 2019 20:43:22 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1575308602; bh=ScrJYaAtQW+dWJ+Xzc+JwaCZ8bJ3P8PHxzvCBEAPhMs=;
 h=Subject:In-Reply-To:Cc:Date:References:To:From:Message-Id;
 b=f8utoL2dMo46IE9/4lHbmDWyaXwYsEl/BW+ECtN4BQR2P/3JQia0hc9iQWL3Vy0sa
 QQe1L9w0ZL+Uf121cbUfO2x5eYVe+7rRDCuutsil0FndltFEo0GkHi739x5QMvFDTF
 ez5wQSvipidJacrKap9G7ZKWqMEFupLExsx8jBTI=
Authentication-Results: mxbackcorp1j.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
X-Yandex-Sender-Uid: 1120000000071945
X-Yandex-Avir: 1
Received: from mxbackcorp1g.mail.yandex.net (localhost [::1])
 by mxbackcorp1g.mail.yandex.net with LMTP id 5Io0GLbCdq-yTjZvSte
 for <yury-kotov@yandex-team.ru>; Mon, 02 Dec 2019 20:43:12 +0300
Received: by sas1-20474e4ea3be.qloud-c.yandex.net with HTTP;
 Mon, 02 Dec 2019 20:43:11 +0300
From: Yury Kotov <yury-kotov@yandex-team.ru>
To: Markus Armbruster <armbru@redhat.com>
In-Reply-To: <87v9r3w0ro.fsf@dusky.pond.sub.org>
References: <20191122092347.28309-1-yury-kotov@yandex-team.ru>
 <87v9r3w0ro.fsf@dusky.pond.sub.org>
Subject: Re: [PATCH] monitor: Fix slow reading
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date: Mon, 02 Dec 2019 20:43:21 +0300
Message-Id: <324361575308591@sas1-20474e4ea3be.qloud-c.yandex.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a02:6b8:0:1a2d::193
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
 =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 "Denis V. Lunev" <den@openvz.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi!

29.11.2019, 11:22, "Markus Armbruster" <armbru@redhat.com>:
> Yury Kotov <yury-kotov@yandex-team.ru> writes:
>
>> =C2=A0The monitor_can_read (as a callback of qemu_chr_fe_set_handlers)
>> =C2=A0should return size of buffer which monitor_qmp_read or monitor_r=
ead
>> =C2=A0can process.
>> =C2=A0Currently, monitor_can_read returns 1 as a result of logical not=
.
>> =C2=A0Thus, for each QMP command, len(QMD) iterations of the main loop
>> =C2=A0are required to handle a command.
>> =C2=A0In fact, these both functions can process any buffer size.
>> =C2=A0So, return 1024 as a reasonable size which is enough to process
>> =C2=A0the most QMP commands, but not too big to block the main loop fo=
r
>> =C2=A0a long time.
>>
>> =C2=A0Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
>> =C2=A0---
>> =C2=A0=C2=A0monitor/monitor.c | 9 ++++++++-
>> =C2=A0=C2=A01 file changed, 8 insertions(+), 1 deletion(-)
>>
>> =C2=A0diff --git a/monitor/monitor.c b/monitor/monitor.c
>> =C2=A0index 12898b6448..cac3f39727 100644
>> =C2=A0--- a/monitor/monitor.c
>> =C2=A0+++ b/monitor/monitor.c
>> =C2=A0@@ -50,6 +50,13 @@ typedef struct {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int64_t rate; /* Minimum time (in =
ns) between two events */
>> =C2=A0=C2=A0} MonitorQAPIEventConf;
>>
>> =C2=A0+/*
>> =C2=A0+ * The maximum buffer size which the monitor can process in one=
 iteration
>> =C2=A0+ * of the main loop. We don't want to block the loop for a long=
 time
>> =C2=A0+ * because of JSON parser, so use a reasonable value.
>> =C2=A0+ */
>> =C2=A0+#define MONITOR_READ_LEN_MAX 1024
>> =C2=A0+
>> =C2=A0=C2=A0/* Shared monitor I/O thread */
>> =C2=A0=C2=A0IOThread *mon_iothread;
>>
>> =C2=A0@@ -498,7 +505,7 @@ int monitor_can_read(void *opaque)
>> =C2=A0=C2=A0{
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Monitor *mon =3D opaque;
>>
>> =C2=A0- return !atomic_mb_read(&mon->suspend_cnt);
>> =C2=A0+ return atomic_mb_read(&mon->suspend_cnt) ? 0 : MONITOR_READ_LE=
N_MAX;
>> =C2=A0=C2=A0}
>>
>> =C2=A0=C2=A0void monitor_list_append(Monitor *mon)
>
> Prior attempt:
> [PATCH 1/1] monitor: increase amount of data for monitor to read
> Message-Id: <1493732857-10721-1-git-send-email-den@openvz.org>
> https://lists.nongnu.org/archive/html/qemu-devel/2017-05/msg00206.html
>
> Review concluded that it breaks HMP command migrate without -d. QMP is
> probably okay. Sadly, no v2.
>
> Next one:
> Subject: [PATCH] monitor: increase amount of data for monitor to read
> Message-Id: <20190610105906.28524-1-dplotnikov@virtuozzo.com>
> https://lists.nongnu.org/archive/html/qemu-devel/2019-06/msg01912.html
>
> Same patch, with a second, suspicious-looking hunk thrown in. I didn't
> make the connection to the prior attempt back then. I wrote "I think I
> need to (re-)examine how QMP reads input, with special consideration to
> its OOB feature."
>
> This patch is a cleaner variation on the same theme. Its ramifications
> are as unobvious as ever.
>
> I figure the HMP situation is unchanged: not safe, although we could
> probably make it safe if we wanted to (Daniel sketched how). My simpler
> suggestion stands: separate f_can_read() callbacks for HMP and QMP
> [PATCH 1], then change only the one for QMP [PATCH 2].
>
> The QMP situation is also unchanged: we still need to think through how
> this affects reading of QMP input, in particular OOB.

I've read the discussion around patches:
"monitor: increase amount of data for monitor to read"
and realized the problem.

It seems that my patch actually has some bugs with HMP and OOB
because of suspend/resume.

IIUC there are some approaches to fix them:

1) Input buffer
  1. Add input buffer for Monitor struct
  2. Handle commands from monitor_xxx_read callbacks one by one
  3. Schedule BH to handle remaining bytes in the buffer

2) Input buffer for suspend/resume
  1. Add input buffer for Monitor struct
  2. Handle multiple commands until monitor is not suspended
  3. If monitor suspended, put remaining data to the buffer
  4. Handle remaining data in the buffer when we get resume

We use QEMU 2.12 which doesn't have the full support of OOB and for which=
 it's
enough to fix HMP case by separating can_read callbacks. But those who us=
e
a newer version of QEMU can use OOB feature to improve HMP/QMP performanc=
e.
So, I'm not sure there's a big sense in introducing some buffers.

Regards,
Yury

