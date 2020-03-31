Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63125C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 08:16:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3844820714
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 08:16:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3844820714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJC4b-0000pO-Cs
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 04:16:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55761)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1jJC3N-0007Dx-5L
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 04:15:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1jJC3L-0003Hx-Ul
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 04:15:20 -0400
Received: from 12.mo6.mail-out.ovh.net ([178.32.125.228]:60901)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1jJC3L-0003GF-Ob
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 04:15:19 -0400
Received: from player711.ha.ovh.net (unknown [10.110.103.132])
 by mo6.mail-out.ovh.net (Postfix) with ESMTP id 30A29209681
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2020 10:15:16 +0200 (CEST)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player711.ha.ovh.net (Postfix) with ESMTPSA id E874410CFE185;
 Tue, 31 Mar 2020 08:15:10 +0000 (UTC)
Subject: Re: [PATCH 4/7] target/ppc: Introduce ppc_radix64_xlate() for Radix
 tree translation
To: David Gibson <david@gibson.dropbear.id.au>
References: <20200330094946.24678-1-clg@kaod.org>
 <20200330094946.24678-5-clg@kaod.org> <20200330161848.27226542@bahia.lan>
 <99dd89d6-f385-7cc1-d688-c104708092c2@kaod.org>
 <88580970-a739-b32f-528f-26c6aa81b598@kaod.org>
 <20200331011310.GG47772@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <15a0034a-fa2c-7852-52b8-df2b76bd0aff@kaod.org>
Date: Tue, 31 Mar 2020 10:15:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200331011310.GG47772@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
X-Ovh-Tracer-Id: 18164143199434804120
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrudeijedgtddvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefheenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrdeigedrvdehtddrudejtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejuddurdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.32.125.228
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
Cc: Suraj Jitindar Singh <sjitindarsingh@gmail.com>, qemu-ppc@nongnu.org,
 Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/31/20 3:13 AM, David Gibson wrote:
> On Mon, Mar 30, 2020 at 05:34:40PM +0200, C=E9dric Le Goater wrote:
>>>>> +        /* No valid pte or access denied due to protection */
>>>>> +        if (cause_excp) {
>>>>> +            ppc_radix64_raise_si(cpu, rwx, eaddr, fault_cause);
>>>>> +        }
>>>>> +        return 1;
>>>>> +    }
>>>>> +
>>>>> +    ppc_radix64_set_rc(cpu, rwx, pte, pte_addr, g_prot);
>>>>> +
>>>>> +    return 0;
>>>>> +}
>>>>> +
>>>>> +static int ppc_radix64_xlate(PowerPCCPU *cpu, vaddr eaddr, int rwx=
,
>>>>> +                             uint64_t lpid, uint64_t pid, bool rel=
ocation,
>>>>> +                             hwaddr *raddr, int *psizep, int *prot=
p,
>>>>> +                             bool cause_excp)
>>>>> +{
>>>>> +    ppc_v3_pate_t pate;
>>>>> +    int psize, prot;
>>>>> +    hwaddr g_raddr;
>>>>> +
>>>>> +    *psizep =3D INT_MAX;
>>>>> +    *protp =3D PAGE_READ | PAGE_WRITE | PAGE_EXEC;
>>>>> +
>>>>> +    /* Get Process Table */
>>>>> +    if (cpu->vhyp && lpid =3D=3D 0) {
>>>>
>>>> Current code doesn't check lpid =3D=3D 0. Not sure to see what it's =
for...
>>>
>>> cpu->vhyp means a pseries machine, lpid =3D=3D 0 means accessing quad=
rant3,=20
>>> so it's the kernel.
>>
>> Sorry. I misread that. It would pid =3D=3D 0 for the kernel.=20
>>
>> So yes, the test cpu->vhyp && lpid =3D=3D 0 might be a bit overkill, g=
iven=20
>> that lpid is always 0 when running under a QEMU pseries machine.
>=20
> Overkill and conceptually incorrect.  When in vhyp mode we're not
> modelling the hypervisor part of the CPU, which means that really the
> LPID doesn't exist, so we shouldn't be looking at it (though it will
> always be 0 in practice).

I will remove the extra check. This has the nice effect of cleaning up=20
a couple of weird changes in patch 7.

Thanks,

C.

