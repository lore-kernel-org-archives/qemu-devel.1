Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B38C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 13:17:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF7142168B
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 13:17:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RmRZBBY3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF7142168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2EMq-00059l-QT
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 08:17:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46423)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j2ELn-0004PF-FE
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 08:16:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j2ELm-0006Q6-DV
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 08:16:15 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:38633)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j2ELm-0006Pq-70
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 08:16:14 -0500
Received: by mail-oi1-x243.google.com with SMTP id l9so5699074oii.5
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 05:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=wVx3wzehpduoSQv0gmHbt4XIlHdewkwFImduFZOCOho=;
 b=RmRZBBY3IRbNK8d3pieTIoU077aYA+YHNbHpoOTXw5UufRmtHGxLVS+jPVbKgbUSsl
 WxOardz0b8idC/1vmIMTbZQVHz37g/l7q6fgLsB2v0fwfl15pNlglQkQqt+jiujWuhwP
 /fKWpqAcst8dXlnrsD5DaubaopP0Ve0MHLxdjjrrAKXCQdyfs4xon5itn278X8WGjKZT
 nsMnY2zEM3ApHflzDqmnyisHue2oYxHGStwe0CAkg6c3rpmlzZ49qbQMIbep7hFUidMp
 pUDNwM5+bKRa4c7Nfa/Yy56OEz9HvdiTr0m4hsOB2OgvtiHdNM4JaBBUaH+oOxX+4jmr
 3oUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=wVx3wzehpduoSQv0gmHbt4XIlHdewkwFImduFZOCOho=;
 b=QaMQE4UB+MqGlAgX85XdmGvwLqyjDXu9xMFCo95ttAFtjE4qaVduiTCkhvVmpBVVSM
 w3Cc0JzV0iuuYl1fKbwfhZcvhTiQ3fk0yeuS3yZ1KVcSLqpW0KFgjiHTkKem+yeR7dzK
 6Z5FbwoT4Cn/3WLZK0nTp9l6QOejn6IJg0RohKux/zrQOBC05/LMIIMdqlhgm1/dP0S0
 F8NzxgqfrUAYrssIlVyJhKc0t5naXvvA7Zfx/wsCOx4Gxqztw0nbAPjj2mYsvh7oyhy5
 tTlEsyWyTzyQRjCWDSTS9E+BlpM3DHk75spC916elWKSQjQ0i1YAN944xd7gJm7gdPLq
 ndNw==
X-Gm-Message-State: APjAAAWwTRPiwIn16mMzOqETuo726s0AAog5QDd09V7QfAp9P9/bJ2Vl
 Ci64ftwYT6Aa7O1HaXd296nNenqW9CAPiNPvgBphdg==
X-Google-Smtp-Source: APXvYqxtZNtes+kLRgHkQOFx5mP457m+KNtH5aOODdohWiEwGwVztzU6lDV2XQTuIAMD2eczvbrB2lJGKOagifv3bFY=
X-Received: by 2002:a54:4f16:: with SMTP id e22mr2913102oiy.170.1581599773558; 
 Thu, 13 Feb 2020 05:16:13 -0800 (PST)
MIME-Version: 1.0
References: <20200213025603.149432-1-kuhn.chenqun@huawei.com>
 <17ae20f0-fcf6-f9a0-b8e3-808255994dfb@redhat.com>
In-Reply-To: <17ae20f0-fcf6-f9a0-b8e3-808255994dfb@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Feb 2020 13:16:02 +0000
Message-ID: <CAFEAcA9OkOn6icoyLFi8Di6iY_PjtnQjKnjqeDgd7UCAPsMhNw@mail.gmail.com>
Subject: Re: [PATCH v2] hw/char/exynos4210_uart: Fix memleaks in
 exynos4210_uart_init
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 QEMU Trivial <qemu-trivial@nongnu.org>, kuhn.chenqun@huawei.com,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 13 Feb 2020 at 10:09, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> On 2/13/20 3:56 AM, kuhn.chenqun@huawei.com wrote:
> > From: Chen Qun <kuhn.chenqun@huawei.com>
> >
> > It's easy to reproduce as follow:
> > virsh qemu-monitor-command vm1 --pretty '{"execute": "device-list-prope=
rties",
> > "arguments":{"typename":"exynos4210.uart"}}'
> >
> > ASAN shows memory leak stack:
> >    #1 0xfffd896d71cb in g_malloc0 (/lib64/libglib-2.0.so.0+0x571cb)
> >    #2 0xaaad270beee3 in timer_new_full /qemu/include/qemu/timer.h:530
> >    #3 0xaaad270beee3 in timer_new /qemu/include/qemu/timer.h:551
> >    #4 0xaaad270beee3 in timer_new_ns /qemu/include/qemu/timer.h:569
> >    #5 0xaaad270beee3 in exynos4210_uart_init /qemu/hw/char/exynos4210_u=
art.c:677
> >    #6 0xaaad275c8f4f in object_initialize_with_type /qemu/qom/object.c:=
516
> >    #7 0xaaad275c91bb in object_new_with_type /qemu/qom/object.c:684
> >    #8 0xaaad2755df2f in qmp_device_list_properties /qemu/qom/qom-qmp-cm=
ds.c:152
> >
> > Reported-by: Euler Robot <euler.robot@huawei.com>
> > Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
> > ---
> > Changes V2 to V1:
> > -Keep s->wordtime in exynos4210_uart_init (Base on Eduardo and Philippe=
's comments).
>
> Thanks.
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>



Applied to target-arm.next, thanks.

-- PMM

