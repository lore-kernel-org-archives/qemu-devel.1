Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB60C432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 20:51:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79B5D2071E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 20:51:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QybNkiRV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79B5D2071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibsfF-0001uS-MB
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 15:51:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47247)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1ibse6-0000hm-HO
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 15:50:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1ibse1-0000vI-Sl
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 15:50:12 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:36469
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ibse1-0000ut-D6
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 15:50:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575319808;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SigqRXSI6kbtCV64VQYYoQQHUkhDakFp3Ak43zI92zA=;
 b=QybNkiRVI79DSr7qIIWlC4A42ZACbZZEX7JhXwaBuXyxgHO+2KOC/so9IDKB/4TBkjbb0l
 WlYFJj2gyJJ4gdSfsAeE0RpSu+Fly1Ih0B0WugdGve4Yw6Udd/VehZPpX1qqw/5IqYPESA
 Swtf+XzIvxt1g+1R5SInhAag2gy+Ac0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-sFCh8dUBPRKQhof3SN8A_A-1; Mon, 02 Dec 2019 15:50:05 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 02E3363CD5;
 Mon,  2 Dec 2019 20:50:02 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6E04F5C240;
 Mon,  2 Dec 2019 20:49:58 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0119D1138606; Mon,  2 Dec 2019 21:49:56 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Yury Kotov <yury-kotov@yandex-team.ru>
Subject: Re: [PATCH] monitor: Fix slow reading
References: <20191122092347.28309-1-yury-kotov@yandex-team.ru>
 <87v9r3w0ro.fsf@dusky.pond.sub.org>
 <324361575308591@sas1-20474e4ea3be.qloud-c.yandex.net>
Date: Mon, 02 Dec 2019 21:49:56 +0100
In-Reply-To: <324361575308591@sas1-20474e4ea3be.qloud-c.yandex.net> (Yury
 Kotov's message of "Mon, 02 Dec 2019 20:43:21 +0300")
Message-ID: <87wobea1vv.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: sFCh8dUBPRKQhof3SN8A_A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Dr. David Alan
 Gilbert" <dgilbert@redhat.com>, Denis Plotnikov <dplotnikov@virtuozzo.com>,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
 "Denis V. Lunev" <den@openvz.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Yury Kotov <yury-kotov@yandex-team.ru> writes:

> Hi!
>
> 29.11.2019, 11:22, "Markus Armbruster" <armbru@redhat.com>:
>> Yury Kotov <yury-kotov@yandex-team.ru> writes:
>>
>>> =C2=A0The monitor_can_read (as a callback of qemu_chr_fe_set_handlers)
>>> =C2=A0should return size of buffer which monitor_qmp_read or monitor_re=
ad
>>> =C2=A0can process.
>>> =C2=A0Currently, monitor_can_read returns 1 as a result of logical not.
>>> =C2=A0Thus, for each QMP command, len(QMD) iterations of the main loop
>>> =C2=A0are required to handle a command.
>>> =C2=A0In fact, these both functions can process any buffer size.
>>> =C2=A0So, return 1024 as a reasonable size which is enough to process
>>> =C2=A0the most QMP commands, but not too big to block the main loop for
>>> =C2=A0a long time.
>>>
>>> =C2=A0Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
>>> =C2=A0---
>>> =C2=A0=C2=A0monitor/monitor.c | 9 ++++++++-
>>> =C2=A0=C2=A01 file changed, 8 insertions(+), 1 deletion(-)
>>>
>>> =C2=A0diff --git a/monitor/monitor.c b/monitor/monitor.c
>>> =C2=A0index 12898b6448..cac3f39727 100644
>>> =C2=A0--- a/monitor/monitor.c
>>> =C2=A0+++ b/monitor/monitor.c
>>> =C2=A0@@ -50,6 +50,13 @@ typedef struct {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int64_t rate; /* Minimum time (in n=
s) between two events */
>>> =C2=A0=C2=A0} MonitorQAPIEventConf;
>>>
>>> =C2=A0+/*
>>> =C2=A0+ * The maximum buffer size which the monitor can process in one =
iteration
>>> =C2=A0+ * of the main loop. We don't want to block the loop for a long =
time
>>> =C2=A0+ * because of JSON parser, so use a reasonable value.
>>> =C2=A0+ */
>>> =C2=A0+#define MONITOR_READ_LEN_MAX 1024
>>> =C2=A0+
>>> =C2=A0=C2=A0/* Shared monitor I/O thread */
>>> =C2=A0=C2=A0IOThread *mon_iothread;
>>>
>>> =C2=A0@@ -498,7 +505,7 @@ int monitor_can_read(void *opaque)
>>> =C2=A0=C2=A0{
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Monitor *mon =3D opaque;
>>>
>>> =C2=A0- return !atomic_mb_read(&mon->suspend_cnt);
>>> =C2=A0+ return atomic_mb_read(&mon->suspend_cnt) ? 0 : MONITOR_READ_LEN=
_MAX;
>>> =C2=A0=C2=A0}
>>>
>>> =C2=A0=C2=A0void monitor_list_append(Monitor *mon)
>>
>> Prior attempt:
>> [PATCH 1/1] monitor: increase amount of data for monitor to read
>> Message-Id: <1493732857-10721-1-git-send-email-den@openvz.org>
>> https://lists.nongnu.org/archive/html/qemu-devel/2017-05/msg00206.html
>>
>> Review concluded that it breaks HMP command migrate without -d. QMP is
>> probably okay. Sadly, no v2.
>>
>> Next one:
>> Subject: [PATCH] monitor: increase amount of data for monitor to read
>> Message-Id: <20190610105906.28524-1-dplotnikov@virtuozzo.com>
>> https://lists.nongnu.org/archive/html/qemu-devel/2019-06/msg01912.html
>>
>> Same patch, with a second, suspicious-looking hunk thrown in. I didn't
>> make the connection to the prior attempt back then. I wrote "I think I
>> need to (re-)examine how QMP reads input, with special consideration to
>> its OOB feature."
>>
>> This patch is a cleaner variation on the same theme. Its ramifications
>> are as unobvious as ever.
>>
>> I figure the HMP situation is unchanged: not safe, although we could
>> probably make it safe if we wanted to (Daniel sketched how). My simpler
>> suggestion stands: separate f_can_read() callbacks for HMP and QMP
>> [PATCH 1], then change only the one for QMP [PATCH 2].
>>
>> The QMP situation is also unchanged: we still need to think through how
>> this affects reading of QMP input, in particular OOB.
>
> I've read the discussion around patches:
> "monitor: increase amount of data for monitor to read"
> and realized the problem.
>
> It seems that my patch actually has some bugs with HMP and OOB
> because of suspend/resume.

For HMP we're sure, for OOB we don't know.

> IIUC there are some approaches to fix them:
>
> 1) Input buffer
>   1. Add input buffer for Monitor struct
>   2. Handle commands from monitor_xxx_read callbacks one by one
>   3. Schedule BH to handle remaining bytes in the buffer
>
> 2) Input buffer for suspend/resume
>   1. Add input buffer for Monitor struct
>   2. Handle multiple commands until monitor is not suspended
>   3. If monitor suspended, put remaining data to the buffer
>   4. Handle remaining data in the buffer when we get resume
>
> We use QEMU 2.12 which doesn't have the full support of OOB and for which=
 it's
> enough to fix HMP case by separating can_read callbacks. But those who us=
e
> a newer version of QEMU can use OOB feature to improve HMP/QMP performanc=
e.

OOB isn't for monitor performance, it's for monitor availability.

QMP executes one command after the other.  While a command executes, the
monitor is effectively unavailable.  This can be a problem.  OOB
execution lets you execute a few special commands right away, without
waiting for prior commands to complete.

> So, I'm not sure there's a big sense in introducing some buffers.

Reading byte-wise is pretty pathetic, but it works.  I'm not sure how
much performance buffers can gain us, and whether it's worth the
necessary review effort.  How QMP reads input is not trivial, thanks to
OOB.

Have you measured the improvement?


