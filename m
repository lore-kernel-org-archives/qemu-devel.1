Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B2AC17441
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 17:37:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1129214E0
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 17:37:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v7CvWN1X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1129214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUa6z-0000Um-MA
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 12:37:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34021)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iUa5r-0008Sc-F7
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 12:36:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iUa5p-0004n1-EB
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 12:36:43 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:33046)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iUa5p-0004mZ-3h
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 12:36:41 -0500
Received: by mail-wm1-x342.google.com with SMTP id a17so2886738wmb.0
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2019 09:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=HNnxjFmrqoWz6Job3vp1ljHdw2Aiy+AK2bbUwC+SXy4=;
 b=v7CvWN1XwcQ3OukyOdzVk4BWKdYokL24fVB4WeGVkcX7VrydqITvS+/TUSNsVL0k0j
 VHMm5Nqm47qMJ/q5n4VrzttgHNrgW2f+n7l51JV6BgZMOnq47HNBYGq+feuXlGHlXjlE
 17LpmxqP2gbHESihkqNzpeYzoYdCrpDWFPZ/A997AA1XK0vbwwExs7NhChySSnWhZvSw
 3lv0PmWFgpxvbvT0q1JF8FNcnFfCnXntFCtHMnlU1ThSXT5cPHurjgOvmoNKYkNC6A3y
 MCMBlDX81uxOW0mSsUv0ErEEAhMXzTwC7XpCTJ7VIXMuJxg0YhwdUEnLLYXRSFRkm19U
 LFDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=HNnxjFmrqoWz6Job3vp1ljHdw2Aiy+AK2bbUwC+SXy4=;
 b=OOAQQS85J8pZjGbdgiHiXb72Z3hvmmq1tItROlMfQVMdAUUjNJs24grvSDuKa7aOB0
 MZ/sntlIMoHqOKco5KM5ewNUmGCsGoTIbukclthf59E7P4HTkxZFd42Ko1zXohW9Pebh
 wqBVPZz+fapGJX6LyhGYRQy58dDLvyCjn9jruHBkbi1KyiTJIWGh5kROL2LPP5IvvJCe
 xVhkOLZEU2sQf/PUc8qRUhi2Opx79jeEVoZbR0nJqaftu0zpYfl7sLEtCQNmKdF5en0e
 ZlnjW0caye3xoLgNY5sfdBZiaQV2veKBltc+YR15K0QQYbpv2DDMxAcGKgUPAHIkoj4y
 Tq/A==
X-Gm-Message-State: APjAAAWyiIVUaXfoiTfuM4k6BofeXIfFih/+QmDzoybCy7nyqhdXrvA1
 /v/UAUC4VcIGhXwaW+YitVbnVg==
X-Google-Smtp-Source: APXvYqzRGdZ+8JCHNbEIp4CyDGFAzKXpqWfQ3/MJ1xZTquCREaHQ+2gALyusSh3yrFGYoxke2EE7Sg==
X-Received: by 2002:a7b:ce84:: with SMTP id q4mr4729339wmj.36.1573580199242;
 Tue, 12 Nov 2019 09:36:39 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id h140sm4553555wme.22.2019.11.12.09.36.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2019 09:36:37 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 2A6F31FF87;
 Tue, 12 Nov 2019 17:36:37 +0000 (GMT)
References: <20191112150105.2498-1-robert.foley@linaro.org>
 <20191112150105.2498-4-robert.foley@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Robert Foley <robert.foley@linaro.org>
Subject: Re: [PATCH v1 3/5] Add use of RCU for qemu_logfile.
In-reply-to: <20191112150105.2498-4-robert.foley@linaro.org>
Date: Tue, 12 Nov 2019 17:36:37 +0000
Message-ID: <87lfsl809m.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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

> This now allows changing the logfile while logging is active,
> and also solves the issue of a seg fault while changing the logfile.
>
> Any read access to the qemu_logfile handle will use
> the rcu_read_lock()/unlock() around the use of the handle.
> To fetch the handle we will use atomic_rcu_read().
> We also in many cases do a check for validity of the
> logfile handle before using it to deal with the case where the
> file is closed and set to NULL.
>
> The cases where we write to the qemu_logfile will use atomic_rcu_set().
> Writers will also use call_rcu() with a newly added qemu_logfile_free
> function for freeing/closing when readers have finished.
>
> Signed-off-by: Robert Foley <robert.foley@linaro.org>
> ---
> v1
>     - Changes for review comments.
>     - Minor changes to definition of QemuLogFile.
>     - Changed qemu_log_separate() to fix unbalanced and
>       remove qemu_log_enabled() check.
>     - changed qemu_log_lock() to include else.
>     - make qemu_logfile_free static.
>     - use g_assert(logfile) in qemu_logfile_free.
>     - Relocated unlock out of if/else in qemu_log_close(), and
>       in qemu_set_log().
> ---
>  include/qemu/log.h | 42 ++++++++++++++++++++++----
>  util/log.c         | 73 +++++++++++++++++++++++++++++++++-------------
>  include/exec/log.h | 33 ++++++++++++++++++---
>  tcg/tcg.c          | 12 ++++++--
>  4 files changed, 128 insertions(+), 32 deletions(-)
>
> diff --git a/include/qemu/log.h b/include/qemu/log.h
> index a7c5b01571..528e1f9dd7 100644
> --- a/include/qemu/log.h
> +++ b/include/qemu/log.h
> @@ -3,9 +3,16 @@
>
>  /* A small part of this API is split into its own header */
>  #include "qemu/log-for-trace.h"
> +#include "qemu/rcu.h"
> +
> +typedef struct QemuLogFile {
> +    struct rcu_head rcu;
> +    FILE *fd;
> +} QemuLogFile;
>
>  /* Private global variable, don't use */
> -extern FILE *qemu_logfile;
> +extern QemuLogFile *qemu_logfile;
> +
>
>  /*
>   * The new API:
> @@ -25,7 +32,16 @@ static inline bool qemu_log_enabled(void)
>   */
>  static inline bool qemu_log_separate(void)
>  {
> -    return qemu_logfile !=3D NULL && qemu_logfile !=3D stderr;
> +    QemuLogFile *logfile;
> +    bool res =3D false;
> +
> +    rcu_read_lock();
> +    logfile =3D atomic_rcu_read(&qemu_logfile);
> +    if (logfile && logfile->fd !=3D stderr) {
> +        res =3D true;
> +    }
> +    rcu_read_unlock();
> +    return res;
>  }
>
>  #define CPU_LOG_TB_OUT_ASM (1 << 0)
> @@ -55,14 +71,23 @@ static inline bool qemu_log_separate(void)
>
>  static inline FILE *qemu_log_lock(void)
>  {
> -    qemu_flockfile(qemu_logfile);
> -    return logfile->fd;
> +    QemuLogFile *logfile;
> +    rcu_read_lock();
> +    logfile =3D atomic_rcu_read(&qemu_logfile);
> +    if (logfile) {
> +        qemu_flockfile(logfile->fd);
> +        return logfile->fd;
> +    } else {
> +        rcu_read_unlock();
> +        return NULL;
> +    }
>  }
>
>  static inline void qemu_log_unlock(FILE *fd)
>  {
>      if (fd) {
>          qemu_funlockfile(fd);
> +        rcu_read_unlock();
>      }
>  }
>
> @@ -73,9 +98,14 @@ static inline void qemu_log_unlock(FILE *fd)
>  static inline void GCC_FMT_ATTR(1, 0)
>  qemu_log_vprintf(const char *fmt, va_list va)
>  {
> -    if (qemu_logfile) {
> -        vfprintf(qemu_logfile, fmt, va);
> +    QemuLogFile *logfile;
> +
> +    rcu_read_lock();
> +    logfile =3D atomic_rcu_read(&qemu_logfile);
> +    if (logfile) {
> +        vfprintf(logfile->fd, fmt, va);
>      }
> +    rcu_read_unlock();
>  }
>
>  /* log only if a bit is set on the current loglevel mask:
> diff --git a/util/log.c b/util/log.c
> index c25643dc99..802b8de42e 100644
> --- a/util/log.c
> +++ b/util/log.c
> @@ -28,7 +28,7 @@
>
>  static char *logfilename;
>  static QemuMutex qemu_logfile_mutex;
> -FILE *qemu_logfile;
> +QemuLogFile *qemu_logfile;
>  int qemu_loglevel;
>  static int log_append =3D 0;
>  static GArray *debug_regions;
> @@ -37,10 +37,14 @@ static GArray *debug_regions;
>  int qemu_log(const char *fmt, ...)
>  {
>      int ret =3D 0;
> -    if (qemu_logfile) {
> +    QemuLogFile *logfile;
> +
> +    rcu_read_lock();
> +    logfile =3D atomic_rcu_read(&qemu_logfile);
> +    if (logfile) {
>          va_list ap;
>          va_start(ap, fmt);
> -        ret =3D vfprintf(qemu_logfile, fmt, ap);
> +        ret =3D vfprintf(logfile->fd, fmt, ap);
>          va_end(ap);
>
>          /* Don't pass back error results.  */
> @@ -48,6 +52,7 @@ int qemu_log(const char *fmt, ...)
>              ret =3D 0;
>          }
>      }
> +    rcu_read_unlock();
>      return ret;
>  }
>
> @@ -56,11 +61,23 @@ static void __attribute__((__constructor__)) qemu_log=
file_init(void)
>      qemu_mutex_init(&qemu_logfile_mutex);
>  }
>
> +static void qemu_logfile_free(QemuLogFile *logfile)
> +{
> +    g_assert(logfile);
> +
> +    if (logfile->fd !=3D stderr) {
> +        fclose(logfile->fd);
> +    }
> +    g_free(logfile);
> +}
> +
>  static bool log_uses_own_buffers;
>
>  /* enable or disable low levels log */
>  void qemu_set_log(int log_flags)
>  {
> +    QemuLogFile *logfile;
> +
>      qemu_loglevel =3D log_flags;
>  #ifdef CONFIG_TRACE_LOG
>      qemu_loglevel |=3D LOG_TRACE;
> @@ -70,44 +87,50 @@ void qemu_set_log(int log_flags)
>      qemu_mutex_lock(&qemu_logfile_mutex);
>      if (!qemu_logfile &&
>          (is_daemonized() ? logfilename !=3D NULL : qemu_loglevel)) {
> +        logfile =3D g_new0(QemuLogFile, 1);
>          if (logfilename) {
> -            qemu_logfile =3D fopen(logfilename, log_append ? "a" : "w");
> -            if (!qemu_logfile) {
> +            logfile->fd =3D fopen(logfilename, log_append ? "a" : "w");
> +            if (!logfile->fd) {
> +                g_free(logfile);
>                  perror(logfilename);
>                  _exit(1);
>              }
>              /* In case we are a daemon redirect stderr to logfile */
>              if (is_daemonized()) {
> -                dup2(fileno(qemu_logfile), STDERR_FILENO);
> -                fclose(qemu_logfile);
> +                dup2(fileno(logfile->fd), STDERR_FILENO);
> +                fclose(logfile->fd);
>                  /* This will skip closing logfile in qemu_log_close() */
> -                qemu_logfile =3D stderr;
> +                logfile->fd =3D stderr;
>              }
>          } else {
>              /* Default to stderr if no log file specified */
>              assert(!is_daemonized());
> -            qemu_logfile =3D stderr;
> +            logfile->fd =3D stderr;
>          }
>          /* must avoid mmap() usage of glibc by setting a buffer "by hand=
" */
>          if (log_uses_own_buffers) {
>              static char logfile_buf[4096];
>
> -            setvbuf(qemu_logfile, logfile_buf, _IOLBF, sizeof(logfile_bu=
f));
> +            setvbuf(logfile->fd, logfile_buf, _IOLBF, sizeof(logfile_buf=
));
>          } else {
>  #if defined(_WIN32)
>              /* Win32 doesn't support line-buffering, so use unbuffered o=
utput. */
> -            setvbuf(qemu_logfile, NULL, _IONBF, 0);
> +            setvbuf(logfile->fd, NULL, _IONBF, 0);
>  #else
> -            setvbuf(qemu_logfile, NULL, _IOLBF, 0);
> +            setvbuf(logfile->fd, NULL, _IOLBF, 0);
>  #endif
>              log_append =3D 1;
>          }
> +        atomic_rcu_set(&qemu_logfile, logfile);
>      }
> -    qemu_mutex_unlock(&qemu_logfile_mutex);
> +    logfile =3D qemu_logfile;

Isn't this read outside of the protection of both rcu_read_lock() and
the mutex? Could that race?

> +
>      if (qemu_logfile &&
>          (is_daemonized() ? logfilename =3D=3D NULL : !qemu_loglevel)) {
> -        qemu_log_close();
> +        atomic_rcu_set(&qemu_logfile, NULL);
> +        call_rcu(logfile, qemu_logfile_free, rcu);

I wonder if we can re-arrange the logic here so it's lets confusing? For
example the NULL qemu_loglevel can be detected at the start and we
should be able just to squash the current log and reset and go. I'm not
sure about the damonize/stdout check.

>      }
> +    qemu_mutex_unlock(&qemu_logfile_mutex);
>  }
>
>  void qemu_log_needs_buffers(void)
> @@ -123,6 +146,7 @@ void qemu_log_needs_buffers(void)
>  void qemu_set_log_filename(const char *filename, Error **errp)
>  {
>      char *pidstr;
> +
>      g_free(logfilename);

nit: stray newline
>
>      pidstr =3D strstr(filename, "%");
> @@ -235,19 +259,28 @@ out:
>  /* fflush() the log file */
>  void qemu_log_flush(void)
>  {
> -    fflush(qemu_logfile);
> +    QemuLogFile *logfile;
> +
> +    rcu_read_lock();
> +    logfile =3D atomic_rcu_read(&qemu_logfile);
> +    if (logfile) {
> +        fflush(logfile->fd);
> +    }
> +    rcu_read_unlock();
>  }
>
>  /* Close the log file */
>  void qemu_log_close(void)
>  {
> +    QemuLogFile *logfile;
> +
>      g_assert(qemu_logfile_mutex.initialized);
>      qemu_mutex_lock(&qemu_logfile_mutex);
> -    if (qemu_logfile) {
> -        if (qemu_logfile !=3D stderr) {
> -            fclose(qemu_logfile);
> -        }
> -        qemu_logfile =3D NULL;
> +    logfile =3D qemu_logfile;
> +
> +    if (logfile) {
> +        atomic_rcu_set(&qemu_logfile, NULL);
> +        call_rcu(logfile, qemu_logfile_free, rcu);
>      }
>      qemu_mutex_unlock(&qemu_logfile_mutex);
>  }
> diff --git a/include/exec/log.h b/include/exec/log.h
> index e2cfd436e6..9bd1e4aa20 100644
> --- a/include/exec/log.h
> +++ b/include/exec/log.h
> @@ -15,8 +15,15 @@
>   */
>  static inline void log_cpu_state(CPUState *cpu, int flags)
>  {
> +    QemuLogFile *logfile;
> +
>      if (qemu_log_enabled()) {
> -        cpu_dump_state(cpu, qemu_logfile, flags);
> +        rcu_read_lock();
> +        logfile =3D atomic_rcu_read(&qemu_logfile);
> +        if (logfile) {
> +            cpu_dump_state(cpu, logfile->fd, flags);
> +        }
> +        rcu_read_unlock();
>      }
>  }
>
> @@ -40,19 +47,37 @@ static inline void log_cpu_state_mask(int mask, CPUSt=
ate *cpu, int flags)
>  static inline void log_target_disas(CPUState *cpu, target_ulong start,
>                                      target_ulong len)
>  {
> -    target_disas(qemu_logfile, cpu, start, len);
> +    QemuLogFile *logfile;
> +    rcu_read_lock();
> +    logfile =3D atomic_rcu_read(&qemu_logfile);
> +    if (logfile) {
> +        target_disas(logfile->fd, cpu, start, len);
> +    }
> +    rcu_read_unlock();
>  }
>
>  static inline void log_disas(void *code, unsigned long size)
>  {
> -    disas(qemu_logfile, code, size);
> +    QemuLogFile *logfile;
> +    rcu_read_lock();
> +    logfile =3D atomic_rcu_read(&qemu_logfile);
> +    if (logfile) {
> +        disas(logfile->fd, code, size);
> +    }
> +    rcu_read_unlock();
>  }
>
>  #if defined(CONFIG_USER_ONLY)
>  /* page_dump() output to the log file: */
>  static inline void log_page_dump(void)
>  {
> -    page_dump(qemu_logfile);
> +    QemuLogFile *logfile;
> +    rcu_read_lock();
> +    logfile =3D atomic_rcu_read(&qemu_logfile);
> +    if (logfile) {
> +        page_dump(logfile->fd);
> +    }
> +    rcu_read_unlock();
>  }
>  #endif
>  #endif
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index 0511266d85..4f616ba38b 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -2114,9 +2114,17 @@ static void tcg_dump_ops(TCGContext *s, bool have_=
prefs)
>          }
>
>          if (have_prefs || op->life) {
> -            for (; col < 40; ++col) {
> -                putc(' ', qemu_logfile);
> +
> +            QemuLogFile *logfile;
> +
> +            rcu_read_lock();
> +            logfile =3D atomic_rcu_read(&qemu_logfile);
> +            if (logfile) {
> +                for (; col < 40; ++col) {
> +                    putc(' ', logfile->fd);
> +                }
>              }
> +            rcu_read_unlock();
>          }
>
>          if (op->life) {


--
Alex Benn=C3=A9e

