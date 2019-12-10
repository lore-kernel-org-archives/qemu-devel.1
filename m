Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB80C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 13:33:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBA962073B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 13:33:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VRDLrXqa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBA962073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iefdo-0002kY-Lw
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 08:33:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38891)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iefct-0002LI-IF
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 08:32:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iefcs-0001uI-7i
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 08:32:31 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:48950
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iefcs-0001uB-4F
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 08:32:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575984749;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6UOlvLt8ueS4279h2ZCjk2hDIPDPl9NF+jnphhKpw8k=;
 b=VRDLrXqanNRArb8RQt/FvpkZCSZNniwpkxiKyAYQ8FVVSFb7uD5/pODzVSjuTaoGZcZOzv
 1fUO0UA0wf8/OTzkFBZyYm+d/NIrDB13SkHsUd30Wr15/Prc2tuJWum/C/jUhp1GjoiIaB
 01jZeof+3vl9WSUSR9IZByU//QnBdd8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-49-MSnHPhIJMNKW-8uPV0MBFA-1; Tue, 10 Dec 2019 08:32:28 -0500
Received: by mail-wr1-f71.google.com with SMTP id z15so9017778wrw.0
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2019 05:32:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=NplI3KVoD13rv+gBpXWGLlYYCili7TnLQtpvV8kFHaQ=;
 b=T3QHXW55B4C50atRNMZVsGxVUo0cLsziBkvLD8xuIl8oI4KNFwKvhrxXPp/kosnuNu
 SW+/eZ9OC9fh/5ZYnRkBX2+kXnaQowzfqaw4War1RKj0KzzeM56y97Xag1PalP4vQw8e
 SFr1PmBTJdmefVtuuiM+nMK9CcCn1dHtnzmmQT8+T2Lwtj5Yp+010C9pzNnKAUkkD+P4
 Nt4h2CKiLSLjQmqqYmJHPLn9MveT9rC3mPwHHg+x1GJ2eYwQYt6GQBjp4gDUnGCu5/5M
 aST+UjJsZlCL4ETPQNszYf4wbUFkLEO1T1UVZEROSsVEvCPsuusVMsqEH+ChIE99Ma48
 Kblg==
X-Gm-Message-State: APjAAAV/ZrGavuoxJ8ETijGh/TIBte+NCk0h61ovP6VjuXDBjAyYD279
 M65/d7mAlJdhECb+Y7g22KIDqvMXSkwRcect5VIuK4/vzxQtav0oYJez+wktS6PwnHy52PSkB/Q
 lG//5vdo86ZCsvOs=
X-Received: by 2002:adf:e74a:: with SMTP id c10mr3226237wrn.386.1575984746921; 
 Tue, 10 Dec 2019 05:32:26 -0800 (PST)
X-Google-Smtp-Source: APXvYqy80jOJJybpW9FFZuLr3Lyj856nFfW81hkQcjfy5OgwYwWb1F0SIC6DipIKKbXvY94HcC46Vw==
X-Received: by 2002:adf:e74a:: with SMTP id c10mr3226215wrn.386.1575984746641; 
 Tue, 10 Dec 2019 05:32:26 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9?
 ([2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9])
 by smtp.gmail.com with ESMTPSA id g9sm3380511wro.67.2019.12.10.05.32.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Dec 2019 05:32:26 -0800 (PST)
Subject: Re: [PATCH] hw/usb: Introduce Kconfig switches for the CCID card
 devices
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-devel@nongnu.org
References: <20191210072048.15603-1-thuth@redhat.com>
 <c402f822-bbbc-7ece-2fb4-1a37484be05e@redhat.com>
 <ab65b73a-0c09-925f-054b-c8ddea8b5476@redhat.com>
 <20772e61-a66d-93ad-7728-dcd3b3fdeb31@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b084a0fe-e3c5-5096-9c71-870fe0ee1ddc@redhat.com>
Date: Tue, 10 Dec 2019 14:32:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20772e61-a66d-93ad-7728-dcd3b3fdeb31@redhat.com>
Content-Language: en-US
X-MC-Unique: MSnHPhIJMNKW-8uPV0MBFA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/12/19 14:27, Philippe Mathieu-Daud=C3=A9 wrote:
> On 12/10/19 9:11 AM, Thomas Huth wrote:
>> On 10/12/2019 08.43, Philippe Mathieu-Daud=C3=A9 wrote:
>>> On 12/10/19 8:20 AM, Thomas Huth wrote:
>>>> In our downstream distribution of QEMU, we need more fine-grained
>>>> control on the set of CCID card devices that we want to include.
>>>> So let's introduce some proper Kconfig switches that it is easier
>>>> to disable them without modifying the corresponding Makefile.objs.
>>>>
>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>> ---
>>>> =C2=A0=C2=A0 hw/usb/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 10 +=
+++++++++
>>>> =C2=A0=C2=A0 hw/usb/Makefile.objs |=C2=A0 7 +++++--
>>>> =C2=A0=C2=A0 2 files changed, 15 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/hw/usb/Kconfig b/hw/usb/Kconfig
>>>> index 555e09377b..1358847eba 100644
>>>> --- a/hw/usb/Kconfig
>>>> +++ b/hw/usb/Kconfig
>>>> @@ -96,3 +96,13 @@ config USB_STORAGE_MTP
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default y
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 depends on USB
>>>> +
>>>> +config CCID_PASSTHRU
>>>> +=C2=A0=C2=A0=C2=A0 bool
>>>> +=C2=A0=C2=A0=C2=A0 default y
>>>> +=C2=A0=C2=A0=C2=A0 depends on USB_SMARTCARD
>>>> +
>>>> +config CCID_EMULATED
>>>> +=C2=A0=C2=A0=C2=A0 bool
>>>> +=C2=A0=C2=A0=C2=A0 default y
>>>> +=C2=A0=C2=A0=C2=A0 depends on USB_SMARTCARD
>>>> diff --git a/hw/usb/Makefile.objs b/hw/usb/Makefile.objs
>>>> index 303ac084a0..ebe103fb3d 100644
>>>> --- a/hw/usb/Makefile.objs
>>>> +++ b/hw/usb/Makefile.objs
>>>> @@ -29,11 +29,14 @@ common-obj-$(CONFIG_USB_BLUETOOTH)=C2=A0=C2=A0=C2=
=A0 +=3D
>>>> dev-bluetooth.o
>>>> =C2=A0=C2=A0 =C2=A0 ifeq ($(CONFIG_USB_SMARTCARD),y)
>>>> =C2=A0=C2=A0 common-obj-y=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +=3D dev-smartcard-reader.o
>>>> -common-obj-$(CONFIG_SMARTCARD)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 +=3D smartcard.mo
>>>> -smartcard.mo-objs :=3D ccid-card-passthru.o ccid-card-emulated.o
>>>> +ifeq ($(CONFIG_SMARTCARD),y)
>>>
>>> We don't need the 'ifeq ($(CONFIG_SMARTCARD),y)' ... endif anymore.
>>
>> I think we do. Both files #include <libcacard.h> thus can only be
>> compiled if CONFIG_SMARTCARD has been set.
>> Don't mix CONFIG_SMARTCARD up with CONFIG_USB_SMARTCARD - these are two
>> different switches!
>=20
> OK I missed SMARTCARD is not in Kconfig.host.
>=20
> What about adding that to your patch and remove the ifeq():
>=20
> -- >8 --
> diff --git a/Kconfig.host b/Kconfig.host
> index bb6e116e2a..b532358854 100644
> --- a/Kconfig.host
> +++ b/Kconfig.host
> @@ -35,3 +35,6 @@ config VIRTFS
>=20
> =C2=A0config PVRDMA
> =C2=A0=C2=A0=C2=A0=C2=A0 bool
> +
> +config SMARTCARD
> +=C2=A0=C2=A0=C2=A0 bool
> diff --git a/hw/usb/Kconfig b/hw/usb/Kconfig
> index 555e09377b..b3292a5cc9 100644
> --- a/hw/usb/Kconfig
> +++ b/hw/usb/Kconfig
> @@ -90,7 +90,7 @@ config USB_BLUETOOTH
> =C2=A0config USB_SMARTCARD
> =C2=A0=C2=A0=C2=A0=C2=A0 bool
> =C2=A0=C2=A0=C2=A0=C2=A0 default y
> -=C2=A0=C2=A0=C2=A0 depends on USB
> +=C2=A0=C2=A0=C2=A0 depends on SMARTCARD && USB
>=20
> =C2=A0config USB_STORAGE_MTP
> =C2=A0=C2=A0=C2=A0=C2=A0 bool

Yes, this is a good idea.

Paolo

> ---
>=20
>>>> +common-obj-$(call
>>>> lor,$(CONFIG_CCID_PASSTHRU),$(CONFIG_CCID_EMULATED)) +=3D smartcard.mo
>>>> +smartcard.mo-objs :=3D $(call
>>>> lif,$(CONFIG_CCID_PASSTHRU),ccid-card-passthru.o) \
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $(call
>>>> lif,$(CONFIG_CCID_EMULATED),ccid-card-emulated.o)
>>>> =C2=A0=C2=A0 smartcard.mo-cflags :=3D $(SMARTCARD_CFLAGS)
>>>> =C2=A0=C2=A0 smartcard.mo-libs :=3D $(SMARTCARD_LIBS)
>>>> =C2=A0=C2=A0 endif
>>>> +endif
>>>> =C2=A0=C2=A0 =C2=A0 ifeq ($(CONFIG_POSIX),y)
>>>> =C2=A0=C2=A0 common-obj-$(CONFIG_USB_STORAGE_MTP)=C2=A0 +=3D dev-mtp.o
>>>>
>>>
>>
>=20


