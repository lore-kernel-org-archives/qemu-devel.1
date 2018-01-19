Received: from eggs.gnu.org ([2001:4830:134:3::10]:57498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ecSSP-0002cg-DO
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 03:55:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ecSSK-000248-Iy
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 03:55:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52508)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ecSSK-00023p-0Q
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 03:55:24 -0500
References: <20180119084235.7100.98318.stgit@pasha-VirtualBox>
	<20180119084409.7100.23132.stgit@pasha-VirtualBox>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6abaddaf-96ee-d03c-0483-716f5317ed38@redhat.com>
Date: Fri, 19 Jan 2018 09:55:08 +0100
MIME-Version: 1.0
In-Reply-To: <20180119084409.7100.23132.stgit@pasha-VirtualBox>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v4 12/23] cpus: push BQL lock to
 qemu_*_wait_io_event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, boost.lists@gmail.com, quintela@redhat.com, jasowang@redhat.com, mst@redhat.com, zuban32s@gmail.com, maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru, kraxel@redhat.com, alex.bennee@linaro.org

On 19/01/2018 09:44, Pavel Dovgalyuk wrote:
>  static void qemu_wait_io_event(CPUState *cpu)
>  {
> +    qemu_mutex_lock_iothread();
> +
>      while (cpu_thread_is_idle(cpu)) {
>          qemu_cond_wait(cpu->halt_cond, &qemu_global_mutex);
>      }

This function locks the iothread and never unlocks it.  Please test your
patches better.

> @@ -1190,6 +1194,8 @@ static void *qemu_kvm_cpu_thread_fn(void *arg)
> =20
>      /* signal CPU creation */
>      cpu->created =3D true;
> +    qemu_mutex_unlock_iothread();
> +
>      qemu_cond_signal(&qemu_cpu_cond);
> =20
>      do {

This function calls qemu_wait_io_event with BQL not taken.

> @@ -1232,10 +1238,10 @@ static void *qemu_dummy_cpu_thread_fn(void *arg=
)
> =20
>      /* signal CPU creation */
>      cpu->created =3D true;
> +    qemu_mutex_unlock_iothread();
>      qemu_cond_signal(&qemu_cpu_cond);
> =20
>      while (1) {
> -        qemu_mutex_unlock_iothread();
>          do {
>              int sig;
>              r =3D sigwait(&waitset, &sig);
> @@ -1246,6 +1252,7 @@ static void *qemu_dummy_cpu_thread_fn(void *arg)
>          }
>          qemu_mutex_lock_iothread();
>          qemu_wait_io_event(cpu);
> +        qemu_mutex_unlock_iothread();

This function calls it with BQL taken.

Even without the mistakes, these changes are hard to follow.  If
possible, please separate the hax_vcpu_hax_exec and kvm_cpu_exec changes
to a separate patch.

Paolo
