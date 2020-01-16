Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 921D9C33CB1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 16:35:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D9DA206D9
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 16:35:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y5Qx/jp+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D9DA206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is87f-0003VF-Fn
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 11:35:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42055)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1is86m-0002YV-Nz
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 11:35:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1is86i-0001aD-T6
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 11:35:00 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:30236
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1is86i-0001Zr-NY
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 11:34:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579192496;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hZgJkPKPnQfsgR2jpIcAyRtRiv0A9p+EqHtin/LwfVU=;
 b=Y5Qx/jp+da53DW0xzhnWTYWGb3o2ncLgi4H58SmEL52ZO+u7b1EV3tFlxxpyCA5kHlbQD4
 ZtVDVARSFEvMvN0PKl2DtragYaFslvtKXOnD4IPPKs0ELjHt3hO2kq4St1RMUON75W9PL5
 bPPsgOPoXTp2V/QpANmhpUgO/WuM/to=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-hzLhUdLGMXOTGJOrWHRInw-1; Thu, 16 Jan 2020 11:34:54 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F19318010C2;
 Thu, 16 Jan 2020 16:34:52 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 291EA60C85;
 Thu, 16 Jan 2020 16:34:49 +0000 (UTC)
Date: Thu, 16 Jan 2020 17:34:48 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [PATCH v2 41/86] hw/hppa/machine: Correctly check the firmware
 is in PDC range
Message-ID: <20200116173448.082d6eb6@redhat.com>
In-Reply-To: <0fb31eb7-9b65-4ec2-b200-b8ac9216edeb@redhat.com>
References: <1579100861-73692-1-git-send-email-imammedo@redhat.com>
 <1579100861-73692-42-git-send-email-imammedo@redhat.com>
 <alpine.BSF.2.21.99999.352.2001151914440.24151@zero.eik.bme.hu>
 <caded923-2daa-9ec2-8129-fb76a744042f@redhat.com>
 <alpine.BSF.2.21.99999.352.2001152238430.24151@zero.eik.bme.hu>
 <0fb31eb7-9b65-4ec2-b200-b8ac9216edeb@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: hzLhUdLGMXOTGJOrWHRInw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 16 Jan 2020 16:14:45 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> On 1/15/20 10:59 PM, BALATON Zoltan wrote:
> > On Wed, 15 Jan 2020, Philippe Mathieu-Daud=C3=A9 wrote: =20
> >> On 1/15/20 7:15 PM, BALATON Zoltan wrote: =20
> >>> On Wed, 15 Jan 2020, Igor Mammedov wrote: =20
> >>>> From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> >>>>
> >>>> The firmware has to reside in the PDC range. If the Elf file
> >>>> expects to load it below FIRMWARE_START, it is incorrect,
> >>>> regardless the RAM size.
> >>>>
> >>>> Acked-by: Helge Deller <deller@gmx.de>
> >>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> >>>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> >>>> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> >>>> ---
> >>>> hw/hppa/machine.c | 2 +-
> >>>> 1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
> >>>> index 5d0de26..6775d87 100644
> >>>> --- a/hw/hppa/machine.c
> >>>> +++ b/hw/hppa/machine.c
> >>>> @@ -155,7 +155,7 @@ static void machine_hppa_init(MachineState=20
> >>>> *machine)
> >>>> =C2=A0=C2=A0=C2=A0 qemu_log_mask(CPU_LOG_PAGE, "Firmware loaded at 0=
x%08" PRIx64
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "-0x%08" PRIx64 ", entry at 0x%08" PRI=
x64 ".\n",
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 firmware_low, firmware_high, firmware_=
entry);
> >>>> -=C2=A0=C2=A0=C2=A0 if (firmware_low < ram_size || firmware_high >=
=3D FIRMWARE_END) {
> >>>> +=C2=A0=C2=A0=C2=A0 if (firmware_low < FIRMWARE_START || firmware_hi=
gh >=3D=20
> >>>> FIRMWARE_END) {
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_report("Firmware ov=
erlaps with memory or IO space");
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exit(1); =20
> >>>
> >>> Should this also be EXIT_FAILURE like in other places when you're=20
> >>> changing the line nearby? =20
> >>
> >> I didn't changed this line, this seems unrelated to the patch purpose.=
 =20
> >=20
> > Fair enough. Just thought because there was patch 85/86 making that=20
> > change to keep consistency. Maybe you can change this in that patch but=
=20
> > I don't really mind just spotted it. =20
>=20
> Ah this is because it is a patch of mine included in Igor series, and=20
> Igor uses EXIT_FAILURE in his other patches, OK now it makes sense.
>=20
> Maybe the EXIT_FAILURE can be done in a new series, calling 'sed' to=20
> update the full repository.

I'll fix it up on respin

>=20


