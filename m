Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3DF6C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 13:54:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0ADE21556
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 13:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RweEJ7b2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0ADE21556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1if2Rf-0001lV-5x
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 08:54:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33517)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1if2PP-0007fD-3Y
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 08:52:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1if2PN-0001WF-Ah
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 08:52:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38907
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1if2PN-0001V4-74
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 08:52:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576072324;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=imZREeAJbmsKRfpVD9WfILTxvWQGZ+trG2dKpVByNTw=;
 b=RweEJ7b25X/juF6opE5mtkPemCrXKu42YZikpgWoAY64OYMgJzVmoJ4W9+Ff3X5BguVQ78
 ++/7+O3oHF2pswXVmhZhF1tE6p+BALmR42l8T+CUjlea/cTreuKI/lX3e8oetANOSGZMvE
 havCPCCRrSZRPMJsb0ohV2uQCVk/ot8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-JYl0e_6CNxWzkcFM-62ejg-1; Wed, 11 Dec 2019 06:51:14 -0500
Received: by mail-wm1-f72.google.com with SMTP id g26so1647437wmk.6
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2019 03:51:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=byrRNTyQi11YCfRwvlmUEIKq7+oiaHZkCiOdUY2Ubw0=;
 b=r/P78EO4lcL6Jl7MLLsmjqIaCKuFvRT4fvn1U+fnBlnadg0Tg4x0b3LEtWZLvF5/Lq
 Nz7xGan9h0iwzhoF3YASjnfcF6kMuAn51R7o0yHBXdpeEtzXazmK9hsBqDHQc/RpYtcM
 a1AX96O9FhjYswTFIABJoIrMFhuJ4XdtrAMCYy+Ul8auqdNikUtK88zYwGC8qFXVc0tO
 vaTEs+lBeMLe0lWQysw5Q7/NB41oMjgHIIa/c1mvXaA8phEbAOpYgCSud2PdLBQwCXMS
 CKYklk90kYk7Ezr778zJDrbJrCOjWNARrTm0CS0U9qIohDaHWlrMcANMeoHrHNqxcroo
 m34Q==
X-Gm-Message-State: APjAAAXfk/3sq2A/sKiOdXgExfdibOn4RNntlYXXv0TZMAaMjMN3me88
 WjpqVo8m0CqqcWS9oVlQXpLVmMy9S4woZRDLI4srZCvb32aVKL0IAAx3A7t+siJteVIbUVxbCjh
 hkqywsMR2zE8FPAM=
X-Received: by 2002:a05:600c:24b:: with SMTP id
 11mr3177707wmj.19.1576065073194; 
 Wed, 11 Dec 2019 03:51:13 -0800 (PST)
X-Google-Smtp-Source: APXvYqyClRK4qcpxhTuQIpdAMujKMXQ8ecFl8AKfJYeXN2yJaQPbVymUZ5DxTcB2l2eHGmgz35jHyg==
X-Received: by 2002:a05:600c:24b:: with SMTP id
 11mr3177684wmj.19.1576065072966; 
 Wed, 11 Dec 2019 03:51:12 -0800 (PST)
Received: from [10.201.33.164] ([195.166.127.210])
 by smtp.gmail.com with ESMTPSA id v188sm2033314wma.10.2019.12.11.03.51.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Dec 2019 03:51:12 -0800 (PST)
Subject: Re: [PATCH v2] hw/usb: Introduce Kconfig switches for the CCID card
 devices
To: Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-devel@nongnu.org
References: <20191211102029.1772-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <70300510-b621-b021-74a3-f3e4ffb06ec3@redhat.com>
Date: Wed, 11 Dec 2019 12:51:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191211102029.1772-1-thuth@redhat.com>
Content-Language: en-US
X-MC-Unique: JYl0e_6CNxWzkcFM-62ejg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/11/19 11:20 AM, Thomas Huth wrote:
> In our downstream distribution of QEMU, we need more fine-grained
> control on the set of CCID card devices that we want to include.
> So let's introduce some proper Kconfig switches that it is easier
> to disable them without modifying the corresponding Makefile.objs.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   v2: Use CONFIG_SMARTCARD in Kconfig.host as suggested by Philippe
>=20
>   Kconfig.host         |  3 +++
>   Makefile             |  3 ++-
>   hw/usb/Kconfig       | 12 +++++++++++-
>   hw/usb/Makefile.objs |  9 ++++-----
>   4 files changed, 20 insertions(+), 7 deletions(-)
>=20
> diff --git a/Kconfig.host b/Kconfig.host
> index bb6e116e2a..b532358854 100644
> --- a/Kconfig.host
> +++ b/Kconfig.host
> @@ -35,3 +35,6 @@ config VIRTFS
>  =20
>   config PVRDMA
>       bool
> +
> +config SMARTCARD
> +    bool
> diff --git a/Makefile b/Makefile
> index b437a346d7..287cda35cb 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -388,7 +388,8 @@ MINIKCONF_ARGS =3D \
>       CONFIG_VHOST_USER=3D$(CONFIG_VHOST_USER) \
>       CONFIG_VIRTFS=3D$(CONFIG_VIRTFS) \
>       CONFIG_LINUX=3D$(CONFIG_LINUX) \
> -    CONFIG_PVRDMA=3D$(CONFIG_PVRDMA)
> +    CONFIG_PVRDMA=3D$(CONFIG_PVRDMA) \
> +    CONFIG_SMARTCARD=3D$(CONFIG_SMARTCARD)

Oh I missed this detail :)

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>  =20
>   MINIKCONF_INPUTS =3D $(SRC_PATH)/Kconfig.host $(SRC_PATH)/hw/Kconfig \
>                      $(wildcard $(SRC_PATH)/hw/*/Kconfig)
> diff --git a/hw/usb/Kconfig b/hw/usb/Kconfig
> index 555e09377b..da3026586f 100644
> --- a/hw/usb/Kconfig
> +++ b/hw/usb/Kconfig
> @@ -90,9 +90,19 @@ config USB_BLUETOOTH
>   config USB_SMARTCARD
>       bool
>       default y
> -    depends on USB
> +    depends on USB && SMARTCARD
>  =20
>   config USB_STORAGE_MTP
>       bool
>       default y
>       depends on USB
> +
> +config CCID_PASSTHRU
> +    bool
> +    default y
> +    depends on USB_SMARTCARD
> +
> +config CCID_EMULATED
> +    bool
> +    default y
> +    depends on USB_SMARTCARD
> diff --git a/hw/usb/Makefile.objs b/hw/usb/Makefile.objs
> index 303ac084a0..478e6d5752 100644
> --- a/hw/usb/Makefile.objs
> +++ b/hw/usb/Makefile.objs
> @@ -27,13 +27,12 @@ common-obj-$(CONFIG_USB_SERIAL)       +=3D dev-serial=
.o
>   common-obj-$(CONFIG_USB_NETWORK)      +=3D dev-network.o
>   common-obj-$(CONFIG_USB_BLUETOOTH)    +=3D dev-bluetooth.o
>  =20
> -ifeq ($(CONFIG_USB_SMARTCARD),y)
> -common-obj-y                          +=3D dev-smartcard-reader.o
> -common-obj-$(CONFIG_SMARTCARD)        +=3D smartcard.mo
> -smartcard.mo-objs :=3D ccid-card-passthru.o ccid-card-emulated.o
> +common-obj-$(CONFIG_USB_SMARTCARD)    +=3D dev-smartcard-reader.o
> +common-obj-$(call lor,$(CONFIG_CCID_PASSTHRU),$(CONFIG_CCID_EMULATED)) +=
=3D smartcard.mo
> +smartcard.mo-objs :=3D $(call lif,$(CONFIG_CCID_PASSTHRU),ccid-card-pass=
thru.o) \
> +                     $(call lif,$(CONFIG_CCID_EMULATED),ccid-card-emulat=
ed.o)
>   smartcard.mo-cflags :=3D $(SMARTCARD_CFLAGS)
>   smartcard.mo-libs :=3D $(SMARTCARD_LIBS)
> -endif
>  =20
>   ifeq ($(CONFIG_POSIX),y)
>   common-obj-$(CONFIG_USB_STORAGE_MTP)  +=3D dev-mtp.o
>=20


