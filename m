Received: from eggs.gnu.org ([2001:4830:134:3::10]:58164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fxbPi-0007id-Vw
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 13:16:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fxbP3-00011v-Cr
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 13:15:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36282 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fxbP3-0000y9-6r
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 13:15:41 -0400
References: <20180904110822.12863-1-fli@suse.com>
	<20180904110822.12863-4-fli@suse.com>
	<20180904112246.GF22349@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <abfcd490-fa0c-9c18-d7a8-7e38d710cd10@redhat.com>
Date: Wed, 5 Sep 2018 12:15:39 -0500
MIME-Version: 1.0
In-Reply-To: <20180904112246.GF22349@redhat.com>
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
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, Fei Li <fli@suse.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>

Adding Markus, as the maintainer of Error APIs, to make sure he sees=20
this thread.

On 09/04/2018 06:22 AM, Daniel P. Berrang=C3=A9 wrote:
> On Tue, Sep 04, 2018 at 07:08:20PM +0800, Fei Li wrote:

In the subject line: s/paramater/parameter/

>> The caller of qemu_init_vcpu() already passed the **errp to handle
>> errors. In view of this, add a new Error parameter to the following
>> call trace to propagate the error and let the final caller check it.
>>
>> Signed-off-by: Fei Li <fli@suse.com>
>> ---

>> -void qemu_init_vcpu(CPUState *cpu)
>> +void qemu_init_vcpu(CPUState *cpu, Error **errp)
>>   {
>>       cpu->nr_cores =3D smp_cores;
>>       cpu->nr_threads =3D smp_threads;
>>       cpu->stopped =3D true;
>> +    Error *local_err =3D NULL;
>>  =20
>>       if (!cpu->as) {
>>           /* If the target cpu hasn't set up any address spaces itself=
,
>> @@ -2046,17 +2047,22 @@ void qemu_init_vcpu(CPUState *cpu)
>>       }
>>  =20
>>       if (kvm_enabled()) {
>> -        qemu_kvm_start_vcpu(cpu);
>> +        qemu_kvm_start_vcpu(cpu, &local_err);
>>       } else if (hax_enabled()) {
>> -        qemu_hax_start_vcpu(cpu);
>> +        qemu_hax_start_vcpu(cpu, &local_err);
>>       } else if (hvf_enabled()) {
>> -        qemu_hvf_start_vcpu(cpu);
>> +        qemu_hvf_start_vcpu(cpu, &local_err);
>>       } else if (tcg_enabled()) {
>> -        qemu_tcg_init_vcpu(cpu);
>> +        qemu_tcg_init_vcpu(cpu, &local_err);
>>       } else if (whpx_enabled()) {
>> -        qemu_whpx_start_vcpu(cpu);
>> +        qemu_whpx_start_vcpu(cpu, &local_err);
>>       } else {
>> -        qemu_dummy_start_vcpu(cpu);
>> +        qemu_dummy_start_vcpu(cpu, &local_err);
>> +    }
>> +
>> +    if (local_err) {
>> +        error_propagate(errp, local_err);
>> +        return;
>>       }
>=20
> I'd be inclined to make this method return a boolean, so....
>=20
>=20
>> diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
>> index b08078e7fc..5b0b4892f2 100644
>> --- a/target/alpha/cpu.c
>> +++ b/target/alpha/cpu.c
>> @@ -66,7 +66,11 @@ static void alpha_cpu_realizefn(DeviceState *dev, E=
rror **errp)
>>           return;
>>       }
>>  =20
>> -    qemu_init_vcpu(cs);
>> +    qemu_init_vcpu(cs, &local_err);
>> +    if (local_err) {
>> +        error_propagate(errp, local_err);
>> +        return;
>> +    }
>=20
> ...this can be simplified to get rid of the local error object
>=20
>    if (!qemu_init_vcpu(cs, errp)) {
>        return;
>    }

Returning a bool introduces an interesting semantic question on whether=20
0 is success or failure (-1/0 vs. false/true means you have to pay=20
attention to return type to decide between !func() or func()<0 when=20
using the return value to learn if errp was set).  But Markus has=20
expressed some thoughts on the matter before:

https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg00124.html

and favored a bool return if only for consistency with glib and to avoid=20
abuse of trying to overload the returned int when using errp is better.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
