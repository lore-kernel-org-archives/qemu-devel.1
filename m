Received: from eggs.gnu.org ([2001:4830:134:3::10]:56974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eFRvu-0002CS-Hp
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 16:42:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eFRvp-0004Q6-M8
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 16:42:50 -0500
References: <20171116170526.12643-1-david@redhat.com>
	<20171116170526.12643-3-david@redhat.com>
	<e6289369-7e0f-7247-34b9-2f27df1c0edc@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <2c90a938-ce8e-e439-3cfa-ee7f175a646d@redhat.com>
Date: Thu, 16 Nov 2017 22:42:41 +0100
MIME-Version: 1.0
In-Reply-To: <e6289369-7e0f-7247-34b9-2f27df1c0edc@de.ibm.com>
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
To: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>

On 16.11.2017 21:57, Christian Borntraeger wrote:
> Please change the subject. In busy times I tend to ignore tcg patches.
> This code is clearly kvm and tcg.
> So what about "s390x/diag:" as prefix?

Right, it was a fix for TCG, that's why I added TCG only. But it should
have been purely s390x or s390x/diag.

>=20
> On 11/16/2017 06:05 PM, David Hildenbrand wrote:
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
>=20
>=20
> I did this to prevent a "still running CPU to restart an already stoppe=
d one".
> Are we sure that this can not happen?

Interesting question. I thought it would not be a problem but the way
locking with run_on_cpu() is handled is tricky. Now I am worried about a
couple of deadlocks.

pause_all_vcpus() actually gives up the qemu_global_mutex, so anybody
waiting for that mutex can continue.

We have a deadlock if two CPUs at the same time would call
pause_all_vcpus(). E.g. two CPUs executing at the same time a DIAG 308
(unlikely).

run_on_cpu temporarily gives up the qemu_global_mutex. If two CPUs call
a run_on_cpu at the same time against each other, we might also have a
deadlock.

Two CPUs simultaneously trying to send a SIGP START/STOP/RESTART cannot
run into a deadlock as they are protected by the SIGP mutex with a tryloc=
k.

So even with pause_all_vcpus() I think we have a problem if another CPU
sends a SIGP to the issuing DIAG CPU and expects the run_on_cpu to
trigger. Deadlock, but unlikely I assume?

Let's defer this patch for now, booting with 1 VCPU is not degraded and
it looked easier than it is.

Maybe fixing pause_all_vcpus() to work with more than one CPU in single
threaded TCG is an (easier) alternative and at least keeps the (tested)
state. 2.12 material.

--=20

Thanks,

David / dhildenb
