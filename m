Received: from eggs.gnu.org ([2001:4830:134:3::10]:55880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <git@kirschju.re>) id 1clWwm-0006cE-2r
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 03:27:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <git@kirschju.re>) id 1clWwi-0006bY-3L
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 03:27:48 -0500
Received: from h2042504.stratoserver.net ([85.214.107.226]:48352)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <git@kirschju.re>) id 1clWwh-0006bA-PQ
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 03:27:44 -0500
References: <20170308001637.9838-1-git@kirschju.re>
	<acb6dafc-ff73-9b59-22c0-aa5e8219e925@redhat.com>
From: Julian Kirsch <git@kirschju.re>
Message-ID: <4684e745-3cf1-49e9-0a9d-13f86f1cc8f1@kirschju.re>
Date: Wed, 8 Mar 2017 09:26:58 +0100
MIME-Version: 1.0
In-Reply-To: <acb6dafc-ff73-9b59-22c0-aa5e8219e925@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] X86/HMP: Expose x86 model specific
 registers via human monitor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Julian Kirsch <git@kirschju.re>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Hi Eric,

thank you for your comments. My answers are inlined.

On 08.03.2017 03:36, Eric Blake wrote:

>=20
> I'm just focusing on the QMP interface portion of this.
>=20
> Is any of this information...
>=20
>> This patch moves the logic of the rdmsr and wrmsr functions to helper.=
c and
>> replaces their current versions in misc_helper.c with stubs calling th=
e new
>> functions. The ordering of MSRs now loosely follows the ordering used =
in the KVM
>> module. As qemu operates on cached values in the CPUX86State struct, t=
he msr-set
>> command is implemented in a hackish way: In order to force qemu to flu=
sh the new
>> values to KVM a call to cpu_synchronize_post_init is triggered, eventu=
ally
>> ending up in calling kvm_put_msrs at KVM_PUT_FULL_STATE level. As MSR =
writes
>> could *still* be caught by the code logic in this function, the msr-se=
t function
>> reads back the values written to determine whether the write was succe=
ssful.
>> This way, we don't have to duplicate the logic used in kvm_put_msrs (h=
as_msr_XXX)
>> to x86_cpu_wrmsr.
>> There are several things I would like to pooint out about this patch:
>>   - The "msr-list" command currently displays MSR values for all virtu=
al cpus.
>>     This is somewhat inconsistent with "info registers" just displayin=
g the
>>     value of the current default cpu. One might think about just displ=
aying the
>>     current value and offer access to other CPU's MSRs by means of swi=
tching
>>     between CPUs using the "cpu" monitor command.
>>   - The new version of x86_cpu_rdmsr exposes MSRs that are arguably of
>>     questionable help for any human / tool using the monitor. However =
I merely
>>     felt a deep urge to reflect the full MSR list from kvm.c when writ=
ing the
>>     code.
>>   - While the need for msr-list is evident (see commit msg), msr-set c=
ould be
>>     used in more obscure cases. For instance, one might offer a way to=
 access
>>     and configure performance counter MSRs of the guest via the hmp. I=
f this
>>     feels too much like an inacceptable hack, I'll happily drop the ms=
r-set
>>     part.
>=20
> ...useful above the --- as part of the commit message?
>=20

I tried to explain the issue of qemu not flushing back the msrs to kvm in=
 cpu.c
. The remainder is merely design questions that are imho not important fo=
r the
commit message.

>=20
>> +++ b/qapi-schema.json
>> @@ -2365,6 +2365,55 @@
>>    'data': {'val': 'int', 'size': 'int', 'filename': 'str'} }
>> =20
>>  ##
>> +# @MsrInfo:
>> +#
>> +# Information about a MSR
>> +#
>> +# @cpu_idx: CPU index
>> +#
>> +# @msr_idx: MSR index
>> +#
>> +# @value: MSR value
>> +#
>> +# Since: 2.8.1
>=20
> You've missed 2.8 by a long shot; you've even missed soft freeze for
> 2.9.  This should be 2.10.
>=20

Ops. thanks for pointing this out, will update it. I sticked to the lates=
t
version returned by "git tag".

>> +##
>> +{ 'struct': 'MsrInfo',
>> +  'data': {'cpu_idx': 'int', 'msr_idx': 'uint32', 'value': 'uint64'} =
}
>=20
> Please spell new members with '-' rather than '_', as in 'cpu-idx' (or
> even spell it out as 'cpu-index') and 'msr-idx'.
>=20

Again, thank you, will take care of it.

>> +
>> +##
>> +# @msr-set:
>> +#
>> +# Set model specific registers (MSRs) on x86
>> +#
>> +# @cpu_idx: CPU holding the MSR that should be written
>> +#
>> +# @msr_idx: MSR index to write
>> +#
>> +# @value: Value to write
>> +#
>> +# Returns: Nothing on success
>=20
> Useless Returns: line.
>=20

Removed.

Best,
Julian
