Received: from eggs.gnu.org ([2001:4830:134:3::10]:56751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gHoSG-0006mn-Ra
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 07:14:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gHoSB-0001ds-LU
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 07:14:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59764)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1gHoSB-0001cL-0j
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 07:14:27 -0400
References: <20181031002526.14262-1-contrib@steffen-goertz.de>
	<20181031002526.14262-2-contrib@steffen-goertz.de>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <32aab4a3-7d7c-6361-43e0-913e68af906d@redhat.com>
Date: Wed, 31 Oct 2018 12:14:20 +0100
MIME-Version: 1.0
In-Reply-To: <20181031002526.14262-2-contrib@steffen-goertz.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 01/13] qtest: Add set_irq_in command to
 set IRQ/GPIO level
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Steffen_G=c3=b6rtz?= <contrib@steffen-goertz.de>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>

On 31/10/2018 01:25, Steffen G=C3=B6rtz wrote:
> Adds a new qtest command "set_irq_in" which allows
> to set qemu gpio lines to a given level.
>=20
> Based on https://lists.gnu.org/archive/html/qemu-devel/2012-12/msg02363=
.html
> which never got merged.
>=20
> Signed-off-by: Steffen G=C3=B6rtz <contrib@steffen-goertz.de>
> Originally-by: Matthew Ogilvie <mmogilvi_qemu@miniinfo.net>
> ---
>  qtest.c          | 40 ++++++++++++++++++++++++++++++++++++++++
>  tests/libqtest.c | 10 ++++++++++
>  tests/libqtest.h | 28 ++++++++++++++++++++++++++++
>  3 files changed, 78 insertions(+)
>=20
> diff --git a/qtest.c b/qtest.c
> index 69b9e9962b..214f42a6c5 100644
> --- a/qtest.c
> +++ b/qtest.c
> @@ -164,6 +164,14 @@ static bool qtest_opened;
>   * where NUM is an IRQ number.  For the PC, interrupts can be intercep=
ted
>   * simply with "irq_intercept_in ioapic" (note that IRQ0 comes out wit=
h
>   * NUM=3D0 even though it is remapped to GSI 2).
> + *
> + * Setting interrupt level:
> + *
> + *  > set_irq_in QOM-PATH IRQ LEVEL

This seems not correct according to:

    qtest_sendf(s, "set_irq_in %s %s %d %d\n", qom_path, name, num,
                level);

> + *  < OK
> + *
> + * Forcibly set the given interrupt pin to the given level.
> + *
>   */
> =20
>  static int hex2nib(char ch)
> @@ -326,7 +334,39 @@ static void qtest_process_command(CharBackend *chr=
, gchar **words)
>          irq_intercept_dev =3D dev;
>          qtest_send_prefix(chr);
>          qtest_send(chr, "OK\n");
> +    } else if (strcmp(words[0], "set_irq_in") =3D=3D 0) {
> +        DeviceState *dev;
> +        qemu_irq irq;
> +        char *name;
> +        int ret;
> +        long num;

qdev_get_gpio_in_named() and qemu_set_irq() take an "int" for the "num"
and "level" parameters, perhaps we can match it here?

> +        long level;
> =20
> +        g_assert(words[1] && words[2] && words[3] && words[4]);
> +
> +        dev =3D DEVICE(object_resolve_path(words[1], NULL));
> +        if (!dev) {
> +            qtest_send_prefix(chr);
> +            qtest_send(chr, "FAIL Unknown device\n");
> +            return;
> +        }
> +
> +        if (strcmp(words[2], "unnamed-gpio-in") =3D=3D 0) {
> +            name =3D NULL;
> +        } else {
> +            name =3D words[2];
> +        }
> +
> +        ret =3D qemu_strtol(words[3], NULL, 10, &num);
> +        g_assert(!ret);
> +        ret =3D qemu_strtol(words[4], NULL, 10, &level);
> +        g_assert(!ret);

Why do you force base 10?

> +
> +        irq =3D qdev_get_gpio_in_named(dev, name, num);
> +
> +        qemu_set_irq(irq, level);
> +        qtest_send_prefix(chr);
> +        qtest_send(chr, "OK\n");
>      } else if (strcmp(words[0], "outb") =3D=3D 0 ||
>                 strcmp(words[0], "outw") =3D=3D 0 ||
>                 strcmp(words[0], "outl") =3D=3D 0) {
> diff --git a/tests/libqtest.c b/tests/libqtest.c
> index 44ce118cfc..1cbde0d91a 100644
> --- a/tests/libqtest.c
> +++ b/tests/libqtest.c
> @@ -732,6 +732,16 @@ void qtest_irq_intercept_in(QTestState *s, const c=
har *qom_path)
>      qtest_rsp(s, 0);
>  }
> =20
> +void qtest_set_irq_in(QTestState *s, const char *qom_path, const char =
*name,
> +                      int num, int level)
> +{
> +    if (!name) {
> +        name =3D "unnamed-gpio-in";
> +    }
> +    qtest_sendf(s, "set_irq_in %s %s %d %d\n", qom_path, name, num, le=
vel);

And here "num" and "level" are "int", so you should match this in qtest.c

Thanks,
Laurent
