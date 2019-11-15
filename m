Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B6EBC432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 16:16:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 517A520692
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 16:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SzcFTm2t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 517A520692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVeHK-0001Be-5s
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 11:16:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50012)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iVeEV-0006lp-4n
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 11:14:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iVeEU-0002r4-4G
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 11:14:03 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:47836
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iVeEU-0002ql-1N
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 11:14:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573834441;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=UennmhyG0dP9wCu8SRBKgYsQAkaiuD+Jxt/UZ17dl+o=;
 b=SzcFTm2tBlUpjliZllzYnct+DD32nzJ/FY4o5Bj8hd8/K5ZnhiJvKsl1NY1DzpWv4HW74O
 QE3dCp+3ViGr1OQ26kUmXJQ7vfIiQnua6uHZzt9ps+/Y3nDoP9FxJX/GhsDWtiJkKNlHG6
 sQeTUSv9VyxSEtjy9v+Id+bFP69fK2E=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-JTBAyKC6PIaYULLrFnybUw-1; Fri, 15 Nov 2019 11:13:58 -0500
Received: by mail-wm1-f72.google.com with SMTP id f11so7220449wmc.8
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2019 08:13:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=W3F/w1aELdf0A/0WT5oul3fnoEMBpqpKoCKpHcMispc=;
 b=KddnsHXXjQUhDR86wiOu9mlPAEFC+Xhp2Gua8SoiyVrkcjezR684Yd+4vmKjwbz52R
 V2ghHs6n2crzkZmIIW9iuaaypm/rtZReXBOqHkKJhF1GgBsptZ89zkiB1fiy62jbfmx4
 uHVvMThF9OmvOU8c6qJhLHb5OB6dGFKB8lcIpgUTIgyRvVw05J9RAd/xyCWyMIKWkqS8
 eMUagmeGcRxVThz4pOr1Jh1KtQTL/es/biqKMZeUdx1ix4W+WCiQoBXVTXQxSTKW+mdC
 basdK631MMvUqZul8wTygUgByM48v/tA4dq+dxt8h/ORhliBIRUFzKRmdZZKuj5WMP2Y
 et7A==
X-Gm-Message-State: APjAAAUWoN4PWLyr47/icgiHKP42hgPtnVUZhzb8HfWb8oqXNIhfvnZk
 /Ey9bPq4Mj1nwwAcTPGyIXqOBIVRWe2cbQjUNNooa5I2IwevuGBQfemZic/Lp0JQqgbsyKJ+UzV
 JjmW04htsm/GknWU=
X-Received: by 2002:adf:fc0a:: with SMTP id i10mr16995948wrr.105.1573834437240; 
 Fri, 15 Nov 2019 08:13:57 -0800 (PST)
X-Google-Smtp-Source: APXvYqzh6nsrSFYjug+U57NGuvdt/lSudSQoPtJKoXziK/gU/mEfB866177mwLmblUL9a03CtDFgiw==
X-Received: by 2002:adf:fc0a:: with SMTP id i10mr16995915wrr.105.1573834436939; 
 Fri, 15 Nov 2019 08:13:56 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:a15b:f753:1ac4:56dc?
 ([2001:b07:6468:f312:a15b:f753:1ac4:56dc])
 by smtp.gmail.com with ESMTPSA id d202sm9583655wmd.47.2019.11.15.08.13.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Nov 2019 08:13:56 -0800 (PST)
Subject: Re: [PATCH for-4.2] hw/i386: Fix compiler warning when CONFIG_IDE_ISA
 is disabled
To: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
References: <20191115145049.26868-1-thuth@redhat.com>
 <CAFEAcA-EuQVBtr=BCE5sdHo+LMv8XchHUSPM=CgSYxPVryWKZg@mail.gmail.com>
 <273a3123-9eef-c78e-5b83-833a21e3988c@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <c7c45aed-76c0-9c17-72fb-6abceb9e5ff4@redhat.com>
Date: Fri, 15 Nov 2019 17:13:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <273a3123-9eef-c78e-5b83-833a21e3988c@redhat.com>
Content-Language: en-US
X-MC-Unique: JTBAyKC6PIaYULLrFnybUw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 15/11/19 16:54, Thomas Huth wrote:
> On 15/11/2019 16.54, Peter Maydell wrote:
>> On Fri, 15 Nov 2019 at 15:10, Thomas Huth <thuth@redhat.com> wrote:
>>>
>>> When CONFIG_IDE_ISA is disabled, compilation currently fails:
>>>
>>>  hw/i386/pc_piix.c: In function =E2=80=98pc_init1=E2=80=99:
>>>  hw/i386/pc_piix.c:81:9: error: unused variable =E2=80=98i=E2=80=99 [-W=
error=3Dunused-variable]
>>>
>>> Move the variable declaration to the right code block to avoid
>>> this problem.
>>>
>>> Fixes: 4501d317b50e ("hw/i386/pc: Extract pc_i8259_create()")
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>  hw/i386/pc_piix.c | 3 +--
>>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>>
>>> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
>>> index 2aefa3b8df..d187db761c 100644
>>> --- a/hw/i386/pc_piix.c
>>> +++ b/hw/i386/pc_piix.c
>>> @@ -78,7 +78,6 @@ static void pc_init1(MachineState *machine,
>>>      X86MachineState *x86ms =3D X86_MACHINE(machine);
>>>      MemoryRegion *system_memory =3D get_system_memory();
>>>      MemoryRegion *system_io =3D get_system_io();
>>> -    int i;
>>>      PCIBus *pci_bus;
>>>      ISABus *isa_bus;
>>>      PCII440FXState *i440fx_state;
>>> @@ -253,7 +252,7 @@ static void pc_init1(MachineState *machine,
>>>      }
>>>  #ifdef CONFIG_IDE_ISA
>>>  else {
>>> -        for(i =3D 0; i < MAX_IDE_BUS; i++) {
>>> +        for (int i =3D 0; i < MAX_IDE_BUS; i++) {
>>>              ISADevice *dev;
>>>              char busname[] =3D "ide.0";
>>>              dev =3D isa_ide_init(isa_bus, ide_iobase[i], ide_iobase2[i=
],
>>
>> Don't put variable declarations inside 'for' statements,
>> please. They should go at the start of a {} block.
>=20
> Why? We're using -std=3Dgnu99 now, so this should not be an issue anymore=
.

For now I can squash the following while we discuss coding standards. :)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index fa62244f4d..0130b8fb4e 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -244,7 +244,8 @@ static void pc_init1(MachineState *machine,
     }
 #ifdef CONFIG_IDE_ISA
 else {
-        for (int i =3D 0; i < MAX_IDE_BUS; i++) {
+        int i;
+        for (i =3D 0; i < MAX_IDE_BUS; i++) {
             ISADevice *dev;
             char busname[] =3D "ide.0";
             dev =3D isa_ide_init(isa_bus, ide_iobase[i], ide_iobase2[i],



Paolo


