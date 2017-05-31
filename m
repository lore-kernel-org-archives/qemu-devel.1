Received: from eggs.gnu.org ([2001:4830:134:3::10]:39826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1dG03q-0007YM-Sy
	for qemu-devel@nongnu.org; Wed, 31 May 2017 05:37:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1dG03m-000865-L5
	for qemu-devel@nongnu.org; Wed, 31 May 2017 05:37:02 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3887)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1dG03m-00084p-2A
	for qemu-devel@nongnu.org; Wed, 31 May 2017 05:36:58 -0400
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Wed, 31 May 2017 09:36:39 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA2BF967@DGGEMA505-MBX.china.huawei.com>
References: <1495865408-13848-1-git-send-email-arei.gonglei@huawei.com>
In-Reply-To: <1495865408-13848-1-git-send-email-arei.gonglei@huawei.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] kvm: don't register smram_listener when
 smm is off
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, Yechuan <yechuan@huawei.com>

Soft ping... :)



Regards,
-Gonglei


> -----Original Message-----
> From: Gonglei (Arei)
> Sent: Saturday, May 27, 2017 2:10 PM
> To: qemu-devel@nongnu.org
> Cc: pbonzini@redhat.com; Yechuan; Gonglei (Arei)
> Subject: [PATCH] kvm: don't register smram_listener when smm is off
>=20
> If the user set disable smm by '-machine smm=3Doff', we
> should not register smram_listener so that we can
> avoid waster memory in kvm since the added sencond
> address space.
>=20
> Meanwhile we should assign value of the global kvm_state
> before invoking the kvm_arch_init(), because
> pc_machine_is_smm_enabled() may use it by kvm_has_mm().
>=20
> Signed-off-by: Gonglei <arei.gonglei@huawei.com>
> ---
>  kvm-all.c         | 4 ++--
>  target/i386/kvm.c | 3 ++-
>  2 files changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/kvm-all.c b/kvm-all.c
> index 90b8573..92bdf2c 100644
> --- a/kvm-all.c
> +++ b/kvm-all.c
> @@ -1746,6 +1746,8 @@ static int kvm_init(MachineState *ms)
>      kvm_ioeventfd_any_length_allowed =3D
>          (kvm_check_extension(s, KVM_CAP_IOEVENTFD_ANY_LENGTH) >
> 0);
>=20
> +    kvm_state =3D s;
> +
>      ret =3D kvm_arch_init(ms, s);
>      if (ret < 0) {
>          goto err;
> @@ -1755,8 +1757,6 @@ static int kvm_init(MachineState *ms)
>          kvm_irqchip_create(ms, s);
>      }
>=20
> -    kvm_state =3D s;
> -
>      if (kvm_eventfds_allowed) {
>          s->memory_listener.listener.eventfd_add =3D
> kvm_mem_ioeventfd_add;
>          s->memory_listener.listener.eventfd_del =3D
> kvm_mem_ioeventfd_del;
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index 011d4a5..cb5b47e 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -1254,7 +1254,8 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>          }
>      }
>=20
> -    if (kvm_check_extension(s, KVM_CAP_X86_SMM)) {
> +    if (kvm_check_extension(s, KVM_CAP_X86_SMM) &&
> +            pc_machine_is_smm_enabled(PC_MACHINE(ms))) {
>          smram_machine_done.notify =3D register_smram_listener;
>          qemu_add_machine_init_done_notifier(&smram_machine_done);
>      }
> --
> 1.8.3.1
>=20
