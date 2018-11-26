Received: from eggs.gnu.org ([2001:4830:134:3::10]:45964)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gREex-00031Q-VB
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 06:02:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gREet-0007vV-T9
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 06:02:35 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:34475)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gREer-0007r5-UD
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 06:02:31 -0500
Received: by mail-wr1-x443.google.com with SMTP id j2so18425441wrw.1
	for <qemu-devel@nongnu.org>; Mon, 26 Nov 2018 03:02:26 -0800 (PST)
References: <20181025172057.20414-1-cota@braap.org>
	<20181025172057.20414-20-cota@braap.org>
	<87r2fbhgok.fsf@linaro.org> <20181123231528.GA13782@flamenco>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181123231528.GA13782@flamenco>
Date: Mon, 26 Nov 2018 11:02:24 +0000
Message-ID: <87va4k3xvj.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC 19/48] translate-all: notify plugin code of
 tb_flush
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, =?utf-8?Q?Llu=C3=ADs?= Vilanova <vilanova@ac.upc.edu>, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>


Emilio G. Cota <cota@braap.org> writes:

> On Fri, Nov 23, 2018 at 17:00:59 +0000, Alex Benn=C3=A9e wrote:
>>
>> Emilio G. Cota <cota@braap.org> writes:
>>
>> > Signed-off-by: Emilio G. Cota <cota@braap.org>
>> > ---
>> >  accel/tcg/translate-all.c | 6 ++++++
>> >  1 file changed, 6 insertions(+)
>> >
>> > diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
>> > index 3423cf74db..1690e3fd5b 100644
>> > --- a/accel/tcg/translate-all.c
>> > +++ b/accel/tcg/translate-all.c
>> > @@ -1233,6 +1233,8 @@ static gboolean tb_host_size_iter(gpointer key, =
gpointer value, gpointer data)
>> >  /* flush all the translation blocks */
>> >  void do_tb_flush(CPUState *cpu, run_on_cpu_data tb_flush_count)
>> >  {
>> > +    bool did_flush =3D false;
>> > +
>> >      mmap_lock();
>> >      /* If it is already been done on request of another CPU,
>> >       * just retry.
>> > @@ -1240,6 +1242,7 @@ void do_tb_flush(CPUState *cpu, run_on_cpu_data =
tb_flush_count)
>> >      if (tb_ctx.tb_flush_count !=3D tb_flush_count.host_int) {
>> >          goto done;
>> >      }
>> > +    did_flush =3D true;
>> >
>> >      if (DEBUG_TB_FLUSH_GATE) {
>> >          size_t nb_tbs =3D tcg_nb_tbs();
>> > @@ -1265,6 +1268,9 @@ void do_tb_flush(CPUState *cpu, run_on_cpu_data =
tb_flush_count)
>> >
>> >  done:
>> >      mmap_unlock();
>> > +    if (did_flush) {
>> > +        qemu_plugin_flush_cb();
>> > +    }
>>
>> Are we introducing a race here?
>
> A race, how? We're in an async safe environment here, i.e. no other
> vCPU is running.

You are right, I was thrown by the mmap_lock/unlocks - but I guess even
they aren't needed now if tb flush is always in an exclusive context.

>
>> What is the purpose of letting the plugin know a flush has occurred?
>
> Plugins might allocate per-TB data that then they get passed each
> time the TB is executed (via the *userdata pointer). For example,
> in a simulator we'd allocate a per-TB struct that describes the
> guest instructions, after having disassembled them at translate time.
>
> It is therefore useful for plugins to know when all TB's have been
> flushed, so that they can then free that per-TB data.

Would they need a generation count propagated here or would it just be
flush anything translation related at this point?

>> It shouldn't have any knowledge of the details of liveliness of the
>> translated code and if it still exits or not. If all it wants to do is
>> look at the counts then I think we can provide a simpler less abuse-able
>> way to do this.
>
> I'm confused. What does "look at the counts" mean here?
>
> To reiterate, plugins should have a way to know when a TB doesn't
> exist any longer, so that they can reclaim memory.

OK that makes sense. Could you expand the commit message just to explain
the use case?

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--
Alex Benn=C3=A9e
