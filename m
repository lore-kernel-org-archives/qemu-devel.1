Received: from eggs.gnu.org ([2001:4830:134:3::10]:43523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fWRfK-00073t-US
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 15:24:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fWRfK-0003EX-5Z
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 15:24:14 -0400
References: <20180622134036.23182-1-f4bug@amsat.org>
	<20180622134036.23182-2-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <ceca80d5-7619-4afa-ce82-5870d7a235ad@redhat.com>
Date: Fri, 22 Jun 2018 21:24:04 +0200
MIME-Version: 1.0
In-Reply-To: <20180622134036.23182-2-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 01/14] hw/input/pckbd: Use
 qemu_log_mask(GUEST_ERROR) instead of fprintf
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, qemu-arm@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 22.06.2018 15:40, Philippe Mathieu-Daud=C3=A9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/input/pckbd.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/input/pckbd.c b/hw/input/pckbd.c
> index f33e3fc63d..26aeac2326 100644
> --- a/hw/input/pckbd.c
> +++ b/hw/input/pckbd.c
> @@ -22,6 +22,7 @@
>   * THE SOFTWARE.
>   */
>  #include "qemu/osdep.h"
> +#include "qemu/log.h"
>  #include "hw/hw.h"
>  #include "hw/isa/isa.h"
>  #include "hw/i386/pc.h"
> @@ -308,7 +309,8 @@ static void kbd_write_command(void *opaque, hwaddr =
addr,
>          /* ignore that */
>          break;
>      default:
> -        fprintf(stderr, "qemu: unsupported keyboard cmd=3D0x%02x\n", (=
int)val);
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "unsupported keyboard cmd=3D0x%02lx\n", val);

Sorry for not spotting it in v1 already, but val is a uint64_t value, so
you need PRIx64 as format string here, otherwise you'll get an error
with 32-bit compilers.

 Thomas
