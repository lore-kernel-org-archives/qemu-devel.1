Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 318C8C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 21:14:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB8EC2077C
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 21:14:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lbe96RVA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB8EC2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSp7I-0007Fx-4X
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 16:14:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40351)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1iSp6R-0006ot-4U
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 16:14:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1iSp6P-0007YS-5C
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 16:14:02 -0500
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:36979)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1iSp6O-0007Tl-P2
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 16:14:01 -0500
Received: by mail-lj1-x243.google.com with SMTP id l20so3873513lje.4
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2019 13:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=IxxERLeHtoDnZZzaI4gugtXh5nzeV9LvMOfNpSL4fww=;
 b=Lbe96RVARijEo1XYyrMD/4j/OrIl0fVbZAwrhmeeAuRQsXH5Ogh1MN7Adgiy/oS5K9
 3Y+GtKkfxSYpBNaTc6o8s3oZQ3XUQg+z13Ryxjjvl2WEd0vr+eSCA4KvkE26uQ2k72Hd
 L1GSNYNrTwlkuNqu0KfJ2MbuACdqNdUsmUCXd9UZ+83BQHUm30ILYTQ8808xJ6Hls4hF
 xxiMz1KZ0eVzPrPShtt0uHW2IQEX+nEz5l7LVhUNLatvNRMCnJ65TzEINGSMTlYdsyLO
 xomwRVcbCbE1yBEZeiCM8/B5WeY8nW/fV2mtOfr5am2E+Fz2pqyxMsO9PY2cFYCpDEh0
 LEPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=IxxERLeHtoDnZZzaI4gugtXh5nzeV9LvMOfNpSL4fww=;
 b=AoiJ9bn+MwBFKojIfceo30Anmdp9pfCfnMJ6c12+4qVLEVKe+c33h38aVevahQ8VYL
 XiQh3xH7+5D4lWIK6t8DvHQB7f8JitG0yZKnM41wB/UdhGA52fU9KjzkPiYzy7ZqlxCi
 5qXRiKnFf9+QxyIOofmMr/aODcdWGW4i0dSUu4LWgCiXTiH6M3Gssx4gHJOHo7XClczC
 QaS+m5Q9rHXUjQJ3z+vroh5Pey81nv6B3QQtvFn0lrNnJ/GcmPzF8WCkcsexQu8qB2xw
 M/620elFh8YoERcO5vD7V9s56Ah86t35OReYVWRnhGw2R9s7Nad0GPzh9b8+5NJr1a9f
 6GFw==
X-Gm-Message-State: APjAAAXSIIN6hUUWrZm/iH7XvXcPZbigAd9qNR/gdnrK3MG/d+zkUMWU
 5gqJR3gkzWgwfY5wFNCggyeFerT43IQaVBDhO5qKYA==
X-Google-Smtp-Source: APXvYqxP3t+cnH+L0Ad/Eum5mait5GFTgK/u5STd1G/YE/xD6XmeY3HX+5wtL4GGl7zEHucOi9XyU1Nb6142P/VAo5o=
X-Received: by 2002:a2e:92c4:: with SMTP id k4mr4033213ljh.10.1573161237484;
 Thu, 07 Nov 2019 13:13:57 -0800 (PST)
MIME-Version: 1.0
References: <20191107142613.2379-1-robert.foley@linaro.org>
 <20191107142613.2379-3-robert.foley@linaro.org> <87zhh7hcyo.fsf@linaro.org>
In-Reply-To: <87zhh7hcyo.fsf@linaro.org>
From: Robert Foley <robert.foley@linaro.org>
Date: Thu, 7 Nov 2019 16:13:46 -0500
Message-ID: <CAEyhzFs5qaKjss3w7-Jfuz0+9JMFwMHW0dkb7_K7UdWV6u3vjw@mail.gmail.com>
Subject: Re: [PATCH 2/4] Add use of RCU for qemu_logfile.
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::243
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
Cc: Peter Puhov <peter.puhov@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 7 Nov 2019 at 11:24, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> Robert Foley <robert.foley@linaro.org> writes:
<snip>
> > diff --git a/include/qemu/log.h b/include/qemu/log.h
> > index a91105b2ad..975de18e23 100644
> > --- a/include/qemu/log.h
> > +++ b/include/qemu/log.h
> > @@ -3,9 +3,17 @@
> >
> >  /* A small part of this API is split into its own header */
> >  #include "qemu/log-for-trace.h"
> > +#include "qemu/rcu.h"
> > +
> > +struct QemuLogFile {
> > +    struct rcu_head rcu;
> > +    FILE *fd;
> > +};
> > +typedef struct QemuLogFile QemuLogFile;
>
> If you are declaring a typedef then do it in one:
>
>   typedef struct QemuLogFile { ...
>
> We only really use the second form for opaque structs where the handle
> is passed around but the contents hidden from the rest of QEMU.
>

OK, makes sense.  Will correct it.  Thanks for explaining.

> >
> >  /* Private global variable, don't use */
> > -extern FILE *qemu_logfile;
> > +extern QemuLogFile *qemu_logfile;
> > +
>
> Do we need multiple

Not 100% sure on the meaning here.  Are you asking if we need to
extern this?  We have a few other cases outside of the log module
where this is getting used so the extern is needed here.

> >
> >  /*
> >   * The new API:
> > @@ -25,7 +33,17 @@ static inline bool qemu_log_enabled(void)
> >   */
> >  static inline bool qemu_log_separate(void)
> >  {
> > -    return qemu_logfile !=3D NULL && qemu_logfile !=3D stderr;
> > +    QemuLogFile *logfile;
> > +
> > +    if (qemu_log_enabled()) {
> > +        rcu_read_lock();
> > +        logfile =3D atomic_rcu_read(&qemu_logfile);
> > +        if (logfile && logfile->fd !=3D stderr) {
> > +            return true;
> > +        }
> > +        rcu_read_unlock();
> > +    }
> > +    return false;
>
> This is unbalanced as you'll have incremented the reader count. Also
> qemu_log_enabled() is also synonymous with logfile existing so you could
> fold that into:
>
>   bool res =3D false;
>
>   rcu_read_lock();
>   *logfile =3D atomic_rcu_read(&qemu_logfile);
>   if (logfile && logfile->fd !=3D stderr) {
>      res =3D true;
>   }
>   rcu_read_unlock();
>   return res;
>
> There is technically a race there as the answer may become invalid after
> qemu_log_separate() returns. However given the users I don't see what
> could fail afterwards.
>

I agree, will make these changes.



> >  }
> >
> >  #define CPU_LOG_TB_OUT_ASM (1 << 0)
> > @@ -55,12 +73,23 @@ static inline bool qemu_log_separate(void)
> >
> >  static inline void qemu_log_lock(void)
> >  {
> > -    qemu_flockfile(qemu_logfile);
> > +    QemuLogFile *logfile;
> > +    rcu_read_lock();
> > +    logfile =3D atomic_rcu_read(&qemu_logfile);
> > +    if (logfile) {
> > +        qemu_flockfile(logfile->fd);
> > +    }
> > +    rcu_read_unlock();
> >  }
>
> static inline FILE *fd qemu_log_lock(void)
> {
       QemuLogFile *logfile;
>     rcu_read_lock();
       logfile =3D atomic_rcu_read(&qemu_logfile);
       if (logfile) {
>         qemu_flockfile(logfile->fd);
           return logfile->fd;
>     } else {
>         rcu_read_unlock();
>         return NULL;
>     }
> }
>
> static inline qemu_log_unlock(FILE *fd)
> {
>     if (fd) {
>         qemu_funlockfile(fd);
>         rcu_read_unlock();
>     }
> }
>
> While the rcu_read_lock() is in progress then we won't ever finish with
> the fd - which we don't want to do until the file locking is finished.

Agree with the adjustments you made to qemu_log_lock().  I updated the
code above with a few tweaks for the QemuLogFile type returned by
atomic_rcu_read().  Does this look OK or is there any other adjustment
we should make here?

The intent here was for qemu_log_lock() to hold the rcu_read_lock()
until after we can qemu_funlockfile(fd).  The idea being that we want
to prevent the fclose(fd) from happening by holding the
rcu_read_lock() across the qemu_log_lock() until qemu_log_unlock().
So we have the qemu_funlockfile(fd) first, and then once we're done
with the fd, it is safe to rcu_read_unlock().


> <snip>
<snip more>
> > diff --git a/util/log.c b/util/log.c
<snip>
> > @@ -65,6 +70,8 @@ static bool log_uses_own_buffers;
> >  /* enable or disable low levels log */
> >  void qemu_set_log(int log_flags)
> >  {
> > +    QemuLogFile *logfile;
> > +
> >      qemu_loglevel =3D log_flags;
> >  #ifdef CONFIG_TRACE_LOG
> >      qemu_loglevel |=3D LOG_TRACE;
> > @@ -77,43 +84,51 @@ void qemu_set_log(int log_flags)
> >      qemu_mutex_lock(&qemu_logfile_mutex);
> >      if (!qemu_logfile &&
> >          (is_daemonized() ? logfilename !=3D NULL : qemu_loglevel)) {
> > +        logfile =3D g_new0(QemuLogFile, 1);
> >          if (logfilename) {
>
> You can assume logfilename exists as glib memory allocations would
> abort() otherwise.
This is good to know about the glib memory allocations as it relates
to the logfile above, since we did not add any check for null on
allocation.

We are thinking that logfilename might be NULL if we either never set
it with a call to qemu_set_log_filename(), or (with our intended new
fix) if we took an error actually opening the file in
qemu_set_log_filename(), and went down the error path.

> > -            qemu_logfile =3D fopen(logfilename, log_append ? "a" : "w"=
);
> > -            if (!qemu_logfile) {
> > +            logfile->fd =3D fopen(logfilename, log_append ? "a" : "w")=
;
> > +            if (!logfile->fd) {
> > +                g_free(logfile);
> >                  perror(logfilename);
> >                  _exit(1);
<snip>
> > +void qemu_logfile_free(QemuLogFile *logfile)
>
> This can be static as it's internal to log.c

Absolutely, makes sense.  Will change it.
> > +{
> > +    if (logfile) {
>
> g_assert(logfile) instead of the if?

I agree, the assert is cleaner.  Will change it.

> > +        if (logfile->fd !=3D stderr) {
> > +            fclose(logfile->fd);
> > +        }
> > +        g_free(logfile);
> > +    }
> >  }
> >
> >  /* Close the log file */
> >  void qemu_log_close(void)
> >  {
> > -    if (qemu_logfile) {
> > -        if (qemu_logfile !=3D stderr) {
> > -            fclose(qemu_logfile);
> > -        }
> > -        qemu_logfile =3D NULL;
> > +    QemuLogFile *logfile;
> > +
> > +    qemu_mutex_lock(&qemu_logfile_mutex);
> > +    logfile =3D qemu_logfile;
> > +
> > +    if (logfile) {
> > +        atomic_rcu_set(&qemu_logfile, NULL);
> > +        qemu_mutex_unlock(&qemu_logfile_mutex);
>
> I think you can move the both the unlocks out of the if/else and drop
> the else.

Agreed.  Originally we were thinking to hold the lock until after the
call_rcu, but I agree with you, it seems safe to move it.

> > +        call_rcu(logfile, qemu_logfile_free, rcu);
> > +    } else {
> > +        qemu_mutex_unlock(&qemu_logfile_mutex);
> >      }
> >  }
<snip>
> > diff --git a/tcg/tcg.c b/tcg/tcg.c
> > index 5475d49ed1..220eaac7c7 100644
> > --- a/tcg/tcg.c
> > +++ b/tcg/tcg.c
> > @@ -2114,9 +2114,17 @@ static void tcg_dump_ops(TCGContext *s, bool hav=
e_prefs)
> >          }
> >
> >          if (have_prefs || op->life) {
> > -            for (; col < 40; ++col) {
> > -                putc(' ', qemu_logfile);
> > +
> > +            QemuLogFile *logfile;
> > +
> > +            rcu_read_lock();
> > +            logfile =3D atomic_rcu_read(&qemu_logfile);
>
> This can probably be a qemu_log_lock() instead given interleaving output
> is going to be confusing.

The function calling tcg_dump_ops(), tcg_gen_code(), already has the
qemu_log_lock() held.

We were thinking about another type of cleanup, but it applies to this
case as well, since this case is using the qemu_logfile.   We were
thinking that at some point (another patch) it might be good to
cleanup the use of the qemu_logfile global so that it is only
referenced from inside the log module.    We noticed a comment in
log.h calling it a private global, which we thought might imply that
it was an intent to keep it private, and that this cleanup might be a
good direction to move in.

Thanks,
-Rob Foley

> > +            if (logfile) {
> > +                for (; col < 40; ++col) {
> > +                    putc(' ', logfile->fd);
> > +                }
> >              }
> > +            rcu_read_unlock();
>
> and qemu_log_unlock();
>
> This cleanup could even be in a separate patch.
>
> >          }
> >
> >          if (op->life) {
>
>
> --
> Alex Benn=C3=A9e

