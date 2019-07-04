Return-Path: <SRS0=blGQ=VB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BEA2C0651F
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 16:37:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1468A2085A
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 16:37:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DVk0M60O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1468A2085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hj4js-0006RP-6k
	for qemu-devel@archiver.kernel.org; Thu, 04 Jul 2019 12:37:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48196)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hj4io-00062K-7i
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 12:36:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hj4in-0004aP-3u
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 12:36:34 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:36933)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hj4im-0004ZI-SZ
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 12:36:33 -0400
Received: by mail-wr1-x444.google.com with SMTP id v14so7258121wrr.4
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2019 09:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=cjiN2/LB7kWpvIHN57PFsMm6pOj+0hDcXNe726dQf1M=;
 b=DVk0M60O031xHoF4uNSrtnDf5phKSLnf/wXlqZYaBtL4TPcvFg9Bh80n9WbFOKaKU+
 fxTVW1V/iZ6/FFducdA4m/qJpYokc5x5eps8ZzQfObOTmH2bOAE4auA7EScA5Bsm4dl8
 X8RKFZPhGo8P8wJ8yDqvxo+6L3E5k+qqTeNX+UoTvZTMmGE0PU4Mdk3JOFShyEtfRfNy
 l6SQo8P7/30Rruxj5ZREpKgDC6F+fMfJsD+cHL+ZBMnQx7Ib/oGtUavLZJuk8VWGcLs7
 rLsXLKhUh7AbOrVXwvxlOTDOxZpUMkh0v+sJ4xOg9WI4IQyLj/VDykfL3hcbHRSXID3f
 wFvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=cjiN2/LB7kWpvIHN57PFsMm6pOj+0hDcXNe726dQf1M=;
 b=MQIS+hLSghsSfNyMgGNTR6LX3KdNj74/2F3gnx3FPwIQib4jV/oTFg2j1FxaR1ZMWR
 yCDsqrGxnebkyN8PHFz4Xd+3QdLkHg5bj6aKYeMuvpWvQI+oJ6/wuWr41r2sZRrJIsG5
 w/BN8tVyLrdfSADHoPitiTLKDyPEeO6LHy8XtsKjOxRK0LaryPdB4vPmikPJQMDgRsip
 plT1vYJYWnvhMHLGsNaJYuwzMDnB6U4faxH0H+CiiclLyTU4OwEboGu55irAHFPCGiwm
 b06csJ3GSYIbwMdSAFSBJdDlmxeTDmiaALV9F6t0MHH7Zm5atcaZJu1LcKQWMtAdZ+0o
 nuFg==
X-Gm-Message-State: APjAAAXXOhR4H0V3Hk5XDPphGNVruK6T7HE8DsbM1Lnoik1/huL3nyjZ
 hvYvKYE8IOPQXzrylMlTbYdbQQ==
X-Google-Smtp-Source: APXvYqyQgTjbSIYqtBs4DPbG4zknD6BwhrQIarYdgnaHy3dL2jr4aWID4S1Or/ZxlPZBJZFcx49jPQ==
X-Received: by 2002:a5d:4602:: with SMTP id t2mr9160741wrq.38.1562258191107;
 Thu, 04 Jul 2019 09:36:31 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id d1sm215057wrs.94.2019.07.04.09.36.30
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 04 Jul 2019 09:36:30 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3730C1FF87;
 Thu,  4 Jul 2019 17:36:30 +0100 (BST)
References: <20190702210017.4275-1-vandersonmr2@gmail.com>
 <20190702210017.4275-5-vandersonmr2@gmail.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190702210017.4275-5-vandersonmr2@gmail.com>
Date: Thu, 04 Jul 2019 17:36:30 +0100
Message-ID: <8736jlwycx.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [PATCH v3 5/6] monitor: adding info tb and tbs to
 monitor
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
Cc: vandersonmr <vandersonmr2@gmail.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


vandersonmr <vandersonmr2@gmail.com> writes:

> adding options to list tbs by some metric and
> investigate their code.
>
> Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
> ---
>  hmp-commands-info.hx | 22 ++++++++++++++
>  monitor/misc.c       | 69 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 91 insertions(+)
>
> diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
> index c59444c461..0b8c0de95d 100644
> --- a/hmp-commands-info.hx
> +++ b/hmp-commands-info.hx
> @@ -288,6 +288,28 @@ ETEXI
>          .params     =3D "",
>          .help       =3D "show dynamic compiler info",
>          .cmd        =3D hmp_info_jit,
> +    {

Ahh this is the breakage:

},
{

> +        .name       =3D "tbs",
> +        .args_type  =3D "number:i?,sortedby:s?",
> +        .params     =3D "[number sortedby]",
> +        .help       =3D "show a [number] translated blocks sorted by [so=
rtedby]"
> +                      "sortedby opts: hotness hg",
> +        .cmd        =3D hmp_info_tbs,
> +    },
> +    {
> +        .name       =3D "tb",
> +        .args_type  =3D "id:i,flags:s?",
> +        .params     =3D "id [log1[,...] flags]",
> +        .help       =3D "show information about one translated block by =
id",
> +        .cmd        =3D hmp_info_tb,
> +    },
> +    {
> +        .name       =3D "coverset",
> +        .args_type  =3D "number:i?",
> +        .params     =3D "[number]",
> +        .help       =3D "show hottest translated blocks neccesary to cov=
er"
> +                      "[number]% of the execution count",
> +        .cmd        =3D hmp_info_coverset,
>      },
>  #endif
>
> diff --git a/monitor/misc.c b/monitor/misc.c
> index bf9faceb86..1fb4d75871 100644
> --- a/monitor/misc.c
> +++ b/monitor/misc.c
> @@ -469,6 +469,75 @@ static void hmp_info_jit(Monitor *mon, const QDict *=
qdict)
>      dump_drift_info();
>  }
>
> +static void hmp_info_tbs(Monitor *mon, const QDict *qdict)
> +{
> +    int n;
> +    const char *s =3D NULL;
> +    if (!tcg_enabled()) {
> +        error_report("TB information is only available with accel=3Dtcg"=
);
> +        return;
> +    }
> +    if (!tb_ctx.tb_stats.map) {
> +        error_report("no TB information recorded");
> +        return;
> +    }
> +
> +    n =3D qdict_get_try_int(qdict, "number", 10);
> +    s =3D qdict_get_try_str(qdict, "sortedby");
> +
> +    int sortedby =3D 0;
> +    if (s =3D=3D NULL || strcmp(s, "hotness") =3D=3D 0) {
> +        sortedby =3D SORT_BY_HOTNESS;
> +    } else if (strcmp(s, "hg") =3D=3D 0) {
> +        sortedby =3D SORT_BY_HG;
> +    }
> +
> +    dump_tbs_info(n, sortedby, true);
> +}
> +
> +static void hmp_info_tb(Monitor *mon, const QDict *qdict)
> +{
> +    const int id =3D qdict_get_int(qdict, "id");
> +    const char *flags =3D qdict_get_try_str(qdict, "flags");
> +    int mask;
> +
> +    if (!tcg_enabled()) {
> +        error_report("TB information is only available with accel=3Dtcg"=
);
> +        return;
> +    }
> +
> +    mask =3D flags ? qemu_str_to_log_mask(flags) : CPU_LOG_TB_IN_ASM;
> +
> +    if (!mask) {
> +        help_cmd(mon, "log");
> +        return;
> +    }
> +
> +    dump_tb_info(id, mask, true);
> +}
> +
> +static void hmp_info_coverset(Monitor *mon, const QDict *qdict)
> +{
> +    int n;
> +    if (!tcg_enabled()) {
> +        error_report("TB information is only available with accel=3Dtcg"=
);
> +        return;
> +    }
> +    if (!qemu_loglevel_mask(CPU_LOG_HOT_TBS)) {
> +        error_report("TB information not being recorded");
> +        return;
> +    }
> +
> +    n =3D qdict_get_try_int(qdict, "number", 90);
> +
> +    if (n < 0 || n > 100) {
> +        error_report("Coverset percentage should be between 0 and 100");
> +        return;
> +    }
> +
> +    dump_coverset_info(n, true);
> +}
> +
>  static void hmp_info_opcount(Monitor *mon, const QDict *qdict)
>  {
>      dump_opcount_info();


--
Alex Benn=C3=A9e

