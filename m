Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D49C3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 15:38:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91863214DA
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 15:38:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="fgW8lbUX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91863214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2dXy-0001dN-HF
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 11:38:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51124)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yury-kotov@yandex-team.ru>) id 1i2dJg-0002kb-8a
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 11:23:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yury-kotov@yandex-team.ru>) id 1i2dJc-0000HB-JN
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 11:23:25 -0400
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:43170)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yury-kotov@yandex-team.ru>)
 id 1i2dJb-0000FE-GP
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 11:23:24 -0400
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net
 [IPv6:2a02:6b8:0:1402::301])
 by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id DC7612E1482;
 Tue, 27 Aug 2019 18:23:17 +0300 (MSK)
Received: from localhost (localhost [::1])
 by mxbackcorp1g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id
 TxfTe3gQQo-NHJqLlgu; Tue, 27 Aug 2019 18:23:17 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1566919397; bh=+0IZVpOZ2cdcfZ8j9t6KXzXTSh315nNZ1gmaVBnPyOg=;
 h=Subject:In-Reply-To:Cc:Date:References:To:From:Message-Id;
 b=fgW8lbUX03s3IndBG3dj1fItUv5sNMupoSSkMveZIwlMiTkjt+4MhbwDgqg1aS6ba
 7e+b51eHlas3GPLXQ0MFLqB5nRE/C1RIKEj/w9k8ZegAsK/3/kjOfkBfLq8tcJC5F2
 ah7IuzcCIbAFXeLdRwUgiKBanJjLFAKk91dWkKcw=
Authentication-Results: mxbackcorp1g.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
X-Yandex-Sender-Uid: 1120000000071945
X-Yandex-Avir: 1
Received: from mxbackcorp2j.mail.yandex.net (localhost [::1])
 by mxbackcorp2j.mail.yandex.net with LMTP id LxhNhjRzjy-4IriKeO1
 for <yury-kotov@yandex-team.ru>; Tue, 27 Aug 2019 18:23:06 +0300
Received: by sas1-fc7737ec834f.qloud-c.yandex.net with HTTP;
 Tue, 27 Aug 2019 18:23:06 +0300
From: Yury Kotov <yury-kotov@yandex-team.ru>
To: =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
In-Reply-To: <CAJ+F1C+hfru6+hOv5=mdJuTMQnPngahZr7ukzfgvkufWgDZjcw@mail.gmail.com>
References: <20190827120221.15725-1-yury-kotov@yandex-team.ru>
 <20190827120221.15725-3-yury-kotov@yandex-team.ru>
 <CAJ+F1C+hfru6+hOv5=mdJuTMQnPngahZr7ukzfgvkufWgDZjcw@mail.gmail.com>
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date: Tue, 27 Aug 2019 18:23:16 +0300
Message-Id: <865911566919386@sas1-fc7737ec834f.qloud-c.yandex.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 77.88.29.217
Subject: Re: [Qemu-devel] [PATCH 2/3] tests/libqtest: Allow to set expected
 exit status
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

27.08.2019, 16:53, "Marc-Andr=C3=A9 Lureau" <marcandre.lureau@gmail.com>:
> Hi
>
> On Tue, Aug 27, 2019 at 4:09 PM Yury Kotov <yury-kotov@yandex-team.ru> =
wrote:
>> =C2=A0Add qtest_set_expected_status function to set expected exit stat=
us of
>> =C2=A0child process. By default expected exit status is 0.
>>
>> =C2=A0Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
>> =C2=A0---
>> =C2=A0=C2=A0tests/libqtest.c | 14 +++++++++++---
>> =C2=A0=C2=A0tests/libqtest.h | 9 +++++++++
>> =C2=A0=C2=A02 files changed, 20 insertions(+), 3 deletions(-)
>
> I sent a vary similar patch with v1 of dbus-vmstate, and dropped it
> because it no longer needs it in v2 (for now) "tests: add
> qtest_set_exit_status()".
>
> Your function is better named already.
>

Thanks, I'll look at this realization

>> =C2=A0diff --git a/tests/libqtest.c b/tests/libqtest.c
>> =C2=A0index 2713b86cf7..118d779c1b 100644
>> =C2=A0--- a/tests/libqtest.c
>> =C2=A0+++ b/tests/libqtest.c
>> =C2=A0@@ -43,6 +43,7 @@ struct QTestState
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int qmp_fd;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pid_t qemu_pid; /* our child QEMU =
process */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int wstatus;
>> =C2=A0+ int expected_status;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bool big_endian;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bool irq_level[MAX_IRQ];
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0GString *rx;
>> =C2=A0@@ -113,6 +114,11 @@ bool qtest_probe_child(QTestState *s)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return false;
>> =C2=A0=C2=A0}
>>
>> =C2=A0+void qtest_set_expected_status(QTestState *s, int status)
>> =C2=A0+{
>> =C2=A0+ s->expected_status =3D status;
>> =C2=A0+}
>> =C2=A0+
>> =C2=A0=C2=A0static void kill_qemu(QTestState *s)
>> =C2=A0=C2=A0{
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pid_t pid =3D s->qemu_pid;
>> =C2=A0@@ -130,11 +136,12 @@ static void kill_qemu(QTestState *s)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* fishy and should be logged=
 with as much detail as possible.
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*/
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0wstatus =3D s->wstatus;
>> =C2=A0- if (wstatus) {
>> =C2=A0+ if (WEXITSTATUS(wstatus) !=3D s->expected_status) {
>
> Shouldn't it check WEXITSTATUS value only when WIFEXITED ?
>

Oh, it seems that you're right. I'll fix it in v2

>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (WIFEXI=
TED(wstatus)) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0fprintf(stderr, "%s:%d: kill_qemu() tried to terminate QEMU "
>> =C2=A0- "process but encountered exit status %d\n",
>> =C2=A0- __FILE__, __LINE__, WEXITSTATUS(wstatus));
>> =C2=A0+ "process but encountered exit status %d (expected %d)\n",
>> =C2=A0+ __FILE__, __LINE__, WEXITSTATUS(wstatus),
>> =C2=A0+ s->expected_status);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0} else if =
(WIFSIGNALED(wstatus)) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0int sig =3D WTERMSIG(wstatus);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0const char *signame =3D strsignal(sig) ?: "unknown ???";
>> =C2=A0@@ -248,6 +255,7 @@ QTestState *qtest_init_without_qmp_handshake=
(const char *extra_args)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0g_test_message("starting QEMU: %s"=
, command);
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0s->wstatus =3D 0;
>> =C2=A0+ s->expected_status =3D 0;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0s->qemu_pid =3D fork();
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (s->qemu_pid =3D=3D 0) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0setenv("QE=
MU_AUDIO_DRV", "none", true);
>> =C2=A0diff --git a/tests/libqtest.h b/tests/libqtest.h
>> =C2=A0index 07ea35867c..c00bca94af 100644
>> =C2=A0--- a/tests/libqtest.h
>> =C2=A0+++ b/tests/libqtest.h
>> =C2=A0@@ -997,4 +997,13 @@ void qmp_assert_error_class(QDict *rsp, con=
st char *class);
>> =C2=A0=C2=A0=C2=A0*/
>> =C2=A0=C2=A0bool qtest_probe_child(QTestState *s);
>>
>> =C2=A0+/**
>> =C2=A0+ * qtest_set_expected_status:
>> =C2=A0+ * @s: QTestState instance to operate on.
>> =C2=A0+ * @status: an expected exit status.
>> =C2=A0+ *
>> =C2=A0+ * Set expected exit status of the child.
>> =C2=A0+ */
>> =C2=A0+void qtest_set_expected_status(QTestState *s, int status);
>> =C2=A0+
>> =C2=A0=C2=A0#endif
>> =C2=A0--
>> =C2=A02.22.0
>
> --
> Marc-Andr=C3=A9 Lureau

Regards,
Yury

