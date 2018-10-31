Received: from eggs.gnu.org ([2001:4830:134:3::10]:56220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <afaerber@suse.de>) id 1gHn28-0007vn-Uf
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 05:43:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <afaerber@suse.de>) id 1gHn20-0000dy-2U
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 05:43:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:52046 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <afaerber@suse.de>) id 1gHn1y-0000ZJ-K4
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 05:43:19 -0400
References: <20180718104836.18488-1-michael@walle.cc>
	<20180718104836.18488-2-michael@walle.cc>
	<190b51b02841b1259a3a35b950f01cf3@walle.cc>
From: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Message-ID: <feb4d8b6-1e10-ffd3-bac8-a09898c845eb@suse.de>
Date: Wed, 31 Oct 2018 10:43:10 +0100
MIME-Version: 1.0
In-Reply-To: <190b51b02841b1259a3a35b950f01cf3@walle.cc>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: Michael Walle <michael@walle.cc>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

Am 31.10.18 um 09:31 schrieb Michael Walle:
> Am 2018-07-18 12:48, schrieb Michael Walle:
>> It is only possible to retrieve the current state of an interrupt
>> line. But
>> there are devices which just pulses the interrupt line. Introduce a la=
tch
>> which is set by qtest and which can be cleared by the test case.
>>
>> Signed-off-by: Michael Walle <michael@walle.cc>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Andreas F=C3=A4rber <afaerber@suse.de>
>=20
> Hi,
>=20
> unfortunately, there was never any feedback. Are you ok with this patch
> in general? There is still one patch for an additional test case in my
> queue, which depends on this.

No objection from my side, but Paolo may be a better reviewer for irq.

Regards,
Andreas

>=20
> -michael
>=20
>> ---
>> =C2=A0tests/libqtest.c | 19 +++++++++++++++++++
>> =C2=A0tests/libqtest.h | 40 ++++++++++++++++++++++++++++++++++++++++
>> =C2=A02 files changed, 59 insertions(+)
>>
>> diff --git a/tests/libqtest.c b/tests/libqtest.c
>> index 098af6aec4..85e1f6f92a 100644
>> --- a/tests/libqtest.c
>> +++ b/tests/libqtest.c
>> @@ -40,6 +40,7 @@ struct QTestState
>> =C2=A0=C2=A0=C2=A0=C2=A0 int fd;
>> =C2=A0=C2=A0=C2=A0=C2=A0 int qmp_fd;
>> =C2=A0=C2=A0=C2=A0=C2=A0 bool irq_level[MAX_IRQ];
>> +=C2=A0=C2=A0=C2=A0 bool irq_latch[MAX_IRQ];
>> =C2=A0=C2=A0=C2=A0=C2=A0 GString *rx;
>> =C2=A0=C2=A0=C2=A0=C2=A0 pid_t qemu_pid;=C2=A0 /* our child QEMU proce=
ss */
>> =C2=A0=C2=A0=C2=A0=C2=A0 bool big_endian;
>> @@ -233,6 +234,7 @@ QTestState *qtest_init_without_qmp_handshake(bool
>> use_oob,
>> =C2=A0=C2=A0=C2=A0=C2=A0 s->rx =3D g_string_new("");
>> =C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < MAX_IRQ; i++) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->irq_level[i] =3D f=
alse;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->irq_latch[i] =3D false;
>> =C2=A0=C2=A0=C2=A0=C2=A0 }
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0 if (getenv("QTEST_STOP")) {
>> @@ -386,6 +388,7 @@ redo:
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (strcmp(words[1], =
"raise") =3D=3D 0) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 s->irq_level[irq] =3D true;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s-=
>irq_latch[irq] =3D true;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 s->irq_level[irq] =3D false;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> @@ -678,6 +681,22 @@ bool qtest_get_irq(QTestState *s, int num)
>> =C2=A0=C2=A0=C2=A0=C2=A0 return s->irq_level[num];
>> =C2=A0}
>>
>> +bool qtest_get_irq_latched(QTestState *s, int num)
>> +{
>> +=C2=A0=C2=A0=C2=A0 g_assert_cmpint(num, <, MAX_IRQ);
>> +
>> +=C2=A0=C2=A0=C2=A0 /* dummy operation in order to make sure irq is up=
 to date */
>> +=C2=A0=C2=A0=C2=A0 qtest_inb(s, 0);
>> +
>> +=C2=A0=C2=A0=C2=A0 return s->irq_latch[num];
>> +}
>> +
>> +void qtest_clear_irq_latch(QTestState *s, int num)
>> +{
>> +=C2=A0=C2=A0=C2=A0 g_assert_cmpint(num, <, MAX_IRQ);
>> +=C2=A0=C2=A0=C2=A0 s->irq_latch[num] =3D false;
>> +}
>> +
>> =C2=A0static int64_t qtest_clock_rsp(QTestState *s)
>> =C2=A0{
>> =C2=A0=C2=A0=C2=A0=C2=A0 gchar **words;
>> diff --git a/tests/libqtest.h b/tests/libqtest.h
>> index ac52872cbe..721dd50863 100644
>> --- a/tests/libqtest.h
>> +++ b/tests/libqtest.h
>> @@ -192,6 +192,24 @@ char *qtest_hmpv(QTestState *s, const char *fmt,
>> va_list ap);
>> =C2=A0bool qtest_get_irq(QTestState *s, int num);
>>
>> =C2=A0/**
>> + * qtest_get_irq_latched:
>> + * @s: #QTestState instance to operate on.
>> + * @num: Interrupt to observe.
>> + *
>> + * Returns: The latched state of the @num interrupt.
>> + */
>> +bool qtest_get_irq_latched(QTestState *s, int num);
>> +
>> +/**
>> + * qtest_clear_irq_latch:
>> + * @s: #QTestState instance to operate on.
>> + * @num: Interrupt to operate on.
>> + *
>> + * Clears the latch of the @num interrupt.
>> + */
>> +void qtest_clear_irq_latch(QTestState *s, int num);
>> +
>> +/**
>> =C2=A0 * qtest_irq_intercept_in:
>> =C2=A0 * @s: #QTestState instance to operate on.
>> =C2=A0 * @string: QOM path of a device.
>> @@ -638,6 +656,28 @@ static inline bool get_irq(int num)
>> =C2=A0}
>>
>> =C2=A0/**
>> + * get_irq_latched:
>> + * @num: Interrupt to observe.
>> + *
>> + * Returns: The latched level of the @num interrupt.
>> + */
>> +static inline bool get_irq_latched(int num)
>> +{
>> +=C2=A0=C2=A0=C2=A0 return qtest_get_irq_latched(global_qtest, num);
>> +}
>> +
>> +/**
>> + * clear_irq_latch:
>> + * @num: Interrupt to operate on.
>> + *
>> + * Clears the latch of the @num interrupt.
>> + */
>> +static inline void clear_irq_latch(int num)
>> +{
>> +=C2=A0=C2=A0=C2=A0 return qtest_clear_irq_latch(global_qtest, num);
>> +}
>> +
>> +/**
>> =C2=A0 * irq_intercept_in:
>> =C2=A0 * @string: QOM path of a device.
>> =C2=A0 *


--=20
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
GF: Felix Imend=C3=B6rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N=C3=BCrnberg)
