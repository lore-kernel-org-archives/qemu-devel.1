Received: from eggs.gnu.org ([2001:4830:134:3::10]:34550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fW24c-0007rz-PT
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 12:04:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fW24X-0002C7-Mc
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 12:04:38 -0400
References: <20180424101859.10239-1-david@redhat.com>
	<7c046e3c-8752-87c5-f4ff-06ef56ef0128@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <c4c55b6f-8ac0-5001-776e-86c28b33142a@redhat.com>
Date: Thu, 21 Jun 2018 18:04:29 +0200
MIME-Version: 1.0
In-Reply-To: <7c046e3c-8752-87c5-f4ff-06ef56ef0128@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1] s390x: refactor reset/reipl handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 21.06.2018 17:49, Christian Borntraeger wrote:
>=20
>=20
> On 04/24/2018 12:18 PM, David Hildenbrand wrote:
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
>=20
> Ok, this breaks the s390 IPL process when -no-reboot  is specified.
> The bios does a diagnose 308 subcode 1 to jump to the final image while
> at the same time resetting all devices. This is now blocked with -no-re=
boot
> (although it is actually the boot)

Indeed, one corner case I missed, thanks for looking into it.

I wonder if we could turn that into a allow "one
S390_RESET_MODIFIED_CLEAR ignoring -no-reboot" if booting from bios
using a simple flag.

Then s/SHUTDOWN_CAUSE_GUEST_RESET/SHUTDOWN_CAUSE_BIOS_RESET/

>=20
>=20
> I have noticed that with virt-install on iso images since virt-install
> specifies -no-reboot.
>=20
> Something like this seems to help but it is not a nice solution.
>=20
> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> index 0d67349004..7b32698eaa 100644
> --- a/hw/s390x/ipl.c
> +++ b/hw/s390x/ipl.c
> @@ -534,8 +534,14 @@ void s390_ipl_reset_request(CPUState *cs, enum s39=
0_reset reset_type)
>               */
>              ipl->iplb_valid =3D s390_gen_initial_iplb(ipl);
>          }
> +        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
> +    } else  if (reset_type =3D=3D S390_RESET_MODIFIED_CLEAR ||
> +                reset_type =3D=3D S390_RESET_LOAD_NORMAL) {
> +	/* ignore -no-reboot */
> +        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET_FORCE);
> +    } else {
> +        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
>      }
> -    qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
>      /* as this is triggered by a CPU, make sure to exit the loop */
>      if (tcg_enabled()) {
>          cpu_loop_exit(cs);
> diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
> index e893f72f3b..e9b11fd6cb 100644
> --- a/include/sysemu/sysemu.h
> +++ b/include/sysemu/sysemu.h
> @@ -44,6 +44,9 @@ typedef enum ShutdownCause {
>                                       turns that into a shutdown */
>      SHUTDOWN_CAUSE_GUEST_PANIC,   /* Guest panicked, and command line =
turns
>                                       that into a shutdown */
> +    SHUTDOWN_CAUSE_GUEST_RESET_FORCE,/* Guest reset that should ignore=
 --no-reboot
> +                                     useful for the subsystem resets o=
n s390 done
> +                                     for kdump and kexec */

I don't think it is that ugly.

>      SHUTDOWN_CAUSE__MAX,
>  } ShutdownCause;
> =20
> diff --git a/vl.c b/vl.c
> index b3426e03d0..18f379e833 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -1674,7 +1674,9 @@ void qemu_system_guest_panicked(GuestPanicInforma=
tion *info)
> =20
>  void qemu_system_reset_request(ShutdownCause reason)
>  {
> -    if (no_reboot) {
> +    if (reason =3D=3D SHUTDOWN_CAUSE_GUEST_RESET_FORCE) {
> +	    reset_requested =3D SHUTDOWN_CAUSE_GUEST_RESET;
> +    } else if (no_reboot) {
>          shutdown_requested =3D reason;
>      } else {
>          reset_requested =3D reason;
>=20


--=20

Thanks,

David / dhildenb
