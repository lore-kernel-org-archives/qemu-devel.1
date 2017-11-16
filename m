Received: from eggs.gnu.org ([2001:4830:134:3::10]:38126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eFOL3-00022v-Rw
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 12:52:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eFOL0-0003QB-MO
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 12:52:33 -0500
References: <20171116170526.12643-1-david@redhat.com>
	<20171116170526.12643-3-david@redhat.com> <87375e15vx.fsf@linaro.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <f0fc452d-8229-6eb3-b5d2-1d55b9ba0ee3@redhat.com>
Date: Thu, 16 Nov 2017 18:52:26 +0100
MIME-Version: 1.0
In-Reply-To: <87375e15vx.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 for-2.11 2/3] s390x/tcg: fix DIAG 308
 with > 1 VCPU (single threaded TCG)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>

On 16.11.2017 18:37, Alex Benn=C3=A9e wrote:
>=20
> David Hildenbrand <david@redhat.com> writes:
>=20
>> Currently, single threaded TCG with > 1 VCPU gets stuck during IPL, wh=
en
>> the bios tries to switch to the loaded kernel via DIAG 308.
>>
>> pause_all_vcpus()/resume_all_vcpus() should not be called from a VCPU.
>>
>> And there is also no need for it. run_on_cpu() will make sure that the
>> CPUs exit KVM/TCG, where they get stopped. Once stopped, they will no
>> longer run.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  target/s390x/diag.c | 4 ----
>>  1 file changed, 4 deletions(-)
>>
>> diff --git a/target/s390x/diag.c b/target/s390x/diag.c
>> index dbbb9e886f..52bc348808 100644
>> --- a/target/s390x/diag.c
>> +++ b/target/s390x/diag.c
>> @@ -27,7 +27,6 @@ static int modified_clear_reset(S390CPU *cpu)
>>      S390CPUClass *scc =3D S390_CPU_GET_CLASS(cpu);
>>      CPUState *t;
>>
>> -    pause_all_vcpus();
>>      cpu_synchronize_all_states();
>>      CPU_FOREACH(t) {
>>          run_on_cpu(t, s390_do_cpu_full_reset, RUN_ON_CPU_NULL);
>=20
> I think you also need to fix the run_on_cpu to be a async_run_on_cpu as
> you would otherwise hang waiting for run_on_cpu to finish on a
> single-threaded TCG run (as you are in the only vCPU context).

No, it works just fine for single threaded TCG. run_on_cpu() can deal
with single threaded TCG just fine. (otherwise e.g. SIGP code also
wouldn't work)

In do_run_on_cpu, the following code always directly triggers for single
threaded tcg:

    if (qemu_cpu_is_self(cpu)) {

        func(cpu, data);

        return;

    }

>=20
> If it is important that the source vCPU doesn't continue you can
> schedule it's work afterwards with a async_safe_run_on_cpu which will
> complete after all other vCPUs have executed their work.
>=20

It is important. Introducing async helpers at a point where sync is
needed sounds strange.

Thanks!

>>
>> --
>> 2.13.6
>=20
>=20
> --
> Alex Benn=C3=A9e
>=20


--=20

Thanks,

David / dhildenb
