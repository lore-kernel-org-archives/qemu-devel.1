Received: from eggs.gnu.org ([2001:4830:134:3::10]:57078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1fxo9b-0005Zj-3M
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 02:52:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1fxo9X-00039y-19
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 02:52:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:47222 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fli@suse.com>) id 1fxo9W-00037l-Mv
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 02:52:30 -0400
References: <20180904110822.12863-1-fli@suse.com>
	<20180904110822.12863-4-fli@suse.com>
	<20180904112246.GF22349@redhat.com>
	<abfcd490-fa0c-9c18-d7a8-7e38d710cd10@redhat.com>
From: Fei Li <fli@suse.com>
Message-ID: <44af1c4a-c57d-09fd-6fe8-129d66e98549@suse.com>
Date: Thu, 6 Sep 2018 14:52:25 +0800
MIME-Version: 1.0
In-Reply-To: <abfcd490-fa0c-9c18-d7a8-7e38d710cd10@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/5] qemu_init_vcpu: add a new Error
 paramater to propagate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>



On 09/06/2018 01:15 AM, Eric Blake wrote:
> Adding Markus, as the maintainer of Error APIs, to make sure he sees=20
> this thread.
Thanks. :)
>
> On 09/04/2018 06:22 AM, Daniel P. Berrang=C3=A9 wrote:
>> On Tue, Sep 04, 2018 at 07:08:20PM +0800, Fei Li wrote:
>
> In the subject line: s/paramater/parameter/
Thanks for pointing this out! :)
>
>>> The caller of qemu_init_vcpu() already passed the **errp to handle
>>> errors. In view of this, add a new Error parameter to the following
>>> call trace to propagate the error and let the final caller check it.
>>>
>>> Signed-off-by: Fei Li <fli@suse.com>
>>> ---
>
>>> -void qemu_init_vcpu(CPUState *cpu)
>>> +void qemu_init_vcpu(CPUState *cpu, Error **errp)
>>> =C2=A0 {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpu->nr_cores =3D smp_cores;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpu->nr_threads =3D smp_threads;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpu->stopped =3D true;
>>> +=C2=A0=C2=A0=C2=A0 Error *local_err =3D NULL;
>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!cpu->as) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* If the targ=
et cpu hasn't set up any address spaces itself,
>>> @@ -2046,17 +2047,22 @@ void qemu_init_vcpu(CPUState *cpu)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (kvm_enabled()) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_kvm_start_vcpu(cpu);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_kvm_start_vcpu(cpu, =
&local_err);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else if (hax_enabled()) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_hax_start_vcpu(cpu);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_hax_start_vcpu(cpu, =
&local_err);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else if (hvf_enabled()) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_hvf_start_vcpu(cpu);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_hvf_start_vcpu(cpu, =
&local_err);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else if (tcg_enabled()) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_tcg_init_vcpu(cpu);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_tcg_init_vcpu(cpu, &=
local_err);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else if (whpx_enabled()) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_whpx_start_vcpu(cpu)=
;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_whpx_start_vcpu(cpu,=
 &local_err);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_dummy_start_vcpu(cpu=
);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_dummy_start_vcpu(cpu=
, &local_err);
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (local_err) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_propagate(errp, loc=
al_err);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>
>> I'd be inclined to make this method return a boolean, so....
>>
>>
>>> diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
>>> index b08078e7fc..5b0b4892f2 100644
>>> --- a/target/alpha/cpu.c
>>> +++ b/target/alpha/cpu.c
>>> @@ -66,7 +66,11 @@ static void alpha_cpu_realizefn(DeviceState *dev,=20
>>> Error **errp)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0 -=C2=A0=C2=A0=C2=A0 qemu_init_vcpu(cs);
>>> +=C2=A0=C2=A0=C2=A0 qemu_init_vcpu(cs, &local_err);
>>> +=C2=A0=C2=A0=C2=A0 if (local_err) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_propagate(errp, loc=
al_err);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>>> +=C2=A0=C2=A0=C2=A0 }
>>
>> ...this can be simplified to get rid of the local error object
>>
>> =C2=A0=C2=A0 if (!qemu_init_vcpu(cs, errp)) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> =C2=A0=C2=A0 }
>
> Returning a bool introduces an interesting semantic question on=20
> whether 0 is success or failure (-1/0 vs. false/true means you have to=20
> pay attention to return type to decide between !func() or func()<0=20
> when using the return value to learn if errp was set).=C2=A0 But Markus=
 has=20
> expressed some thoughts on the matter before:
>
> https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg00124.html
>
> and favored a bool return if only for consistency with glib and to=20
> avoid abuse of trying to overload the returned int when using errp is=20
> better.
>
Thanks for providing these instructive discussions, I read the link, and=20
yes,
I agree with "return a bool: false/true inside the callee". Just as the=20
following:

 =C2=A0=C2=A0=C2=A0 if (!foo(arg, errp)) { // assuming foo() returns a bo=
ol: false/true
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 handle the error...
 =C2=A0=C2=A0=C2=A0 }

As this is "Nicely concise." :)
I will prepare the next version according to all the comments.

Have a nice day, thanks all
Fei
