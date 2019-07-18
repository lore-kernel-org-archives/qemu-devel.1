Return-Path: <SRS0=9jkQ=VP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CFD3C76186
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 02:24:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3679B20659
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 02:24:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZbEAEd9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3679B20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnw5q-0002uY-FG
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 22:24:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45587)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <npiggin@gmail.com>) id 1hnw5f-0002Oi-3F
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 22:24:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <npiggin@gmail.com>) id 1hnw5e-0003ae-4H
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 22:24:15 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:44025)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <npiggin@gmail.com>)
 id 1hnw5d-0003Zy-Se; Wed, 17 Jul 2019 22:24:14 -0400
Received: by mail-pl1-x644.google.com with SMTP id 4so6043270pld.10;
 Wed, 17 Jul 2019 19:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :user-agent:message-id:content-transfer-encoding;
 bh=bIvLasevc7hsK0P8G7iuj8R/u6TWMR3LCLCh3qs3YWo=;
 b=fZbEAEd9jXcySzmxIGKr86E334noJNZ6lI7xW+RgOzF+0M1rvaHOaJLLu914O3nlxs
 8dWFx7GpYo8lCvfH3C9cBTIHKVqohqc0Jtldb8Hg9UiG2G4YMPLcmtasjj+3Ed6Kihdq
 p5gb73NoWKErODYyh+PkX9k+x//FW3DxQwngatx4p9h/+sVfezFhHAzJE8+1FBnz/+63
 9dB2MMQQEe7vmNBNkYP+oCV2M0D59oSuaG/dB3yAZ+lv8SCI/IcWm9vNs4TaNusutF72
 hfby1A40HSVbF7Z41bg6W0t/7hXT39TFD0H3NCbvyLgB+G6BXz9ni8OBRZ0jhu1VmtlI
 QATw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:user-agent:message-id:content-transfer-encoding;
 bh=bIvLasevc7hsK0P8G7iuj8R/u6TWMR3LCLCh3qs3YWo=;
 b=tuYpw3AGE0kdAeHwo9DD0tI9d4bKMihwIv94WjPJ97BsmnU9T/Y97Ui1KkB5jP/G3F
 s0jBSfbN00sIJ991V3NNrqdAiInpdBdLvcW0rhK7V1UCxbd5VpyhEWBCZCNsquPZmLnk
 mC29ixGX8nZhCs3atilgu21t84b6dr0A1yjAePzlTEfIAxsmn6DmNDhsPLWJNzOjHbaf
 3yRF1CwCCG6BFFstAx9Xw5BvA5ZHO24aJUnN54+m8U2D7A604VfhG8+cCUJMZxmuWV06
 n/WDPU1RWGxwOy9i403F8DtQqRgoJQhhwh3hBF99KyVCg1Y9zkwymtHptXpiNje0JuR7
 pxZg==
X-Gm-Message-State: APjAAAWYb4NGi7uRVXhmayG0nLJKs2s0WuJWGzfg/f3bTb1n2BIYguR9
 rgVhv70PU6NcXDrOvF2d0ZM=
X-Google-Smtp-Source: APXvYqwx8f4J/FS7PEAKOhFRvSRIBQj/w168H+OsdutwiUsUcTDBxwjPHug26+k7yvayIto1Lkbp6Q==
X-Received: by 2002:a17:902:f204:: with SMTP id
 gn4mr47615059plb.3.1563416653111; 
 Wed, 17 Jul 2019 19:24:13 -0700 (PDT)
Received: from localhost ([203.220.8.141])
 by smtp.gmail.com with ESMTPSA id u6sm22089922pjx.23.2019.07.17.19.24.11
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 17 Jul 2019 19:24:12 -0700 (PDT)
Date: Thu, 18 Jul 2019 12:24:05 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: =?iso-8859-1?q?C=E9dric?= Le Goater <clg@kaod.org>, David Gibson
 <david@gibson.dropbear.id.au>
References: <20190717053952.13729-1-npiggin@gmail.com>
 <20190717053952.13729-3-npiggin@gmail.com>
 <87ead8b1-45a6-28ff-2ba6-d1afc5326ec0@kaod.org>
In-Reply-To: <87ead8b1-45a6-28ff-2ba6-d1afc5326ec0@kaod.org>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1563416548.4hlzxhm7x8.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: Re: [Qemu-devel] [PATCH v5 2/4] spapr: Implement H_PROD
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
Cc: qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

C=C3=A9dric Le Goater's on July 17, 2019 11:33 pm:
> On 17/07/2019 07:39, Nicholas Piggin wrote:
>> H_PROD is added, and H_CEDE is modified to test the prod bit
>> according to PAPR.
>>=20
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> ---
>>  hw/ppc/spapr_hcall.c | 29 +++++++++++++++++++++++++++++
>>  1 file changed, 29 insertions(+)
>>=20
>> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
>> index e615881ac4..8b208ab259 100644
>> --- a/hw/ppc/spapr_hcall.c
>> +++ b/hw/ppc/spapr_hcall.c
>> @@ -1050,14 +1050,41 @@ static target_ulong h_cede(PowerPCCPU *cpu, Spap=
rMachineState *spapr,
>>  {
>>      CPUPPCState *env =3D &cpu->env;
>>      CPUState *cs =3D CPU(cpu);
>> +    SpaprCpuState *spapr_cpu =3D spapr_cpu_state(cpu);
>> =20
>>      env->msr |=3D (1ULL << MSR_EE);
>>      hreg_compute_hflags(env);
>> +
>> +    if (spapr_cpu->prod) {
>> +        spapr_cpu->prod =3D false;
>> +        return H_SUCCESS;
>> +    }
>> +
>>      if (!cpu_has_work(cs)) {
>>          cs->halted =3D 1;
>>          cs->exception_index =3D EXCP_HLT;
>=20
> Shouldn't that be EXCP_HALTED instead ?=20

Possibly, I'm not sure. I don't know if it even makes a difference in
ppc code?

Thanks,
Nick
=

