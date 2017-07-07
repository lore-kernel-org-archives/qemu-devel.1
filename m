Received: from eggs.gnu.org ([2001:4830:134:3::10]:52037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dTPVy-0006lR-SC
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 05:25:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dTPVv-0007iw-Nc
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 05:25:30 -0400
Received: from roura.ac.upc.edu ([147.83.33.10]:48619 helo=roura.ac.upc.es)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dTPVv-0007c5-At
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 05:25:27 -0400
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <149865219962.17063.10630533069463266646.stgit@frigg.lan>
	<149865462073.17063.17488435214703164893.stgit@frigg.lan>
	<20170630004134.GJ13979@flamenco>
Date: Fri, 07 Jul 2017 11:25:09 +0200
In-Reply-To: <20170630004134.GJ13979@flamenco> (Emilio G. Cota's message of
	"Thu, 29 Jun 2017 20:41:34 -0400")
Message-ID: <87h8yofvka.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v11 10/29] target/i386: [tcg] Refactor
 translate_insn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>

Emilio G Cota writes:

> On Wed, Jun 28, 2017 at 15:57:00 +0300, Llu=C3=ADs Vilanova wrote:
>> Incrementally paves the way towards using the generic instruction transl=
ation
>> loop.
>>=20
>> Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
>> ---
>> target/i386/translate.c |   72 +++++++++++++++++++++++++++++++----------=
------
>> 1 file changed, 48 insertions(+), 24 deletions(-)
>>=20
>> diff --git a/target/i386/translate.c b/target/i386/translate.c
>> index 3eee348de7..da4b409d97 100644
>> --- a/target/i386/translate.c
>> +++ b/target/i386/translate.c
>> @@ -4420,15 +4420,17 @@ static void gen_sse(CPUX86State *env, DisasConte=
xt *s, int b,
>>=20
>> /* convert one instruction. s->base.is_jmp is set if the translation must
>> be stopped. Return the next pc value */
>> -static target_ulong disas_insn(CPUX86State *env, DisasContext *s,
>> -                               target_ulong pc_start)
>> +static target_ulong disas_insn(DisasContextBase *dcbase, CPUState *cpu)
>> {
>> +    DisasContext *s =3D container_of(dcbase, DisasContext, base);
>> +    CPUX86State *env =3D cpu->env_ptr;

> Minor nit: you can pass dc (*s) here directly, no need for container_of
[...]

I prefer not to so that the code will work in the future (i.e., not assumin=
g the
location of base inside disascontext).


Thanks,
  Lluis
