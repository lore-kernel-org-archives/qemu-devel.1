Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1770EC43331
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 16:33:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C94A1214D8
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 16:33:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OJww+ozB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C94A1214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSkj5-0000OL-0N
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 11:33:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41760)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iSkhc-0008CL-Nn
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 11:32:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iSkhb-0003Mp-AD
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 11:32:08 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:36467)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iSkhb-0003MI-35
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 11:32:07 -0500
Received: by mail-wm1-x344.google.com with SMTP id c22so3161449wmd.1
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2019 08:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=v+ot3ABb5Wv5nAL9AGUS0Mzley72eDcGEufztKwBIsg=;
 b=OJww+ozBZUwHKgsl/z6f9nJHZnvpXoRYG2xzB7brPzBVTGfmLD0FKjoDFY7l6Prfsv
 ry8XApjBQz+JFWKmafN09JHL4JRWpGN8+LpkhDv3FvR15ETMPitT9fU+IhA06+rRHFdu
 89boKvaMcU9ItiDDY9YyGmtx2haXlpZEhQl8hc6QR70P9EIU3jsG/BICuYgGmgJjxdJx
 64+wE6KA3yGma/0LJdaBnSn/mYmXTlF+hPVOjyH3oI7kDAWfXul6d08eE65rDlaF4QTn
 KFu6Psnd5f6xug7LKLsxu6HWiHJ6c2DTv829Vg4ncXoD2PtMWsYPGtwplc+pQpHvsgBF
 aBIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=v+ot3ABb5Wv5nAL9AGUS0Mzley72eDcGEufztKwBIsg=;
 b=DR6SsvaWknQMCJBjtWRuKf2gSZNlSyvooZ+OvfJS9qaQBvYZwQlm5MudneMt6yx+b6
 431Lx0kE7PWAGQEg0pzeH7jBEeuqyS6xur2DmCbsoSFmqydbo657hdFotEhjwekkkeUc
 oqACb0aa5ORGXZeuVVYO1bXmqhDCb/eYtmvXjdJRgRj2ECmN9a4wqD8FKF9Pez6a4wbr
 PIXEjcPu84sBwYt2oxeZymCCNr3pZD63U1VVk9l1fzL12PzThyvWOgq4W7oh8eBfMqVS
 8SDhaLYXaM/xkBOFPdKQxPsydwy/YEl+mJEF7v81xOJ89GaT2hZG41y+GcP8t4Ahb8n9
 cZuQ==
X-Gm-Message-State: APjAAAXwr6m+AOT6xjLSytc8qKTKWa41ITOPu95F/ouFojo1HEIom+b1
 ywytilxLRsB0Y19hvJHF34HkSw==
X-Google-Smtp-Source: APXvYqzsu6uvH6D5JR/vj8w3+coEHno4ynq5CuQVDOQTR8L9sf2leWH/L4hLSAPjGz4ygSuWzi5yYQ==
X-Received: by 2002:a7b:cc86:: with SMTP id p6mr3948550wma.116.1573144325568; 
 Thu, 07 Nov 2019 08:32:05 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 5sm2105467wmk.48.2019.11.07.08.32.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Nov 2019 08:32:04 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 264681FF87;
 Thu,  7 Nov 2019 16:32:04 +0000 (GMT)
References: <20191107142613.2379-1-robert.foley@linaro.org>
 <20191107142613.2379-5-robert.foley@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Robert Foley <robert.foley@linaro.org>
Subject: Re: [PATCH 4/4] Added tests for close and change of logfile.
In-reply-to: <20191107142613.2379-5-robert.foley@linaro.org>
Date: Thu, 07 Nov 2019 16:32:04 +0000
Message-ID: <87tv7fhcl7.fsf@linaro.org>
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

> One test ensures that the logfile handle is still valid even if
> the logfile is changed during logging.
> The other test validates that the logfile handle remains valid under
> the logfile lock even if the logfile is closed.
>
> Signed-off-by: Robert Foley <robert.foley@linaro.org>
> ---
>  tests/test-logging.c | 74 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 74 insertions(+)
>
> diff --git a/tests/test-logging.c b/tests/test-logging.c
> index a12585f70a..a3190ff92c 100644
> --- a/tests/test-logging.c
> +++ b/tests/test-logging.c
> @@ -108,6 +108,76 @@ static void test_parse_path(gconstpointer data)
>      error_free_or_abort(&err);
>  }
>
> +static void test_logfile_write(gconstpointer data)
> +{
> +    QemuLogFile *logfile;
> +    gchar const *dir =3D data;
> +    Error *err =3D NULL;
> +    gchar *file_path;
> +    gchar *file_path1;

  with g_autofree char *file_path you can avoid the free down bellow.

> +    FILE *orig_fd;
> +
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

Maybe better would be:

  logfile2 =3D atomic_rcu_read(&qemu_logfile);
  g_assert(logfile->fd =3D=3D orig_fd);
  g_assert(logfile2->fd !=3D logfile->fd);
  fprintf(logfile2->fd, "%s 2nd write to file\n", __func__);
  fflush(logfile2->fd);

<snip>
> +    g_assert(logfile->fd =3D=3D orig_fd);
> +    fprintf(logfile->fd, "%s 2nd write to file\n", __func__);
> +    fflush(logfile->fd);
> +    rcu_read_unlock();
> +
> +    g_free(file_path);
> +    g_free(file_path1);
> +}
> +
> +static void test_logfile_lock(gconstpointer data)
> +{
> +    FILE *logfile;
> +    gchar const *dir =3D data;
> +    Error *err =3D NULL;
> +    gchar *file_path;

g_autofree

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
> +    g_free(file_path);
> +}
> +
>  /* Remove a directory and all its entries (non-recursive). */
>  static void rmdir_full(gchar const *root)
>  {
> @@ -134,6 +204,10 @@ int main(int argc, char **argv)
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

