Received: from eggs.gnu.org ([2001:4830:134:3::10]:38137)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <michael@walle.cc>) id 1gHluu-0003w0-6I
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 04:31:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <michael@walle.cc>) id 1gHluq-0004sk-Hz
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 04:31:56 -0400
Received: from ssl.serverraum.org ([2a01:4f8:151:8464::1:2]:56963)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <michael@walle.cc>) id 1gHluo-0004jI-Lc
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 04:31:51 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Wed, 31 Oct 2018 09:31:34 +0100
From: Michael Walle <michael@walle.cc>
In-Reply-To: <20180718104836.18488-2-michael@walle.cc>
References: <20180718104836.18488-1-michael@walle.cc>
	<20180718104836.18488-2-michael@walle.cc>
Message-ID: <190b51b02841b1259a3a35b950f01cf3@walle.cc>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/3] qtest: new functions for pulsed IRQs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>

Am 2018-07-18 12:48, schrieb Michael Walle:
> It is only possible to retrieve the current state of an interrupt line.=
=20
> But
> there are devices which just pulses the interrupt line. Introduce a=20
> latch
> which is set by qtest and which can be cleared by the test case.
>=20
> Signed-off-by: Michael Walle <michael@walle.cc>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Andreas F=C3=A4rber <afaerber@suse.de>

Hi,

unfortunately, there was never any feedback. Are you ok with this patch=20
in general? There is still one patch for an additional test case in my=20
queue, which depends on this.

-michael

> ---
>  tests/libqtest.c | 19 +++++++++++++++++++
>  tests/libqtest.h | 40 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 59 insertions(+)
>=20
> diff --git a/tests/libqtest.c b/tests/libqtest.c
> index 098af6aec4..85e1f6f92a 100644
> --- a/tests/libqtest.c
> +++ b/tests/libqtest.c
> @@ -40,6 +40,7 @@ struct QTestState
>      int fd;
>      int qmp_fd;
>      bool irq_level[MAX_IRQ];
> +    bool irq_latch[MAX_IRQ];
>      GString *rx;
>      pid_t qemu_pid;  /* our child QEMU process */
>      bool big_endian;
> @@ -233,6 +234,7 @@ QTestState *qtest_init_without_qmp_handshake(bool=20
> use_oob,
>      s->rx =3D g_string_new("");
>      for (i =3D 0; i < MAX_IRQ; i++) {
>          s->irq_level[i] =3D false;
> +        s->irq_latch[i] =3D false;
>      }
>=20
>      if (getenv("QTEST_STOP")) {
> @@ -386,6 +388,7 @@ redo:
>=20
>          if (strcmp(words[1], "raise") =3D=3D 0) {
>              s->irq_level[irq] =3D true;
> +            s->irq_latch[irq] =3D true;
>          } else {
>              s->irq_level[irq] =3D false;
>          }
> @@ -678,6 +681,22 @@ bool qtest_get_irq(QTestState *s, int num)
>      return s->irq_level[num];
>  }
>=20
> +bool qtest_get_irq_latched(QTestState *s, int num)
> +{
> +    g_assert_cmpint(num, <, MAX_IRQ);
> +
> +    /* dummy operation in order to make sure irq is up to date */
> +    qtest_inb(s, 0);
> +
> +    return s->irq_latch[num];
> +}
> +
> +void qtest_clear_irq_latch(QTestState *s, int num)
> +{
> +    g_assert_cmpint(num, <, MAX_IRQ);
> +    s->irq_latch[num] =3D false;
> +}
> +
>  static int64_t qtest_clock_rsp(QTestState *s)
>  {
>      gchar **words;
> diff --git a/tests/libqtest.h b/tests/libqtest.h
> index ac52872cbe..721dd50863 100644
> --- a/tests/libqtest.h
> +++ b/tests/libqtest.h
> @@ -192,6 +192,24 @@ char *qtest_hmpv(QTestState *s, const char *fmt,
> va_list ap);
>  bool qtest_get_irq(QTestState *s, int num);
>=20
>  /**
> + * qtest_get_irq_latched:
> + * @s: #QTestState instance to operate on.
> + * @num: Interrupt to observe.
> + *
> + * Returns: The latched state of the @num interrupt.
> + */
> +bool qtest_get_irq_latched(QTestState *s, int num);
> +
> +/**
> + * qtest_clear_irq_latch:
> + * @s: #QTestState instance to operate on.
> + * @num: Interrupt to operate on.
> + *
> + * Clears the latch of the @num interrupt.
> + */
> +void qtest_clear_irq_latch(QTestState *s, int num);
> +
> +/**
>   * qtest_irq_intercept_in:
>   * @s: #QTestState instance to operate on.
>   * @string: QOM path of a device.
> @@ -638,6 +656,28 @@ static inline bool get_irq(int num)
>  }
>=20
>  /**
> + * get_irq_latched:
> + * @num: Interrupt to observe.
> + *
> + * Returns: The latched level of the @num interrupt.
> + */
> +static inline bool get_irq_latched(int num)
> +{
> +    return qtest_get_irq_latched(global_qtest, num);
> +}
> +
> +/**
> + * clear_irq_latch:
> + * @num: Interrupt to operate on.
> + *
> + * Clears the latch of the @num interrupt.
> + */
> +static inline void clear_irq_latch(int num)
> +{
> +    return qtest_clear_irq_latch(global_qtest, num);
> +}
> +
> +/**
>   * irq_intercept_in:
>   * @string: QOM path of a device.
>   *
