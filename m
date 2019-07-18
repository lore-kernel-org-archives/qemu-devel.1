Return-Path: <SRS0=9jkQ=VP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 526E5C7618F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 02:19:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F9002173B
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 02:19:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lrnV6Kx3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F9002173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnw1M-0000d5-B2
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 22:19:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44274)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <npiggin@gmail.com>) id 1hnw1A-00007d-MC
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 22:19:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <npiggin@gmail.com>) id 1hnw19-0000zY-L2
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 22:19:36 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:35254)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <npiggin@gmail.com>)
 id 1hnw19-0000z5-Em; Wed, 17 Jul 2019 22:19:35 -0400
Received: by mail-pl1-x644.google.com with SMTP id w24so13009070plp.2;
 Wed, 17 Jul 2019 19:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :user-agent:message-id:content-transfer-encoding;
 bh=xNyLpvy92Ua4cSSxAt1g9knlBHlC/mCShea5vsDEbUc=;
 b=lrnV6Kx3p0JDIULI6kfSqN/u9IBCoVIYeYPWr+DhLEdDlbHgfNT6wdnX15UlccorWd
 nvWz5V3ooZ+V8y5gSk+7KniDJbNCsO0y4W9eEVrpYOkNusW6GIP1Q+2NrybT0SJR2PYt
 NybLZaNn+3MMmypjIRhv6HYDFAzkVtsWxayRJhK4KYaL/CznutdijDPDrZ1cb9HjIUlt
 lT86W99zBhIdq8nY9RPeDPFl6Tp2YfrDShUL2t9ciN2GNT3qpSUapwxBWNJeuWfz30KY
 pj+ozyfI5LQL7ZCnyfzlLht6TTBSAiUlqq8ha8g33Xe3t56l5MrrKY7KnVFOfLDO0woy
 Dy2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:user-agent:message-id:content-transfer-encoding;
 bh=xNyLpvy92Ua4cSSxAt1g9knlBHlC/mCShea5vsDEbUc=;
 b=MsNrrwWaNffupHKKQxv+PwDXmIp33WgBAZJr7DnGTaAsZb+lM/KLTUTySSH3R9K9ye
 uYPfD6GHntb3od+eXyIYZTz0hgYK3qoDB2apVfPy35QR5FzRG+SI9WvFbtshbgNJFmyQ
 4yV1SE0jeqGtbpTnFSaiCMLP8/GWjFi91j/cc+txVAApUtAcZpGdG2CB07PvZ27opvLr
 o7aTDrUn014+8hLkFTHNxb9R9q302EcVqL4jPTI4RWSdfcny+BPzWElu2dYnPykU0k3w
 dl69+96yPfJDg4/j+OajKnG3s9kejX50nqUuwpkEI4JMn1QgC33AEnR56QFjBoMqNmF4
 3acA==
X-Gm-Message-State: APjAAAUyIK9cUO5oQM58veUqk4BCVccqjdiY+FvTm35YUC2lYZGwqE+b
 3GW+qBmeQkvaDvYeqvb+hOE=
X-Google-Smtp-Source: APXvYqx9x8PhBe2NmrbNAIYu+gUrabhePZjeBR4/4NMFozhXTlRZ8V7WRsOPz+sySuYXFi0v7PQlzQ==
X-Received: by 2002:a17:902:7c90:: with SMTP id
 y16mr47828478pll.238.1563416374605; 
 Wed, 17 Jul 2019 19:19:34 -0700 (PDT)
Received: from localhost ([203.220.8.141])
 by smtp.gmail.com with ESMTPSA id x22sm30182640pff.5.2019.07.17.19.19.33
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 17 Jul 2019 19:19:33 -0700 (PDT)
Date: Thu, 18 Jul 2019 12:19:27 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Greg Kurz <groug@kaod.org>
References: <20190717053952.13729-1-npiggin@gmail.com>
 <20190717053952.13729-4-npiggin@gmail.com>
 <20190717190058.269862ea@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <20190717190058.269862ea@bahia.lab.toulouse-stg.fr.ibm.com>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1563416320.h0scj0883z.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: Re: [Qemu-devel] [PATCH v5 3/4] spapr: Implement H_CONFER
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
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 =?iso-8859-1?q?C=E9dric?= Le Goater <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Greg Kurz's on July 18, 2019 3:00 am:
> On Wed, 17 Jul 2019 15:39:51 +1000
> Nicholas Piggin <npiggin@gmail.com> wrote:
>=20
>> This does not do directed yielding and is not quite as strict as PAPR
>> specifies in terms of precise dispatch behaviour. This generally will
>> mean suboptimal performance, rather than guest misbehaviour. Linux
>> does not rely on exact dispatch behaviour.
>>=20
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> ---
>=20
> LGTM.
>=20
> Reviewed-by: Greg Kurz <groug@kaod.org>
>=20
> Just two minor comments, see below.
>=20
>> Changes since v4:
>> - Style, added justification comments, spelling.
>> - Fixed trying to dereference spapr_cpu for a -1 target.
>>=20
>>  hw/ppc/spapr_hcall.c | 68 ++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 68 insertions(+)
>>=20
>> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
>> index 8b208ab259..5e655172b2 100644
>> --- a/hw/ppc/spapr_hcall.c
>> +++ b/hw/ppc/spapr_hcall.c
>> @@ -1069,6 +1069,73 @@ static target_ulong h_cede(PowerPCCPU *cpu, Spapr=
MachineState *spapr,
>>      return H_SUCCESS;
>>  }
>> =20
>> +static target_ulong h_confer(PowerPCCPU *cpu, SpaprMachineState *spapr,
>> +                           target_ulong opcode, target_ulong *args)
>> +{
>> +    target_long target =3D args[0];
>> +    uint32_t dispatch =3D args[1];
>> +    CPUState *cs =3D CPU(cpu);
>> +    SpaprCpuState *spapr_cpu;
>> +
>> +    /*
>> +     * -1 means confer to all other CPUs without dispatch counter check=
,
>> +     *  otherwise it's a targeted confer.
>> +     */
>> +    if (target !=3D -1) {
>> +        PowerPCCPU *target_cpu =3D spapr_find_cpu(target);
>> +        CPUState *target_cs =3D CPU(target_cpu);
>> +        unsigned int target_dispatch;
>=20
> Maybe make it uint32_t to be consistent with dispatch above, and this
> is the actual return type of ldl_be_phys() ?

Sure okay.

>> +
>> +        if (!target_cs) {
>=20
> This is the only user of target_cs, maybe drop it and use target_cpu
> instead ?

That probably works, I'll try.

Thanks,
Nick
=

