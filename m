Received: from eggs.gnu.org ([2001:4830:134:3::10]:38362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eADVo-0001Mg-Vk
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 07:18:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eADVk-00032d-2l
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 07:18:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57904)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eADVj-000325-SS
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 07:18:11 -0400
References: <20171031112457.10516.8971.stgit@pasha-VirtualBox>
	<20171031112644.10516.1734.stgit@pasha-VirtualBox>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a8979594-78e4-13dc-2958-f7b4444a1bb0@redhat.com>
Date: Thu, 2 Nov 2017 12:17:51 +0100
MIME-Version: 1.0
In-Reply-To: <20171031112644.10516.1734.stgit@pasha-VirtualBox>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 19/26] cpu-exec: reset exit flag before
 calling cpu_exec_nocache
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

On 31/10/2017 12:26, Pavel Dovgalyuk wrote:
> This patch resets icount_decr.u32.high before calling cpu_exec_nocache
> when exception is pending. Exception is caused by the first instruction
> in the block and it cannot be executed without resetting the flag.
>=20
> Signed-off-by: Maria Klimushenkova <maria.klimushenkova@ispras.ru>
> Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
>=20
> ---
>  accel/tcg/cpu-exec.c |    1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> index 35d0240..aaa9c2d 100644
> --- a/accel/tcg/cpu-exec.c
> +++ b/accel/tcg/cpu-exec.c
> @@ -500,6 +500,7 @@ static inline bool cpu_handle_exception(CPUState *c=
pu, int *ret)
>      } else if (replay_has_exception()
>                 && cpu->icount_decr.u16.low + cpu->icount_extra =3D=3D =
0) {
>          /* try to cause an exception pending in the log */
> +        atomic_set(&cpu->icount_decr.u16.high, 0);
>          cpu_exec_nocache(cpu, 1, tb_find(cpu, NULL, 0, curr_cflags()),=
 true);
>          *ret =3D -1;
>          return true;
>=20

I am not sure about this.  I think if instead you should return false=20
from here and EXCP_INTERRUPT from cpu_exec.

More important: there is still a race, because high can be set to -1=20
right after your atomic_set.  Maybe:

1) you should only return true if cpu->exception_index was set by=20
cpu_exec_nocache?

2) you should not do

    *ret =3D -1;
    return true;

and instead do

    if (cpu->exception_index < 0 &&
        replay_has_exception() &&
        cpu->icount_decr.u16.low + cpu->icount_extra =3D=3D 0) {
           /* try to cause an exception pending in the log */
           cpu_exec_nocache(cpu, 1, tb_find(cpu, NULL, 0, curr_cflags()),=
 true);
        }
    }
    if (cpu->exception_index >=3D 0) {
        ...
    }
    return false;

Paolo
