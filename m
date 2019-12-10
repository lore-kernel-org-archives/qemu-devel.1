Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC78C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 13:28:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 386202077B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 13:28:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aB+LNhaH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 386202077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iefYe-0001RD-EW
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 08:28:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37310)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iefXp-00010A-3J
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 08:27:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iefXn-00086P-T4
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 08:27:17 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:57497
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iefXn-00086J-PY
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 08:27:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575984435;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K6emwh2NMZ0d5ni8jNgsl/ce6sw3MjpgimcZ8a/R2l8=;
 b=aB+LNhaHHiE0NDzIVNb+y4aPSndlO3yTUHXI256HoiDvuUIlsctK16FHoysrE+JazqzAw8
 fmC0VRgpZUtMXBNZSYuu30qw+RCfyVjdYkF6XqE/ykNcKx7ZRzYPLBz2KBcEf15UbVcMyV
 n2ORRN5d6C9Rq1R8P0VqduL6EPRMBKM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-87-FqCfnxdqPoyMUNDiGbY62w-1; Tue, 10 Dec 2019 08:27:13 -0500
Received: by mail-wm1-f69.google.com with SMTP id y125so860270wmg.1
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2019 05:27:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vgrRtxFkSVGRlN8p5mi6a9us8ylOqeCoto9XpJ/UTdE=;
 b=CWiMIzvFQwcQo+5ggjkLGA8D7GIp8XPzU04Q2Ti+n0Jne1rnl0JlgFAya0qxuvuJTB
 L/Hded9iZrZRNKYtyxGJ79xXj6cw74g6HuFNYN2x7MDldErM6gExQHdX+izE+x4ztWkX
 5/3fPDljAxujKsGl7DijjTREZlLdGNfKRGLBvqna4ZQHz+DK6OVU8MZr4Qqul8vxbGcB
 LuLNGDrsONNtinOiezUGnaNo9DIFD8lh8mzu+sQ8nEePf7CRboVMdCz2YUzRz6a2KxIV
 xlOTECjfcJKquuFoBqIwiXtMyQ9cdW3TfdR8utCFkeUYfVZ/2mAvd4ESs+XV/psI+j5C
 tYWg==
X-Gm-Message-State: APjAAAVST0kmrgTkF+qeqI1g8K1H6wc9ZnNGkuPt5eddoapZEMD/Uyxe
 Y/LBYCKMmsgiqsGKszvptQXNfODp8sHm4xip362+qsSJIHjTCQCdnuOANTUN/TcIn17nQmLEh2a
 6jnoxRO+ITZXijuc=
X-Received: by 2002:a05:6000:cf:: with SMTP id
 q15mr3205335wrx.393.1575984431833; 
 Tue, 10 Dec 2019 05:27:11 -0800 (PST)
X-Google-Smtp-Source: APXvYqwzYnkJ1WFzj60kJ5lorH7fxVlY9m7Yy97L88HTpS0P4sYyHDz0gffsOrTWlfcwQpnXkqpspw==
X-Received: by 2002:a05:6000:cf:: with SMTP id
 q15mr3205304wrx.393.1575984431594; 
 Tue, 10 Dec 2019 05:27:11 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id z4sm3184536wme.17.2019.12.10.05.27.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Dec 2019 05:27:11 -0800 (PST)
Subject: Re: [PATCH] hw/usb: Introduce Kconfig switches for the CCID card
 devices
To: Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-devel@nongnu.org
References: <20191210072048.15603-1-thuth@redhat.com>
 <c402f822-bbbc-7ece-2fb4-1a37484be05e@redhat.com>
 <ab65b73a-0c09-925f-054b-c8ddea8b5476@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <20772e61-a66d-93ad-7728-dcd3b3fdeb31@redhat.com>
Date: Tue, 10 Dec 2019 14:27:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <ab65b73a-0c09-925f-054b-c8ddea8b5476@redhat.com>
Content-Language: en-US
X-MC-Unique: FqCfnxdqPoyMUNDiGbY62w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/10/19 9:11 AM, Thomas Huth wrote:
> On 10/12/2019 08.43, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 12/10/19 8:20 AM, Thomas Huth wrote:
>>> In our downstream distribution of QEMU, we need more fine-grained
>>> control on the set of CCID card devices that we want to include.
>>> So let's introduce some proper Kconfig switches that it is easier
>>> to disable them without modifying the corresponding Makefile.objs.
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>  =C2=A0 hw/usb/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 10 +++++++=
+++
>>>  =C2=A0 hw/usb/Makefile.objs |=C2=A0 7 +++++--
>>>  =C2=A0 2 files changed, 15 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/hw/usb/Kconfig b/hw/usb/Kconfig
>>> index 555e09377b..1358847eba 100644
>>> --- a/hw/usb/Kconfig
>>> +++ b/hw/usb/Kconfig
>>> @@ -96,3 +96,13 @@ config USB_STORAGE_MTP
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default y
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 depends on USB
>>> +
>>> +config CCID_PASSTHRU
>>> +=C2=A0=C2=A0=C2=A0 bool
>>> +=C2=A0=C2=A0=C2=A0 default y
>>> +=C2=A0=C2=A0=C2=A0 depends on USB_SMARTCARD
>>> +
>>> +config CCID_EMULATED
>>> +=C2=A0=C2=A0=C2=A0 bool
>>> +=C2=A0=C2=A0=C2=A0 default y
>>> +=C2=A0=C2=A0=C2=A0 depends on USB_SMARTCARD
>>> diff --git a/hw/usb/Makefile.objs b/hw/usb/Makefile.objs
>>> index 303ac084a0..ebe103fb3d 100644
>>> --- a/hw/usb/Makefile.objs
>>> +++ b/hw/usb/Makefile.objs
>>> @@ -29,11 +29,14 @@ common-obj-$(CONFIG_USB_BLUETOOTH)=C2=A0=C2=A0=C2=
=A0 +=3D
>>> dev-bluetooth.o
>>>  =C2=A0 =C2=A0 ifeq ($(CONFIG_USB_SMARTCARD),y)
>>>  =C2=A0 common-obj-y=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 +=3D dev-smartcard-reader.o
>>> -common-obj-$(CONFIG_SMARTCARD)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 +=3D smartcard.mo
>>> -smartcard.mo-objs :=3D ccid-card-passthru.o ccid-card-emulated.o
>>> +ifeq ($(CONFIG_SMARTCARD),y)
>>
>> We don't need the 'ifeq ($(CONFIG_SMARTCARD),y)' ... endif anymore.
>=20
> I think we do. Both files #include <libcacard.h> thus can only be
> compiled if CONFIG_SMARTCARD has been set.
> Don't mix CONFIG_SMARTCARD up with CONFIG_USB_SMARTCARD - these are two
> different switches!

OK I missed SMARTCARD is not in Kconfig.host.

What about adding that to your patch and remove the ifeq():

-- >8 --
diff --git a/Kconfig.host b/Kconfig.host
index bb6e116e2a..b532358854 100644
--- a/Kconfig.host
+++ b/Kconfig.host
@@ -35,3 +35,6 @@ config VIRTFS

  config PVRDMA
      bool
+
+config SMARTCARD
+    bool
diff --git a/hw/usb/Kconfig b/hw/usb/Kconfig
index 555e09377b..b3292a5cc9 100644
--- a/hw/usb/Kconfig
+++ b/hw/usb/Kconfig
@@ -90,7 +90,7 @@ config USB_BLUETOOTH
  config USB_SMARTCARD
      bool
      default y
-    depends on USB
+    depends on SMARTCARD && USB

  config USB_STORAGE_MTP
      bool
---

>>> +common-obj-$(call
>>> lor,$(CONFIG_CCID_PASSTHRU),$(CONFIG_CCID_EMULATED)) +=3D smartcard.mo
>>> +smartcard.mo-objs :=3D $(call
>>> lif,$(CONFIG_CCID_PASSTHRU),ccid-card-passthru.o) \
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $(call
>>> lif,$(CONFIG_CCID_EMULATED),ccid-card-emulated.o)
>>>  =C2=A0 smartcard.mo-cflags :=3D $(SMARTCARD_CFLAGS)
>>>  =C2=A0 smartcard.mo-libs :=3D $(SMARTCARD_LIBS)
>>>  =C2=A0 endif
>>> +endif
>>>  =C2=A0 =C2=A0 ifeq ($(CONFIG_POSIX),y)
>>>  =C2=A0 common-obj-$(CONFIG_USB_STORAGE_MTP)=C2=A0 +=3D dev-mtp.o
>>>
>>
>=20


