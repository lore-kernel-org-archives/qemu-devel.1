Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59974C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 16:24:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F7BF206DF
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 16:24:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HNuuxFD/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F7BF206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSkaX-0004Dx-3N
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 11:24:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40705)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iSkZp-0003if-JJ
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 11:24:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iSkZn-0000Dj-Cg
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 11:24:05 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:36653)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iSkZn-0000D5-3g
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 11:24:03 -0500
Received: by mail-wr1-x443.google.com with SMTP id r10so3753180wrx.3
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2019 08:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=BgOJ9n1jjbZsgSm0LJpyq2BGvnTr88O6R86l6L0ErZI=;
 b=HNuuxFD/H+B1AZEjoRrQRZOivQql6V9BbvBLQX8d3NTKR5NG2UN9aPBCeZst7G6dLx
 GNSl4DuRrzBhIx5vGcu0z+DxnjjxnS9vbk8N3WkdmdzXlJKoVg5fkO4dD+T6u8IcMtmH
 HoG7q9InZsQ6Cqkkqj8rQDf0V+KADoNIlNxeVwuUGLoR2pm3RJMsSaaf/1Kw7+nQnp88
 2i01L1CqHybRXL/81fBXWo9ztoeX9okL+wmciLROsCcIwqL5RmAnU+Cf7+Te5uHg5cyf
 PoyjpeEss1kte2M0tdD8udaxJ6pmRH6s4zSOYsIlW5vZS8FCxP572AKQMV0IMVio5bd6
 GKcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=BgOJ9n1jjbZsgSm0LJpyq2BGvnTr88O6R86l6L0ErZI=;
 b=ff/LOrYqIP9gOwxkc2WuSHfWgKQujU1tNcpQJdfTDgZIAo+LSiWFLt177m0xRD5eRR
 +CHux4tUktT2LtU3xyNWAO8KDpIZhvENZXCCvS4LfffesjQk4hfHmvJWTAw9OmsT8Voc
 yhC0dK+XWXnOcn0e+9gBR7853G5NzARNWJ8vp9Ja6F/sFDnqrGOOqyMWypzxWtKPwCHl
 GNTgNqePRStKmKz7+wd4ek1bmDtaM/Y/mN3GG0QBekdPn1HuJPYEBENKH1jPcta0KgLp
 rw6gs0u5KUmIsG71hYSvN4awvFg8/EPWJkzsug0cy0th39zSxttQLPe3AOwyE/hheBbB
 UDDQ==
X-Gm-Message-State: APjAAAWm0/r3+kiyq7hPY6Zd8wXGerosNPaiG89bVj57xxPc1go876mM
 1kKIOIvow3Ix0JEhwmlfpzsXSQ==
X-Google-Smtp-Source: APXvYqyhFgpgBRjq0E6BwiZKLeBljbQdCV5CJmUL3vaRKwuh2G3X08eA5byqGp82b7LQfl0EWeBy8g==
X-Received: by 2002:adf:ee10:: with SMTP id y16mr3653962wrn.67.1573143841540; 
 Thu, 07 Nov 2019 08:24:01 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 200sm3847353wme.32.2019.11.07.08.24.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Nov 2019 08:24:00 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8EA111FF87;
 Thu,  7 Nov 2019 16:23:59 +0000 (GMT)
References: <20191107142613.2379-1-robert.foley@linaro.org>
 <20191107142613.2379-3-robert.foley@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Robert Foley <robert.foley@linaro.org>
Subject: Re: [PATCH 2/4] Add use of RCU for qemu_logfile.
In-reply-to: <20191107142613.2379-3-robert.foley@linaro.org>
Date: Thu, 07 Nov 2019 16:23:59 +0000
Message-ID: <87zhh7hcyo.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
>  include/qemu/log.h | 47 ++++++++++++++++++++++++----
>  util/log.c         | 78 ++++++++++++++++++++++++++++++++++------------
>  include/exec/log.h | 33 +++++++++++++++++---
>  tcg/tcg.c          | 12 +++++--
>  4 files changed, 138 insertions(+), 32 deletions(-)
>
> diff --git a/include/qemu/log.h b/include/qemu/log.h
> index a91105b2ad..975de18e23 100644
> --- a/include/qemu/log.h
> +++ b/include/qemu/log.h
> @@ -3,9 +3,17 @@
>
>  /* A small part of this API is split into its own header */
>  #include "qemu/log-for-trace.h"
> +#include "qemu/rcu.h"
> +
> +struct QemuLogFile {
> +    struct rcu_head rcu;
> +    FILE *fd;
> +};
> +typedef struct QemuLogFile QemuLogFile;

If you are declaring a typedef then do it in one:

  typedef struct QemuLogFile { ...

We only really use the second form for opaque structs where the handle
is passed around but the contents hidden from the rest of QEMU.

>
>  /* Private global variable, don't use */
> -extern FILE *qemu_logfile;
> +extern QemuLogFile *qemu_logfile;
> +

Do we need multiple

>
>  /*
>   * The new API:
> @@ -25,7 +33,17 @@ static inline bool qemu_log_enabled(void)
>   */
>  static inline bool qemu_log_separate(void)
>  {
> -    return qemu_logfile !=3D NULL && qemu_logfile !=3D stderr;
> +    QemuLogFile *logfile;
> +
> +    if (qemu_log_enabled()) {
> +        rcu_read_lock();
> +        logfile =3D atomic_rcu_read(&qemu_logfile);
> +        if (logfile && logfile->fd !=3D stderr) {
> +            return true;
> +        }
> +        rcu_read_unlock();
> +    }
> +    return false;

This is unbalanced as you'll have incremented the reader count. Also
qemu_log_enabled() is also synonymous with logfile existing so you could
fold that into:

  bool res =3D false;

  rcu_read_lock();
  *logfile =3D atomic_rcu_read(&qemu_logfile);
  if (logfile && logfile->fd !=3D stderr) {
     res =3D true;
  }
  rcu_read_unlock();
  return res;

There is technically a race there as the answer may become invalid after
qemu_log_separate() returns. However given the users I don't see what
could fail afterwards.


>  }
>
>  #define CPU_LOG_TB_OUT_ASM (1 << 0)
> @@ -55,12 +73,23 @@ static inline bool qemu_log_separate(void)
>
>  static inline void qemu_log_lock(void)
>  {
> -    qemu_flockfile(qemu_logfile);
> +    QemuLogFile *logfile;
> +    rcu_read_lock();
> +    logfile =3D atomic_rcu_read(&qemu_logfile);
> +    if (logfile) {
> +        qemu_flockfile(logfile->fd);
> +    }
> +    rcu_read_unlock();
>  }

static inline FILE *fd qemu_log_lock(void)
{
    FILE *fd;
    rcu_read_lock();
    fd =3D atomic_rcu_read(&qemu_logfile);
    if (fd) {
        qemu_flockfile(fd);
        return fd;
    } else {
        rcu_read_unlock();
        return NULL;
    }
}

static inline qemu_log_unlock(FILE *fd)
{
    if (fd) {
        qemu_funlockfile(fd);
        rcu_read_unlock();
    }
}

While the rcu_read_lock() is in progress then we won't ever finish with
the fd - which we don't want to do until the file locking is finished.

<snip>
>
>  /* Logging functions: */
> @@ -70,9 +99,14 @@ static inline void qemu_log_unlock(void)
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
> @@ -129,5 +163,6 @@ void qemu_print_log_usage(FILE *f);
>  void qemu_log_flush(void);
>  /* Close the log file */
>  void qemu_log_close(void);
> +void qemu_logfile_free(QemuLogFile *logfile);
>
>  #endif
> diff --git a/util/log.c b/util/log.c
> index dff2f98c8c..d409532b8f 100644
> --- a/util/log.c
> +++ b/util/log.c
> @@ -29,7 +29,7 @@
>  static char *logfilename;
>  static bool qemu_logfile_initialized;
>  static QemuMutex qemu_logfile_mutex;
> -FILE *qemu_logfile;
> +QemuLogFile *qemu_logfile;
>  int qemu_loglevel;
>  static int log_append =3D 0;
>  static GArray *debug_regions;
> @@ -38,10 +38,14 @@ static GArray *debug_regions;
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
> @@ -49,6 +53,7 @@ int qemu_log(const char *fmt, ...)
>              ret =3D 0;
>          }
>      }
> +    rcu_read_unlock();
>      return ret;
>  }
>
> @@ -65,6 +70,8 @@ static bool log_uses_own_buffers;
>  /* enable or disable low levels log */
>  void qemu_set_log(int log_flags)
>  {
> +    QemuLogFile *logfile;
> +
>      qemu_loglevel =3D log_flags;
>  #ifdef CONFIG_TRACE_LOG
>      qemu_loglevel |=3D LOG_TRACE;
> @@ -77,43 +84,51 @@ void qemu_set_log(int log_flags)
>      qemu_mutex_lock(&qemu_logfile_mutex);
>      if (!qemu_logfile &&
>          (is_daemonized() ? logfilename !=3D NULL : qemu_loglevel)) {
> +        logfile =3D g_new0(QemuLogFile, 1);
>          if (logfilename) {

You can assume logfilename exists as glib memory allocations would
abort() otherwise.

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
> +
>      if (qemu_logfile &&
>          (is_daemonized() ? logfilename =3D=3D NULL : !qemu_loglevel)) {
> -        qemu_log_close();
> +        atomic_rcu_set(&qemu_logfile, NULL);
> +        qemu_mutex_unlock(&qemu_logfile_mutex);
> +        call_rcu(logfile, qemu_logfile_free, rcu);
> +    } else {
> +        qemu_mutex_unlock(&qemu_logfile_mutex);
>      }
>  }
>
> @@ -247,17 +262,40 @@ out:
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
> +}
> +
> +void qemu_logfile_free(QemuLogFile *logfile)

This can be static as it's internal to log.c

> +{
> +    if (logfile) {

g_assert(logfile) instead of the if?

> +        if (logfile->fd !=3D stderr) {
> +            fclose(logfile->fd);
> +        }
> +        g_free(logfile);
> +    }
>  }
>
>  /* Close the log file */
>  void qemu_log_close(void)
>  {
> -    if (qemu_logfile) {
> -        if (qemu_logfile !=3D stderr) {
> -            fclose(qemu_logfile);
> -        }
> -        qemu_logfile =3D NULL;
> +    QemuLogFile *logfile;
> +
> +    qemu_mutex_lock(&qemu_logfile_mutex);
> +    logfile =3D qemu_logfile;
> +
> +    if (logfile) {
> +        atomic_rcu_set(&qemu_logfile, NULL);
> +        qemu_mutex_unlock(&qemu_logfile_mutex);

I think you can move the both the unlocks out of the if/else and drop
the else.

> +        call_rcu(logfile, qemu_logfile_free, rcu);
> +    } else {
> +        qemu_mutex_unlock(&qemu_logfile_mutex);
>      }
>  }
>
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
> index 5475d49ed1..220eaac7c7 100644
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

This can probably be a qemu_log_lock() instead given interleaving output
is going to be confusing.

> +            if (logfile) {
> +                for (; col < 40; ++col) {
> +                    putc(' ', logfile->fd);
> +                }
>              }
> +            rcu_read_unlock();

and qemu_log_unlock();

This cleanup could even be in a separate patch.

>          }
>
>          if (op->life) {


--
Alex Benn=C3=A9e

