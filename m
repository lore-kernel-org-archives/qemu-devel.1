Received: from eggs.gnu.org ([2001:4830:134:3::10]:41329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1degcx-0005FA-B9
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 07:55:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1degcs-00010k-DB
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 07:55:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55238)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1degcs-0000zP-3T
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 07:55:14 -0400
References: <150210580404.1343.7325713896658799315.stgit@bahia.lan>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <77c63a1b-92f9-8fc5-dbf5-855c28adc03d@redhat.com>
Date: Mon, 7 Aug 2017 13:55:09 +0200
MIME-Version: 1.0
In-Reply-To: <150210580404.1343.7325713896658799315.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] kvm: workaround build break on
 gcc-7.1.1 / fedora26
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 07/08/2017 13:36, Greg Kurz wrote:
> Building QEMU on fedora26 with the latest gcc package fails:
>=20
>   CC      ppc64-softmmu/target/ppc/kvm.o
> In file included from include/sysemu/hw_accel.h:16:0,
>                  from target/ppc/kvm.c:31:
> target/ppc/kvm.c: In function =E2=80=98kvmppc_booke_watchdog_enable=E2=80=
=99:
> include/sysemu/kvm.h:449:35: error: =E2=80=98args_tmp[i]=E2=80=99 may b=
e used uninitialized
>  in this function [-Werror=3Dmaybe-uninitialized]
>              cap.args[i] =3D args_tmp[i];                              =
 \
>                                    ^
> target/ppc/kvm.c: In function =E2=80=98kvmppc_set_papr=E2=80=99:
> include/sysemu/kvm.h:449:35: error: =E2=80=98args_tmp[i]=E2=80=99 may b=
e used uninitialized
>  in this function [-Werror=3Dmaybe-uninitialized]
> cc1: all warnings being treated as errors
>=20
> $ rpm -q gcc
> gcc-7.1.1-3.fc26.ppc64le
>=20
> The compiler should obviously optimize this code away when no extra
> agument is passed to kvm_vm_enable_cap() and kvm_vcpu_enable_cap(),
> but it doesn't. This bug should be fixed one day in gcc, but we can
> also change our code pattern so that we don't hit the issue anymore.
> We workaround this, by using memcpy() instead of open-coding the copy.

Nice way to do it, thanks.  I'll queue it for 2.10.

Paolo

> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
> v2: - use memcpy()
> ---
>  include/sysemu/kvm.h |   14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
>=20
> diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
> index 91fc07ee9afe..3a458f50e9f4 100644
> --- a/include/sysemu/kvm.h
> +++ b/include/sysemu/kvm.h
> @@ -428,11 +428,8 @@ int kvm_vm_check_extension(KVMState *s, unsigned i=
nt extension);
>              .flags =3D cap_flags,                                     =
 \
>          };                                                           \
>          uint64_t args_tmp[] =3D { __VA_ARGS__ };                      =
 \
> -        int i;                                                       \
> -        for (i =3D 0; i < (int)ARRAY_SIZE(args_tmp) &&                =
 \
> -                     i < ARRAY_SIZE(cap.args); i++) {                \
> -            cap.args[i] =3D args_tmp[i];                              =
 \
> -        }                                                            \
> +        size_t n =3D MIN(ARRAY_SIZE(args_tmp), ARRAY_SIZE(cap.args)); =
 \
> +        memcpy(cap.args, args_tmp, n * sizeof(cap.args[0]));         \
>          kvm_vm_ioctl(s, KVM_ENABLE_CAP, &cap);                       \
>      })
> =20
> @@ -443,11 +440,8 @@ int kvm_vm_check_extension(KVMState *s, unsigned i=
nt extension);
>              .flags =3D cap_flags,                                     =
 \
>          };                                                           \
>          uint64_t args_tmp[] =3D { __VA_ARGS__ };                      =
 \
> -        int i;                                                       \
> -        for (i =3D 0; i < (int)ARRAY_SIZE(args_tmp) &&                =
 \
> -                     i < ARRAY_SIZE(cap.args); i++) {                \
> -            cap.args[i] =3D args_tmp[i];                              =
 \
> -        }                                                            \
> +        size_t n =3D MIN(ARRAY_SIZE(args_tmp), ARRAY_SIZE(cap.args)); =
 \
> +        memcpy(cap.args, args_tmp, n * sizeof(cap.args[0]));         \
>          kvm_vcpu_ioctl(cpu, KVM_ENABLE_CAP, &cap);                   \
>      })
> =20
>=20
