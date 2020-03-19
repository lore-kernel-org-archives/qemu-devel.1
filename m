Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB193C4332D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 02:29:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A86F520768
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 02:29:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qbbAZzOK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A86F520768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEkwS-0003QK-Su
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 22:29:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48983)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <npiggin@gmail.com>) id 1jEkvr-0002uY-Eh
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 22:29:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <npiggin@gmail.com>) id 1jEkvq-0005lm-06
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 22:29:15 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:33597)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <npiggin@gmail.com>)
 id 1jEkvp-0005hK-Qe; Wed, 18 Mar 2020 22:29:13 -0400
Received: by mail-pf1-x443.google.com with SMTP id n7so565299pfn.0;
 Wed, 18 Mar 2020 19:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :user-agent:message-id:content-transfer-encoding;
 bh=69JCyOFRTHiCDcQ0HWPnIX1pUDtFwQ8tQgJ9HDRCQOE=;
 b=qbbAZzOKwukl55ZB6szfmedKABbeJ1Ads450fCkz2LikvmzoaMbt08ageXHqBi0fBf
 +O0PoLJ8dIwWclNjXg+dpTkX1V8TbcA69e0JCtv43CTziTQ7I0EtfSBKltSqJ31IxKXt
 asKr16OVqNF2ME8sgJ3yg0/fhGbx1WQemw4qkjSrEj3wyE/UHqN6LArnBR/z7mFl67DM
 MDSON+r91U4uqsiqpya38aFEmsr0nyRy5pFE7uy/0DoJ5+APWAJmfs/3G2uqyefLQ9Ev
 8vlZk+9APx68t500c1GTdzJtbjFv050xOkBRoxX6jph8GfZ1c7YHGPjz1tpxQvQrOwaX
 cJ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:user-agent:message-id:content-transfer-encoding;
 bh=69JCyOFRTHiCDcQ0HWPnIX1pUDtFwQ8tQgJ9HDRCQOE=;
 b=CqgIX2ODwDZF1Pg7EyMPoRhJzOU88hbf7fJg1ZI3jJtWU8Tq1lfloNd1FTvnMMb6KO
 B2DGMCWuagC4uogwigu2xiqe6PyxMSLht/epUY1M2QwOhlnJvxgNaDcDRCn36B+oqfIY
 E4idka0U3t0z6WsvcYdBOzwoDX5JQTOAtJ13IdBBWY+HKi4o2MYZ3Kf578ZlnEMx7tpS
 rtA8yxe9uC2tEDIQCUOajqqTi9UOazCSnMKQPh9MXSaTsreBnnKqQAS5BofQVtsN31vH
 IK6EC+nP6QF5WS/uY/Ul6AOfPaLp+DHPOEEDD4A93bcwQTcq7uMxxAckFzWhrGcQCWd4
 /mEg==
X-Gm-Message-State: ANhLgQ2rL8LcIc8kO7eqdZD/ZUPgDb3YBEFjfCZvf9IFGvOq0GSfMquV
 jfT9Zr5cktR5R36NPuNfcwQ=
X-Google-Smtp-Source: ADFU+vvOGoTY2wHOeG//jtIL8mn1RX+HKGyXRSCqK7xvEzlgDrecJ8oNaHZqZ3ClglNO6DHDoQgJOw==
X-Received: by 2002:a63:309:: with SMTP id 9mr853688pgd.193.1584584952773;
 Wed, 18 Mar 2020 19:29:12 -0700 (PDT)
Received: from localhost (14-202-190-183.tpgi.com.au. [14.202.190.183])
 by smtp.gmail.com with ESMTPSA id u24sm333799pgo.83.2020.03.18.19.29.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2020 19:29:11 -0700 (PDT)
Date: Thu, 19 Mar 2020 12:27:22 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 1/5] ppc/spapr: KVM FWNMI should not be enabled until
 guest requests it
To: Greg Kurz <groug@kaod.org>
References: <20200317050215.159334-1-npiggin@gmail.com>
 <20200317050215.159334-2-npiggin@gmail.com>
 <20200317120214.58195d0e@bahia.lan>
In-Reply-To: <20200317120214.58195d0e@bahia.lan>
MIME-Version: 1.0
User-Agent: astroid/0.15.0 (https://github.com/astroidmail/astroid)
Message-Id: <1584584746.exy0ui5cdw.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 =?iso-8859-1?q?C=E9dric_Le=0A?= Goater <clg@fr.ibm.com>,
 Ganesh Goudar <ganeshgr@linux.ibm.com>, qemu-ppc@nongnu.org,
 =?iso-8859-1?q?David=0A?= Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Greg Kurz's on March 17, 2020 9:02 pm:
> On Tue, 17 Mar 2020 15:02:11 +1000
> Nicholas Piggin <npiggin@gmail.com> wrote:
>=20
>> The KVM FWNMI capability should be enabled with the "ibm,nmi-register"
>> rtas call. Although MCEs from KVM will be delivered as architected
>> interrupts to the guest before "ibm,nmi-register" is called, KVM has
>> different behaviour depending on whether the guest has enabled FWNMI
>> (it attempts to do more recovery on behalf of a non-FWNMI guest).
>>=20
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> ---
>>  hw/ppc/spapr_caps.c  | 5 +++--
>>  hw/ppc/spapr_rtas.c  | 7 +++++++
>>  target/ppc/kvm.c     | 7 +++++++
>>  target/ppc/kvm_ppc.h | 6 ++++++
>>  4 files changed, 23 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
>> index 679ae7959f..eb5521d0c2 100644
>> --- a/hw/ppc/spapr_caps.c
>> +++ b/hw/ppc/spapr_caps.c
>> @@ -517,9 +517,10 @@ static void cap_fwnmi_apply(SpaprMachineState *spap=
r, uint8_t val,
>>      }
>> =20
>>      if (kvm_enabled()) {
>> -        if (kvmppc_set_fwnmi() < 0) {
>> +        if (!kvmppc_get_fwnmi()) {
>>              error_setg(errp, "Firmware Assisted Non-Maskable Interrupts=
(FWNMI) "
>> -                             "not supported by KVM");
>> +                             "not supported by KVM, "
>> +                             "try appending -machine cap-fwnmi=3Doff");
>=20
> It is usually preferred to keep error message strings on one
> line for easier grepping. Also hints should be specified with
> error_append_hint() because they are treated differently by
> QMP (ie. not printed).
>=20
> Something like:
>=20
>         if (!kvmppc_get_fwnmi()) {
>             error_setg(errp,
>        "Firmware Assisted Non-Maskable Interrupts(FWNMI) not supported by=
 KVM");
>             error_append_hint(errp, "Try appending -machine cap-fwnmi=3Do=
ff\n");
>         }

Hmm, okay.

>=20
> Note that the current error handling code has an issue that
> prevents hints to be printed when errp =3D=3D &error_fatal, which
> is exactly what spapr_caps_apply() does. Since this affects
> a lot of locations in the code base, there's an on-going
> effort to fix that globally:
>=20
> https://patchwork.ozlabs.org/project/qemu-devel/list/?series=3D163907
>=20
> I don't know if this will make it for 5.0, but in any case I
> think you should call error_append_hint() in this patch anyway
> and the code will just work at some later point.
>=20
> Rest looks good.

Thanks will do,
Nick

=

