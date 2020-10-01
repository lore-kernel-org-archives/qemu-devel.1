Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 731B1C4727E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 17:14:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0321420872
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 17:14:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J8+WTiE1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0321420872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO2AN-00022k-1M
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 13:14:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55354)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kO243-0002Co-RY
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 13:08:19 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:33985)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kO241-0001dx-I0
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 13:08:19 -0400
Received: by mail-io1-xd43.google.com with SMTP id m17so7545099ioo.1
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 10:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=4j5c48y1lsXWezaWLb9RPPe3fan9KI/tMQdBeuAk67Q=;
 b=J8+WTiE1GDjYdcY4+NsPeD8bzfNPc5YDQzCu5CMee+E6UYWzYc8kZROyLR8LG55BAi
 EsWdDlvhoFgoibivEd9NrFoMDk8JbCowB/LYkQCBmAnbmdXZlUo3+pYE0LqbrJDsVEC2
 VdSs0/P20DTyijn4VA8lk2AtIJpUiopqbftWJVk9UTyZ3RnRUm/XbZdyWoKJmxIvaluJ
 rOLPU18Avb6CPPilqDO4LEWx23cmfHVIV56DI8pYy5GvSbSXM8uI22eryeNevEK36vox
 oU0y5TGF2X8UO2SiYh1M48TvwnMLmVHxrIwUaU5ESKe3vM/5ImJGD2i6sK3EUByvF6R6
 Cvlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=4j5c48y1lsXWezaWLb9RPPe3fan9KI/tMQdBeuAk67Q=;
 b=Q/IJRA/QjiCnXOIQaI/On1KP/ebDTlSDglvhpx4VN90Sp5A+x11Y2+JkI3ib7FawfQ
 zMmdpm95m37lnsnmeSgr5liKgdfhMO9kvgKLGuhIdeukM5hZig/iyW23KG85YRWhXuOz
 zGlLl8KVVB1jvMVzMlsqsniXfbJsLCvDDxJX1b+Tp5kig7D20YDW2BHT9oYEvyZfBwFe
 Q+02L4LpVgO/X6eij1jGdbL1909oIFM8r/ov/Rj/qQLQ/du6Zhmm66EeS+fh14XbgOuo
 1rotjeIDE8Q2cIjOrx4UmMRhyUllaNRacxU0em4QjoW1UyQzjwMQHAfpkTCpbntVtkuU
 zdbg==
X-Gm-Message-State: AOAM53029ymwTJXnmOY/XtjnyHh2OMAWJIS5KNCwgS4W3EezlOSPAXq7
 b8BZ33kIc8HI0o3PdbfsRbxAJuSj2tAtHmcOXUg=
X-Google-Smtp-Source: ABdhPJwy75RoPRz8+it8/Ii2DV2mKKSevIDil8InlkjO5pgdcGRxsJSdSDw5IjB9MDuVxJSJPgbrItRCZQfcuaIWd4U=
X-Received: by 2002:a02:a615:: with SMTP id c21mr7188650jam.106.1601572096178; 
 Thu, 01 Oct 2020 10:08:16 -0700 (PDT)
MIME-Version: 1.0
References: <20201001164322.1585392-1-f4bug@amsat.org>
 <20201001164322.1585392-3-f4bug@amsat.org>
In-Reply-To: <20201001164322.1585392-3-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 1 Oct 2020 09:56:51 -0700
Message-ID: <CAKmqyKNO_EPn_2CeKaqzTMCyAf7YhYA046GqZ6y2t0=Kcy06qA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] qdev-monitor: Display frequencies scaled to SI unit
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d43;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd43.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>,
 Peter Maydell <peter.maydell@linaro.org>, Luc Michel <luc@lmichel.fr>,
 Eduardo Habkost <ehabkost@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Havard Skinnemoen <hskinnemoen@google.com>, Tyrone Ting <kfting@nuvoton.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Damien Hedde <damien.hedde@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 1, 2020 at 9:43 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
> wrote:
>
> Since commit 9f2ff99c7f2 ("qdev-monitor: print the device's clock
> with info qtree") we can display the clock frequencies in the
> monitor. Use the recently introduced freq_to_str() to display
> the frequencies using the closest SI unit (human friendlier).
>
> Before:
>
>   (qemu) info qtree
>   [...]
>   dev: xilinx,zynq_slcr, id ""
>     clock-in "ps_clk" freq_hz=3D3.333333e+07
>     mmio 00000000f8000000/0000000000001000
>
> After:
>
>   dev: xilinx,zynq_slcr, id ""
>     clock-in "ps_clk" freq_hz=3D33.3 MHz
>     mmio 00000000f8000000/0000000000001000
>
> Reviewed-by: Luc Michel <luc@lmichel.fr>
> Reviewed-by: Damien Hedde <damien.hedde@greensocs.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  qdev-monitor.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/qdev-monitor.c b/qdev-monitor.c
> index e9b7228480..a0301cfca8 100644
> --- a/qdev-monitor.c
> +++ b/qdev-monitor.c
> @@ -747,11 +747,13 @@ static void qdev_print(Monitor *mon, DeviceState *d=
ev, int indent)
>          }
>      }
>      QLIST_FOREACH(ncl, &dev->clocks, node) {
> -        qdev_printf("clock-%s%s \"%s\" freq_hz=3D%e\n",
> +        g_autofree char *freq =3D NULL;
> +
> +        freq =3D freq_to_str(clock_get_hz(ncl->clock));
> +        qdev_printf("clock-%s%s \"%s\" freq_hz=3D%s\n",
>                      ncl->output ? "out" : "in",
>                      ncl->alias ? " (alias)" : "",
> -                    ncl->name,
> -                    CLOCK_PERIOD_TO_HZ(1.0 * clock_get(ncl->clock)));
> +                    ncl->name, freq);
>      }
>      class =3D object_get_class(OBJECT(dev));
>      do {
> --
> 2.26.2
>
>

