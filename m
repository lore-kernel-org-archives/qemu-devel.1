Received: from eggs.gnu.org ([2001:4830:134:3::10]:43347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fpSxn-0006II-BC
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 02:37:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fpSxm-0002Ty-81
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 02:37:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41928 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fpSxm-0002Tk-1S
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 02:37:54 -0400
References: <20180814013801.26036-1-cota@braap.org>
	<20180814013801.26036-2-cota@braap.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <54ac7b1f-7430-453f-cbba-b7fef74d3187@redhat.com>
Date: Tue, 14 Aug 2018 08:37:49 +0200
MIME-Version: 1.0
In-Reply-To: <20180814013801.26036-2-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/4] hw/i386/pc: hold the BQL when calling
 cpu_get_ticks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 14/08/2018 03:37, Emilio G. Cota wrote:
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  hw/i386/pc.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 83a444472b..7371cd9960 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -158,7 +158,18 @@ static uint64_t ioportF0_read(void *opaque, hwaddr=
 addr, unsigned size)
>  /* TSC handling */
>  uint64_t cpu_get_tsc(CPUX86State *env)
>  {
> -    return cpu_get_ticks();
> +    uint64_t ret;
> +    bool locked;
> +
> +    locked =3D qemu_mutex_iothread_locked();
> +    if (!locked) {
> +        qemu_mutex_lock_iothread();
> +    }
> +    ret =3D cpu_get_ticks();
> +    if (!locked) {
> +        qemu_mutex_unlock_iothread();
> +    }
> +    return ret;
>  }
> =20
>  /* IRQ handling */
>=20

We could use a spinlock for the rare case of timers_state.cpu_ticks_prev
> ticks (or even, on 64-bit, a seqlock+spinlock).  I'll give it a shot.

Paolo
