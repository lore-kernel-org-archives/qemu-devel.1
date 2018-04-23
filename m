Received: from eggs.gnu.org ([2001:4830:134:3::10]:34373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fAhMD-00070A-7O
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 15:42:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fAhMA-0005f6-4B
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 15:42:37 -0400
References: <20180412192602.13430-1-david@redhat.com>
	<20180423124222.3c79c3fe.cohuck@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <7239f367-1661-bd0d-0625-b095df679f0f@redhat.com>
Date: Mon, 23 Apr 2018 21:42:23 +0200
MIME-Version: 1.0
In-Reply-To: <20180423124222.3c79c3fe.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC] s390x: refactor reset/reipl handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 23.04.2018 12:42, Cornelia Huck wrote:
> On Thu, 12 Apr 2018 21:26:02 +0200
> David Hildenbrand <david@redhat.com> wrote:
>=20
>> Calling pause_all_vcpus()/resume_all_vcpus() from a VCPU thread might
>> not be the best idea. As pause_all_vcpus() temporarily drops the qemu
>> mutex, two parallel calls to pause_all_vcpus() can be active at a time=
,
>> resulting in a deadlock. (either by two VCPUs or by the main thread an=
d a
>> VCPU)
>>
>> Let's handle it via the main loop instead, as suggested by Paolo. If w=
e
>> would have two parallel reset requests by two different VCPUs at the
>> same time, the last one would win.
>>
>> We use the existing ipl device to handle it. The nice side effect is
>> that we can get rid of reipl_requested.
>>
>> This change implies that all reset handling now goes via the common
>> path, so "no-reboot" handling is now active for all kinds of reboots.
>>
>> Let's execute any CPU initialization code on the target CPU using
>> run_on_cpu.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>
>> Did only a quick check with TCG. I think this way it is way easier to
>> control what is getting reset.
>=20
> Yes, I like this patch.
>=20
>>
>>  hw/s390x/ipl.c                     | 44 ++++++++++++++++++++++++---
>>  hw/s390x/ipl.h                     | 16 ++++++++--
>>  hw/s390x/s390-virtio-ccw.c         | 49 +++++++++++++++++++++++++----=
-
>>  include/hw/s390x/s390-virtio-ccw.h |  2 --
>>  target/s390x/cpu.h                 | 26 ++++++++++++++++
>>  target/s390x/diag.c                | 61 +++--------------------------=
---------
>>  target/s390x/internal.h            |  6 ----
>>  target/s390x/kvm.c                 |  2 +-
>>  8 files changed, 127 insertions(+), 79 deletions(-)
>>
>> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
>> index fb554ab156..f7589d20f1 100644
>> --- a/hw/s390x/ipl.c
>> +++ b/hw/s390x/ipl.c
>> @@ -26,6 +26,7 @@
>>  #include "qemu/config-file.h"
>>  #include "qemu/cutils.h"
>>  #include "qemu/option.h"
>> +#include "exec/exec-all.h"
>> =20
>>  #define KERN_IMAGE_START                0x010000UL
>>  #define KERN_PARM_AREA                  0x010480UL
>> @@ -484,11 +485,22 @@ IplParameterBlock *s390_ipl_get_iplb(void)
>>      return &ipl->iplb;
>>  }
>> =20
>> -void s390_reipl_request(void)
>> +void s390_ipl_reset_request(CPUState *cs, enum s390_reset reset_type)
>>  {
>>      S390IPLState *ipl =3D get_ipl_device();
>> =20
>> -    ipl->reipl_requested =3D true;
>> +    if (reset_type =3D=3D S390_RESET_EXTERNAL || reset_type =3D=3D S3=
90_RESET_REIPL) {
>> +        /* let's always use CPU 0 */
>> +        ipl->reset_cpu =3D NULL;
>> +    } else {
>> +        ipl->reset_cpu =3D cs;
>> +    }
>> +    ipl->reset_type =3D reset_type;
>> +
>> +    if (reset_type !=3D S390_RESET_REIPL) {
>=20
> Pull the check for S390_RESET_REIPL into the if condition below? Gets
> rid of the goto :)

Yes, that's the thing I was no realizing, while hacking on this. I
thought I would have to shift the whole block.

>=20
>> +        goto no_reipl;
>> +    }
>> +
>>      if (ipl->iplb_valid &&
>>          !ipl->netboot &&
>>          ipl->iplb.pbt =3D=3D S390_IPL_TYPE_CCW &&
>> @@ -505,7 +517,32 @@ void s390_reipl_request(void)
>>              ipl->iplb_valid =3D s390_gen_initial_iplb(ipl);
>>          }
>>      }
>> +no_reipl:
>>      qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
>> +    /* as this is triggered by a CPU, make sure to exit the loop */
>> +    if (tcg_enabled()) {
>> +        cpu_loop_exit(cs);
>> +    }
>> +}
>> +
>> +void s390_ipl_get_reset_request(CPUState **cs, enum s390_reset *reset=
_type)
>> +{
>> +    S390IPLState *ipl =3D get_ipl_device();
>> +
>> +    *cs =3D ipl->reset_cpu;
>> +    if (!ipl->reset_cpu) {
>> +        /* use CPU 0 as default */
>> +        *cs =3D qemu_get_cpu(0);
>=20
> That looks somewhat ugly. Maybe just stuff cpu 0 in there at init time?

Well, it's the same we already had just at a different place :)

>=20
> As an aside: Are we guaranteed to always have cpu 0? IIRC there was
> some code relying on that; but just grabbing an 'any' cpu looks more
> like what we want.

We will always create at least one CPU. The fist CPU will always be CPU
with ID 0. As cpu_index corresponds to ID for us, we will always get CPU
0 via qemu_get_cpu(). (and we don't have CPU unplug)

However I might just store the cpu id in there instead of an reference.
So we could "fallback" here to some random CPU that exists (in case
qemu_get_cpu()  returns NULL).

>=20
>> +    }
>> +    *reset_type =3D ipl->reset_type;
>> +}
>=20
>>  static void s390_machine_reset(void)
>>  {
>> -    S390CPU *ipl_cpu =3D S390_CPU(qemu_get_cpu(0));
>> +    enum s390_reset reset_type;
>> +    CPUState *cs, *t;
>> =20
>> +    /* get the reset parameters, reset them once done */
>> +    s390_ipl_get_reset_request(&cs, &reset_type);
>> +
>> +    /* all CPUs are paused and synchronized at this point */
>>      s390_cmma_reset();
>> -    qemu_devices_reset();
>> -    s390_crypto_reset();
>> =20
>> -    /* all cpus are stopped - configure and start the ipl cpu only */
>> -    s390_ipl_prepare_cpu(ipl_cpu);
>> -    s390_cpu_set_state(S390_CPU_STATE_OPERATING, ipl_cpu);
>> +    switch (reset_type) {
>> +    case S390_RESET_EXTERNAL:
>> +    case S390_RESET_REIPL:
>> +        qemu_devices_reset();
>> +        s390_crypto_reset();
>> +
>> +        /* configure and start the ipl CPU only */
>> +        run_on_cpu(cs, s390_do_cpu_ipl, RUN_ON_CPU_NULL);
>> +        break;
>> +    case S390_RESET_MODIFIED_CLEAR:
>> +        CPU_FOREACH(t) {
>> +            run_on_cpu(t, s390_do_cpu_full_reset, RUN_ON_CPU_NULL);
>> +        }
>> +        subsystem_reset();
>> +        s390_crypto_reset();
>> +        run_on_cpu(cs, s390_do_cpu_load_normal, RUN_ON_CPU_NULL);
>> +        break;
>> +    case S390_RESET_LOAD_NORMAL:
>> +        CPU_FOREACH(t) {
>> +            run_on_cpu(t, s390_do_cpu_reset, RUN_ON_CPU_NULL);
>> +        }
>> +        subsystem_reset();
>> +        run_on_cpu(cs, s390_do_cpu_initital_reset, RUN_ON_CPU_NULL);
>=20
> 'initital' looks like a typo; 'initial'?

I keep making this spelling error over and over again :D (I think my
brain memorized how to type "initial" fast, the wrong way)

Thanks!

>=20
> (But you made the same typo twice, so it compiles :)
>=20
>> +        run_on_cpu(cs, s390_do_cpu_load_normal, RUN_ON_CPU_NULL);
>> +        break;
>=20
> Moan on default case hit?

Yes, makes sense!

>=20
>> +    }
>> +    s390_ipl_clear_reset_request();
>>  }
>> =20
>>  static void s390_machine_device_plug(HotplugHandler *hotplug_dev,

Thanks!

--=20

Thanks,

David / dhildenb
