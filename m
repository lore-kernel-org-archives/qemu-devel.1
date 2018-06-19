Received: from eggs.gnu.org ([2001:4830:134:3::10]:43517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fVGPg-0005q0-RR
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 09:11:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fVGPc-0007yJ-Tu
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 09:11:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60690 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fVGPc-0007y6-Nu
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 09:11:08 -0400
Date: Tue, 19 Jun 2018 14:11:02 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180619131102.GW20929@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180619105451.29163-1-contrib@steffen-goertz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180619105451.29163-1-contrib@steffen-goertz.de>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC] Add NRF51 RNG peripheral
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Steffen =?utf-8?B?R8O2cnR6?= <contrib@steffen-goertz.de>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@gmail.com>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>, Joel Stanley <joel@jms.id.au>

On Tue, Jun 19, 2018 at 06:54:51AM -0400, Steffen G=C3=B6rtz wrote:
> Add a model of the NRF51 RNG peripheral.
>=20
> Signed-off-by: Steffen G=C3=B6rtz <contrib@steffen-goertz.de>
> ---
>  hw/misc/Makefile.objs       |   1 +
>  hw/misc/nrf51_rng.c         | 241 ++++++++++++++++++++++++++++++++++++
>  include/hw/misc/nrf51_rng.h |  61 +++++++++
>  3 files changed, 303 insertions(+)
>  create mode 100644 hw/misc/nrf51_rng.c
>  create mode 100644 include/hw/misc/nrf51_rng.h
>=20

> +static void nrf51_rng_timer_expire(void *opaque) {
> +    Nrf51RNGState *s =3D NRF51_RNG(opaque);
> +
> +    qcrypto_random_bytes(&s->value, 1, NULL);

Passing NULL for the error object and ignoring return value is a
security flaw, because you'll be reporting non-random data to the
guest on failure. If you don't want to handle failure, then best
thing todo is pass  &error_abort so that QEMU terminates if the
RNG fails

> +
> +    s->state.event_valrdy =3D 1;
> +    qemu_set_irq(s->eep_valrdy, 1);
> +
> +    if(s->state.interrupt_enabled) {
> +        qemu_irq_pulse(s->irq);
> +    }
> +
> +    if(s->state.shortcut_stop_on_valrdy) {
> +        s->state.active =3D 0;
> +    }
> +
> +    rng_update_timer(s);
> +}

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
