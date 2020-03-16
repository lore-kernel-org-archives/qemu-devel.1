Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05FFBC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 23:27:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1F7820663
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 23:27:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="leaLbxOW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1F7820663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDz8x-0005XT-Re
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 19:27:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44645)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <npiggin@gmail.com>) id 1jDz8I-0004yr-Fh
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 19:26:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <npiggin@gmail.com>) id 1jDz8H-00040z-GJ
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 19:26:54 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:40576)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <npiggin@gmail.com>)
 id 1jDz8H-0003ra-7G; Mon, 16 Mar 2020 19:26:53 -0400
Received: by mail-pl1-x641.google.com with SMTP id h11so8713409plk.7;
 Mon, 16 Mar 2020 16:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :user-agent:message-id:content-transfer-encoding;
 bh=Zpqt1uOoyfjztKwxbH4+Uziqugg12byaUeSwYxCC3jY=;
 b=leaLbxOWCVHH7Z0yEVPBml8HY2TzCz+m2N/G66vrPTc7TVon9JbrVariRvoS+K54Fe
 6B160751kP9UxQtm05AwjvPh4WwQc3WTDONx+cIiBd0e4ckZC6jpz4x7eXnJ4CvE20Ck
 OKeic84wmcclRDMjPiei5czLKjVLZUp3VmlYbtZiZBpc+ejBws+XIMkD7XXggXZ0/v6q
 Scl/S6u/vSChPFoDEn1WK6p1fbMpPjwNR8i8CcHpxa3SHw0I69+2nlxGk/NdMMYLJu+f
 xkRiOmjaQ4CWHnsBpq2Yq/+HRt7/9ZtxBuq2Vas6BR/+lagRbP29kyVmRfegYczs05sy
 RDqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:user-agent:message-id:content-transfer-encoding;
 bh=Zpqt1uOoyfjztKwxbH4+Uziqugg12byaUeSwYxCC3jY=;
 b=uMd2E5V9lJMRHssrqXncO0NYb/nUkcoXgYHnXpHoATFMUBTtPdglymB5OqB2KMScc9
 zN/5FzsOHEzdyHA+xmQrUHFGFKU+IMns4xWwCeDpcyAmiTfFSEcPNHad/RNXaytpZ3Qj
 VqZv+4DNBMTg32yUh8biBd+Owl8teuFPcgk9/xtu7FAGt3gl8J8qtcy2+ZPY5FLLmkG4
 3rrAGNK0DNcQplM8zJMqfNHSPEh1/aEeMUujQ10BsfTOmXl9kgOw1Vw1InU8KdLgV84+
 eLcSqJ2MolpwzhCeMuPH9Zb+Zo8+DlCe4KR0QObz1F47xP2A13yYEzvhA56SCXL3XZza
 Lf1Q==
X-Gm-Message-State: ANhLgQ25AXGZHDGsgpLBiG7N55LKSyFessz1BaDoJwJtqpByrdJk29R6
 4lWgogHpLI1ar0pkaUwGPOc=
X-Google-Smtp-Source: ADFU+vuwUlAb5wUzdBnB6/1krPgcm3TpT9g72iEpspZmLQ7HiLPkIxEUsXq3Feq2EJHGaXozjsH6jA==
X-Received: by 2002:a17:902:ff0b:: with SMTP id
 f11mr1170132plj.266.1584401212168; 
 Mon, 16 Mar 2020 16:26:52 -0700 (PDT)
Received: from localhost (203-213-47-190.tpgi.com.au. [203.213.47.190])
 by smtp.gmail.com with ESMTPSA id w128sm528006pgb.55.2020.03.16.16.26.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 16:26:51 -0700 (PDT)
Date: Tue, 17 Mar 2020 09:26:15 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 5/8] ppc/spapr: Allow FWNMI on TCG
To: Greg Kurz <groug@kaod.org>
References: <20200316142613.121089-1-npiggin@gmail.com>
 <20200316142613.121089-6-npiggin@gmail.com>
 <20200316190103.00bd1628@bahia.lan>
In-Reply-To: <20200316190103.00bd1628@bahia.lan>
MIME-Version: 1.0
User-Agent: astroid/0.15.0 (https://github.com/astroidmail/astroid)
Message-Id: <1584400812.98siy81ysk.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
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
Cc: Aravinda Prasad <arawinda.p@gmail.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, Ganesh Goudar <ganeshgr@linux.ibm.com>,
 =?iso-8859-1?q?David=0A?= Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Greg Kurz's on March 17, 2020 4:01 am:
> On Tue, 17 Mar 2020 00:26:10 +1000
> Nicholas Piggin <npiggin@gmail.com> wrote:
>=20
>> There should no longer be a reason to prevent TCG providing FWNMI.
>> System Reset interrupts are generated to the guest with nmi monitor
>> command and H_SIGNAL_SYS_RESET. Machine Checks can not be injected
>> currently, but this could be implemented with the mce monitor cmd
>> similarly to i386.
>>=20
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> ---
>>  hw/ppc/spapr_caps.c | 5 +----
>>  1 file changed, 1 insertion(+), 4 deletions(-)
>>=20
>> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
>> index f626d769a0..679ae7959f 100644
>> --- a/hw/ppc/spapr_caps.c
>> +++ b/hw/ppc/spapr_caps.c
>> @@ -516,10 +516,7 @@ static void cap_fwnmi_apply(SpaprMachineState *spap=
r, uint8_t val,
>>          return; /* Disabled by default */
>>      }
>> =20
>> -    if (tcg_enabled()) {
>> -        warn_report("Firmware Assisted Non-Maskable Interrupts(FWNMI) n=
ot "
>> -                    "supported in TCG");
>=20
> With this warning removed, we can now drop the "cap-fwnmi=3Doff" setting
> in qtest, but this can be done as a followup.

Ah right, thanks. Would you send the patch later or should I?

Thanks,
Nick
=

