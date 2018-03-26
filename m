Received: from eggs.gnu.org ([2001:4830:134:3::10]:36597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1f0NYL-00080X-Ea
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 04:32:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1f0NYI-0005J1-C0
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 04:32:29 -0400
References: <1521156300-19296-1-git-send-email-akrowiak@linux.vnet.ibm.com>
	<1521156300-19296-7-git-send-email-akrowiak@linux.vnet.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <4d76348b-e1de-7d92-3434-5213d092c6d0@redhat.com>
Date: Mon, 26 Mar 2018 10:32:06 +0200
MIME-Version: 1.0
In-Reply-To: <1521156300-19296-7-git-send-email-akrowiak@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 6/7] s390x/kvm: handle AP instruction
 interception
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, bjsdjshi@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, eskultet@redhat.com, berrange@redhat.com, alex.williamson@redhat.com, eric.auger@redhat.com, pbonzini@redhat.com, peter.maydell@linaro.org, agraf@suse.de, rth@twiddle.net

On 16.03.2018 00:24, Tony Krowiak wrote:
> If the CPU model indicates that AP facility is installed on
> the guest (i.e., -cpu xxxx,ap=3Don), then the expectation is that
> the AP bus running in the guest will initialize; however, if the
> AP instructions are not being interpreted by the firmware, then
> they will be intercepted and routed back to QEMU for handling.
> If a handler is not defined to process the intercepted instruciton,
> then an operation exception will be injected into the
> guest, in which case the AP bus will not initialize.
>=20
> There are two situations where AP instructions will not be
> interpreted:
>=20
> 1. The guest is not configured with a vfio-ap device (i.e.,
>    -device vfio-ap,sysfsdev=3D$path-to-mdev). The realize function for
>    the vfio-ap device enables interpretive execution of AP
>    instructions.
>=20
> 2. The guest is a second level guest but the first level guest has
>    not enabled interpretive execution.
>=20
> This patch introduces AP instruction handlers to ensure the AP bus
> module initializes on the guest when the AP facility is installed
> on the guest but AP instructions are not being interpreted. The logic
> incorporated is:
>=20
> * If the CPU model indicates AP instructions are
>   installed
>=20
>   * Set the status response code for the instruction to indicate that
>     the APQN contained in the instruction is not valid. This is
>     a valid response because there will be no devices configured for
>     the guest in any of the above scenarios.
>=20
> * Else return an error from the handler. This will result in an
>   operation being injected into the guest and the AP bus will not

s/operation/operation exception/

>   initialize on the guest. That is commensurate with how things work
>   today.
>=20
> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
> ---
>  hw/vfio/ap.c                 |   45 ++++++++++++++++++++++++++++++++++=
++++++++
>  include/hw/s390x/ap-device.h |    6 +++++
>  target/s390x/kvm.c           |   14 +++++++++++++
>  3 files changed, 65 insertions(+), 0 deletions(-)
>=20
> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
> index b397bb1..88e744d 100644
> --- a/hw/vfio/ap.c
> +++ b/hw/vfio/ap.c
> @@ -148,6 +148,51 @@ static void vfio_ap_unrealize(DeviceState *dev, Er=
ror **errp)
>      kvm_s390_set_interpret_ap(0);
>  }
> =20

I think you are missing cpu_synchronize_state(CPU(cpu)) in all of these
functions.

> +int ap_device_handle_nqap(S390CPU *cpu)
> +{
> +    CPUS390XState *env =3D &cpu->env;
> +
> +    if (s390_has_feat(S390_FEAT_AP)) {
> +        env->regs[1] =3D 0x10000;
> +
> +        return 0;
> +    }
> +
> +    return -EOPNOTSUPP;
> +}
> +
> +int ap_device_handle_dqap(S390CPU *cpu)
> +{
> +    CPUS390XState *env =3D &cpu->env;
> +
> +    if (s390_has_feat(S390_FEAT_AP)) {
> +        env->regs[1] =3D 0x10000;
> +
> +        return 0;
> +    }
> +
> +    return -EOPNOTSUPP;
> +}
> +
> +int ap_device_handle_pqap(S390CPU *cpu)
> +{
> +    CPUS390XState *env =3D &cpu->env;
> +    int fc =3D 4 & (env->regs[0] >> 24);
> +
> +    /*
> +     * The Query Configuration Information (QCI) function (fc =3D=3D 4=
) does not
> +     * set a response code in reg 1, so check for that along with the
> +     * AP feature.
> +     */
> +    if ((fc !=3D 4) && s390_has_feat(S390_FEAT_AP)) {
> +        env->regs[1] =3D 0x10000;
> +
> +        return 0;
> +    }

This would imply an operation exception in case fc=3D=3D4, which sounds v=
ery
wrong.

Hard to review without access to documentation. (hard to understand why
such stuff is to be kept confidential for decades)

> +
> +    return -EOPNOTSUPP;
> +}
> +
>  static Property vfio_ap_properties[] =3D {
>      DEFINE_PROP_STRING("sysfsdev", VFIOAPDevice, vdev.sysfsdev),
>      DEFINE_PROP_END_OF_LIST(),
> diff --git a/include/hw/s390x/ap-device.h b/include/hw/s390x/ap-device.=
h
> index 693df90..d45ae38 100644
> --- a/include/hw/s390x/ap-device.h
> +++ b/include/hw/s390x/ap-device.h
> @@ -11,6 +11,8 @@
>  #ifndef HW_S390X_AP_DEVICE_H
>  #define HW_S390X_AP_DEVICE_H
> =20


--=20

Thanks,

David / dhildenb
