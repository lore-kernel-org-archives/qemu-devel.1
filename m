Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39B09C432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 08:25:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B0F620715
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 08:25:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BjMjaYxi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B0F620715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVARh-0006kk-3s
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 03:25:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45593)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iVAR4-0006HK-Ej
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 03:25:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iVAR3-0004uy-C2
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 03:25:02 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:36950)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1iVAR3-0004uK-5p
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 03:25:01 -0500
Received: by mail-wr1-x441.google.com with SMTP id t1so5382747wrv.4
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2019 00:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=r3hSQEjjEKkpLvTQd4S5ltTyv5/WMOj1XCGltmUQwDY=;
 b=BjMjaYxi/BbF5MJdPSkewQxeP5KNo+jdbT1i9RrVTYL4WMJrxHkzX3E2xElSa1WGhz
 AOjC0WulTtXT/wzj0UTjw5STWC9jT8l7EPtuVURpiAF3Uyutia8gm5hPRMM5/AFzbruE
 eoQZSuc+tsV+R0uw1mV2D5L8hLv8fHfeOvDBtddPMK3FTXA8YhAWenPuXZlnxUqrHRgB
 Yz+1IuRxJBlhLr6OucAootgbXknXNAkkx51OXneIm2/DnT0Pk99b/nnum0s1LCaPOsK0
 TSKnEnnKy5G0c9XhNBmgefI48Ge/TQe+uUvI7IxkEjxQBAoN7VfA9CWL8W1VHqHyp53v
 AZXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=r3hSQEjjEKkpLvTQd4S5ltTyv5/WMOj1XCGltmUQwDY=;
 b=YhFlERtqzwo5wpnAiKW5zIMI+P9zrqaqeX35ci+XCZ2RuaFwVrEBW2TUdY0OCrgta4
 5Q7GADb81txu52LgQHCh+/NwOrhj3+tIr2vA/GINzMbkPqkA+Qc5nzm8bbO7UZKitnoH
 RyEQWWueDmgNuDx13Cd9iyqNMP85sVuvDbC7fSVgugKk1FPKJ2u1K0LsANmc6iPTtHGy
 UTHFnL1Hj8BuPjeEUg1ZXh1j9yhbXtYk0dUFUKpnyhoexy1JSqFCRUggqdknsiDG5thc
 aXLgydApmgaIOxEPY439OODxbizCxj3Nrq2RkehcmRNAXmWUErxTv15i5Vg0JND3CN9Z
 My7g==
X-Gm-Message-State: APjAAAU6ssDbp/YesyW0vqVpAlOoNTt45ZSLmV60KG8CkSvkD1SQ5UMP
 v/In2xeKXdTOkS9/MT/Im4ATcfwDd7D4zoSpFgvnMjB2
X-Google-Smtp-Source: APXvYqzu+3KImPBowIOp+i8d8tersVJc5TGLniH1ws3pJmzFki7vH/DmnlpKb0MkVcp/geHLHL4uuUA9Z4BbuNcm0iM=
X-Received: by 2002:a5d:670a:: with SMTP id o10mr7276362wru.312.1573719900061; 
 Thu, 14 Nov 2019 00:25:00 -0800 (PST)
MIME-Version: 1.0
References: <1573655945-14912-1-git-send-email-pbonzini@redhat.com>
 <1573655945-14912-5-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1573655945-14912-5-git-send-email-pbonzini@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 14 Nov 2019 12:24:48 +0400
Message-ID: <CAJ+F1C+LbrQNhOn7Vhr+9Q9NjW8NPHmjrxqdnGJzAUZ2OfS3WA@mail.gmail.com>
Subject: Re: [PATCH 04/16] vl: move icount configuration earlier
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: Thomas Huth <thuth@redhat.com>, QEMU <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Nov 13, 2019 at 6:43 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> Once qemu_tcg_configure is turned into a QOM property setter, it will not
> be able to set a default value for mttcg_enabled.  Setting the default wi=
ll
> move to the TCG init_machine method, which currently runs after "-icount"
> is processed.
>
> However, it is harmless to do configure_icount for all accelerators; we w=
ill
> just fail later if a non-TCG accelerator being selected.  So do that.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  vl.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/vl.c b/vl.c
> index fc9e70f..dbc99d7 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -2829,11 +2829,7 @@ static void user_register_global_props(void)
>
>  static int do_configure_icount(void *opaque, QemuOpts *opts, Error **err=
p)
>  {
> -    if (tcg_enabled()) {
> -        configure_icount(opts, errp);
> -    } else {
> -        error_setg(errp, "-icount is not allowed with hardware virtualiz=
ation");
> -    }
> +    configure_icount(opts, errp);
>      return 0;
>  }
>
> @@ -2854,6 +2850,9 @@ static void configure_accelerators(const char *prog=
name)
>      bool init_failed =3D false;
>      AccelClass *acc =3D NULL;
>
> +    qemu_opts_foreach(qemu_find_opts("icount"),
> +                      do_configure_icount, NULL, &error_fatal);
> +
>      accel =3D qemu_opt_get(qemu_get_machine_opts(), "accel");
>      if (accel =3D=3D NULL) {
>          /* Select the default accelerator */
> @@ -2901,11 +2900,13 @@ static void configure_accelerators(const char *pr=
ogname)
>          error_report("Back to %s accelerator", acc->name);
>      }
>
> -    qemu_opts_foreach(qemu_find_opts("icount"),
> -                      do_configure_icount, NULL, &error_fatal);
> -
>      qemu_opts_foreach(qemu_find_opts("accel"),
>                        do_configure_accelerator, NULL, &error_fatal);
> +
> +    if (!tcg_enabled() && use_icount) {
> +        error_report("-icount is not allowed with hardware virtualizatio=
n");
> +        exit(1);
> +    }
>  }
>
>  int main(int argc, char **argv, char **envp)
> --
> 1.8.3.1
>
>
>


--
Marc-Andr=C3=A9 Lureau

