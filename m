Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FEB0C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 08:57:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37AFE217D7
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 08:57:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M4IFd7Wi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37AFE217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDm3q-0006Do-Ca
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 04:57:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51272)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iDm2R-000521-Aw
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 04:55:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iDm2O-00054v-E4
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 04:55:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27078
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iDm2O-00052U-2r
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 04:55:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1569574539;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=x+b6HB9iVXvo1TA1jrk7HBf1QZlvoN0Lt7ELC2ASeYg=;
 b=M4IFd7Wiubjhoi3Rq+iCE0aja7sj2HOxNbm4YBWh1z2qiJWr72C2aMKWKvcrPvED/TVPKS
 jpD2HEJ6exW6wNvrl9jKNnNGEm66QUbritaKP47OiK6wllOxMhst/M6aYwdIrVs7CazD6c
 WdK1ZADXT3bfD6WvBRhtpLEonSvJYtQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-152-SVtE9dOVMTet0f6mwsbD5Q-1; Fri, 27 Sep 2019 04:55:36 -0400
Received: by mail-wm1-f70.google.com with SMTP id 4so1945499wmj.6
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2019 01:55:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=TLuPOwZsOKgbcL4lmRaLvFX2Q1YP2BSREZBrEyAbfgM=;
 b=qSZEXM9rJoLZo0y4vtO0EvOVVzH1QfEEzvwIHETMX2NZye1zB2U4c1756ZDvXQOlig
 RBDhETNO7uzSGNf1NRx+xc9b9Hr/X7gZO78TTrGOCCHIIlUefLk6sGnlWOCx5cWfojqA
 /vdwvguRbl/YQVJp5j0YYT0b8BfVFEg1u4rg4G8dU5zkP3VjrW+XWBZ5cGyKkjvPSnMm
 CGibaysSy5Xv2IadEpKn0Uh6oWIGg/UovELNhBOK56Karw6mFQlT0/PB7xh7kVYnl42g
 2f/I6aaqae97NrmHQQZ3DqLifdNHSyGXUFGlnY9QbZC1FRmUYCR4kfPVRv73gMgBpNn5
 VA8Q==
X-Gm-Message-State: APjAAAWyrB7ldNSaIkjosTWY69V4KWZjQt0Z1YVWYjjkVpsuPvu6tNlD
 XlDjYs1B7Dts2P/pUghqltvZzURLJFZzK2Gub66pHeekDhLF9zFxo244/zeda1szRWasYZjzzvL
 kt6qWQRdaJdzZI0c=
X-Received: by 2002:a1c:a796:: with SMTP id q144mr6252302wme.15.1569574535531; 
 Fri, 27 Sep 2019 01:55:35 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy9V+veFJKlBSRc0WITlt1pIK7YfGLoacVhmlnoKHl5r22cJ7F1/+HHP21xdw+jhEBF+FfNqw==
X-Received: by 2002:a1c:a796:: with SMTP id q144mr6252290wme.15.1569574535208; 
 Fri, 27 Sep 2019 01:55:35 -0700 (PDT)
Received: from [192.168.1.35] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id e3sm6276799wme.39.2019.09.27.01.55.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Sep 2019 01:55:34 -0700 (PDT)
Subject: Re: [PATCH v2 01/20] target/mips: Clean up helper.c
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <1569415572-19635-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1569415572-19635-2-git-send-email-aleksandar.markovic@rt-rk.com>
 <8f976a4a-e56a-d1f7-def9-14dd66140f0c@redhat.com>
 <CAL1e-=gdKQvtCX5DXCzMGPum5XiOxr7j51bQM0K8vosjPa-TcQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <bd382933-fe90-08ab-76f6-175f5d81b2b5@redhat.com>
Date: Fri, 27 Sep 2019 10:55:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAL1e-=gdKQvtCX5DXCzMGPum5XiOxr7j51bQM0K8vosjPa-TcQ@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: SVtE9dOVMTet0f6mwsbD5Q-1
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
Cc: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, arikalo@wavecomp.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/27/19 6:32 AM, Aleksandar Markovic wrote:
> 25.09.2019. 17.53, "Philippe Mathieu-Daud=C3=A9" <philmd@redhat.com
> <mailto:philmd@redhat.com>> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=
=D0=B0=D0=BE/=D0=BB=D0=B0:
>>
>> On 9/25/19 2:45 PM, Aleksandar Markovic wrote:
>> > From: Aleksandar Markovic <amarkovic@wavecomp.com
> <mailto:amarkovic@wavecomp.com>>
>> >
>> > Mostly fix errors and warnings reported by 'checkpatch.pl
> <http://checkpatch.pl> -f'.
>> >
>> > Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com
> <mailto:amarkovic@wavecomp.com>>
>> > ---
>> >=C2=A0 target/mips/helper.c | 132
> +++++++++++++++++++++++++++++++--------------------
>> >=C2=A0 1 file changed, 80 insertions(+), 52 deletions(-)
>> >
>> > diff --git a/target/mips/helper.c b/target/mips/helper.c
>> > index a2b6459..3dd1aae 100644
>> > --- a/target/mips/helper.c
>> > +++ b/target/mips/helper.c
>> > @@ -39,8 +39,8 @@ enum {
>> >=C2=A0 #if !defined(CONFIG_USER_ONLY)
>> >=C2=A0
>> >=C2=A0 /* no MMU emulation */
>> > -int no_mmu_map_address (CPUMIPSState *env, hwaddr *physical, int *pro=
t,
>> > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 target_ulong address, int rw, int access_type)
>> > +int no_mmu_map_address(CPUMIPSState *env, hwaddr *physical, int *prot=
,
>> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0target_ulong address, int rw, int access_type)
>> >=C2=A0 {
>> >=C2=A0 =C2=A0 =C2=A0 *physical =3D address;
>> >=C2=A0 =C2=A0 =C2=A0 *prot =3D PAGE_READ | PAGE_WRITE | PAGE_EXEC;
>> > @@ -48,26 +48,28 @@ int no_mmu_map_address (CPUMIPSState *env,
> hwaddr *physical, int *prot,
>> >=C2=A0 }
>> >=C2=A0
>> >=C2=A0 /* fixed mapping MMU emulation */
>> > -int fixed_mmu_map_address (CPUMIPSState *env, hwaddr *physical, int
> *prot,
>> > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0target_ulong address, int rw, int
> access_type)
>> > +int fixed_mmu_map_address(CPUMIPSState *env, hwaddr *physical, int
> *prot,
>> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 target_ulong address, int rw, int
> access_type)
>> >=C2=A0 {
>> >=C2=A0 =C2=A0 =C2=A0 if (address <=3D (int32_t)0x7FFFFFFFUL) {
>> > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(env->CP0_Status & (1 << CP0St_ERL))=
)
>> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(env->CP0_Status & (1 << CP0St_ERL))=
) {
>> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *physical =3D address =
+ 0x40000000UL;
>> > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 else
>> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {
>> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *physical =3D address;
>> > -=C2=A0 =C2=A0 } else if (address <=3D (int32_t)0xBFFFFFFFUL)
>> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> > +=C2=A0 =C2=A0 } else if (address <=3D (int32_t)0xBFFFFFFFUL) {
>> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *physical =3D address & 0x1FFFFFFF;
>> > -=C2=A0 =C2=A0 else
>> > +=C2=A0 =C2=A0 } else {
>> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *physical =3D address;
>> > +=C2=A0 =C2=A0 }
>> >=C2=A0
>> >=C2=A0 =C2=A0 =C2=A0 *prot =3D PAGE_READ | PAGE_WRITE | PAGE_EXEC;
>> >=C2=A0 =C2=A0 =C2=A0 return TLBRET_MATCH;
>> >=C2=A0 }
>> >=C2=A0
>> >=C2=A0 /* MIPS32/MIPS64 R4000-style MMU emulation */
>> > -int r4k_map_address (CPUMIPSState *env, hwaddr *physical, int *prot,
>> > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0target_ulong address, int rw, int access_type)
>> > +int r4k_map_address(CPUMIPSState *env, hwaddr *physical, int *prot,
>> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 target_ulong address, int rw, int access_type)
>> >=C2=A0 {
>> >=C2=A0 =C2=A0 =C2=A0 uint16_t ASID =3D env->CP0_EntryHi & env->CP0_Entr=
yHi_ASID_mask;
>> >=C2=A0 =C2=A0 =C2=A0 int i;
>> > @@ -99,8 +101,9 @@ int r4k_map_address (CPUMIPSState *env, hwaddr
> *physical, int *prot,
>> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (rw !=3D MMU_DATA_S=
TORE || (n ? tlb->D1 : tlb->D0)) {
>> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *physica=
l =3D tlb->PFN[n] | (address & (mask >> 1));
>> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *prot =
=3D PAGE_READ;
>> > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (n ? tlb->=
D1 : tlb->D0)
>> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (n ? tlb->=
D1 : tlb->D0) {
>> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 *prot |=3D PAGE_WRITE;
>> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(n =
? tlb->XI1 : tlb->XI0)) {
>> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 *prot |=3D PAGE_EXEC;
>> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> > @@ -130,8 +133,11 @@ static int is_seg_am_mapped(unsigned int am,
> bool eu, int mmu_idx)
>> >=C2=A0 =C2=A0 =C2=A0 int32_t adetlb_mask;
>> >=C2=A0
>> >=C2=A0 =C2=A0 =C2=A0 switch (mmu_idx) {
>> > -=C2=A0 =C2=A0 case 3 /* ERL */:
>> > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* If EU is set, always unmapped */
>> > +=C2=A0 =C2=A0 case 3:
>> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*
>> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* ERL
>> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* If EU is set, always unmapped
>> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
>>
>> My IDE show the current form nicer when the switch is folded.
>>
>> Are these comment really bothering checkpatch?
>>
>=20
> While being sintaxically correct, interleaving comments and code in a
> single code line is considered a bad practice by many.
>=20
>> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (eu) {
>> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;
>> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> > @@ -204,9 +210,9 @@ static int
> get_segctl_physical_address(CPUMIPSState *env, hwaddr *physical,
>> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pa & ~(hwadd=
r)segmask);
>> >=C2=A0 }
>> >=C2=A0
>> > -static int get_physical_address (CPUMIPSState *env, hwaddr *physical,
>> > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int *prot, target_ulong real_add=
ress,
>> > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int rw, int access_type, int mmu=
_idx)
>> > +static int get_physical_address(CPUMIPSState *env, hwaddr *physical,
>> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int *prot, target_ulong real_addr=
ess,
>> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int rw, int access_type, int mmu_=
idx)
>> >=C2=A0 {
>> >=C2=A0 =C2=A0 =C2=A0 /* User mode can only access useg/xuseg */
>> >=C2=A0 #if defined(TARGET_MIPS64)
>> > @@ -252,14 +258,15 @@ static int get_physical_address (CPUMIPSState
> *env, hwaddr *physical,
>> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {
>> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 segctl =3D env->CP0_Se=
gCtl2 >> 16;
>> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D get_segctl_physical_address(env, =
physical, prot,
> real_address, rw,
>> > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 access_type, mmu_idx, segctl,
>> > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 0x3FFFFFFF);
>> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D get_segctl_physical_address(env, =
physical, prot,
>> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 real_address, rw,
> access_type,
>> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 mmu_idx, segctl, 0x3FFFFFFF);
>> >=C2=A0 #if defined(TARGET_MIPS64)
>> >=C2=A0 =C2=A0 =C2=A0 } else if (address < 0x4000000000000000ULL) {
>> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* xuseg */
>> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (UX && address <=3D (0x3FFFFFFFFF=
FFFFFFULL & env->SEGMask)) {
>> > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D env->tlb->map_addre=
ss(env, physical, prot,
> real_address, rw, access_type);
>> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D env->tlb->map_addre=
ss(env, physical, prot,
>> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 real=
_address, rw, access_type);
>> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {
>> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D TLBRET_BADADDR=
;
>> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> > @@ -267,7 +274,8 @@ static int get_physical_address (CPUMIPSState
> *env, hwaddr *physical,
>> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* xsseg */
>> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((supervisor_mode || kernel_mode)=
 &&
>> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SX && address <=3D (0x=
7FFFFFFFFFFFFFFFULL & env->SEGMask)) {
>> > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D env->tlb->map_addre=
ss(env, physical, prot,
> real_address, rw, access_type);
>> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D env->tlb->map_addre=
ss(env, physical, prot,
>> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 real=
_address, rw, access_type);
>> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {
>> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D TLBRET_BADADDR=
;
>> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> > @@ -307,7 +315,8 @@ static int get_physical_address (CPUMIPSState
> *env, hwaddr *physical,
>> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* xkseg */
>> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (kernel_mode && KX &&
>> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 address <=3D (0xFFFFFF=
FF7FFFFFFFULL & env->SEGMask)) {
>> > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D env->tlb->map_addre=
ss(env, physical, prot,
> real_address, rw, access_type);
>> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D env->tlb->map_addre=
ss(env, physical, prot,
>> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 real=
_address, rw, access_type);
>> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {
>> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D TLBRET_BADADDR=
;
>> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> > @@ -328,8 +337,10 @@ static int get_physical_address (CPUMIPSState
> *env, hwaddr *physical,
>> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 access_type, mmu_idx,
>> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 env->CP0_SegCtl0 >> 16,
> 0x1FFFFFFF);
>> >=C2=A0 =C2=A0 =C2=A0 } else {
>> > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* kseg3 */
>> > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* XXX: debug segment is not emulated */
>> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*
>> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* kseg3
>> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* XXX: debug segment is not emulate=
d
>> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
>>
>> Ditto.
>>
>> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D get_segctl_physical_address(=
env, physical, prot,
> real_address, rw,
>> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 access_type, mmu_idx,
>> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 env->CP0_SegCtl0,
> 0x1FFFFFFF);
>> > @@ -515,9 +526,9 @@ static void raise_mmu_exception(CPUMIPSState
> *env, target_ulong address,
>> >=C2=A0 #if defined(TARGET_MIPS64)
>> >=C2=A0 =C2=A0 =C2=A0 env->CP0_EntryHi &=3D env->SEGMask;
>> >=C2=A0 =C2=A0 =C2=A0 env->CP0_XContext =3D
>> > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* PTEBase */=C2=A0 =C2=A0(env->CP0_XCont=
ext & ((~0ULL) <<
> (env->SEGBITS - 7))) |
>> > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* R */=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
(extract64(address, 62, 2) << (env->SEGBITS
> - 9)) |
>> > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* BadVPN2 */=C2=A0 =C2=A0(extract64(addr=
ess, 13, env->SEGBITS - 13)
> << 4);
>> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 (env->CP0_XContext & ((~0ULL) << (env->SE=
GBITS - 7))) | /*
> PTEBase */
>> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 (extract64(address, 62, 2) << (env->SEGBI=
TS - 9)) |=C2=A0 =C2=A0 =C2=A0/*
> R=C2=A0 =C2=A0 =C2=A0 =C2=A0*/
>> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 (extract64(address, 13, env->SEGBITS - 13=
) << 4);=C2=A0 =C2=A0 =C2=A0 =C2=A0/*
> BadVPN2 */
>> >=C2=A0 #endif
>> >=C2=A0 =C2=A0 =C2=A0 cs->exception_index =3D exception;
>> >=C2=A0 =C2=A0 =C2=A0 env->error_code =3D error_code;
>> > @@ -945,7 +956,8 @@ bool mips_cpu_tlb_fill(CPUState *cs, vaddr
> address, int size,
>> >=C2=A0 }
>> >=C2=A0
>> >=C2=A0 #ifndef CONFIG_USER_ONLY
>> > -hwaddr cpu_mips_translate_address(CPUMIPSState *env, target_ulong
> address, int rw)
>> > +hwaddr cpu_mips_translate_address(CPUMIPSState *env, target_ulong
> address,
>> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int rw)
>> >=C2=A0 {
>> >=C2=A0 =C2=A0 =C2=A0 hwaddr physical;
>> >=C2=A0 =C2=A0 =C2=A0 int prot;
>> > @@ -1005,7 +1017,7 @@ static const char * const excp_names[EXCP_LAST
> + 1] =3D {
>> >=C2=A0 };
>> >=C2=A0 #endif
>> >=C2=A0
>> > -target_ulong exception_resume_pc (CPUMIPSState *env)
>> > +target_ulong exception_resume_pc(CPUMIPSState *env)
>> >=C2=A0 {
>> >=C2=A0 =C2=A0 =C2=A0 target_ulong bad_pc;
>> >=C2=A0 =C2=A0 =C2=A0 target_ulong isa_mode;
>> > @@ -1013,8 +1025,10 @@ target_ulong exception_resume_pc
> (CPUMIPSState *env)
>> >=C2=A0 =C2=A0 =C2=A0 isa_mode =3D !!(env->hflags & MIPS_HFLAG_M16);
>> >=C2=A0 =C2=A0 =C2=A0 bad_pc =3D env->active_tc.PC | isa_mode;
>> >=C2=A0 =C2=A0 =C2=A0 if (env->hflags & MIPS_HFLAG_BMASK) {
>> > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* If the exception was raised from a del=
ay slot, come back to
>> > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0the jump.=C2=A0 */
>> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*
>> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* If the exception was raised from =
a delay slot, come back to
>> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*=C2=A0 the jump.
>> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
>> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bad_pc -=3D (env->hflags & MIPS_HFLA=
G_B16 ? 2 : 4);
>> >=C2=A0 =C2=A0 =C2=A0 }
>> >=C2=A0
>> > @@ -1022,14 +1036,14 @@ target_ulong exception_resume_pc
> (CPUMIPSState *env)
>> >=C2=A0 }
>> >=C2=A0
>> >=C2=A0 #if !defined(CONFIG_USER_ONLY)
>> > -static void set_hflags_for_handler (CPUMIPSState *env)
>> > +static void set_hflags_for_handler(CPUMIPSState *env)
>> >=C2=A0 {
>> >=C2=A0 =C2=A0 =C2=A0 /* Exception handlers are entered in 32-bit mode.=
=C2=A0 */
>> >=C2=A0 =C2=A0 =C2=A0 env->hflags &=3D ~(MIPS_HFLAG_M16);
>> >=C2=A0 =C2=A0 =C2=A0 /* ...except that microMIPS lets you choose.=C2=A0=
 */
>> >=C2=A0 =C2=A0 =C2=A0 if (env->insn_flags & ASE_MICROMIPS) {
>> > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 env->hflags |=3D (!!(env->CP0_Config3
>> > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0& (1 << CP0C3_ISA_ON_EXC))
>> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 env->hflags |=3D (!!(env->CP0_Config3 &
>> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0(1 << CP0C3_ISA_ON_EXC))
>> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 << MIPS_HFLAG_M16_SHIFT);
>> >=C2=A0 =C2=A0 =C2=A0 }
>> >=C2=A0 }
>> > @@ -1096,10 +1110,12 @@ void mips_cpu_do_interrupt(CPUState *cs)
>> >=C2=A0 =C2=A0 =C2=A0 switch (cs->exception_index) {
>> >=C2=A0 =C2=A0 =C2=A0 case EXCP_DSS:
>> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env->CP0_Debug |=3D 1 << CP0DB_DSS;
>> > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Debug single step cannot be raised ins=
ide a delay slot and
>> > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0resume will always occur on =
the next instruction
>> > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(but we assume the pc has al=
ways been updated during
>> > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0code translation). */
>> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*
>> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Debug single step cannot be raise=
d inside a delay slot and
>> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* resume will always occur on the n=
ext instruction
>> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* (but we assume the pc has always =
been updated during
>> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* code translation).
>> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
>> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env->CP0_DEPC =3D env->active_tc.PC =
| !!(env->hflags &
> MIPS_HFLAG_M16);
>> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto enter_debug_mode;
>> >=C2=A0 =C2=A0 =C2=A0 case EXCP_DINT:
>> > @@ -1111,7 +1127,8 @@ void mips_cpu_do_interrupt(CPUState *cs)
>> >=C2=A0 =C2=A0 =C2=A0 case EXCP_DBp:
>> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env->CP0_Debug |=3D 1 << CP0DB_DBp;
>> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Setup DExcCode - SDBBP instructio=
n */
>> > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 env->CP0_Debug =3D (env->CP0_Debug & ~(0x=
1fULL << CP0DB_DEC))
> | 9 << CP0DB_DEC;
>> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 env->CP0_Debug =3D (env->CP0_Debug & ~(0x=
1fULL << CP0DB_DEC)) |
>> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0(9 << CP0DB_DEC);
>> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto set_DEPC;
>> >=C2=A0 =C2=A0 =C2=A0 case EXCP_DDBS:
>> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env->CP0_Debug |=3D 1 << CP0DB_DDBS;
>> > @@ -1132,8 +1149,9 @@ void mips_cpu_do_interrupt(CPUState *cs)
>> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env->hflags |=3D MIPS_HFLAG_DM | MIP=
S_HFLAG_CP0;
>> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env->hflags &=3D ~(MIPS_HFLAG_KSU);
>> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* EJTAG probe trap enable is not im=
plemented... */
>> > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(env->CP0_Status & (1 << CP0St_EXL))=
)
>> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(env->CP0_Status & (1 << CP0St_EXL))=
) {
>> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env->CP0_Cause &=3D ~(=
1U << CP0Ca_BD);
>> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env->active_tc.PC =3D env->exception=
_base + 0x480;
>> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 set_hflags_for_handler(env);
>> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>> > @@ -1159,8 +1177,9 @@ void mips_cpu_do_interrupt(CPUState *cs)
>> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env->hflags |=3D MIPS_HFLAG_CP0;
>> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env->hflags &=3D ~(MIPS_HFLAG_KSU);
>> > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(env->CP0_Status & (1 << CP0St_EXL))=
)
>> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(env->CP0_Status & (1 << CP0St_EXL))=
) {
>> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env->CP0_Cause &=3D ~(=
1U << CP0Ca_BD);
>> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env->active_tc.PC =3D env->exception=
_base;
>> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 set_hflags_for_handler(env);
>> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>> > @@ -1176,12 +1195,16 @@ void mips_cpu_do_interrupt(CPUState *cs)
>> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t=
 pending =3D (env->CP0_Cause & CP0Ca_IP_mask)
>>> CP0Ca_IP;
>> >=C2=A0
>> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (env-=
>CP0_Config3 & (1 << CP0C3_VEIC)) {
>> > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 /* For VEIC mode, the external interrupt
> controller feeds
>> > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0* the vector through the CP0Cause IP lines.=C2=A0 */
>> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 /*
>> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0* For VEIC mode, the external interrupt
> controller feeds
>> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0* the vector through the CP0Cause IP lines.
>> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0*/
>> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 vector =3D pending;
>> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {
>> > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 /* Vectored Interrupts
>> > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0* Mask with Status.IM7-IM0 to get enabled
> interrupts. */
>> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 /*
>> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0* Vectored Interrupts
>> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0* Mask with Status.IM7-IM0 to get enabled
> interrupts.
>> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0*/
>> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 pending &=3D (env->CP0_Status >> CP0St_IM) & 0xff;
>> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 /* Find the highest-priority interrupt. */
>> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 while (pending >>=3D 1) {
>> > @@ -1354,7 +1377,8 @@ void mips_cpu_do_interrupt(CPUState *cs)
>> >=C2=A0
>> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env->active_tc.PC +=3D offset;
>> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 set_hflags_for_handler(env);
>> > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 env->CP0_Cause =3D (env->CP0_Cause & ~(0x=
1f << CP0Ca_EC)) |
> (cause << CP0Ca_EC);
>> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 env->CP0_Cause =3D (env->CP0_Cause & ~(0x=
1f << CP0Ca_EC)) |
>> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0(cause << CP0Ca_EC);
>> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>> >=C2=A0 =C2=A0 =C2=A0 default:
>> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 abort();
>> > @@ -1390,7 +1414,7 @@ bool mips_cpu_exec_interrupt(CPUState *cs, int
> interrupt_request)
>> >=C2=A0 }
>> >=C2=A0
>> >=C2=A0 #if !defined(CONFIG_USER_ONLY)
>> > -void r4k_invalidate_tlb (CPUMIPSState *env, int idx, int use_extra)
>> > +void r4k_invalidate_tlb(CPUMIPSState *env, int idx, int use_extra)
>> >=C2=A0 {
>> >=C2=A0 =C2=A0 =C2=A0 CPUState *cs =3D env_cpu(env);
>> >=C2=A0 =C2=A0 =C2=A0 r4k_tlb_t *tlb;
>> > @@ -1400,16 +1424,20 @@ void r4k_invalidate_tlb (CPUMIPSState *env,
> int idx, int use_extra)
>> >=C2=A0 =C2=A0 =C2=A0 target_ulong mask;
>> >=C2=A0
>> >=C2=A0 =C2=A0 =C2=A0 tlb =3D &env->tlb->mmu.r4k.tlb[idx];
>> > -=C2=A0 =C2=A0 /* The qemu TLB is flushed when the ASID changes, so no=
 need to
>> > -=C2=A0 =C2=A0 =C2=A0 =C2=A0flush these entries again.=C2=A0 */
>> > +=C2=A0 =C2=A0 /*
>> > +=C2=A0 =C2=A0 =C2=A0* The qemu TLB is flushed when the ASID changes, =
so no need to
>> > +=C2=A0 =C2=A0 =C2=A0* flush these entries again.
>> > +=C2=A0 =C2=A0 =C2=A0*/
>> >=C2=A0 =C2=A0 =C2=A0 if (tlb->G =3D=3D 0 && tlb->ASID !=3D ASID) {
>> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
>> >=C2=A0 =C2=A0 =C2=A0 }
>> >=C2=A0
>> >=C2=A0 =C2=A0 =C2=A0 if (use_extra && env->tlb->tlb_in_use < MIPS_TLB_M=
AX) {
>> > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* For tlbwr, we can shadow the discarded=
 entry into
>> > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0a new (fake) TLB entry, as l=
ong as the guest can not
>> > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tell that it's there.=C2=A0 =
*/
>> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*
>> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* For tlbwr, we can shadow the disc=
arded entry into
>> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* a new (fake) TLB entry, as long a=
s the guest can not
>> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* tell that it's there.
>> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
>> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env->tlb->mmu.r4k.tlb[env->tlb->tlb_=
in_use] =3D *tlb;
>> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env->tlb->tlb_in_use++;
>> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
>> >
>>
>> Except 2 comments, OK for the rest.
>>
>> Another patch that makes rebasing very painful :(
>>
>=20
> It would be fantastic if you apply the same reasoning to your patches,
> that spread all over the code base, and happen so frequently, and
> certainly create enormously more rebasing problems for multitude of
> people than this patch or series does.

Fair enough :D

You are free to question and Nack them.

Regards,

Phil.


