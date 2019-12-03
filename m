Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A14C432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 08:30:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC3CF2053B
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 08:30:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="bpSHVj7x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC3CF2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ic3ZK-0001oW-Rt
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 03:30:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40234)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yury-kotov@yandex-team.ru>) id 1ic3XM-0000Tp-MP
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 03:28:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yury-kotov@yandex-team.ru>) id 1ic3XE-00071m-AU
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 03:27:56 -0500
Received: from forwardcorp1p.mail.yandex.net
 ([2a02:6b8:0:1472:2741:0:8b6:217]:57110)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yury-kotov@yandex-team.ru>)
 id 1ic3X8-0006wW-1S
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 03:27:48 -0500
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net
 [IPv6:2a02:6b8:0:1619::119])
 by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id BA6112E153B;
 Tue,  3 Dec 2019 11:27:40 +0300 (MSK)
Received: from localhost (localhost [::1])
 by mxbackcorp2j.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id
 vTAXRDL4Qv-Rev8NfPs; Tue, 03 Dec 2019 11:27:40 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1575361660; bh=3eQdbf7lTtOzcP1hFTyMtJ+3kGVeB+hbqIfMT228wjA=;
 h=Cc:Subject:Date:References:To:From:Message-Id;
 b=bpSHVj7x2Dt2pVA5ZCntXLfSV/kzOaagHD+5RLiwwO4mEA25GAkeJH8TDaXF/WYLf
 Je8GXSVtxtO+9rTAvLEp9Bz4Ur3ptepsFCF7n2HUJXAJeQao6tJEnHRMsfBLM/Wnl8
 zymrPC1fjsFDN7ct5zYUqRgBP/vqNDU9E0OWjJuE=
Authentication-Results: mxbackcorp2j.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
X-Yandex-Sender-Uid: 1120000000071945
X-Yandex-Avir: 1
Received: from mxbackcorp1g.mail.yandex.net (localhost [::1])
 by mxbackcorp1g.mail.yandex.net with LMTP id DN8Z2l0ILW-4xqbSb5V
 for <yury-kotov@yandex-team.ru>; Tue, 03 Dec 2019 11:27:29 +0300
Received: by vla1-6bb9290e4d68.qloud-c.yandex.net with HTTP;
 Tue, 03 Dec 2019 11:27:29 +0300
From: Yury Kotov <yury-kotov@yandex-team.ru>
To: Markus Armbruster <armbru@redhat.com>
References: <20191122092347.28309-1-yury-kotov@yandex-team.ru>
 <87v9r3w0ro.fsf@dusky.pond.sub.org>
 <324361575308591@sas1-20474e4ea3be.qloud-c.yandex.net>
 <87wobea1vv.fsf@dusky.pond.sub.org>
Subject: Re: [PATCH] monitor: Fix slow reading
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date: Tue, 03 Dec 2019 11:27:39 +0300
Message-Id: <490061575361649@vla1-6bb9290e4d68.qloud-c.yandex.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a02:6b8:0:1472:2741:0:8b6:217
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
 "Denis V. Lunev" <den@openvz.org>,
 =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

02.12.2019, 23:50, "Markus Armbruster" <armbru@redhat.com>:
> Yury Kotov <yury-kotov@yandex-team.ru> writes:
>
>> =C2=A0Hi!
>>
>> =C2=A029.11.2019, 11:22, "Markus Armbruster" <armbru@redhat.com>:
>>> =C2=A0Yury Kotov <yury-kotov@yandex-team.ru> writes:
>>>
>>>> =C2=A0=C2=A0The monitor_can_read (as a callback of qemu_chr_fe_set_h=
andlers)
>>>> =C2=A0=C2=A0should return size of buffer which monitor_qmp_read or m=
onitor_read
>>>> =C2=A0=C2=A0can process.
>>>> =C2=A0=C2=A0Currently, monitor_can_read returns 1 as a result of log=
ical not.
>>>> =C2=A0=C2=A0Thus, for each QMP command, len(QMD) iterations of the m=
ain loop
>>>> =C2=A0=C2=A0are required to handle a command.
>>>> =C2=A0=C2=A0In fact, these both functions can process any buffer siz=
e.
>>>> =C2=A0=C2=A0So, return 1024 as a reasonable size which is enough to =
process
>>>> =C2=A0=C2=A0the most QMP commands, but not too big to block the main=
 loop for
>>>> =C2=A0=C2=A0a long time.
>>>>
>>>> =C2=A0=C2=A0Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
>>>> =C2=A0=C2=A0---
>>>> =C2=A0=C2=A0=C2=A0monitor/monitor.c | 9 ++++++++-
>>>> =C2=A0=C2=A0=C2=A01 file changed, 8 insertions(+), 1 deletion(-)
>>>>
>>>> =C2=A0=C2=A0diff --git a/monitor/monitor.c b/monitor/monitor.c
>>>> =C2=A0=C2=A0index 12898b6448..cac3f39727 100644
>>>> =C2=A0=C2=A0--- a/monitor/monitor.c
>>>> =C2=A0=C2=A0+++ b/monitor/monitor.c
>>>> =C2=A0=C2=A0@@ -50,6 +50,13 @@ typedef struct {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int64_t rate; /* Minimum t=
ime (in ns) between two events */
>>>> =C2=A0=C2=A0=C2=A0} MonitorQAPIEventConf;
>>>>
>>>> =C2=A0=C2=A0+/*
>>>> =C2=A0=C2=A0+ * The maximum buffer size which the monitor can proces=
s in one iteration
>>>> =C2=A0=C2=A0+ * of the main loop. We don't want to block the loop fo=
r a long time
>>>> =C2=A0=C2=A0+ * because of JSON parser, so use a reasonable value.
>>>> =C2=A0=C2=A0+ */
>>>> =C2=A0=C2=A0+#define MONITOR_READ_LEN_MAX 1024
>>>> =C2=A0=C2=A0+
>>>> =C2=A0=C2=A0=C2=A0/* Shared monitor I/O thread */
>>>> =C2=A0=C2=A0=C2=A0IOThread *mon_iothread;
>>>>
>>>> =C2=A0=C2=A0@@ -498,7 +505,7 @@ int monitor_can_read(void *opaque)
>>>> =C2=A0=C2=A0=C2=A0{
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Monitor *mon =3D opaque;
>>>>
>>>> =C2=A0=C2=A0- return !atomic_mb_read(&mon->suspend_cnt);
>>>> =C2=A0=C2=A0+ return atomic_mb_read(&mon->suspend_cnt) ? 0 : MONITOR=
_READ_LEN_MAX;
>>>> =C2=A0=C2=A0=C2=A0}
>>>>
>>>> =C2=A0=C2=A0=C2=A0void monitor_list_append(Monitor *mon)
>>>
>>> =C2=A0Prior attempt:
>>> =C2=A0[PATCH 1/1] monitor: increase amount of data for monitor to rea=
d
>>> =C2=A0Message-Id: <1493732857-10721-1-git-send-email-den@openvz.org>
>>> =C2=A0https://lists.nongnu.org/archive/html/qemu-devel/2017-05/msg002=
06.html
>>>
>>> =C2=A0Review concluded that it breaks HMP command migrate without -d.=
 QMP is
>>> =C2=A0probably okay. Sadly, no v2.
>>>
>>> =C2=A0Next one:
>>> =C2=A0Subject: [PATCH] monitor: increase amount of data for monitor t=
o read
>>> =C2=A0Message-Id: <20190610105906.28524-1-dplotnikov@virtuozzo.com>
>>> =C2=A0https://lists.nongnu.org/archive/html/qemu-devel/2019-06/msg019=
12.html
>>>
>>> =C2=A0Same patch, with a second, suspicious-looking hunk thrown in. I=
 didn't
>>> =C2=A0make the connection to the prior attempt back then. I wrote "I =
think I
>>> =C2=A0need to (re-)examine how QMP reads input, with special consider=
ation to
>>> =C2=A0its OOB feature."
>>>
>>> =C2=A0This patch is a cleaner variation on the same theme. Its ramifi=
cations
>>> =C2=A0are as unobvious as ever.
>>>
>>> =C2=A0I figure the HMP situation is unchanged: not safe, although we =
could
>>> =C2=A0probably make it safe if we wanted to (Daniel sketched how). My=
 simpler
>>> =C2=A0suggestion stands: separate f_can_read() callbacks for HMP and =
QMP
>>> =C2=A0[PATCH 1], then change only the one for QMP [PATCH 2].
>>>
>>> =C2=A0The QMP situation is also unchanged: we still need to think thr=
ough how
>>> =C2=A0this affects reading of QMP input, in particular OOB.
>>
>> =C2=A0I've read the discussion around patches:
>> =C2=A0"monitor: increase amount of data for monitor to read"
>> =C2=A0and realized the problem.
>>
>> =C2=A0It seems that my patch actually has some bugs with HMP and OOB
>> =C2=A0because of suspend/resume.
>
> For HMP we're sure, for OOB we don't know.
>
>> =C2=A0IIUC there are some approaches to fix them:
>>
>> =C2=A01) Input buffer
>> =C2=A0=C2=A0=C2=A01. Add input buffer for Monitor struct
>> =C2=A0=C2=A0=C2=A02. Handle commands from monitor_xxx_read callbacks o=
ne by one
>> =C2=A0=C2=A0=C2=A03. Schedule BH to handle remaining bytes in the buff=
er
>>
>> =C2=A02) Input buffer for suspend/resume
>> =C2=A0=C2=A0=C2=A01. Add input buffer for Monitor struct
>> =C2=A0=C2=A0=C2=A02. Handle multiple commands until monitor is not sus=
pended
>> =C2=A0=C2=A0=C2=A03. If monitor suspended, put remaining data to the b=
uffer
>> =C2=A0=C2=A0=C2=A04. Handle remaining data in the buffer when we get r=
esume
>>
>> =C2=A0We use QEMU 2.12 which doesn't have the full support of OOB and =
for which it's
>> =C2=A0enough to fix HMP case by separating can_read callbacks. But tho=
se who use
>> =C2=A0a newer version of QEMU can use OOB feature to improve HMP/QMP p=
erformance.
>
> OOB isn't for monitor performance, it's for monitor availability.
>
> QMP executes one command after the other. While a command executes, the
> monitor is effectively unavailable. This can be a problem. OOB
> execution lets you execute a few special commands right away, without
> waiting for prior commands to complete.
>
>> =C2=A0So, I'm not sure there's a big sense in introducing some buffers=
.
>
> Reading byte-wise is pretty pathetic, but it works. I'm not sure how
> much performance buffers can gain us, and whether it's worth the
> necessary review effort. How QMP reads input is not trivial, thanks to
> OOB.
>
> Have you measured the improvement?

Honestly, I have a different use case than Denis. But I think his assessm=
ent
of this improvement is reasonable.

My use case (sorry I didn't mention it before):
I need this improvement to make sure that a single iteration of the main =
loop
will be enough to handle at least a single QMP command.

It's helpful for my another patch:
https://lists.gnu.org/archive/html/qemu-devel/2019-11/msg04100.html

If incoming migration yields for just a single byte of QMP stream so it n=
eeds
about 30 such yields to handle something like query-status to check wheth=
er
incoming-QEMU is still alive or not.

Regards,
Yury


