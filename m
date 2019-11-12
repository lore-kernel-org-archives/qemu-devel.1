Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD75C17440
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 17:10:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE52C2196E
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 17:10:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t6k3m8gE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE52C2196E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUZgd-0003FX-6a
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 12:10:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58578)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iUZfy-0002lE-6m
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 12:09:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iUZfw-00079w-Vi
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 12:09:57 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:34461)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iUZfw-00079H-No
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 12:09:56 -0500
Received: by mail-wr1-x444.google.com with SMTP id e6so19462160wrw.1
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2019 09:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=+8X2fw+lpiGEVyw/TSnjv5VUz1kjUlvOB6+1svjsaqc=;
 b=t6k3m8gEQShAZFagrNgeQG0qRjU/SAWph4XRyo9hgp+J9lUCTZzJOoj0A86mfmI1Y+
 nUU3QpeQXUnTVY8pDxl3VUGtmsf2ArWTA1ATW5wHGtB+IG65vKbnUQSW7D1+r07VlYVI
 5sOsCgDinXdTJEvHCuVOFERuHnPg9uQhaeEzC0XYClreYieyIgLkFR0bdf10qHK0G1bB
 3jH6ED3TSfjQB/UlqK7zcxaEgyoeNHdZUhBKb/6NbvbfLOMCmqJV4//QpASrSrYe8pqk
 l49OP0Jfn1xgrShCcnQM+VtychOZn8Pc25oGK2c9Drsh8WI1osZu0qqlxVvhhDZTXnaZ
 gr/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=+8X2fw+lpiGEVyw/TSnjv5VUz1kjUlvOB6+1svjsaqc=;
 b=LqTqmVAF+Lh9HT0abn2IotlCYhw29bSvTIDPrJPblIsiuccOCeoJ1T939+zBGv8xiZ
 pVpzpTMepTtCfA1mdE4WwWnO8XivdrzxniNSAxXrnWT4CTVmIznnKij2xM+GRJM6h6Hp
 mdxsxwE0cJZla6pLfGG1yvKVaVo6tL4gxVVaB7+tgppEcoprwpNNfR4h0Y9+TZ2clU4Y
 vOS9C4onI256SH9ZXvvWSsRTsR4MQHyAmf7+sY0MkhKOdAs2CODzOYzaV+aJBA3ifFqS
 MdOt8ZNyL/R6tRKH9K/xTAFkwlsMCLrgnrovSy+Md2XSHNZnZBvC5/6Xwvr+xm8bALhm
 0DXg==
X-Gm-Message-State: APjAAAU3KaeIMDphczmwRLeD2W3kIWhXOnl0Mn7WlAL0jhMZce+JmLWe
 SEju/kK4vxcbe5ZwvHIFiPS0Tg==
X-Google-Smtp-Source: APXvYqzDU3IQQuwM8MNnV4QUhvmpAyR1Rb+bHEY6cpHVTmsaAI9kYVI1p9wjtMiqNHM8bXFQCPjk+g==
X-Received: by 2002:a5d:5391:: with SMTP id d17mr321340wrv.382.1573578594947; 
 Tue, 12 Nov 2019 09:09:54 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id h140sm4470875wme.22.2019.11.12.09.09.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2019 09:09:53 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 080E91FF87;
 Tue, 12 Nov 2019 17:09:53 +0000 (GMT)
References: <20191112150105.2498-1-robert.foley@linaro.org>
 <20191112150105.2498-2-robert.foley@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Robert Foley <robert.foley@linaro.org>
Subject: Re: [PATCH v1 1/5] Add a mutex to guarantee single writer to
 qemu_logfile handle.
In-reply-to: <20191112150105.2498-2-robert.foley@linaro.org>
Date: Tue, 12 Nov 2019 17:09:52 +0000
Message-ID: <87r22d81i7.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: peter.puhov@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Robert Foley <robert.foley@linaro.org> writes:

> Also added qemu_logfile_init() for initializing the logfile mutex.
>
> Signed-off-by: Robert Foley <robert.foley@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
> v1
>     - changed qemu_logfile_init() to use __constructor__.
> ---
>  util/log.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/util/log.c b/util/log.c
> index 1ca13059ee..c25643dc99 100644
> --- a/util/log.c
> +++ b/util/log.c
> @@ -24,8 +24,10 @@
>  #include "qapi/error.h"
>  #include "qemu/cutils.h"
>  #include "trace/control.h"
> +#include "qemu/thread.h"
>
>  static char *logfilename;
> +static QemuMutex qemu_logfile_mutex;
>  FILE *qemu_logfile;
>  int qemu_loglevel;
>  static int log_append =3D 0;
> @@ -49,6 +51,11 @@ int qemu_log(const char *fmt, ...)
>      return ret;
>  }
>
> +static void __attribute__((__constructor__)) qemu_logfile_init(void)
> +{
> +    qemu_mutex_init(&qemu_logfile_mutex);
> +}
> +
>  static bool log_uses_own_buffers;
>
>  /* enable or disable low levels log */
> @@ -58,6 +65,9 @@ void qemu_set_log(int log_flags)
>  #ifdef CONFIG_TRACE_LOG
>      qemu_loglevel |=3D LOG_TRACE;
>  #endif
> +
> +    g_assert(qemu_logfile_mutex.initialized);
> +    qemu_mutex_lock(&qemu_logfile_mutex);
>      if (!qemu_logfile &&
>          (is_daemonized() ? logfilename !=3D NULL : qemu_loglevel)) {
>          if (logfilename) {
> @@ -93,6 +103,7 @@ void qemu_set_log(int log_flags)
>              log_append =3D 1;
>          }
>      }
> +    qemu_mutex_unlock(&qemu_logfile_mutex);
>      if (qemu_logfile &&
>          (is_daemonized() ? logfilename =3D=3D NULL : !qemu_loglevel)) {
>          qemu_log_close();
> @@ -230,12 +241,15 @@ void qemu_log_flush(void)
>  /* Close the log file */
>  void qemu_log_close(void)
>  {
> +    g_assert(qemu_logfile_mutex.initialized);
> +    qemu_mutex_lock(&qemu_logfile_mutex);
>      if (qemu_logfile) {
>          if (qemu_logfile !=3D stderr) {
>              fclose(qemu_logfile);
>          }
>          qemu_logfile =3D NULL;
>      }
> +    qemu_mutex_unlock(&qemu_logfile_mutex);
>  }
>
>  const QEMULogItem qemu_log_items[] =3D {


--
Alex Benn=C3=A9e

