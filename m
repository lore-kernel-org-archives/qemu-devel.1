Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5473C3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 13:55:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F56D2070B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 13:55:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CP9pmPUX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F56D2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2bws-0003FR-Nz
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 09:55:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35142)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1i2buI-0001TZ-HT
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 09:53:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1i2buH-0006wA-89
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 09:53:10 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:45644)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1i2buG-0006ub-W7
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 09:53:09 -0400
Received: by mail-wr1-x444.google.com with SMTP id q12so18864647wrj.12
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2019 06:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=HaE10EfUUmAgAVGwqnjCbQvf4W8D0ODY+dAVSSK+wgE=;
 b=CP9pmPUXsqCuYI0KgJxUoyxi2DwaMcYnyaSBMcv5Oxda+sOvmnLi0m0WSMdd+Xs/Ll
 nkcxF+8Z49fsOLR6lZ8Be5EYMSj8Kgn6CyGdUxzVtynDVwcFpd028rb/vsuedf2zNrra
 DT11L0leeqPr1cWNKYgztD296LCjqhcm97UY2CNafL5AVMQlaoluoLcolD5nmvZYalcQ
 o4NJS0cRYGEFU6Sl5tP48yB5SVsR66WFzAG/C+Q5dbhid9tH5UEKra0advBJc6QwHQ0A
 fzPA7jKjLhd1IcuXTPdu3wJTkU5bduFCRGo2vDwxJPIYdKvp+sOxT6IKHDsUMeKJHDp1
 ZR7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=HaE10EfUUmAgAVGwqnjCbQvf4W8D0ODY+dAVSSK+wgE=;
 b=X45OnpzbmU3kovKMkkvvO1wK9D7QAeOxzY4Z4V3wrV9WyXYOKXl576969bLp+DgBys
 ji76BfE6v6VHXcgI78ce1ae5yb2I17656FB727L51XNZdgXrJ9hQFylD1P4hrRLE20TG
 Ncm06P8dsaCt++iPWWZ/fApP1gXhEZseO+ehgXxs0JCPHLsSiJehS/MpTBUVfUPy8REy
 gELZfgf11hjuBCqqbm5yPnug8sWn8dwq4ehiF/7gV9OIlX9o7Joe1eFN5JnMqXcqnwbb
 7trfG6FB0IO3X+H0qL4rsw+Ay5JZ9/kEh3d5Vo8JHciE48UVITz3sxqlyR3ZsOwEPoRS
 QOxg==
X-Gm-Message-State: APjAAAWaQgDspn4QCLi+STFUHHdc1iKBwWYwQT/5eJktFWsKfdkSOjrL
 BOThupzY8SRxNNoYf9/VNNmNdfCaW97px492fdY=
X-Google-Smtp-Source: APXvYqx6Ph9aLMrfRnUTiFvb6SWbM1qJ2vW6GqwOGRM6nuBnFnN3x/KDHHC23X+tfoistVmBt7bSqyl0znZaUsTzQps=
X-Received: by 2002:a05:6000:12c3:: with SMTP id
 l3mr29199265wrx.100.1566913987652; 
 Tue, 27 Aug 2019 06:53:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190827120221.15725-1-yury-kotov@yandex-team.ru>
 <20190827120221.15725-3-yury-kotov@yandex-team.ru>
In-Reply-To: <20190827120221.15725-3-yury-kotov@yandex-team.ru>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 27 Aug 2019 17:52:55 +0400
Message-ID: <CAJ+F1C+hfru6+hOv5=mdJuTMQnPngahZr7ukzfgvkufWgDZjcw@mail.gmail.com>
To: Yury Kotov <yury-kotov@yandex-team.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [PATCH 2/3] tests/libqtest: Allow to set expected
 exit status
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, yc-core@yandex-team.ru,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Tue, Aug 27, 2019 at 4:09 PM Yury Kotov <yury-kotov@yandex-team.ru> wrot=
e:
>
> Add qtest_set_expected_status function to set expected exit status of
> child process. By default expected exit status is 0.
>
> Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
> ---
>  tests/libqtest.c | 14 +++++++++++---
>  tests/libqtest.h |  9 +++++++++
>  2 files changed, 20 insertions(+), 3 deletions(-)
>

I sent a vary similar patch with v1 of dbus-vmstate, and dropped it
because it no longer needs it in v2 (for now) "tests: add
qtest_set_exit_status()".

Your function is better named already.


> diff --git a/tests/libqtest.c b/tests/libqtest.c
> index 2713b86cf7..118d779c1b 100644
> --- a/tests/libqtest.c
> +++ b/tests/libqtest.c
> @@ -43,6 +43,7 @@ struct QTestState
>      int qmp_fd;
>      pid_t qemu_pid;  /* our child QEMU process */
>      int wstatus;
> +    int expected_status;
>      bool big_endian;
>      bool irq_level[MAX_IRQ];
>      GString *rx;
> @@ -113,6 +114,11 @@ bool qtest_probe_child(QTestState *s)
>      return false;
>  }
>
> +void qtest_set_expected_status(QTestState *s, int status)
> +{
> +    s->expected_status =3D status;
> +}
> +
>  static void kill_qemu(QTestState *s)
>  {
>      pid_t pid =3D s->qemu_pid;
> @@ -130,11 +136,12 @@ static void kill_qemu(QTestState *s)
>       * fishy and should be logged with as much detail as possible.
>       */
>      wstatus =3D s->wstatus;
> -    if (wstatus) {
> +    if (WEXITSTATUS(wstatus) !=3D s->expected_status) {

Shouldn't it check WEXITSTATUS value only when WIFEXITED ?

>          if (WIFEXITED(wstatus)) {
>              fprintf(stderr, "%s:%d: kill_qemu() tried to terminate QEMU =
"
> -                    "process but encountered exit status %d\n",
> -                    __FILE__, __LINE__, WEXITSTATUS(wstatus));
> +                    "process but encountered exit status %d (expected %d=
)\n",
> +                    __FILE__, __LINE__, WEXITSTATUS(wstatus),
> +                    s->expected_status);
>          } else if (WIFSIGNALED(wstatus)) {
>              int sig =3D WTERMSIG(wstatus);
>              const char *signame =3D strsignal(sig) ?: "unknown ???";
> @@ -248,6 +255,7 @@ QTestState *qtest_init_without_qmp_handshake(const ch=
ar *extra_args)
>      g_test_message("starting QEMU: %s", command);
>
>      s->wstatus =3D 0;
> +    s->expected_status =3D 0;
>      s->qemu_pid =3D fork();
>      if (s->qemu_pid =3D=3D 0) {
>          setenv("QEMU_AUDIO_DRV", "none", true);
> diff --git a/tests/libqtest.h b/tests/libqtest.h
> index 07ea35867c..c00bca94af 100644
> --- a/tests/libqtest.h
> +++ b/tests/libqtest.h
> @@ -997,4 +997,13 @@ void qmp_assert_error_class(QDict *rsp, const char *=
class);
>   */
>  bool qtest_probe_child(QTestState *s);
>
> +/**
> + * qtest_set_expected_status:
> + * @s: QTestState instance to operate on.
> + * @status: an expected exit status.
> + *
> + * Set expected exit status of the child.
> + */
> +void qtest_set_expected_status(QTestState *s, int status);
> +
>  #endif
> --
> 2.22.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

