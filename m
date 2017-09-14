Received: from eggs.gnu.org ([2001:4830:134:3::10]:47330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dsVL7-0006jC-SP
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 10:42:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dsVL6-0003J9-7x
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 10:42:01 -0400
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:53726)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dsVL5-0003Hz-Ul
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 10:42:00 -0400
Received: by mail-wr0-x236.google.com with SMTP id l22so528547wrc.10
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 07:41:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <150529666493.10902.14830445134051381968.stgit@frigg.lan>
References: <150529642278.10902.18234057937634437857.stgit@frigg.lan>
	<150529666493.10902.14830445134051381968.stgit@frigg.lan>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Sep 2017 15:41:38 +0100
Message-ID: <CAFEAcA9p9B8AFaaSaSOOSsFsEhHW=XPLBFs5MrozWq=7p4_9Zg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 01/22] instrument: Add documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Emilio G. Cota" <cota@braap.org>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On 13 September 2017 at 10:57, Llu=C3=ADs Vilanova <vilanova@ac.upc.edu> wr=
ote:
> Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
> ---
>  MAINTAINERS         |    6 ++
>  docs/instrument.txt |  173 +++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 179 insertions(+)
>  create mode 100644 docs/instrument.txt
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 36eeb42d19..fb0eaee06a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1486,6 +1486,12 @@ F: scripts/tracetool/
>  F: docs/tracing.txt
>  T: git git://github.com/stefanha/qemu.git tracing
>
> +Event instrumentation
> +M: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
> +M: Stefan Hajnoczi <stefanha@redhat.com>
> +S: Maintained
> +F: docs/instrument.txt
> +
>  TPM
>  S: Orphan
>  F: tpm.c
> diff --git a/docs/instrument.txt b/docs/instrument.txt
> new file mode 100644
> index 0000000000..24a0d21fc7
> --- /dev/null
> +++ b/docs/instrument.txt
> @@ -0,0 +1,173 @@
> +=3D Event instrumentation =3D
> +
> +=3D=3D Introduction =3D=3D
> +
> +Event instrumentation allows users to execute their own host-native code=
 on a
> +set of pre-defined events provided by QEMU. QEMU also exposes other
> +functionality to peek/poke at the guest state (e.g., memory or registers=
), as
> +well as interacting with tracing events. For those familiar with the ter=
m, this
> +provides dynamic binary instrumentation, works on all QEMU-supported
> +architectures, as well as works in both 'user' (standalone application) =
and
> +'system' (full-system emulation) modes.
> +
> +Look at the headers installed by QEMU on the "qemu-instr" directory for =
further
> +information beyond this document.
> +
> +
> +=3D=3D Loading an instrumentation library =3D=3D
> +
> +Instrumentation code can be bundled into a dynamic library, which can be=
 later
> +loaded into QEMU:
> +
> +* Using the command-line "-instr" argument.
> +
> +* Using the "instr-load" and "instr-unload" commands in the HMP and QMP
> +  interfaces.
> +
> +
> +=3D=3D Example =3D=3D
> +
> +1. Configure QEMU with event instrumentation:
> +
> +    # instrument guest_cpu_enter and guest_mem_before
> +    mkdir -p /path/to/qemu-build
> +    cd /path/to/qemu-build
> +    /path/to/qemu-source/configure \
> +      --enable-instrument \
> +      --prefix=3D/path/to/qemu-install

Ideally instrumentation should be cost-free in the case where
we're not using it, so we can default it to enabled.

> +
> +2. Build and install QEMU:
> +
> +    make install
> +
> +3. Create the "Makefile" to build the instrumentation library:
> +
> +    mkdir -p /tmp/my-instrument
> +
> +    cat > /tmp/my-instrument/Makefile <<EOF
> +    QEMU_PATH=3D/tmp/qemu-install/
> +
> +    CFLAGS +=3D -g
> +    CFLAGS +=3D -O3
> +    CFLAGS +=3D -Werror -Wall
> +    CFLAGS +=3D -I$(QEMU_PATH)/include

Plugins shouldn't have or need access to all of the QEMU source
tree or its include files. We want to be able to provide them
with one header file which defines all they need (and all they
get), under a suitably non-restrictive license like 2-clause-BSD.

> +
> +    all: libtrace-instrument.la
> +
> +    libtrace-instrument.la: instrument.lo
> +            libtool --mode=3Dlink --tag=3DCC $(CC) -module -rpath /usr/l=
ocal/lib -o $@ $^

-rpath ?

> +
> +    %.lo: %.c
> +            libtool --mode=3Dcompile --tag=3DCC $(CC) $(CFLAGS) -c $^
> +
> +    clean:
> +            $(RM) -f *.o *.so *.lo
> +            $(RM) -Rf .libs
> +    EOF
> +
> +4. Write your instrumentation library:
> +
> +    cat > /tmp/my-instrument/instrument.c <<EOF
> +    #include <stdio.h>
> +    #include <assert.h>
> +
> +    #include <qemu-instr/control.h>         /* manipulate events */
> +    #include <qemu-instr/trace.h>           /* manipulate tracing */
> +
> +    /* the address for the memory access is not known at translation tim=
e */
> +    void guest_mem_before_trans(QICPU vcpu_trans, QITCGv_cpu vcpu_exec,
> +                                QITCGv vaddr, QIMemInfo info)
> +    {
> +        printf("%s: %p %p %p %d %d %d %d\n", __func__, vcpu_trans, vcpu_=
exec, vaddr,
> +               1 << info.size_shift, info.sign_extend, info.endianness, =
info.store);
> +        if (info.store) {
> +            /* generate at execution time only for memory writes */
> +            qi_event_gen_guest_mem_before_exec(vcpu_exec, vaddr, info);
> +        }
> +    }
> +
> +    /* called when QEMU executes a memory access */
> +    void guest_mem_before_exec(QICPU vcpu, uint64_t vaddr, QIMemInfo inf=
o)
> +    {
> +        if (info.store) {
> +            /* if called by TCG code, we'll only get writes (see above) =
*/
> +            printf("%s: %p %lx %d %d %d %d\n", __func__, vcpu, vaddr,
> +                   1 << info.size_shift, info.sign_extend, info.endianne=
ss, info.store);
> +        }
> +    }

This looks like it's exposing too much implementation detail.
We should just provide an API for "hook to be called for
memory writes" which gets all the information when it
is called. I don't think we should expose any kind of
"this hook is called at translation time" at all.

I guess the API docs are in doc comments in a header somewhere,
so I'll go look in the other patches.

thanks
-- PMM
