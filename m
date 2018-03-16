Received: from eggs.gnu.org ([2001:4830:134:3::10]:33194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1ewwNw-0007xd-1J
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 16:55:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1ewwNt-0001vR-Vt
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 16:55:32 -0400
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:33043)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1ewwNt-0001ug-K9
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 16:55:29 -0400
Received: by mail-ot0-x244.google.com with SMTP id y11-v6so11723854otg.0
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 13:55:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAHNT7NuQVXscY4GGfL7EjCMkA3pjd-Qhtm7H9rY=AhU7L85twg@mail.gmail.com>
References: <1520629272-98060-1-git-send-email-mjc@sifive.com>
	<a407b0b4-17fc-e399-d0b1-c2eaf87a4836@amsat.org>
	<CAFEAcA_eaem+n79=DmSJnWYFQzrggAdab7H3hihnuq--=hy8kA@mail.gmail.com>
	<CAHNT7NuQVXscY4GGfL7EjCMkA3pjd-Qhtm7H9rY=AhU7L85twg@mail.gmail.com>
From: Michael Clark <mjc@sifive.com>
Date: Fri, 16 Mar 2018 13:55:28 -0700
Message-ID: <CAHNT7Nt06n_7wNw2Mx6s7=kF=d2M8VmQbL8G7108XKeQmM9r-g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] RISC-V: Fix riscv_isa_string,
 use popcount to count bits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, QEMU Developers <qemu-devel@nongnu.org>, Palmer Dabbelt <palmer@sifive.com>

On Fri, Mar 16, 2018 at 10:03 AM, Michael Clark <mjc@sifive.com> wrote:

>
> On Thu, Mar 15, 2018 at 12:27 PM, Peter Maydell <peter.maydell@linaro.org=
>
> wrote:
>
>> On 10 March 2018 at 21:25, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> wrote:
>> > On 03/09/2018 10:01 PM, Michael Clark wrote:
>> >> Logic bug caused the string size calculation for the RISC-V
>> >> format ISA string to be small. This fix allows slack for rv128.
>> >>
>> >> Cc: Palmer Dabbelt <palmer@sifive.com>
>> >> Cc: Peter Maydell <peter.maydell@linaro.org>
>> >> Cc: Eric Blake <eblake@redhat.com>
>> >> Signed-off-by: Michael Clark <mjc@sifive.com>
>> >> ---
>> >>  target/riscv/cpu.c | 2 +-
>> >>  1 file changed, 1 insertion(+), 1 deletion(-)
>> >>
>> >> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>> >> index 4851890..1456535 100644
>> >> --- a/target/riscv/cpu.c
>> >> +++ b/target/riscv/cpu.c
>> >> @@ -391,7 +391,7 @@ static const TypeInfo riscv_cpu_type_info =3D {
>> >>  char *riscv_isa_string(RISCVCPU *cpu)
>> >>  {
>> >>      int i;
>> >> -    size_t maxlen =3D 5 + ctz32(cpu->env.misa);
>> >> +    size_t maxlen =3D 8 + ctpop64(cpu->env.misa);
>> >
>> > Can you document the magic 5/8?
>> >
>> > This looks nice, but this seems to me too much optimization to save fe=
w
>> > bytes, using sizeof(riscv_exts) is overflow-free.
>> >
>> > Maybe this is enough and self-explanatory:
>> >
>> >        const size_t maxlen =3D sizeof("rv128") + sizeof(riscv_exts);
>> >
>> >>      char *isa_string =3D g_new0(char, maxlen);
>> >>      snprintf(isa_string, maxlen, "rv%d", TARGET_LONG_BITS);
>> >
>> > Also, if you keep the snprintf() return value, you can (naming it 'n')
>> > simplify (also easier to review):
>> >
>> >>      for (i =3D 0; i < sizeof(riscv_exts); i++) {
>> >>
>> >         if (cpu->env.misa & RV(riscv_exts[i])) {
>> > -           isa_string[strlen(isa_string)] =3D riscv_exts[i] - 'A' + '=
a';
>> > +           isa_string[n++] =3D tolower(riscv_exts[i]);
>> >         }
>> >     }
>> >
>> > and simply use g_new() with:
>> >
>> > +   isa_string[n] =3D '\0';
>> >
>> >     return isa_string;
>> > }
>>
>> Hi -- any chance of a respin of this patch that addresses Philippe's
>> review comments so we can fix it before rc0? This is causing
>> my merge-build tests to fail about 50% of the time on OpenBSD
>> at the moment...
>
>
> I'll respin asap.
>
> I was out earlier this week as I was at the RISC-V Hackathon at the
> Embedded Linux Conference in Portland. I also have to go through the revi=
ew
> backlog for the post merge spec conformance and cleanup series...
>

I've sent out the riscv_isa_string fix patch as well as the RISC-V
Post-merge spec conformance and cleanup series independently. I could
combine them so we have one post-merge PR that contains the riscv_isa_strin=
g
string fix, the spec conformance fixes and cleanup. Many of the cleanup
patches have been reviewed by Phil, but the patches that haven't been
reviewed are spec conformance fixes and likely require a reading of the
RISC-V Privileged ISA Specification, which may not happen, unless anyone
with RISC-V knowledge has time. They have sign off.

If I submit a PR it will include the checkpatch fixes that I noticed after
sending the patches. The series has been tested pretty extensively and the
earlier revision is what we have in the riscv.org repo and in SiFive's
freedom-u-sdk. i.e. it is what folk are using. I've been working inside of
QEMU RISC-V quite a lot with this series applied, running the latest Fedora
image with SMP Linux, building QEMU inside of QEMU as I'm working on a TCG
backend for RISC-V that I started this Monday during the RISC-V Hackathon.

FYI: This is the work in progress branch on the TCG backend for RISC-V
(it's not quite complete but the bones are there):

- https://github.com/michaeljclark/riscv-qemu/tree/riscv-tcg-backend
