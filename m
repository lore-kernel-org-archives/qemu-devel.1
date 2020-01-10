Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1650CC282DD
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 19:20:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D33A62051A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 19:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ez3kFaMH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D33A62051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipzpf-0007bO-I6
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 14:20:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50244)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1ipzo4-00063O-PO
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 14:18:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1ipzo3-0000VR-6G
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 14:18:52 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:54704
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ipzo2-0000RV-VV
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 14:18:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578683930;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wYy9RIEcnBRxr6Ja2Vdphx10aFgzQcnoOANAowuc2eE=;
 b=ez3kFaMHxQ61arvvQEHhSq424D78/5ZaSD0RVifg5LbsLP0rA1ZVJbOAHnRf8SUhYDr9nx
 DJSRdjjiyff9/tL9FKUzhrNnV77okbA3/4Uj007RjSNykovZ3hj1SswhPXuMZVi3AQNb+K
 PC4PdT1SbMrmv0KY6170xKvzVezeF8I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-9LCGyL8kOmumK1OSKH_L4A-1; Fri, 10 Jan 2020 14:18:49 -0500
X-MC-Unique: 9LCGyL8kOmumK1OSKH_L4A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 007C7801E7A;
 Fri, 10 Jan 2020 19:18:47 +0000 (UTC)
Received: from [10.3.117.16] (ovpn-117-16.phx2.redhat.com [10.3.117.16])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E25685DA32;
 Fri, 10 Jan 2020 19:18:42 +0000 (UTC)
Subject: Re: [PATCH 04/15] hw/ppc/spapr_rtas: Restrict variables scope to
 single switch case
To: Greg Kurz <groug@kaod.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@redhat.com>
References: <20200109152133.23649-1-philmd@redhat.com>
 <20200109152133.23649-5-philmd@redhat.com>
 <20200109184349.1aefa074@bahia.lan>
 <9870f8ed-3fa0-1deb-860d-7481cb3db556@redhat.com>
 <20200110105055.3e72ddf4@bahia.lan>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <6ad8e693-813a-26ea-73f8-319d440de1e3@redhat.com>
Date: Fri, 10 Jan 2020 13:18:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200110105055.3e72ddf4@bahia.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 Juan Quintela <quintela@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <rth@twiddle.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/10/20 3:50 AM, Greg Kurz wrote:

>>> I guess a decent compiler can be smart enough detect that the initial=
ization
>>> isn't needed outside of the RTAS_SYSPARM_SPLPAR_CHARACTERISTICS branc=
h...
>>> Anyway, reducing scope isn't bad. The only hitch I could see is that =
some
>>> people do prefer to have all variables declared upfront, but there's =
a nested
>>> param_val variable already so I guess it's okay.
>>
>> I don't want to outsmart compilers :)

Or conversely play the game of which compilers will warn about an=20
atypical construct.

>>
>> The MACHINE() macro is not a simple cast, it does object introspection
>> with OBJECT_CHECK(), thus is not free. Since
>=20
> Sure, I understand the motivation in avoiding an unneeded call
> to calling object_dynamic_cast_assert().
>=20
>> object_dynamic_cast_assert() argument is not const, I'm not sure the
>> compiler can remove the call.
>>
>=20
> Not remove the call, but delay it to the branch that uses it,
> ie. parameter =3D=3D RTAS_SYSPARM_SPLPAR_CHARACTERISTICS.
>=20
>> Richard, Eric, do you know?
>>
>>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>>> ---
>>>>    hw/ppc/spapr_rtas.c | 4 ++--
>>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
>>>> index 6f06e9d7fe..7237e5ebf2 100644
>>>> --- a/hw/ppc/spapr_rtas.c
>>>> +++ b/hw/ppc/spapr_rtas.c
>>>> @@ -267,8 +267,6 @@ static void rtas_ibm_get_system_parameter(PowerP=
CCPU *cpu,
>>>>                                              uint32_t nret, target_u=
long rets)
>>>>    {
>>>>        PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
>>>> -    MachineState *ms =3D MACHINE(spapr);
>>>> -    unsigned int max_cpus =3D ms->smp.max_cpus;
>>>>        target_ulong parameter =3D rtas_ld(args, 0);
>>>>        target_ulong buffer =3D rtas_ld(args, 1);
>>>>        target_ulong length =3D rtas_ld(args, 2);
>>>> @@ -276,6 +274,8 @@ static void rtas_ibm_get_system_parameter(PowerP=
CCPU *cpu,
>>>>   =20
>>>>        switch (parameter) {
>>>>        case RTAS_SYSPARM_SPLPAR_CHARACTERISTICS: {
>>>> +        MachineState *ms =3D MACHINE(spapr);
>>>> +        unsigned int max_cpus =3D ms->smp.max_cpus;

Declaring an initializer inside a switch statement can trigger warnings=20
under some compilation scenarios (particularly if the variable is=20
referenced outside of the scope where it was introduced).  But here, you=20
are using 'case label: { ...' to create a scope, which presumably ends=20
before the next case label, and is thus not going to trigger compiler=20
warnings.

An alternative is indeed leaving the declaration up front but deferring=20
the (possibly expensive) initializer to the case label that needs it:

MachineState *ms;
switch (parameter) {
case ...:
   ms =3D MACHINE(spapr);

and done that way, you might not even need the extra {} behind the case=20
label (I didn't read the file to see if there is already some other=20
reason for having introduced that sub-scope).

As for whether compilers are smart enough to defer non-trivial=20
initialization to the one case label that uses the variable, I wouldn't=20
count on it.  If the non-trivial initialization includes a function call=20
(which the MACHINE() macro does), it's much harder to prove whether that=20
function call has side effects that may be needed prior to the switch=20
statement.  So limiting the scope of the initialization (whether by=20
dropping the declaration, or just deferring the call) DOES make sense.


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


