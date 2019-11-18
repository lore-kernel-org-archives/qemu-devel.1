Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A72C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 12:51:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 061CD20692
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 12:51:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tfpO6rGE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 061CD20692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWgVa-0003sz-86
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 07:51:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33800)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1iWgUi-00035U-Nh
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 07:51:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1iWgUh-0001Lr-45
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 07:51:04 -0500
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:42903)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1iWgUg-0001LI-RU
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 07:51:03 -0500
Received: by mail-lj1-x241.google.com with SMTP id n5so18777399ljc.9
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 04:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=RajvsY/lbA9UW1A2+yK01rwYbGkOx9cHDhZbKw6G3yk=;
 b=tfpO6rGEMW77IrYjv2NaxjfBsdfwVWfV8kxNDVvTsNtqgvaUTfun86APx9wfKexjfo
 LSh4pKMJTb2ZdKxR1kCNoCmfvyvmIhk5WAC8u0XLWcb06fCd7aHLKtd3BiaNAPhOkh3W
 gcmfNZjdykCKBYY7CmEGEHPB31i65t5TmNi8gE8BnLhLlbfGnfjabPRRm6tQTXoFHcBi
 nC/kmyMo59aT4nPRAEgUDvLWEynl4Nt5/1Y3dp1Bs93RP46QN3d/5uMzkQIhFNUBRMno
 xZSK/h9fVNB2VCKRjCetsIotnywSFzCQvDOFNFyO19xqOzVfqkiBuHZYdad2GeT7Dyle
 eoBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=RajvsY/lbA9UW1A2+yK01rwYbGkOx9cHDhZbKw6G3yk=;
 b=eqY0rP6Jg36iq/b36Evs5V7JBYrkTIfQ+Fcwscxoi7v62W2mvz0/Fw3A5Jm9W8dgy/
 ISmyLsnQaHBGxzbHf3MgcNrLXlxm6tz5gkqhb1holNYlEj/scv+RRzw12HRXiL3E7Rbn
 /5Pj8WBmt2tVBUC+pcVqO4VvwezJT91Vv9fnvllsSBhaifDBxjs9m1Ie0NXxNsCvyMfF
 mtP/XQL7/othHywNiDNGfAwLYvTdnehbOboYwQz7WUv5ypqUJshwJQaT5Na+ZYU5K+wv
 Z4ajezeeRfL7gABYdptciMDgoLSLXBxy7cUMMiiaOQCmCWHOhnAtagAYvblzNXDrrzqv
 gZwQ==
X-Gm-Message-State: APjAAAX21WSHwWcvCwm6zbKNRzeZFYj81mNac7rQ97oIMPRnB/4ql9LZ
 +4vh39h09Q3rUyKwB/q1hexOxSSAQTTdpBn9fjompw==
X-Google-Smtp-Source: APXvYqwqt66z7knyJD7ph3ud+/kSZKGoBUOiV7OAHSwgZPJmfeBCOxvQ2ZVCqUKCwk5NLaVFWf6BhVRyWDxHXrINSAw=
X-Received: by 2002:a2e:574d:: with SMTP id r13mr13416855ljd.10.1574081460883; 
 Mon, 18 Nov 2019 04:51:00 -0800 (PST)
MIME-Version: 1.0
References: <20191115131040.2834-1-robert.foley@linaro.org>
 <20191115131040.2834-4-robert.foley@linaro.org> <87d0dpgz1b.fsf@linaro.org>
In-Reply-To: <87d0dpgz1b.fsf@linaro.org>
From: Robert Foley <robert.foley@linaro.org>
Date: Mon, 18 Nov 2019 07:50:50 -0500
Message-ID: <CAEyhzFuFoJ-gh5DcYjU2NoEWn8Rp+OZHXdB3GwgKnJPNHZOqMw@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] Add a mutex to guarantee single writer to
 qemu_logfile handle.
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::241
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

On Mon, 18 Nov 2019 at 07:16, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> > +    qemu_mutex_lock(&qemu_logfile_mutex);
> >      if (qemu_logfile && !need_to_open_file) {
> > +        qemu_mutex_unlock(&qemu_logfile_mutex);
> >          qemu_log_close();
> >      } else if (!qemu_logfile && need_to_open_file) {
> >          if (logfilename) {
> > @@ -105,6 +115,7 @@ void qemu_set_log(int log_flags)
> >  #endif
> >              log_append =3D 1;
> >          }
> > +        qemu_mutex_unlock(&qemu_logfile_mutex);
> >      }
> >  }
>
> This looks a bit odd. I can see it's fixed up in a later patch but I
> guess the reason is to avoid a double lock when we get to
> qemu_log_close(). In the cases of unavoidable temporary ugliness in a
> patch series it is best to note the problem and mention it will be
> cleaned up by a later patch in the series.
>
> With an extra comment in the commit message:
>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
This is true that given the order of the patches, we needed to add
this bit of temporary ugliness to avoid the double lock with this
commit, knowing that we would undo these changes later.

I will add more details to the commit message.

Thanks,
-Rob

On Mon, 18 Nov 2019 at 07:16, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
>
> Robert Foley <robert.foley@linaro.org> writes:
>
> > Also added qemu_logfile_init() for initializing the logfile mutex.
> >
> > Signed-off-by: Robert Foley <robert.foley@linaro.org>
> > ---
> > v2
> >     - In qemu_set_log() moved location of mutex lock/unlock
> >       due to cleanup changes.
> > ---
> > v1
> >     - changed qemu_logfile_init() to use __constructor__.
> > ---
> >  util/log.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/util/log.c b/util/log.c
> > index 417d16ec66..91ebb5c924 100644
> > --- a/util/log.c
> > +++ b/util/log.c
> > @@ -24,8 +24,10 @@
> >  #include "qapi/error.h"
> >  #include "qemu/cutils.h"
> >  #include "trace/control.h"
> > +#include "qemu/thread.h"
> >
> >  static char *logfilename;
> > +static QemuMutex qemu_logfile_mutex;
> >  FILE *qemu_logfile;
> >  int qemu_loglevel;
> >  static int log_append =3D 0;
> > @@ -49,6 +51,11 @@ int qemu_log(const char *fmt, ...)
> >      return ret;
> >  }
> >
> > +static void __attribute__((__constructor__)) qemu_logfile_init(void)
> > +{
> > +    qemu_mutex_init(&qemu_logfile_mutex);
> > +}
> > +
> >  static bool log_uses_own_buffers;
> >
> >  /* enable or disable low levels log */
> > @@ -70,7 +77,10 @@ void qemu_set_log(int log_flags)
> >      if (qemu_loglevel && (!is_daemonized() || logfilename)) {
> >          need_to_open_file =3D true;
> >      }
> > +    g_assert(qemu_logfile_mutex.initialized);
> > +    qemu_mutex_lock(&qemu_logfile_mutex);
> >      if (qemu_logfile && !need_to_open_file) {
> > +        qemu_mutex_unlock(&qemu_logfile_mutex);
> >          qemu_log_close();
> >      } else if (!qemu_logfile && need_to_open_file) {
> >          if (logfilename) {
> > @@ -105,6 +115,7 @@ void qemu_set_log(int log_flags)
> >  #endif
> >              log_append =3D 1;
> >          }
> > +        qemu_mutex_unlock(&qemu_logfile_mutex);
> >      }
> >  }
>
> This looks a bit odd. I can see it's fixed up in a later patch but I
> guess the reason is to avoid a double lock when we get to
> qemu_log_close(). In the cases of unavoidable temporary ugliness in a
> patch series it is best to note the problem and mention it will be
> cleaned up by a later patch in the series.
>
> With an extra comment in the commit message:
>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> >
> > @@ -240,12 +251,15 @@ void qemu_log_flush(void)
> >  /* Close the log file */
> >  void qemu_log_close(void)
> >  {
> > +    g_assert(qemu_logfile_mutex.initialized);
> > +    qemu_mutex_lock(&qemu_logfile_mutex);
> >      if (qemu_logfile) {
> >          if (qemu_logfile !=3D stderr) {
> >              fclose(qemu_logfile);
> >          }
> >          qemu_logfile =3D NULL;
> >      }
> > +    qemu_mutex_unlock(&qemu_logfile_mutex);
> >  }
> >
> >  const QEMULogItem qemu_log_items[] =3D {
>
>
> --
> Alex Benn=C3=A9e

