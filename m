Received: from eggs.gnu.org ([2001:4830:134:3::10]:40083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ej09t-0005Xz-E8
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 05:07:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ej09o-0005i3-DW
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 05:07:25 -0500
References: <1517864246-11101-1-git-send-email-walling@linux.vnet.ibm.com>
	<1517864246-11101-12-git-send-email-walling@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <0024946c-b47e-14cd-0b30-3a8009f76342@redhat.com>
Date: Tue, 6 Feb 2018 11:07:12 +0100
MIME-Version: 1.0
In-Reply-To: <1517864246-11101-12-git-send-email-walling@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v5 11/12] s390-ccw: clear
 pending irqs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Collin L. Walling" <walling@linux.vnet.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: frankja@linux.vnet.ibm.com, cohuck@redhat.com, david@redhat.com, alifm@linux.vnet.ibm.com, mihajlov@linux.vnet.ibm.com, borntraeger@de.ibm.com, eblake@redhat.com

On 05.02.2018 21:57, Collin L. Walling wrote:
> It is possible while waiting for multiple types of external
> interrupts that we might have pending irqs remaining between
> irq consumption and irq disabling. Those interrupts could
> propagate to the guest after IPL completes and cause unwanted
> behavior.
>=20
> To avoid this, we clear the write event mask to prevent further
> service interrupts from ASCII events and then consume all pending
> irqs for a miniscule duration. Once finished, we reset the write
> event mask and resume business as usual.
>=20
> Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
> ---
>  pc-bios/s390-ccw/menu.c | 16 ++++++++++++++++
>  pc-bios/s390-ccw/sclp.c | 12 ++++++++++++
>  2 files changed, 28 insertions(+)
>=20
> diff --git a/pc-bios/s390-ccw/menu.c b/pc-bios/s390-ccw/menu.c
> index 85d285f..971f6b6 100644
> --- a/pc-bios/s390-ccw/menu.c
> +++ b/pc-bios/s390-ccw/menu.c
> @@ -64,6 +64,20 @@ static inline bool check_clock_int(void)
>      return *code =3D=3D 0x1004;
>  }
> =20
> +static void clear_pending_irqs(void)
> +{
> +    uint64_t time =3D 50 * TOD_CLOCK_SECOND / 0x3e8;

s/0x3e8/1000/ please.

> +    sclp_clear_write_mask();
> +
> +    set_clock_comparator(get_clock() + time);
> +    enable_clock_int();
> +    consume_sclp_int();
> +    disable_clock_int();
> +
> +    sclp_setup(); /* re-enable write mask */
> +}

I'm pretty much confused by this code. First, isn't there a small chance
that there is a clock int between consume_sclp_int() and
disable_clock_int() (if consume_sclp_int() has consumed an SCLP
interrupt instead of a clock interrupt) ?
Second, if you finally enable the SCLP write mask again, doesn't that
mean that there could be interrupts pending again afterwards?

 Thomas
