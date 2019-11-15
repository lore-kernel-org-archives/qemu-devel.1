Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C8BEC432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 16:26:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EB7A20730
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 16:26:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R/0608e6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EB7A20730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVeQC-0008Uz-L5
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 11:26:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51732)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iVeOn-0006x1-Ox
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 11:24:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iVeOl-0000Pm-IE
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 11:24:40 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52799
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iVeOl-0000PR-EJ
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 11:24:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573835078;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rVekyxgN4bMiTsZH/4w84/56lmlCAIprnqv5e2wLqAE=;
 b=R/0608e62GBknF6UB9wipVhJcoVhcnO+XWRr8yDNBcikv2G+N9spLMVqW+0/ttAghcXcGW
 MQz4We0zRJK9G43Ivo96Ha7irWd67aVqMKmniUBamc35F/hfQ4aaJWx5yCEF2L3SX6LPrd
 Q54MLvAYcZV2+YIN4F6kDx1hnaAjuSM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-6SrWiY4qPBmPr32446gpQA-1; Fri, 15 Nov 2019 11:24:37 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 18D291858F1D;
 Fri, 15 Nov 2019 16:24:36 +0000 (UTC)
Received: from localhost.localdomain (ovpn-117-84.ams2.redhat.com
 [10.36.117.84])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2BC671036C81;
 Fri, 15 Nov 2019 16:24:29 +0000 (UTC)
Subject: Re: [PATCH for-4.2] hw/i386: Fix compiler warning when CONFIG_IDE_ISA
 is disabled
To: Peter Maydell <peter.maydell@linaro.org>
References: <20191115145049.26868-1-thuth@redhat.com>
 <CAFEAcA-EuQVBtr=BCE5sdHo+LMv8XchHUSPM=CgSYxPVryWKZg@mail.gmail.com>
 <273a3123-9eef-c78e-5b83-833a21e3988c@redhat.com>
 <CAFEAcA9N+T=M=5-xb3ahRMqD6oxhm5Lx55-1Mtk1vXsRJEomwA@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <85b5fbcc-e06b-7ce2-0a97-7fdc156915cd@redhat.com>
Date: Fri, 15 Nov 2019 17:12:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9N+T=M=5-xb3ahRMqD6oxhm5Lx55-1Mtk1vXsRJEomwA@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: 6SrWiY4qPBmPr32446gpQA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
 QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 15/11/2019 17.15, Peter Maydell wrote:
> On Fri, 15 Nov 2019 at 16:08, Thomas Huth <thuth@redhat.com> wrote:
>>
>> On 15/11/2019 16.54, Peter Maydell wrote:
>>> On Fri, 15 Nov 2019 at 15:10, Thomas Huth <thuth@redhat.com> wrote:
>>>> --- a/hw/i386/pc_piix.c
>>>> +++ b/hw/i386/pc_piix.c
>>>> @@ -78,7 +78,6 @@ static void pc_init1(MachineState *machine,
>>>>      X86MachineState *x86ms =3D X86_MACHINE(machine);
>>>>      MemoryRegion *system_memory =3D get_system_memory();
>>>>      MemoryRegion *system_io =3D get_system_io();
>>>> -    int i;
>>>>      PCIBus *pci_bus;
>>>>      ISABus *isa_bus;
>>>>      PCII440FXState *i440fx_state;
>>>> @@ -253,7 +252,7 @@ static void pc_init1(MachineState *machine,
>>>>      }
>>>>  #ifdef CONFIG_IDE_ISA
>>>>  else {
>>>> -        for(i =3D 0; i < MAX_IDE_BUS; i++) {
>>>> +        for (int i =3D 0; i < MAX_IDE_BUS; i++) {
>>>>              ISADevice *dev;
>>>>              char busname[] =3D "ide.0";
>>>>              dev =3D isa_ide_init(isa_bus, ide_iobase[i], ide_iobase2[=
i],
>>>
>>> Don't put variable declarations inside 'for' statements,
>>> please. They should go at the start of a {} block.
>>
>> Why? We're using -std=3Dgnu99 now, so this should not be an issue anymor=
e.
>=20
> Consistency with the rest of the code base, which mostly
> avoids this particular trick.

We've also got a few spots that use it...
(run e.g.: grep -r 'for (int ' hw/* )

> See the 'Declarations' section of CODING_STYLE.rst.

OK, that's a point. But since this gnu99 is a rather new option that we
just introduced less than a year ago, we should maybe think of whether
we want to allow this for for-loops now, too (since IMHO it's quite a
nice feature in gnu99).

 Thomas


