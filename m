Received: from eggs.gnu.org ([209.51.188.92]:52480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1go2QL-0005Pq-RL
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 03:37:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1go2QK-0003ty-PY
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 03:37:45 -0500
References: <20190127101836.15451-1-sourav.jb1988@gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <33a499ed-6f6a-ccd2-a1f8-48646b6be6c9@redhat.com>
Date: Mon, 28 Jan 2019 09:37:29 +0100
MIME-Version: 1.0
In-Reply-To: <20190127101836.15451-1-sourav.jb1988@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/input/lm832x: set device category of
 lm832x
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kumar sourav <sourav.jb1988@gmail.com>, qemu-trivial@nongnu.org
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org

 Hi,

On 2019-01-27 11:18, kumar sourav wrote:
> Sets the category of lm832x as DEVICE_CATEGORY_INPUT
> Devices should be assigned to one of DEVICE_CATEGORY_XXXX
>=20
> Signed-off-by: kumar sourav <sourav.jb1988@gmail.com>
> ---
>  hw/input/lm832x.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/hw/input/lm832x.c b/hw/input/lm832x.c
> index cffbf586d4..07ae5e0aee 100644
> --- a/hw/input/lm832x.c
> +++ b/hw/input/lm832x.c
> @@ -509,6 +509,7 @@ static void lm8323_class_init(ObjectClass *klass, v=
oid *data)
>      k->recv =3D lm_i2c_rx;
>      k->send =3D lm_i2c_tx;
>      dc->vmsd =3D &vmstate_lm_kbd;
> +    set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
>  }

This device already has DEVICE_CATEGORY_MISC set since it is derived
from TYPE_I2C_SLAVE. If you now set another category bit here, the
device shows up twice in the output of "-device help". That's not so nice=
.

I see multiple options here:

1) Drop this patch since the device already has a category

2) Make sure to clear_bit() the MISC category here again

3) Remove the set_bit(DEVICE_CATEGORY_MISC, k->categories) in
   hw/i2c/core.c - it does not make that much sense to set the
   MISC category for an abstract parent class.

4) Introduce a new DEVICE_CATEGORY_I2C which could be used
   instead of the DEVICE_CATEGORY_MISC in hw/i2c/core.c

One of the last two options sound most appealing to me.

 Thomas
