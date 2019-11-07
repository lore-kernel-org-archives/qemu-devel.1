Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC3EBC43331
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 20:14:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 858122166E
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 20:14:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kqqkh/Wc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 858122166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSoAr-0004fN-N4
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 15:14:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54765)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iSo94-00049r-Tf
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 15:12:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iSo92-0002OS-NQ
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 15:12:42 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:35990)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iSo92-0002N1-Ef
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 15:12:40 -0500
Received: by mail-wm1-x344.google.com with SMTP id c22so3915673wmd.1
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2019 12:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=EhnmLO2RD4mb6YZZBDOZ19p4IxdMpLbZJ5TlQJ7wui8=;
 b=kqqkh/WcDPwF14pZGOYacb6+ZH34DH2a5oRoJoOppreg4O6c8ltvvUxfC0qDbGLj1k
 miA+dIlGE981VezW+wqPIctSJY7bem0Wa+N6/Kxl9f0Q1yoJ2Nl69ImpxOSswsQ5Ahcq
 XcjtmZYO97tNNF6K/5+Lr0qbti0Zc8r9+BLZ7mmNz5QwNiAWzeD+pW8lPgxVytph6JqO
 RvqkWcCV5+7iki8+C/JXAKjWTdokKqKh4ybp88Bfp/38uL6z/YXUC1URa40bPbSRFay8
 joFjFUma+tmUpZcFcqKVXL3C4T5a679HjlGxlB/8rzjVVVT6xX74incTtkFxNQ925r/T
 9fSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=EhnmLO2RD4mb6YZZBDOZ19p4IxdMpLbZJ5TlQJ7wui8=;
 b=oGOsrE+CC+EJjzz6dRWm2EerBNPL8NwYcBH/TxHVMsTyVLTLY6J8V69buw8k//jyHA
 7sU4DloRnCp1vS9SfD8xqLCeGhYs21VBprMAD1kdCmX3kneHQv6F4puQ0WJaHFQmo/pO
 Au2LWZr+O8JneDGfEnfJX64JB/DBfTdBvRFqgxVg3N+0XJhj+fkKuIF/8kGRUfFG/Gft
 qBLD1k0VC3LthC7AQ7iz69aT+HjOD0spC8J/y81AJ1P5qTYIvwefkqtW/Mz5iqIScie5
 9mh1UefVPAAw5EyG8i4ALegXjMyM0goSQHVZTjisOJzdQYCB9Il9Fp7/bjoedv7RZqTK
 iBHQ==
X-Gm-Message-State: APjAAAU/q85rlwaMUGlgT9bMiARZlYq9u67ZF8N4IVqkTFR/ZTH76A9V
 addiz400BEx2uxVyBQVBij28jg==
X-Google-Smtp-Source: APXvYqx8C68GAxQ6UyO0WH3j+ATDfLQebDvVIdyjEibSmNKxzSHiebOMm+2iGfscof39HBi1TxoAXg==
X-Received: by 2002:a1c:9a81:: with SMTP id c123mr4551646wme.118.1573157558750; 
 Thu, 07 Nov 2019 12:12:38 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id d4sm2090262wrw.83.2019.11.07.12.12.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Nov 2019 12:12:37 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 2B8E51FF87;
 Thu,  7 Nov 2019 20:12:37 +0000 (GMT)
References: <20191107142613.2379-1-robert.foley@linaro.org>
 <20191107142613.2379-5-robert.foley@linaro.org>
 <87tv7fhcl7.fsf@linaro.org> <87imnvha2k.fsf@linaro.org>
 <CAEyhzFsxT=A6HtbVeScSPdO1bHqBMq9Sn_bF1j6Y+T4=E=fQDA@mail.gmail.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Robert Foley <robert.foley@linaro.org>
Subject: Re: [PATCH 4/4] Added tests for close and change of logfile.
In-reply-to: <CAEyhzFsxT=A6HtbVeScSPdO1bHqBMq9Sn_bF1j6Y+T4=E=fQDA@mail.gmail.com>
Date: Thu, 07 Nov 2019 20:12:37 +0000
Message-ID: <87d0e3h2dm.fsf@linaro.org>
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
Cc: Peter Puhov <peter.puhov@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Robert Foley <robert.foley@linaro.org> writes:

> Thanks for providing the stack trace.
>
> We debugged this and it seems to come about because of an interesting
> circumstance.  We added our new tests after a pre-existing test,
> parse_path(), which runs into an issue, a dangling pointer, which
> could lead to a double free.  There were no other tests after the test
> that ran into the issue, so the double free was not exposed until we
> added our test which called qemu_set_log_filename().
>
> Upon entry to qemu_set_log_filename() it frees logfilename.   In the
> case where we get an error, we return out without setting the
> logfilename to NULL.
> And on next call into this function we will end up with a double free.
>
> For a fix, we could put this at the beginning of qemu_set_log_filename().
> if (logfilename) {
>     g_free(logfilename);
>     logfilename =3D NULL;
> }

g_free(logfilename) should be safe against NULL. However we need to
ensure that logfilename is NULL'ed after it so we don't see the double
free.

> We were curious to understand why we did not see it in our own
> testing.  Although we did run make check before our first post, we did
> not see this issue.  The docker tests seem to use something like
> MALLOC_CHECK_, which catches memory issues like this.   We will be
> sure to run the docker tests as well in the future.

I was just running in my normal checkout - it could depend on how glibc
was built for your system though. Mine is Debian Buster.

>
> On Thu, 7 Nov 2019 at 12:26, Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:
>>
>>
>> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
>>
>> > Robert Foley <robert.foley@linaro.org> writes:
>> >
>> >> One test ensures that the logfile handle is still valid even if
>> >> the logfile is changed during logging.
>> >> The other test validates that the logfile handle remains valid under
>> >> the logfile lock even if the logfile is closed.
>>
>> Also this doesn't see to work:
>>
>> 17:24:31 [alex@zen:~/l/q/b/all] review/rcu-logfile|=E2=80=A6 2 + ./tests=
/test-logging
>> /logging/parse_range: OK
>> /logging/parse_path: OK
>> /logging/logfile_write_path: free(): double free detected in tcache 2
>> fish: =E2=80=9C./tests/test-logging=E2=80=9D terminated by signal SIGABR=
T (Abort)
>>
>> in gdb
>>
>> Starting program: /home/alex/lsrc/qemu.git/builds/all/tests/test-logging
>> [Thread debugging using libthread_db enabled]
>> Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1=
".
>> [New Thread 0x7ffff6f38700 (LWP 28960)]
>> /logging/parse_range: OK
>> /logging/parse_path: OK
>> /logging/logfile_write_path: free(): double free detected in tcache 2
>>
>> Thread 1 "test-logging" received signal SIGABRT, Aborted.
>> __GI_raise (sig=3Dsig@entry=3D6) at ../sysdeps/unix/sysv/linux/raise.c:50
>> 50      ../sysdeps/unix/sysv/linux/raise.c: No such file or directory.
>> (gdb) bt
>> #0  __GI_raise (sig=3Dsig@entry=3D6) at ../sysdeps/unix/sysv/linux/raise=
.c:50
>> #1  0x00007ffff7587535 in __GI_abort () at abort.c:79
>> #2  0x00007ffff75de508 in __libc_message (action=3Daction@entry=3Ddo_abo=
rt, fmt=3Dfmt@entry=3D0x7ffff76e928d "%s\n") at ../sysdeps/posix/libc_fatal=
.c:181
>> #3  0x00007ffff75e4c1a in malloc_printerr (str=3Dstr@entry=3D0x7ffff76ea=
f58 "free(): double free detected in tcache 2") at malloc.c:5341
>> #4  0x00007ffff75e66fd in _int_free (av=3D0x7ffff7720c40 <main_arena>, p=
=3D0x5555555cac40, have_lock=3D<optimized out>) at malloc.c:4193
>> #5  0x00005555555614a8 in qemu_set_log_filename (filename=3D0x5555555cb1=
10 "/tmp/qemu-test-logging.RO35A0/qemu_test_log_write0.log", errp=3D0x7ffff=
fffdef0) at /home/alex/lsrc/qemu.git/util/log.c:148
>> #6  0x000055555555d8be in test_logfile_write (data=3D0x5555555c7370) at =
/home/alex/lsrc/qemu.git/tests/test-logging.c:127
>> #7  0x00007ffff7cdc15a in test_case_run (tc=3D0x5555555c9c60) at ../../.=
./glib/gtestutils.c:2318
>> #8  g_test_run_suite_internal (suite=3Dsuite@entry=3D0x5555555c8a40, pat=
h=3Dpath@entry=3D0x0) at ../../../glib/gtestutils.c:2403
>> #9  0x00007ffff7cdc014 in g_test_run_suite_internal (suite=3Dsuite@entry=
=3D0x5555555c8a20, path=3Dpath@entry=3D0x0) at ../../../glib/gtestutils.c:2=
415
>> #10 0x00007ffff7cdc412 in g_test_run_suite (suite=3D0x5555555c8a20) at .=
./../../glib/gtestutils.c:2490
>> #11 0x00007ffff7cdc431 in g_test_run () at ../../../glib/gtestutils.c:17=
55
>> #12 0x000055555555ce07 in main (argc=3D<optimized out>, argv=3D<optimize=
d out>) at /home/alex/lsrc/qemu.git/tests/test-logging.c:212
>>
>>
>> >>
>> >> Signed-off-by: Robert Foley <robert.foley@linaro.org>
>> >> ---
>> >>  tests/test-logging.c | 74 ++++++++++++++++++++++++++++++++++++++++++=
++
>> >>  1 file changed, 74 insertions(+)
>> >>
>> >> diff --git a/tests/test-logging.c b/tests/test-logging.c
>> >> index a12585f70a..a3190ff92c 100644
>> >> --- a/tests/test-logging.c
>> >> +++ b/tests/test-logging.c
>> >> @@ -108,6 +108,76 @@ static void test_parse_path(gconstpointer data)
>> >>      error_free_or_abort(&err);
>> >>  }
>> >>
>> >> +static void test_logfile_write(gconstpointer data)
>> >> +{
>> >> +    QemuLogFile *logfile;
>> >> +    gchar const *dir =3D data;
>> >> +    Error *err =3D NULL;
>> >> +    gchar *file_path;
>> >> +    gchar *file_path1;
>> >
>> >   with g_autofree char *file_path you can avoid the free down bellow.
>> >
>> >> +    FILE *orig_fd;
>> >> +
>> >> +    file_path =3D g_build_filename(dir, "qemu_test_log_write0.log", =
NULL);
>> >> +    file_path1 =3D g_build_filename(dir, "qemu_test_log_write1.log",=
 NULL);
>> >> +
>> >> +    /*
>> >> +     * Test that even if an open file handle is changed,
>> >> +     * our handle remains valid due to RCU.
>> >> +     */
>> >> +    qemu_set_log_filename(file_path, &err);
>> >> +    g_assert(!err);
>> >> +    rcu_read_lock();
>> >> +    logfile =3D atomic_rcu_read(&qemu_logfile);
>> >> +    orig_fd =3D logfile->fd;
>> >> +    g_assert(logfile && logfile->fd);
>> >> +    fprintf(logfile->fd, "%s 1st write to file\n", __func__);
>> >> +    fflush(logfile->fd);
>> >> +
>> >> +    /* Change the logfile and ensure that the handle is still valid.=
 */
>> >> +    qemu_set_log_filename(file_path1, &err);
>> >> +    g_assert(!err);
>> >
>> > Maybe better would be:
>> >
>> >   logfile2 =3D atomic_rcu_read(&qemu_logfile);
>> >   g_assert(logfile->fd =3D=3D orig_fd);
>> >   g_assert(logfile2->fd !=3D logfile->fd);
>> >   fprintf(logfile2->fd, "%s 2nd write to file\n", __func__);
>> >   fflush(logfile2->fd);
>> >
>> > <snip>
>> >> +    g_assert(logfile->fd =3D=3D orig_fd);
>> >> +    fprintf(logfile->fd, "%s 2nd write to file\n", __func__);
>> >> +    fflush(logfile->fd);
>> >> +    rcu_read_unlock();
>> >> +
>> >> +    g_free(file_path);
>> >> +    g_free(file_path1);
>> >> +}
>> >> +
>> >> +static void test_logfile_lock(gconstpointer data)
>> >> +{
>> >> +    FILE *logfile;
>> >> +    gchar const *dir =3D data;
>> >> +    Error *err =3D NULL;
>> >> +    gchar *file_path;
>> >
>> > g_autofree
>> >
>> >> +
>> >> +    file_path =3D g_build_filename(dir, "qemu_test_logfile_lock0.log=
", NULL);
>> >> +
>> >> +    /*
>> >> +     * Test the use of the logfile lock, such
>> >> +     * that even if an open file handle is closed,
>> >> +     * our handle remains valid for use due to RCU.
>> >> +     */
>> >> +    qemu_set_log_filename(file_path, &err);
>> >> +    logfile =3D qemu_log_lock();
>> >> +    g_assert(logfile);
>> >> +    fprintf(logfile, "%s 1st write to file\n", __func__);
>> >> +    fflush(logfile);
>> >> +
>> >> +    /*
>> >> +     * Initiate a close file and make sure our handle remains
>> >> +     * valid since we still have the logfile lock.
>> >> +     */
>> >> +    qemu_log_close();
>> >> +    fprintf(logfile, "%s 2nd write to file\n", __func__);
>> >> +    fflush(logfile);
>> >> +    qemu_log_unlock(logfile);
>> >> +
>> >> +    g_assert(!err);
>> >> +    g_free(file_path);
>> >> +}
>> >> +
>> >>  /* Remove a directory and all its entries (non-recursive). */
>> >>  static void rmdir_full(gchar const *root)
>> >>  {
>> >> @@ -134,6 +204,10 @@ int main(int argc, char **argv)
>> >>
>> >>      g_test_add_func("/logging/parse_range", test_parse_range);
>> >>      g_test_add_data_func("/logging/parse_path", tmp_path, test_parse=
_path);
>> >> +    g_test_add_data_func("/logging/logfile_write_path",
>> >> +                         tmp_path, test_logfile_write);
>> >> +    g_test_add_data_func("/logging/logfile_lock_path",
>> >> +                         tmp_path, test_logfile_lock);
>> >>
>> >>      rc =3D g_test_run();
>>
>>
>> --
>> Alex Benn=C3=A9e


--
Alex Benn=C3=A9e

