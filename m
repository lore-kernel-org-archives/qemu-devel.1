Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B2FDC43331
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 17:06:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFFFA2077C
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 17:06:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S4N92UZd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFFFA2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSlEl-0005Br-TH
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 12:06:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45293)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iSl2k-0007Hl-Db
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 11:54:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iSl2i-0003KE-9V
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 11:53:58 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:50264)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iSl2Y-0003Hu-Nn
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 11:53:50 -0500
Received: by mail-wm1-x344.google.com with SMTP id l17so2461202wmh.0
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2019 08:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=HCQGCtmuwjtYx72ZypYwDHyCsYnSsp6GyNhsHSD01wQ=;
 b=S4N92UZdX+FgjVBcl8yidGQkIFUVEAG7b/uoRpOW8hLh94f7f7TZhBjXqcePyLRekC
 OedSLGtPdlh5+C9SAmFC7jrKptiiZcypkEl+PlcR5GUldKeafnHyY4qO/A8Hux0cdh50
 RP8429GC3G7PgV3L0MoItK/fUAd6DVjWnu3UfeY/a/dyJyMWiEtmk0QG1Y440qGm/sBu
 P6fv6DfpSHbOU6m1Bzs0r6QoBYXiGjkRtLLTlVN2S9+XEVtnagYO+vvPfkdUy0MrSgMk
 /GG1Paz4tDXZvKxpfY9rsmLBauZ9XPdLNCQzUN/7fbs8lIh+fb7eVXl874Cs/jscCpb2
 Iq7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=HCQGCtmuwjtYx72ZypYwDHyCsYnSsp6GyNhsHSD01wQ=;
 b=CyGv6fOB2DrubXiZET1yxbXtAImFQugH4gCxPxitJx04RzfUvzc+pz+LdI0jLVAQdI
 xsZ11GbBiMB6ZB4/+yydI+eClfzWY3nB0x0lLWicyALSHzjaaH0qxaFVFSb86nTdVXak
 ksLe8xvHnWlIiFxwqfwnXOwNvtHQq14rmZ15uswb09AgdPChl9c9FpM5ep2433vZlgmb
 AmuMaJrCcmLocNE85pSHu4hTn9UqgFaMoIMgm2eL1RL9B3hWfZqVjyPMLtDNAfPFkyEa
 85ak/fzHS3TIoy9gQR6UbV0voErnYBke6QapN+3j1mIHpexZc9WlLNutAYXd3SHuWaoR
 ThpQ==
X-Gm-Message-State: APjAAAVU0rT/5GaWmVjvhqpmFdJ1MZgSBlWMYiP+WqO/zS7hXoov9ITv
 60YHB73yKFYFZI2gAkfZ/vZLuQ==
X-Google-Smtp-Source: APXvYqzjSSTvCxNQCH7nk8ycWErMVrbbtdLamXn0DLDKdqJ6Hg2+rt5KEZPwZSv/1ouYTBkpydF8EA==
X-Received: by 2002:a05:600c:2202:: with SMTP id
 z2mr3781076wml.162.1573145623477; 
 Thu, 07 Nov 2019 08:53:43 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f14sm2536790wrv.17.2019.11.07.08.53.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Nov 2019 08:53:42 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D69991FF87;
 Thu,  7 Nov 2019 16:53:41 +0000 (GMT)
References: <20191107142613.2379-1-robert.foley@linaro.org>
 <20191107142613.2379-2-robert.foley@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Robert Foley <robert.foley@linaro.org>
Subject: Re: [PATCH 1/4] Add a mutex to guarantee single writer to
 qemu_logfile handle.
In-reply-to: <20191107142613.2379-2-robert.foley@linaro.org>
Date: Thu, 07 Nov 2019 16:53:41 +0000
Message-ID: <87o8xnhbl6.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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

> This is being added in preparation for using RCU with the logfile handle.
> Also added qemu_logfile_init() for initializing the logfile mutex.
>
> Signed-off-by: Robert Foley <robert.foley@linaro.org>
> ---
>  util/log.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/util/log.c b/util/log.c
> index 1ca13059ee..dff2f98c8c 100644
> --- a/util/log.c
> +++ b/util/log.c
> @@ -24,8 +24,11 @@
>  #include "qapi/error.h"
>  #include "qemu/cutils.h"
>  #include "trace/control.h"
> +#include "qemu/thread.h"
>
>  static char *logfilename;
> +static bool qemu_logfile_initialized;
> +static QemuMutex qemu_logfile_mutex;
>  FILE *qemu_logfile;
>  int qemu_loglevel;
>  static int log_append =3D 0;
> @@ -49,6 +52,14 @@ int qemu_log(const char *fmt, ...)
>      return ret;
>  }
>
> +static void qemu_logfile_init(void)
> +{
> +    if (!qemu_logfile_initialized) {
> +        qemu_mutex_init(&qemu_logfile_mutex);
> +        qemu_logfile_initialized =3D true;
> +    }
> +}
> +
>  static bool log_uses_own_buffers;
>
>  /* enable or disable low levels log */
> @@ -58,6 +69,12 @@ void qemu_set_log(int log_flags)
>  #ifdef CONFIG_TRACE_LOG
>      qemu_loglevel |=3D LOG_TRACE;
>  #endif
> +
> +    /* Is there a better place to call this to init the logfile subsyste=
m? */
> +    if (!qemu_logfile_initialized) {
> +        qemu_logfile_init();
> +    }

It wouldn't be the worst thing in the world to expose:

  qemu_logfile_init()

and make vl.c and main.c call it before the setup. Then you can drop the
flag or even just g_assert(qemu_log_mutex_initialised) in qemu_set_log
and qemu_set_logfile.

In fact you could just use:

  static void __attribute__((__constructor__)) qemu_logfile_init(void)

and make the compiler do it for you.

> +    qemu_mutex_lock(&qemu_logfile_mutex);
>      if (!qemu_logfile &&
>          (is_daemonized() ? logfilename !=3D NULL : qemu_loglevel)) {
>          if (logfilename) {
> @@ -93,6 +110,7 @@ void qemu_set_log(int log_flags)
>              log_append =3D 1;
>          }
>      }
> +    qemu_mutex_unlock(&qemu_logfile_mutex);
>      if (qemu_logfile &&
>          (is_daemonized() ? logfilename =3D=3D NULL : !qemu_loglevel)) {
>          qemu_log_close();
> @@ -114,6 +132,11 @@ void qemu_set_log_filename(const char *filename, Err=
or **errp)
>      char *pidstr;
>      g_free(logfilename);
>
> +    /* Is there a better place to call this to init the logfile subsyste=
m? */
> +    if (!qemu_logfile_initialized) {
> +        qemu_logfile_init();
> +    }
> +
>      pidstr =3D strstr(filename, "%");
>      if (pidstr) {
>          /* We only accept one %d, no other format strings */


--
Alex Benn=C3=A9e

