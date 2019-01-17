Received: from eggs.gnu.org ([209.51.188.92]:51060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gk2dk-0000mI-9j
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 03:03:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gk2di-0000gH-7t
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 03:03:04 -0500
Received: from 8.mo178.mail-out.ovh.net ([46.105.74.227]:54150)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gk2di-0000aL-0g
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 03:03:02 -0500
Received: from player715.ha.ovh.net (unknown [10.109.146.50])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id F1D4447238
	for <qemu-devel@nongnu.org>; Thu, 17 Jan 2019 09:02:57 +0100 (CET)
References: <1547194672-24169-1-git-send-email-thuth@redhat.com>
	<1547194672-24169-3-git-send-email-thuth@redhat.com>
	<7d949380-e8e5-c5bd-1fd4-e87f3106e7f2@kaod.org>
	<186ccbfa-0797-25bb-453c-74c9ace0e4d5@redhat.com>
	<35b8b6d4-953a-d5ef-ceb5-5fa4a93c6c0e@kaod.org>
	<0a108f6c-8c9b-1b1e-463d-c3af171c2f19@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <1e69c5fd-c228-cb17-aeea-caa5e045b0f6@kaod.org>
Date: Thu, 17 Jan 2019 09:02:45 +0100
MIME-Version: 1.0
In-Reply-To: <0a108f6c-8c9b-1b1e-463d-c3af171c2f19@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v5 2/3] ppc: Fix duplicated
 typedefs to be able to compile with Clang in gnu99 mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, pbonzini@redhat.com, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

On 1/17/19 8:01 AM, Thomas Huth wrote:
> On 2019-01-16 14:29, C=C3=A9dric Le Goater wrote:
>> On 1/16/19 12:47 PM, Thomas Huth wrote:
>>> On 2019-01-16 12:43, C=C3=A9dric Le Goater wrote:
>>>> On 1/11/19 9:17 AM, Thomas Huth wrote:
>>>>> When compiling the ppc code with clang and -std=3Dgnu99, there are =
a
>>>>> couple of warnings/errors like this one:
>>>>>
>>>>>   CC      ppc64-softmmu/hw/intc/xics.o
>>>>> In file included from hw/intc/xics.c:35:
>>>>> include/hw/ppc/xics.h:43:25: error: redefinition of typedef 'ICPSta=
te' is a C11 feature
>>>>>       [-Werror,-Wtypedef-redefinition]
>>>>> typedef struct ICPState ICPState;
>>>>>                         ^
>>>>> target/ppc/cpu.h:1181:25: note: previous definition is here
>>>>> typedef struct ICPState ICPState;
>>>>>                         ^
>>>>> Work around the problems by including the proper headers instead.
>>>>
>>>> Thomas,
>>>>
>>>>
>>>> After a closer look, I think we should use 'void *' under PowerPCCPU=
=20
>>>> as it was the case before I introduced the second interrupt presente=
r.
>>>
>>> If you don't like the #includes, why not simply do anonymous struct
>>> forward declarations here? I think that would be better than "void *"=
.
>>
>> yes.
>> =20
>>>> That's a bigger change reverting bits of already merged patches. I c=
an
>>>> take care of it if you prefer.=20
>>>
>>> Could I keep the current patch in my series so that I can get the
>>> patches finally merged? You could then do any clean up that you like =
on
>>> top of it, ok?
>>
>> OK.=20
>>
>> See below the patch I would propose. Compiled tested with clang -std=3D=
gnu99.
> [...]
>> @@ -1204,8 +1199,8 @@ struct PowerPCCPU {
>>      int32_t node_id; /* NUMA node this CPU belongs to */
>>      PPCHash64Options *hash64_opts;
>>  #ifndef CONFIG_USER_ONLY
>> -    ICPState *icp;
>> -    XiveTCTX *tctx;
>> +    struct ICPState *icp;
>> +    struct XiveTCTX *tctx;
>>  #endif
>=20
> That's pretty much what I had in an earlier version of my patch:
>=20
> https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg01810.html
>=20
> But Greg did not like it:
>=20
> https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg01893.html

yeah :/ Sorry for all the fuss. We have been tackling this problem for=20
years now.=20

I think the patchset I just sent is good step forward and I checked=20
compilation with clang -std=3Dgn99 !

Thanks,


C.
