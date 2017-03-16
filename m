Received: from eggs.gnu.org ([2001:4830:134:3::10]:36903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1coWhl-0003JO-1v
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 10:48:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1coWhh-0004lx-27
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 10:48:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51138)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1coWhg-0004lk-Q2
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 10:48:36 -0400
References: <20170130131517.8092-1-sw@weilnetz.de>
	<c16d6c6a-96b8-01fd-ca20-978e9c1a2367@redhat.com>
	<d09ccce8-9ac4-66f5-36e1-132c9cffd9f7@redhat.com>
	<4e1a0f31-c9a8-f504-11a0-191158390e3d@amsat.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <60e58838-d550-4e60-7b85-7079eb2c72b3@redhat.com>
Date: Thu, 16 Mar 2017 15:48:32 +0100
MIME-Version: 1.0
In-Reply-To: <4e1a0f31-c9a8-f504-11a0-191158390e3d@amsat.org>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] target/s390x: Fix broken user mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Stefan Weil <sw@weilnetz.de>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel@nongnu.org, Bruce Rogers <brogers@suse.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>

On 16.03.2017 15:46, Philippe Mathieu-Daud=E9 wrote:
> Hi Stefan, Richard.
>=20
> On 03/16/2017 10:28 AM, David Hildenbrand wrote:
>> On 02.03.2017 20:56, David Hildenbrand wrote:
>>> Am 30.01.2017 um 14:15 schrieb Stefan Weil:
>>>> Returning NULL from get_max_cpu_model results in a SIGSEGV runtime e=
rror.
>>>>
>>>> Signed-off-by: Stefan Weil <sw@weilnetz.de>
>>>> ---
>>>>
>>>> v2: Re-sent as v1 was damaged by my mailer.
>>>>
>>>> This is also broken in Debian.
>>>>
>>>> In addition, there is no default CPU ("any"), so binfmt and related
>>>> actions currently don't work. I hacked my local installation by
>>>> duplicating the "qemu" cpu definition for "any", but maybe there is
>>>> a better solution.
>>>
>>> That should then already work.
>>>
>>>>
>>>> Regards
>>>> Stefan
>>>>
>>>>  target/s390x/cpu_models.c | 2 --
>>>>  1 file changed, 2 deletions(-)
>>>>
>>>> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
>>>> index 2a894ee..6e34763 100644
>>>> --- a/target/s390x/cpu_models.c
>>>> +++ b/target/s390x/cpu_models.c
>>>> @@ -660,7 +660,6 @@ static void check_compatibility(const S390CPUMod=
el *max_model,
>>>>
>>>>  static S390CPUModel *get_max_cpu_model(Error **errp)
>>>>  {
>>>> -#ifndef CONFIG_USER_ONLY
>>>>      static S390CPUModel max_model;
>>>>      static bool cached;
>>>>
>>>> @@ -680,7 +679,6 @@ static S390CPUModel *get_max_cpu_model(Error **e=
rrp)
>>>>          cached =3D true;
>>>>          return &max_model;
>>>>      }
>>>> -#endif
>>>>      return NULL;
>>>>  }
>>>>
>>>>
>>>
>>> I thought this was already picked up for stable...
>>> But looks like only the "any" model fixup got.
>>>
>>> So
>>>
>>> Acked-by: David Hildenbrand <david@redhat.com>
>>>
>>
>> Ping, can somebody please pick this up?
>=20
> I see at least two possible changes:
>=20
> the nasty one to catch bug:
>=20
> @@ -681,7 +681,7 @@ static S390CPUModel *get_max_cpu_model(Error **errp=
)
>           return &max_model;
>       }
>   #endif
> -    return NULL;
> +    abort();
>   }
>=20
> and the nicer one to avoid SIGSEGV:
>=20
> @@ -734,8 +734,10 @@ void s390_realize_cpu_model(CPUState *cs, Error **=
errp)
>       }
>=20
>       max_model =3D get_max_cpu_model(errp);
> -    if (*errp) {
> -        error_prepend(errp, "CPU models are not available: ");
> +    if (max_model =3D=3D NULL) {
> +        if (*errp) {
> +            error_prepend(errp, "CPU models are not available: ");
> +        } else {
> +            error_setg(errp, "CPU models are not available");
> +        }
>           return;
>       }
>=20

As already discussed, user mode should behave just like tcg. No special
handling. So the original patch here is just fine in my opinion.

--=20

Thanks,

David
