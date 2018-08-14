Received: from eggs.gnu.org ([2001:4830:134:3::10]:41416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fpSnA-0006BG-1z
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 02:26:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fpSn9-00074D-2S
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 02:26:56 -0400
References: <20180813163859.17964-1-cota@braap.org>
	<20180813163859.17964-2-cota@braap.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fc839a5e-9974-c4cf-1616-9f9f22f43350@redhat.com>
Date: Tue, 14 Aug 2018 08:26:49 +0200
MIME-Version: 1.0
In-Reply-To: <20180813163859.17964-2-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/3] qom: use cpu->in_cpu_list instead of
 QTAILQ_IN_USE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org

On 13/08/2018 18:38, Emilio G. Cota wrote:
> This paves the way for implementing the CPU list with an RCU QLIST.
>=20
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  cpus-common.c     | 3 ++-
>  include/qom/cpu.h | 2 ++
>  2 files changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/cpus-common.c b/cpus-common.c
> index 59f751ecf9..6eaedae60b 100644
> --- a/cpus-common.c
> +++ b/cpus-common.c
> @@ -85,6 +85,7 @@ void cpu_list_add(CPUState *cpu)
>          assert(!cpu_index_auto_assigned);
>      }
>      QTAILQ_INSERT_TAIL(&cpus, cpu, node);
> +    cpu->in_cpu_list =3D true;
>      qemu_mutex_unlock(&qemu_cpu_list_lock);
> =20
>      finish_safe_work(cpu);
> @@ -93,7 +94,7 @@ void cpu_list_add(CPUState *cpu)
>  void cpu_list_remove(CPUState *cpu)
>  {
>      qemu_mutex_lock(&qemu_cpu_list_lock);
> -    if (!QTAILQ_IN_USE(cpu, node)) {
> +    if (!cpu->in_cpu_list) {
>          /* there is nothing to undo since cpu_exec_init() hasn't been =
called */
>          qemu_mutex_unlock(&qemu_cpu_list_lock);
>          return;
> diff --git a/include/qom/cpu.h b/include/qom/cpu.h
> index bd796579ee..aa555e27a7 100644
> --- a/include/qom/cpu.h
> +++ b/include/qom/cpu.h
> @@ -411,6 +411,8 @@ struct CPUState {
> =20
>      bool ignore_memory_transaction_failures;
> =20
> +    bool in_cpu_list; /* protected by qemu_cpu_list_lock */
> +
>      /* Note that this is accessed at the start of every TB via a negat=
ive
>         offset from AREG0.  Leave this field at the end so as to make t=
he
>         (absolute value) offset as small as possible.  This reduces cod=
e
>=20

Reviewwed-by: Paolo Bonzini <pbonzini@redhat.com>
