Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B5C1C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 18:22:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC49221872
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 18:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j0w8yqp7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC49221872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUanu-0007W8-4p
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 13:22:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39730)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iUanC-0006qP-Cs
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 13:21:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iUanA-0002Q7-SI
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 13:21:30 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:42525)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iUanA-0002PJ-LT
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 13:21:28 -0500
Received: by mail-wr1-x442.google.com with SMTP id a15so19612327wrf.9
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2019 10:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=ze0qk99a0ZI4xKqJVhmmFP7mmohB+jerB0F3KktSdLU=;
 b=j0w8yqp7CkOV4q8Kquk7tSkNF1uFiZICsF5E62ruQJ4hw673TTyL7YS0vayZJr5Mpn
 ZqR3QeszpXBtZwgpod5WJb5V6vhZjX3UG3DUrT/XAoi9JvlfmkrepfnkyZFx7+m0cLV8
 MolugZgvs4//u/lHrYQjEbi7jSliwiOMEw63VfZIFrrWX7SxyFezBYeTZ3wih3ecd7uL
 vxC3W7vGhGvdDq/OP3TraIELPXjfZnR2RxGGuhImiAg0bFCnxVDusHNJrjheEWoa6qYF
 QbxnXbBiAcvB3AvOoNrQCg2rDP98RQmM5u5t7DQOYmaFPqyWP5vfCFJnLbu8juiBGj0m
 +cJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=ze0qk99a0ZI4xKqJVhmmFP7mmohB+jerB0F3KktSdLU=;
 b=BQTUVY+sjMwGXuGfZKdFr3TQaGEPj+nevQt5lgSQhWQnXpBpctk4wVCUXEP1wg+8it
 Hady0xSLpJZuDUjW84bY9NmRgmzS4/e2jBONq/ZxpvL0z2olM5wZQYnXplu1WNKVdaPA
 zLrBDKEvbxt9ZcJQ/55vDdJVGTEVSE4OvzlSobLPzYhM2js5PWeAlAhYbRTf6cXZunAK
 eBpRBsNuBaq3IjSFxf21tVn54iVUFLk+DFochqQZV4mZTmKKJTQCaZTRScADOo9HRv4v
 HAza/RfhgxpMuJsmYznPbfYRy3RmMkck6SleAecAkPnJ/6Pu836UXux5/KlupjT1J48s
 yk5Q==
X-Gm-Message-State: APjAAAVFtU9gqvVVFEHnLyYlOJj8Z+TLoYyPdKcj+OhbPLzKa7yVSVAl
 5NjUurF5V9L5WOcD57NBwJhH24A+nEo=
X-Google-Smtp-Source: APXvYqyu4AoUpPx29Wf2P9rb738Fo7QGzxTfvWFtmqL99YElvT98RGZqj1pwD604gPDCZQR2eaSSaA==
X-Received: by 2002:a5d:6cc3:: with SMTP id c3mr26607220wrc.202.1573582887060; 
 Tue, 12 Nov 2019 10:21:27 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u26sm3909599wmj.9.2019.11.12.10.21.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2019 10:21:25 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 13B921FF87;
 Tue, 12 Nov 2019 18:21:25 +0000 (GMT)
References: <20191112150105.2498-1-robert.foley@linaro.org>
 <20191112150105.2498-5-robert.foley@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Robert Foley <robert.foley@linaro.org>
Subject: Re: [PATCH v1 4/5] Added tests for close and change of logfile.
In-reply-to: <20191112150105.2498-5-robert.foley@linaro.org>
Date: Tue, 12 Nov 2019 18:21:25 +0000
Message-ID: <87imnp7y6y.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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

> One test ensures that the logfile handle is still valid even if
> the logfile is changed during logging.
> The other test validates that the logfile handle remains valid under
> the logfile lock even if the logfile is closed.
>
> Signed-off-by: Robert Foley <robert.foley@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> --
> v1
>     - Changes for first round of code review comments.
>     - Added in use of g_autofree, removed the g_free()s.
>     - Added in use of logfile2 and changed sequence of asserts.
> ---
>  tests/test-logging.c | 80 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 80 insertions(+)
>
> diff --git a/tests/test-logging.c b/tests/test-logging.c
> index a12585f70a..1e646f045d 100644
> --- a/tests/test-logging.c
> +++ b/tests/test-logging.c
> @@ -108,6 +108,82 @@ static void test_parse_path(gconstpointer data)
>      error_free_or_abort(&err);
>  }
>
> +static void test_logfile_write(gconstpointer data)
> +{
> +    QemuLogFile *logfile;
> +    QemuLogFile *logfile2;
> +    gchar const *dir =3D data;
> +    Error *err =3D NULL;
> +    g_autofree gchar *file_path;
> +    g_autofree gchar *file_path1;
> +    FILE *orig_fd;
> +
> +    /*
> +     * Before starting test, set log flags, to ensure the file gets
> +     * opened below with the call to qemu_set_log_filename().
> +     * In cases where a logging backend other than log is used,
> +     * this is needed.
> +     */
> +    qemu_set_log(CPU_LOG_TB_OUT_ASM);
> +    file_path =3D g_build_filename(dir, "qemu_test_log_write0.log", NULL=
);
> +    file_path1 =3D g_build_filename(dir, "qemu_test_log_write1.log", NUL=
L);
> +
> +    /*
> +     * Test that even if an open file handle is changed,
> +     * our handle remains valid due to RCU.
> +     */
> +    qemu_set_log_filename(file_path, &err);
> +    g_assert(!err);
> +    rcu_read_lock();
> +    logfile =3D atomic_rcu_read(&qemu_logfile);
> +    orig_fd =3D logfile->fd;
> +    g_assert(logfile && logfile->fd);
> +    fprintf(logfile->fd, "%s 1st write to file\n", __func__);
> +    fflush(logfile->fd);
> +
> +    /* Change the logfile and ensure that the handle is still valid. */
> +    qemu_set_log_filename(file_path1, &err);
> +    g_assert(!err);
> +    logfile2 =3D atomic_rcu_read(&qemu_logfile);
> +    g_assert(logfile->fd =3D=3D orig_fd);
> +    g_assert(logfile2->fd !=3D logfile->fd);
> +    fprintf(logfile->fd, "%s 2nd write to file\n", __func__);
> +    fflush(logfile->fd);
> +    rcu_read_unlock();
> +}
> +
> +static void test_logfile_lock(gconstpointer data)
> +{
> +    FILE *logfile;
> +    gchar const *dir =3D data;
> +    Error *err =3D NULL;
> +    g_autofree gchar *file_path;
> +
> +    file_path =3D g_build_filename(dir, "qemu_test_logfile_lock0.log", N=
ULL);
> +
> +    /*
> +     * Test the use of the logfile lock, such
> +     * that even if an open file handle is closed,
> +     * our handle remains valid for use due to RCU.
> +     */
> +    qemu_set_log_filename(file_path, &err);
> +    logfile =3D qemu_log_lock();
> +    g_assert(logfile);
> +    fprintf(logfile, "%s 1st write to file\n", __func__);
> +    fflush(logfile);
> +
> +    /*
> +     * Initiate a close file and make sure our handle remains
> +     * valid since we still have the logfile lock.
> +     */
> +    qemu_log_close();
> +    fprintf(logfile, "%s 2nd write to file\n", __func__);
> +    fflush(logfile);
> +    qemu_log_unlock(logfile);
> +
> +    g_assert(!err);
> +}
> +
>  /* Remove a directory and all its entries (non-recursive). */
>  static void rmdir_full(gchar const *root)
>  {
> @@ -134,6 +210,10 @@ int main(int argc, char **argv)
>
>      g_test_add_func("/logging/parse_range", test_parse_range);
>      g_test_add_data_func("/logging/parse_path", tmp_path, test_parse_pat=
h);
> +    g_test_add_data_func("/logging/logfile_write_path",
> +                         tmp_path, test_logfile_write);
> +    g_test_add_data_func("/logging/logfile_lock_path",
> +                         tmp_path, test_logfile_lock);
>
>      rc =3D g_test_run();


--
Alex Benn=C3=A9e

