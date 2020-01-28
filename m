Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C3DC32771
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 00:40:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F8ED24656
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 00:40:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HvK2gkWk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F8ED24656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwEw0-00048p-Ju
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 19:40:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45893)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ianjiang.ict@gmail.com>) id 1iwEvJ-0003ew-PF
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 19:40:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ianjiang.ict@gmail.com>) id 1iwEvI-0004N9-Ry
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 19:40:09 -0500
Received: from mail-il1-x144.google.com ([2607:f8b0:4864:20::144]:42929)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <ianjiang.ict@gmail.com>)
 id 1iwEvI-0004Mq-Ng
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 19:40:08 -0500
Received: by mail-il1-x144.google.com with SMTP id x2so5468199ila.9
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2020 16:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=4cHC1KYSdAaBrGJYyKBZPVY4mT1snIhlJ8dcs+kjA7w=;
 b=HvK2gkWkYpEfZnMVh9AYpCK9jt7iVl1l9gxojj2OQSFhfzy+DHPMf41u4jhQlzaO2h
 3fEOda4bu/UNRMjx2Q0m5YKETHzlFbKywiWkksuMdTAw7Xeq/r9qpROd9Wq7ELWvBTwC
 7AKIvnxcBc+YgpDS3t5n9sErmLcvqX3AM87WCwEDUrQARof8L5eRlqEvWkz5LEQoFh2O
 HhRN6AZ4og8yzNWn763mI7UQGWmafGmxu/QhwuNNi4041TYB6WjCRfIBYGJFzGV3lDkL
 31qDKNIuFjBtziHpwNOcF4oQvLfCCXr1F5cgObFSpavTqDN02ywvm/WhjGuMb6Swkfd3
 Yz8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=4cHC1KYSdAaBrGJYyKBZPVY4mT1snIhlJ8dcs+kjA7w=;
 b=LTl1XBEx9cxadXAk8eAAjvEyawkcT9IfrLgxXxVo7paTSZBv38c+92VHsCkmYe+net
 f4HZ1cDFA4Qp/Exy4FAZu2fCL2Ss80WpMolKfndZzssQ8+ZFduoIGV771J5Lj8/TdT8l
 7e+Vxm6T5WS3VIdl1paXa35MvQiFXEgyjMvGi3i1n6VIr/PyxjDzG5jNNmfE1bUKUzp/
 I4XpllXHjVzjfw40W8eFoURYQo3gO016TgX01vrHJIJn49EWzxo6wXyoyNI8I3/9s/8B
 XHi+/fGkstarnbNa4r2bTpn50b/hD2LMszzPSadHwoMu+A36w676YBDonAAUqz/OjjKq
 I4GQ==
X-Gm-Message-State: APjAAAVEPiBWbmAeqqF83VyBTdEzTuVQoAh2nzOPBzpaw8TTtvHLjsgE
 3c1cZySNq4EA8OUWSvapzO/ZS7k3eDXKtRHvvDA=
X-Google-Smtp-Source: APXvYqzRYo+OhqmixJS6bibSvG4FAlE8JRNl/QVFVxSJH4MVLSSJSi+uNrK3euROKr2ciOXiwCDo4gDBGv5+0fpts4M=
X-Received: by 2002:a92:af4b:: with SMTP id n72mr17861752ili.288.1580172007739; 
 Mon, 27 Jan 2020 16:40:07 -0800 (PST)
MIME-Version: 1.0
References: <20200127141051.12543-1-ianjiang.ict@gmail.com>
 <3f82064c-4441-550a-7e18-806ab3e54171@linaro.org>
In-Reply-To: <3f82064c-4441-550a-7e18-806ab3e54171@linaro.org>
From: Ian Jiang <ianjiang.ict@gmail.com>
Date: Tue, 28 Jan 2020 08:39:56 +0800
Message-ID: <CAMAD20n4OTSwg+aVUNJdkBRLR2K_QZaEzs6+u0U+gAua-eW9rQ@mail.gmail.com>
Subject: Re: [PATCH] riscv: Add helper to make NaN-boxing for FP register
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::144
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
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The patch description is modified and a new version is committed.
--
Ian Jiang

Richard Henderson <richard.henderson@linaro.org> =E4=BA=8E2020=E5=B9=B41=E6=
=9C=8828=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=881:38=E5=86=99=E9=81=
=93=EF=BC=9A
>
> On 1/27/20 6:10 AM, Ian Jiang wrote:
> > The function that makes NaN-boxing when a 32-bit value is assigned
> > to a 64-bit FP register is split out to a helper gen_nanbox_fpr().
> > Then it is applied in translating of the FLW instruction.
> >
> > This also applies for other instructions when the RVD extension is
> > present, such as FMV.W.W, FADD.S, FSUB.S and so on.
>
> I wouldn't mention this yet, as it begs the question of what you are doin=
g
> about it.  Which is nothing, yet, since that will apply to a follow-up pa=
tch.
>
>
> >
> > Signed-off-by: Ian Jiang <ianjiang.ict@gmail.com>
> > ---
> >  target/riscv/insn_trans/trans_rvf.inc.c | 17 +++++++++++++++--
> >  1 file changed, 15 insertions(+), 2 deletions(-)
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>
>
> r~

