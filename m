Received: from eggs.gnu.org ([2001:4830:134:3::10]:55512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1fzIKv-0003jM-2o
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 05:18:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1fzIKr-00060z-QE
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 05:18:25 -0400
Received: from mail.ispras.ru ([83.149.199.45]:39032)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1fzIKr-000606-AF
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 05:18:21 -0400
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <152819515565.30857.16834004920507717324.stgit@pasha-ThinkPad-T60>
	<152819519376.30857.17032517857304957536.stgit@pasha-ThinkPad-T60>
	<87pnxpz9jf.fsf@linaro.org>
In-Reply-To: <87pnxpz9jf.fsf@linaro.org>
Date: Mon, 10 Sep 2018 12:18:19 +0300
Message-ID: <001501d448e7$37421570$a5c64050$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: ru
Subject: Re: [Qemu-devel] [RFC PATCH v2 7/7] plugins: add syscall logging
 plugin sample
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?'Alex_Benn=C3=A9e'?= <alex.bennee@linaro.org>, 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, maria.klimushenkova@ispras.ru, pbonzini@redhat.com, vilanova@ac.upc.edu

> From: Alex Benn=C3=A9e [mailto:alex.bennee@linaro.org]
> Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru> writes:
>=20
> > This is an example of plugin which instruments only specific =
instructions:
> > sysenter and sysexit. When executing them, it prints system call id
> > and return code to the QEMU log.
>=20
> Again I'm not sure this is a very useful example either. It doesn't
> achieve anything we can't already do with the existing logging/strace
> stuff and it is quite ugly in it's knowledge of a single architecture =
to
> try and figure out what's going on.

Not exactly. strace is intrusive, when running within the VM.
And this plugin does not affect the emulated system at all (except the =
slowdown).

Pavel Dovgalyuk
>=20
> >
> > Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> > ---
> >  plugins/syscall-log/Makefile      |   19 ++++++++++++++++
> >  plugins/syscall-log/syscall-log.c |   44 =
+++++++++++++++++++++++++++++++++++++
> >  2 files changed, 63 insertions(+)
> >  create mode 100644 plugins/syscall-log/Makefile
> >  create mode 100644 plugins/syscall-log/syscall-log.c
> >
> > diff --git a/plugins/syscall-log/Makefile =
b/plugins/syscall-log/Makefile
> > new file mode 100644
> > index 0000000..1bbdf04
> > --- /dev/null
> > +++ b/plugins/syscall-log/Makefile
> > @@ -0,0 +1,19 @@
> > +CFLAGS +=3D -I../include -fno-PIE -fPIC -O3
> > +LDFLAGS +=3D -shared
> > +# TODO: Windows
> > +DSOSUF :=3D .so
> > +
> > +NAME:=3D syscall-log
> > +BIN :=3D $(NAME)$(DSOSUF)
> > +
> > +FILES :=3D syscall-log.o
> > +
> > +%.o: %.c
> > +	$(CC) -c -o $@ $< $(CFLAGS)
> > +
> > +all: $(FILES)
> > +	$(CC) $(LDFLAGS) -o $(BIN) $(FILES)
> > +
> > +clean:
> > +	rm $(FILES)
> > +	rm $(BIN)
> > diff --git a/plugins/syscall-log/syscall-log.c =
b/plugins/syscall-log/syscall-log.c
> > new file mode 100644
> > index 0000000..1f5d55f
> > --- /dev/null
> > +++ b/plugins/syscall-log/syscall-log.c
> > @@ -0,0 +1,44 @@
> > +#include <stdint.h>
> > +#include <stdio.h>
> > +#include "plugins.h"
> > +
> > +bool plugin_init(const char *args)
> > +{
> > +    return true;
> > +}
> > +
> > +bool plugin_needs_before_insn(uint64_t pc, void *cpu)
> > +{
> > +    uint8_t code =3D 0;
> > +    if (!qemulib_read_memory(cpu, pc, &code, 1)
> > +        && code =3D=3D 0x0f) {
> > +        if (qemulib_read_memory(cpu, pc + 1, &code, 1)) {
> > +            return false;
> > +        }
> > +        if (code =3D=3D 0x34) {
> > +            /* sysenter */
> > +            return true;
> > +        }
> > +        if (code =3D=3D 0x35) {
> > +            /* sysexit */
> > +            return true;
> > +        }
> > +    }
> > +    return false;
> > +}
> > +
> > +void plugin_before_insn(uint64_t pc, void *cpu)
> > +{
> > +    uint8_t code =3D 0;
> > +    uint32_t reg;
> > +    qemulib_read_memory(cpu, pc + 1, &code, 1);
> > +    /* Read EAX. There should be a header with register ids
> > +       or a function for reading the register by the name */
> > +    qemulib_read_register(cpu, (uint8_t*)&reg, 0);
> > +    /* log system calls */
> > +    if (code =3D=3D 0x34) {
> > +        qemulib_log("sysenter %x\n", reg);
> > +    } else if (code =3D=3D 0x35) {
> > +        qemulib_log("sysexit %x\n", reg);
> > +    }
> > +}
>=20
>=20
> --
> Alex Benn=C3=A9e
