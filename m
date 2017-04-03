Received: from eggs.gnu.org ([2001:4830:134:3::10]:47299)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chouteau@adacore.com>) id 1cv5H8-0001Ka-KP
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 12:56:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chouteau@adacore.com>) id 1cv5H5-00009o-CT
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 12:56:18 -0400
Received: from mel.act-europe.fr ([194.98.77.210]:44939
	helo=smtp.eu.adacore.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <chouteau@adacore.com>)
	id 1cv5H5-00008m-3V
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 12:56:15 -0400
References: <e72bc20d-9da1-255b-bc44-e6e8786799be@gmail.com>
From: Fabien Chouteau <chouteau@adacore.com>
Message-ID: <2677e4ce-5266-1492-6232-34bf700589e1@adacore.com>
Date: Mon, 3 Apr 2017 18:56:13 +0200
MIME-Version: 1.0
In-Reply-To: <e72bc20d-9da1-255b-bc44-e6e8786799be@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] LEON3 timer patch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gabriele Galeotti <gabriele.galeotti.xyz@gmail.com>, qemu-devel@nongnu.org

On 30/03/2017 21:30, Gabriele Galeotti wrote:
>=20
> Hi all.
> According to "GR712RC Dual-Core LEON3FT SPARC V8 Processor User=E2=80=99=
s Manual",
> "11.3 Registers", pg 87-88, Table 55 Timer control register, the IP "in=
terrupt pending"
> bit:
>=20
> Interrupt Pending (IP): The core sets this bit to =E2=80=981=E2=80=99 w=
hen an interrupt is signalled. This bit remains =E2=80=981=E2=80=99
> until cleared by writing =E2=80=980=E2=80=99 to this bit.
>=20
> Thus  the code handling should changed so that the pending bit is manta=
ined when "value" has a 1
> in that position.

Thanks Gabriele,

I think my implementation is based on the "GRLIB IP Core User' Manual"
which says "Interrupt Pending (IP): The core sets this bit to "1" when
an interrupt is signalled. This bit remains "1" until cleared by writing
"1" to this bit, writes of "0" have no effect."

Do you know why the two docs are different on that aspect?


>=20
> Signed-off-by: Gabriele Galeotti <gabriele.galeotti.xyz@gmail.com>
> ---
>  hw/timer/grlib_gptimer.c | 3 ---
>  1 file changed, 3 deletions(-)
>=20
> diff --git a/hw/timer/grlib_gptimer.c b/hw/timer/grlib_gptimer.c
> index 4ed96e9..c555ae8 100644
> --- a/hw/timer/grlib_gptimer.c
> +++ b/hw/timer/grlib_gptimer.c
> @@ -276,9 +276,6 @@ static void grlib_gptimer_write(void *opaque, hwadd=
r addr,
>              trace_grlib_gptimer_writel(id, addr, value);
> .
>              if (value & GPTIMER_INT_PENDING) {
> -                /* clear pending bit */
> -                value &=3D ~GPTIMER_INT_PENDING;
> -            } else {
>                  /* keep pending bit */
>                  value |=3D unit->timers[id].config & GPTIMER_INT_PENDI=
NG;
>              }

My understanding is that with your modifications, users can set the
pending bit by writing one to it.


I suggest something like this:

diff --git a/hw/timer/grlib_gptimer.c b/hw/timer/grlib_gptimer.c
index a05304d..4344787 100644
--- a/hw/timer/grlib_gptimer.c
+++ b/hw/timer/grlib_gptimer.c
@@ -275,11 +275,14 @@ static void grlib_gptimer_write(void *opaque, hwadd=
r addr,
         case CONFIG_OFFSET:
             trace_grlib_gptimer_writel(id, addr, value);

+            /* Interrupt pending. Remains 1 until cleared by writing 0 t=
o this
+             * bit.
+             */
             if (value & GPTIMER_INT_PENDING) {
-                /* clear pending bit */
+                /* Clear pending bit in value */
                 value &=3D ~GPTIMER_INT_PENDING;
-            } else {
-                /* keep pending bit */
+
+                /* Read current pending bit from register */
                 value |=3D unit->timers[id].config & GPTIMER_INT_PENDING=
;
             }


Regards,
