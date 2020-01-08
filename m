Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 033EBC282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 21:20:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF57B206DB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 21:20:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="ZNnZvA30"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF57B206DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipIkL-0007uR-Kg
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 16:20:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60754)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <deller@gmx.de>) id 1ipIgJ-0006Va-RE
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 16:16:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <deller@gmx.de>) id 1ipIgI-0001OP-Oz
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 16:15:59 -0500
Received: from mout.gmx.net ([212.227.17.21]:39153)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <deller@gmx.de>) id 1ipIgI-0001M8-C0
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 16:15:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1578518144;
 bh=LY5832VXgoqu/8iAYPUrF7mbuo3VYMRD045YAPFVnrw=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=ZNnZvA30mZIMSyGaQx+MixSEu7WYJLLCHyJQo4R+idCAyesBVY54Ogb0tH/yd8InK
 pxpNiTTJ7gK9GDEwdIZfa1saxFbJ6v7LgULXcF1K+azL68Tgv3XgIFW+fyImDHTaAL
 sTYY7TMohHlCU4IlSE7d9aGVBLiM4Z1IQ7RSl56s=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.128.161]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MJE27-1j8lND2BsR-00KgeO; Wed, 08
 Jan 2020 22:15:44 +0100
Subject: Re: [PATCH 1/3] hw/hppa/machine: Correctly check the firmware is in
 PDC range
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org,
 Sven Schnelle <svens@stackframe.org>
References: <20200108181425.21485-1-f4bug@amsat.org>
 <20200108181425.21485-2-f4bug@amsat.org>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
 c2TFWAS8k6RLkk41ZUU8ENX8+qZx/Q==
Message-ID: <25674517-77f3-eb1a-1a4c-db953ef4e04b@gmx.de>
Date: Wed, 8 Jan 2020 22:15:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200108181425.21485-2-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1kGK9dQCdfLhjhSuMJLA+7bHHcrJqpc2ZrgSVn8Sw+EqjwpP75Q
 FzBDE0VaBIxajfukxhAIUrQdThbMoaB8Gfuvep6USh+SuMbsaCUt22C6ECKEtU9lsFxFvGi
 nr4uBtrsAp6gB2HoavGAZXVinACKkHw4D/HsCSGw7LkWUgcZ0o9Dog2EMovJRAGP2oyCZzv
 2PFGli2XNdNVBU6WB7zvA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JmhTNZt6GvI=:jm13GR2LqWmJXk2h+BgBNU
 07BwO2+XjTMmc03IL/WYHg47c1KwqV4NZmrRehGNacY47yOodovTBkaQSwFIzPnVa/wPFI00v
 OddRzCSKzpIovtgMOy5xLCpVkkivjGX7K39gURnW4SAySG5/i9YnzG60MQuixvMUAQ1IGhSGB
 TwCpyZOtfE0k4nvhCwKvLqJ0NniogXmSV/uRA4xz+wc102UeibtgMH5zwkdbcRDTERq/whHv/
 5nXnn0/qFceizEQV1lVUqb9eDxeZ93ElyRHdLwnsRrhKSeVlNaVO5kSNhJE4Y1yWSNmg5vMaB
 Waq1wSsB7XNjReXD/tBWRAV23DAeyifHSeFSh9vzxuRtAe6RDW5+5PMhSKVS/1Rtii9KSVwkA
 dfDpC/qcSxqShmQ2c+2BPrt2nTqgaey/uBOsSt0GmmEODDDU+/UnbwlnCwG0t2hHfHx2hRcem
 wuy1aQVWHPfjgnosQuslXON1eEFqqDCp2LZMJ/3TNFXMbWoj6eb2paMRLHlC2L4H5ql4/l+3/
 1HMiMBxKdHstnPL6fErxCwP3TAiYfZD+XkccwEgS5HpEtids68LWpMvd6ycze7iKg3IsgY9Y8
 ByRqmlssSacLEAfCqZWIHsIcK0cRi150XhGSddlr40IKt2HX9iqIwrZvCCARhmk1RAsRORWaF
 QiX6t9cG6PgwPK9brietQesKW08dVWl5W7RMgxCO47/dmHzvBRkKDL8kLcc5Vqj6+LjXFp4E8
 OKcxGPI+8se/Ckw+V6ESdnENiPM7/i1dV+en9aOGeqdoSdHUo1zHOgM2B81EGc89wvMI+tzQV
 adaJEYoGT1rP8KEWcUJCYRQs5eb1WYqxIuVCB0LgvY+e1T6nbT2ENSTYLH6SW6Ui705EDviAI
 /lrBqU+M5YTvhDjJDnqj2Ocxs8dgTOmuYW074EzBuF0ljv90mOVRTS/GkWjK5Wco7xX9o48sD
 As1TyJzA/6LFkZgJhh1yJXVobXYC/R5J11YFzjsWf+f1fCDe/ElhqiUmJEI011CuZeS7DcsQB
 6F5TAChxduxcXN8Yej2XlhKZUe2LR6h+ReFV9ChEHYYXud79AIxDNPlRaeOrBTBcoYFhRBfE6
 JYZC9aE9nTceRak5VZkxbfOudONJqE8Bstc7OAf0D1wgrkq5hADeiS2hxGaf77936Mh4YuTSU
 212n4fKggb3+AtVYPD13MalE7eU44jqGTmLLxMKvfYwN+It6Z2NmFGfpdyBBqfFdRopDChULX
 qWAU7omAri1+xkklTyBdUe4Mi82kWpE1HqS4eQg==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.17.21
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
Cc: Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08.01.20 19:14, Philippe Mathieu-Daud=C3=A9 wrote:
> The firmware has to reside in the PDC range. If the Elf file
> expects to load it below FIRMWARE_START, it is incorrect,
> regardless the RAM size.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Acked-by: Helge Deller <deller@gmx.de>

> ---
> Note we define FIRMWARE_END=3D0xf0800000 but in the specs
> the PDC ends at 0xf1000000.
> ---
>  hw/hppa/machine.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
> index 5d0de26140..6775d879f8 100644
> --- a/hw/hppa/machine.c
> +++ b/hw/hppa/machine.c
> @@ -155,7 +155,7 @@ static void machine_hppa_init(MachineState *machine)
>      qemu_log_mask(CPU_LOG_PAGE, "Firmware loaded at 0x%08" PRIx64
>                    "-0x%08" PRIx64 ", entry at 0x%08" PRIx64 ".\n",
>                    firmware_low, firmware_high, firmware_entry);
> -    if (firmware_low < ram_size || firmware_high >=3D FIRMWARE_END) {
> +    if (firmware_low < FIRMWARE_START || firmware_high >=3D FIRMWARE_EN=
D) {
>          error_report("Firmware overlaps with memory or IO space");
>          exit(1);
>      }
>


