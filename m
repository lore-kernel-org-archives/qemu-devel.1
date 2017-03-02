Received: from eggs.gnu.org ([2001:4830:134:3::10]:33612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brogers@suse.com>) id 1cjWso-0004Th-1w
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 14:59:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brogers@suse.com>) id 1cjWsl-0005A6-Dj
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 14:59:26 -0500
Received: from prv-mh.provo.novell.com ([137.65.248.74]:38950)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brogers@suse.com>) id 1cjWsl-00059d-40
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 14:59:23 -0500
Message-Id: <58B81727020000480014092F@prv-mh.provo.novell.com>
Date: Thu, 02 Mar 2017 12:59:19 -0700
From: "Bruce Rogers" <brogers@suse.com>
References: <20170302193300.21188-1-brogers@suse.com>
	<36cb066c-4d1f-dc7f-ada6-cef224566f2d@redhat.com>
	<19443ff2-d552-4540-965b-b4840f2899ce@redhat.com>
In-Reply-To: <19443ff2-d552-4540-965b-b4840f2899ce@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Subject: Re: [Qemu-devel] [PATCH] linux-user: Exclude more cpu model code
 when building s390x linux-user
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, david@redhat.com
Cc: borntraeger@de.ibm.com, Alexander Graf <agraf@suse.de>, "rth@twiddle.net" <rth@twiddle.net>, Stefan Weil <sw@weilnetz.de>

>>> On 3/2/2017 at 12:53 PM, <david@redhat.com> wrote:
> Am 02.03.2017 um 20:50 schrieb David Hildenbrand:
>> Am 02.03.2017 um 20:33 schrieb Bruce Rogers:
>>> Currently qemu-s390x segfaults. Avoid cpu model code which doesn't
>>> apply in linux user case.
>>=20
>> That was also my impression, but it does apply. However, for now it
>> doesn't matter, as also tcg isn't properly wired up.
>>=20
>> In general, linux-user can support _at least_ the same features as tcg,
>> in theory even more (all that only apply to kernel space).
>>=20
>> We had a proper fix on this list by Richard Henderson, wonder what
>> happened to that?
>=20
> Actually it was Stefan Weil :) cc-ing him.

I'm not all so familiar with this code, I only saw a failure and fixed it =
the
most obvious way for me. I'm happy if there is a better fix out there.

BTW: I resent the patch again with SOB.

Brue

>=20
>>=20
>> This file should contain no CONFIG_USER_ONLY apart from the QMP
>> interface stuff.
>>=20
>>> ---
>>>  target/s390x/cpu_models.c | 6 +++---
>>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
>>> index 2a894eec65..97e4e75f68 100644
>>> --- a/target/s390x/cpu_models.c
>>> +++ b/target/s390x/cpu_models.c
>>> @@ -590,7 +590,6 @@ CpuModelBaselineInfo=20
> *arch_query_cpu_model_baseline(CpuModelInfo *infoa,
>>>      cpu_info_from_model(baseline_info->model, &model, true);
>>>      return baseline_info;
>>>  }
>>> -#endif
>>> =20
>>>  static void check_consistency(const S390CPUModel *model)
>>>  {
>>> @@ -660,7 +659,6 @@ static void check_compatibility(const S390CPUModel=
=20
> *max_model,
>>> =20
>>>  static S390CPUModel *get_max_cpu_model(Error **errp)
>>>  {
>>> -#ifndef CONFIG_USER_ONLY
>>>      static S390CPUModel max_model;
>>>      static bool cached;
>>> =20
>>> @@ -680,9 +678,9 @@ static S390CPUModel *get_max_cpu_model(Error =
**errp)
>>>          cached =3D true;
>>>          return &max_model;
>>>      }
>>> -#endif
>>>      return NULL;
>>>  }
>>> +#endif
>>> =20
>>>  static inline void apply_cpu_model(const S390CPUModel *model, Error =
**errp)
>>>  {
>>> @@ -718,6 +716,7 @@ static inline void apply_cpu_model(const S390CPUMod=
el=20
> *model, Error **errp)
>>> =20
>>>  void s390_realize_cpu_model(CPUState *cs, Error **errp)
>>>  {
>>> +#ifndef CONFIG_USER_ONLY
>>>      S390CPUClass *xcc =3D S390_CPU_GET_CLASS(cs);
>>>      S390CPU *cpu =3D S390_CPU(cs);
>>>      const S390CPUModel *max_model;
>>> @@ -751,6 +750,7 @@ void s390_realize_cpu_model(CPUState *cs, Error =
**errp)
>>>      }
>>> =20
>>>      apply_cpu_model(cpu->model, errp);
>>> +#endif
>>>  }
>>> =20
>>>  static void get_feature(Object *obj, Visitor *v, const char *name,
>>>
>>=20
>>=20
>=20
>=20
> --=20
> Thanks,
>=20
> David
