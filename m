Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E729CC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 13:38:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A30E2206F6
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 13:38:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IlMXAkNU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A30E2206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGjld-0003IO-Qf
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 09:38:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50247)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jGjhl-00077V-IM
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 09:34:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jGjhi-0006r6-Ux
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 09:34:51 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:28934)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jGjhi-0006qY-LS
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 09:34:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585056889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UZwOfPAtE+xJvlQrJdjTSsG1XdnHiKfuOiVWYKNsZn8=;
 b=IlMXAkNUc6KK7TGF+apv8MnrXsdohAjNrgJbI3Zxw145vZR2yo5KRskhVVKaYXv3rF5tOV
 5Ps0v7y3z14tj/Y0vayj3Td7cz9ABahubjO/6kg/VKOnylSwoCXbeQOcf6ceoo8S9CVflM
 Mv0mnuRMcEJHpRy9WlKkhEU4+UW6ToI=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-rZu581lvOzmgT4fOz1zNIQ-1; Tue, 24 Mar 2020 09:34:47 -0400
X-MC-Unique: rZu581lvOzmgT4fOz1zNIQ-1
Received: by mail-ed1-f69.google.com with SMTP id f19so8084941edt.5
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2020 06:34:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Ch1t1Slrewfqgj/JFtKC8iOST2wdrwamJ599JYwhedw=;
 b=tQkfT5nyvkzQ21MKOT4EV3LXPZfofftXWVYjFm+Ltac9dAAca3knTipOXXqRF4g97Y
 4oDrm/sq34PWrdd2SVBNChaxqwfWawN5DOTkCrG3Bv2mpx9GD+LnXJmSqgcUpdekbr2V
 6NueOq2l021xyLCCPnDnzKZsoGVLZ3e57QK4Sk73d3G1eNznTthW2lqu3FvqQfKUhJF4
 NXILbJKXDYzY/UIvrTNeU6R+h42BWOFCnRoupcDb4BeXyIkbyKcOXivi1hD4Sm33u55G
 RCf8xHy+6eizJB/xUjyCcOLaSPQeaXdd2d/pRTvvpdtsXOSWw+7iYfF78Y+4CQGBj3Tr
 ywCA==
X-Gm-Message-State: ANhLgQ1OjM7C8KRYqsUufvvQSn8B8dd7+cUZcV7FpERM3lcjGtoq+n8d
 w90oP1kjaM4GB6O4PmDa8/1+xqPzaaxvv1n0sIE/rAJRUw8ATz15Mu2nO6ulq+I+FZ+Y9DjmHM6
 pNfvmMO5XMBmukz0=
X-Received: by 2002:a17:906:4d8d:: with SMTP id
 s13mr3523158eju.154.1585056886032; 
 Tue, 24 Mar 2020 06:34:46 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vs0ak+2eCTLJL8x9ri8Tu3xQh/FAJne5PFlvVjPBqiocbPJSUzKSFVvdEBFa0MOzAX/XCRMzw==
X-Received: by 2002:a17:906:4d8d:: with SMTP id
 s13mr3523139eju.154.1585056885793; 
 Tue, 24 Mar 2020 06:34:45 -0700 (PDT)
Received: from [192.168.1.35] (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id r30sm1315579edi.75.2020.03.24.06.34.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Mar 2020 06:34:45 -0700 (PDT)
Subject: Re: [PATCH-for-5.0] hw/audio/fmopl: fix segmentation fault
To: =?UTF-8?Q?Volker_R=c3=bcmelin?= <vr_qemu@t-online.de>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20200324061855.5951-1-vr_qemu@t-online.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <5a2f4db9-8d50-42d2-172d-f02285535573@redhat.com>
Date: Tue, 24 Mar 2020 14:34:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200324061855.5951-1-vr_qemu@t-online.de>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/24/20 7:18 AM, Volker R=C3=BCmelin wrote:
> Current code allocates the memory for ENV_CURVE too late. Move
> allocation to OPLOpenTable() and deallocation to OPLCloseTable().
>=20
> To reproduce the bug start qemu with -soundhw adlib.
>=20
> Fixes 2eea51bd01 "hw/audio/fmopl: Move ENV_CURVE to .heap to save
> 32KiB of .bss"

Oops sorry, thanks for the fix!

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>=20
> Signed-off-by: Volker R=C3=BCmelin <vr_qemu@t-online.de>
> ---
>   hw/audio/fmopl.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/audio/fmopl.c b/hw/audio/fmopl.c
> index 356d4dfbca..8a71a569fa 100644
> --- a/hw/audio/fmopl.c
> +++ b/hw/audio/fmopl.c
> @@ -627,6 +627,7 @@ static int OPLOpenTable( void )
>   =09=09free(AMS_TABLE);
>   =09=09return 0;
>   =09}
> +    ENV_CURVE =3D g_new(int32_t, 2 * EG_ENT + 1);
>   =09/* make total level table */
>   =09for (t =3D 0;t < EG_ENT-1 ;t++){
>   =09=09rate =3D ((1<<TL_BITS)-1)/pow(10,EG_STEP*t/20);=09/* dB -> voltag=
e */
> @@ -694,6 +695,7 @@ static int OPLOpenTable( void )
>  =20
>   static void OPLCloseTable( void )
>   {
> +    g_free(ENV_CURVE);
>   =09free(TL_TABLE);
>   =09free(SIN_TABLE);
>   =09free(AMS_TABLE);
> @@ -1090,7 +1092,6 @@ FM_OPL *OPLCreate(int clock, int rate)
>   =09OPL->clock =3D clock;
>   =09OPL->rate  =3D rate;
>   =09OPL->max_ch =3D max_ch;
> -    ENV_CURVE =3D g_new(int32_t, 2 * EG_ENT + 1);
>   =09/* init grobal tables */
>   =09OPL_initialize(OPL);
>   =09/* reset chip */
> @@ -1128,7 +1129,6 @@ void OPLDestroy(FM_OPL *OPL)
>   #endif
>   =09OPL_UnLockTable();
>   =09free(OPL);
> -    g_free(ENV_CURVE);
>   }
>  =20
>   /* ----------  Option handlers ----------       */
>=20


