Return-Path: <SRS0=g5aJ=2O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A793AC2D0C0
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2019 00:10:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F4D3206D3
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2019 00:10:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CZHLnNhC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F4D3206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ijXmE-0005bo-IH
	for qemu-devel@archiver.kernel.org; Mon, 23 Dec 2019 19:10:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37007)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ijXlN-0005AZ-3O
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 19:09:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ijXlK-00021e-9p
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 19:09:23 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44112
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ijXlJ-0001zi-Uu
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 19:09:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577146161;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z5Qvz0kjU83nkXZ8Uw4YHn+pcoUe6gYr2aYl45TIask=;
 b=CZHLnNhCjMcDUTFtyWqQ5CvsKczXXQ+gsBe3xvJbGYJ7zTnAmnMesq0VHwiunPfYEO1aj+
 vUSzTw19yp+gW3l/BedXz7DQrP7L5UBgSRaqvLmyFG4SoRkRboL8CXDYXZeR27PjzIdwDw
 dR2FXHaWLDa45d9f5jt+YU34aatQ664=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-111-8ydVKJanMFeMgI5cooqDyA-1; Mon, 23 Dec 2019 19:09:19 -0500
Received: by mail-wm1-f69.google.com with SMTP id o24so114524wmh.0
 for <qemu-devel@nongnu.org>; Mon, 23 Dec 2019 16:09:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1ina/tpP30gacQU4n8XO9E7QzuViRunDHfWEakJYCHE=;
 b=eUWaEVyCew+sIAwCn9gqIE6VMY68/+WVQYlLnYaOMFbH9Mp25f5tWlD/MoSWY0o/4w
 JGlhGJoEt+2D4oOLAS6/j7jJceT6SfN5h8yQHtOjNpS/Q7Q8yePtvzQWRG7jAOf9jesG
 ZVN6yh59xxVsx3PK8KG0nJaR3iQwpVoKCSXo9ApJLGzagKWIjq8jzbN1zqF0jbBCYFMI
 8n+BU9+zjPTfLdp2+TMR3pxiExbk9judkqPOAKFD60UWQXe0m25VVnyc6XqTygW5F/be
 alBx0XFZs+qKYNwjFVDmb6Op3KuIcpltvdRbDSvbLVFzNJzchyLwN1+Cxid3HBO2PKu6
 MMgA==
X-Gm-Message-State: APjAAAX9hm6KaFrHL0ZqBNg1NmDbN2knY16frRBJD6fVTNzWsCUstR9I
 Uzn6F1L8FeVWGamMTpxCV9yJpfOq4an8lJ/H0lK/jY0YlbSLe/r7mDw0raHEoT9SPzvQJmmk8pg
 P2+ckELd4LAqBxLs=
X-Received: by 2002:a1c:28d4:: with SMTP id o203mr1073469wmo.123.1577146158251; 
 Mon, 23 Dec 2019 16:09:18 -0800 (PST)
X-Google-Smtp-Source: APXvYqx0yH/YndAAciQ24CPsyWR/LzYkaleo6GVIizN2K5urmqRUAcTNbWYuQtL02ZESorPyd/980A==
X-Received: by 2002:a1c:28d4:: with SMTP id o203mr1073444wmo.123.1577146158000; 
 Mon, 23 Dec 2019 16:09:18 -0800 (PST)
Received: from ?IPv6:2a01:cb1d:8a0a:f500:48c1:8eab:256a:caf9?
 ([2a01:cb1d:8a0a:f500:48c1:8eab:256a:caf9])
 by smtp.gmail.com with ESMTPSA id e8sm21972918wrt.7.2019.12.23.16.09.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Dec 2019 16:09:17 -0800 (PST)
Subject: Re: [PATCH v9 14/15] hw/i386: Introduce the microvm machine type
To: Paolo Bonzini <pbonzini@redhat.com>, Sergio Lopez <slp@redhat.com>,
 qemu-devel@nongnu.org
References: <20191015112346.45554-1-slp@redhat.com>
 <20191015112346.45554-15-slp@redhat.com>
 <6276a8e7-2928-6e33-64a1-3ae01a30a718@redhat.com>
 <a5863b05-4021-df51-d84f-1bb070fa6137@redhat.com>
 <8eec451f-3ee3-b111-2c03-3c29ade661a6@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <21e2508a-764f-1db9-9c53-dc9eb43d7f68@redhat.com>
Date: Tue, 24 Dec 2019 01:09:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <8eec451f-3ee3-b111-2c03-3c29ade661a6@redhat.com>
Content-Language: en-US
X-MC-Unique: 8ydVKJanMFeMgI5cooqDyA-1
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
Cc: ehabkost@redhat.com, mst@redhat.com, kraxel@redhat.com, imammedo@redhat.com,
 rth@twiddle.net, lersek@redhat.com, sgarzare@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Paolo,

On 10/16/19 11:29 AM, Paolo Bonzini wrote:
> On 16/10/19 11:26, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 10/16/19 9:46 AM, Paolo Bonzini wrote:
>>>
>>>> diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
>>>> index c5c9d4900e..d399dcba52 100644
>>>> --- a/hw/i386/Kconfig
>>>> +++ b/hw/i386/Kconfig
>>>> @@ -92,6 +92,10 @@ config Q35
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select SMBIOS
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select FW_CFG_DMA
>>>>  =C2=A0 +config MICROVM
>>>> +=C2=A0=C2=A0=C2=A0 bool
>>>
>>> Missing:
>>>
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 select ISA_BUS
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 select APIC
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 select IOAPIC
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 select I8259
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 select MC146818RTC
>>
>> maybe 'select SERIAL_ISA' too?
>=20
> Right, but only 'imply'.

Per the documentation, you are correct:

   Boards specify their constituent devices using ``imply`` and ``select``
   directives.  A device should be listed under ``select`` if the board
   cannot be started at all without it.  It should be listed under
   ``imply`` if (depending on the QEMU command line) the board may or
   may not be started without it.  Boards also default to false; they are
   enabled by the ``default-configs/*.mak`` for the target they apply to.

But then the build fails configured with --without-default-devices:

   LINK    x86_64-softmmu/qemu-system-x86_64
/usr/bin/ld: hw/i386/microvm.o: in function `microvm_devices_init':
hw/i386/microvm.c:157: undefined reference to `serial_hds_isa_init'
collect2: error: ld returned 1 exit status
make[1]: *** [Makefile:206: qemu-system-x86_64] Error 1
make: *** [Makefile:483: x86_64-softmmu/all] Error 2

We have:

static void microvm_devices_init(MicrovmMachineState *mms)
{
     ...
     if (mms->isa_serial) {
         serial_hds_isa_init(isa_bus, 0, 1);
     }
     ...
}

With this diff the link succeed:

-- >8 --
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -95,7 +95,7 @@ config Q35

  config MICROVM
      bool
-    imply SERIAL_ISA
+    select SERIAL_ISA
      select ISA_BUS
      select APIC
      select IOAPIC
---

I was going to send this as a patch but suddently remembered this=20
thread. I'm not sure what you want so I prefer ask first :)

We have CONFIG_SERIAL_ISA declared in "config-devices.h" so we could=20
also use:

-- >8 --
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -153,9 +153,11 @@ static void=20
microvm_devices_init(MicrovmMachineState *mms)
          microvm_set_rtc(mms, rtc_state);
      }

+#ifdef CONFIG_SERIAL_ISA
      if (mms->isa_serial) {
          serial_hds_isa_init(isa_bus, 0, 1);
      }
+#endif

      if (bios_name =3D=3D NULL) {
          bios_name =3D MICROVM_BIOS_FILENAME;
---

The binary links too, and the difference with the other hunk is now the=20
device is not listed in 'qemu-system-x86_64 -M microvm -device help'.
However I guess understand we prefer to avoid that kind of ifdef'ry.

Which way to you prefer?

Thanks,

Phil.


