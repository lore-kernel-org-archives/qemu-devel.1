Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41165C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 16:38:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C3BB2173E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 16:38:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QATF7kgm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C3BB2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idGca-00006I-Lj
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 11:38:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44198)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1idF0x-0003LV-BJ
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:55:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1idF0w-0000av-9A
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:55:27 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:26677
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1idF0v-0000Zv-Ub
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:55:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575644125;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EHbm8Mxi9u2lFeWBbTrrb+xSZH5nxlwfv/bz8PraP9I=;
 b=QATF7kgmiQXmVI57BwIsmn8R0SZRvIE9zBKpUt/dmqnp6KXmchTAMegL8fR43VcXYADMFU
 b2TBRoi4+Uc9sttXtckkZkXHYhnlTd1D2p7sNWWhLltliQTVkK9Hy5+2eV4o/PX+HEJlM/
 7C2F/q1fMCeKXHvGinn0Xj+Dvfid+KE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-ubOm45EQNvq6HEiULMtd-Q-1; Fri, 06 Dec 2019 00:52:48 -0500
Received: by mail-wr1-f72.google.com with SMTP id f17so2659154wrt.19
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2019 21:52:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=l8aWSs178d8/fwMfPao1yrat6D85BysxnDFjaz8aBTs=;
 b=VJwa2I4P0rb/DG1fuBoQ6jhqfi+4S+TgkWPMF/tvyEahOdZZfBof/L1mngUM+QEe7G
 Ts2vTbWs9RZEzkGVntV2mWsOyMpcJzUkn+9wi/TFh/DI9ZIOJPowV4/bDpY+GO0ww3Iy
 UbWJlAh/Xowl3HUsjFIhkZQCC+p0FeA1ben/OjJuOb4ScrRgFTMzEfsPj7PrPVJPQZxd
 VTymjwTZJNkhI68XTj3yI5tGv35DuvQ5udj8SGTtL/CmDUm+TLHkqY5Vy8wRUqCO9jit
 BqSB0x2FOJZGXC0t0ph2aieiykzG3lCXxKz9N19L55mPll2195ZBKKseVJdVm6rowS6E
 7B9A==
X-Gm-Message-State: APjAAAUFR93tuZBuYeWK6tRl6Qpk5grfU31gvw/7c6novEPNm7XJld+m
 mjGI9wpOBqDC1D4kMSgmypLdy7jZwB8alu/pLPX3onBNYqtnIR9DH5pHE5pGv4LKEHyKOe003NB
 OEVIB24E21cQHEMc=
X-Received: by 2002:adf:c54e:: with SMTP id s14mr14485934wrf.385.1575611566677; 
 Thu, 05 Dec 2019 21:52:46 -0800 (PST)
X-Google-Smtp-Source: APXvYqzqvdph8N4eEATXx7VPoDC6N158p+8Yq7hQsXhoLsLN5iZppGEZ+dTwGbWwqCeH5FnocoSZQw==
X-Received: by 2002:adf:c54e:: with SMTP id s14mr14485920wrf.385.1575611566530; 
 Thu, 05 Dec 2019 21:52:46 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id y20sm2172351wmi.25.2019.12.05.21.52.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Dec 2019 21:52:46 -0800 (PST)
Subject: Re: [PATCH 2/3] hw/audio: Remove the "use_broken_id" hack from the
 AC97 device
To: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20191205160652.23493-1-thuth@redhat.com>
 <20191205160652.23493-3-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1ace7f19-252a-365d-75d9-0b6a02ef064b@redhat.com>
Date: Fri, 6 Dec 2019 06:52:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191205160652.23493-3-thuth@redhat.com>
Content-Language: en-US
X-MC-Unique: ubOm45EQNvq6HEiULMtd-Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: libvir-list@redhat.com, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/5/19 5:06 PM, Thomas Huth wrote:
> Now that the old pc-0.x machine types are gone, we do not need
> the "use_broken_id" hack anymore.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   hw/audio/ac97.c | 9 ---------
>   1 file changed, 9 deletions(-)
>=20
> diff --git a/hw/audio/ac97.c b/hw/audio/ac97.c
> index a136b97f68..78cda88333 100644
> --- a/hw/audio/ac97.c
> +++ b/hw/audio/ac97.c
> @@ -161,7 +161,6 @@ typedef struct AC97BusMasterRegs {
>   typedef struct AC97LinkState {
>       PCIDevice dev;
>       QEMUSoundCard card;
> -    uint32_t use_broken_id;
>       uint32_t glob_cnt;
>       uint32_t glob_sta;
>       uint32_t cas;
> @@ -1373,13 +1372,6 @@ static void ac97_realize(PCIDevice *dev, Error **e=
rrp)
>       c[PCI_BASE_ADDRESS_0 + 6] =3D 0x00;
>       c[PCI_BASE_ADDRESS_0 + 7] =3D 0x00;
>  =20
> -    if (s->use_broken_id) {
> -        c[PCI_SUBSYSTEM_VENDOR_ID] =3D 0x86;
> -        c[PCI_SUBSYSTEM_VENDOR_ID + 1] =3D 0x80;
> -        c[PCI_SUBSYSTEM_ID] =3D 0x00;
> -        c[PCI_SUBSYSTEM_ID + 1] =3D 0x00;
> -    }
> -
>       c[PCI_INTERRUPT_LINE] =3D 0x00;      /* intr_ln interrupt line rw *=
/
>       c[PCI_INTERRUPT_PIN] =3D 0x01;      /* intr_pn interrupt pin ro */
>  =20
> @@ -1411,7 +1403,6 @@ static int ac97_init (PCIBus *bus)
>  =20
>   static Property ac97_properties[] =3D {
>       DEFINE_AUDIO_PROPERTIES(AC97LinkState, card),
> -    DEFINE_PROP_UINT32 ("use_broken_id", AC97LinkState, use_broken_id, 0=
),
>       DEFINE_PROP_END_OF_LIST (),
>   };
>  =20
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


