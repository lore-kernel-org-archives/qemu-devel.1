Received: from eggs.gnu.org ([2001:4830:134:3::10]:51924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fyHIS-0004Cv-DM
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 09:59:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fyHIO-00046U-Cu
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 09:59:40 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:37256)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fyHIN-00041l-Ss
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 09:59:36 -0400
Received: by mail-wr1-x441.google.com with SMTP id u12-v6so15056842wrr.4
	for <qemu-devel@nongnu.org>; Fri, 07 Sep 2018 06:59:35 -0700 (PDT)
References: <152819515565.30857.16834004920507717324.stgit@pasha-ThinkPad-T60>
	<152819518838.30857.7489579122481731984.stgit@pasha-ThinkPad-T60>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <152819518838.30857.7489579122481731984.stgit@pasha-ThinkPad-T60>
Date: Fri, 07 Sep 2018 14:59:33 +0100
Message-ID: <87r2i5z9ve.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v2 6/7] plugin: add instruction
 execution logger
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru, pbonzini@redhat.com, vilanova@ac.upc.edu


Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru> writes:

> From: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
>
> This patch adds a plugin for logging addresses of all executed instructio=
ns,
> making a complete instruction-level trace.

This isn't a good example. You can do this now with a much simpler:

  ${QEMU} -singlestep -d nochain,trace:exec_tb -D $trace ${BINARY}

Or even with a binary log:

  ${QEMU} -singlestep -d nochain -trace enable=3Dexec_tb,file=3D$trace ${BI=
NARY}

Which is all currently built-in. For the example to be worthwhile we
need to show how we can do something we currently can't do with the
existing infrastructure.

Perhaps a better example would be logging each PC execution to a hash
table so we can compute the hottest PC?

However that is going to require another API to allow information to be
exported from the plugin itself to report it's results.

>
> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> ---
>  plugins/exec-log/Makefile   |   19 +++++++++++++++++++
>  plugins/exec-log/exec-log.c |   18 ++++++++++++++++++
>  2 files changed, 37 insertions(+)
>  create mode 100644 plugins/exec-log/Makefile
>  create mode 100644 plugins/exec-log/exec-log.c
>
> diff --git a/plugins/exec-log/Makefile b/plugins/exec-log/Makefile
> new file mode 100644
> index 0000000..86374f4
> --- /dev/null
> +++ b/plugins/exec-log/Makefile
> @@ -0,0 +1,19 @@
> +CFLAGS +=3D -I../include -fno-PIE -fPIC -O3

I would have:

QEMU_SRC=3D../..
CFLAGS +=3D -I$(QEMU_SRC)/include -fno-PIE -fPIC -O3

to make it clearer for out of tree plugins.

> +LDFLAGS +=3D -shared
> +# TODO: Windows
> +DSOSUF :=3D .so
> +
> +NAME:=3D exec-log
> +BIN :=3D $(NAME)$(DSOSUF)
> +
> +FILES :=3D exec-log.o
> +
> +%.o: %.c
> +	$(CC) -c -o $@ $< $(CFLAGS)
> +
> +all: $(FILES)
> +	$(CC) $(LDFLAGS) -o $(BIN) $(FILES)
> +
> +clean:
> +	rm $(FILES)
> +	rm $(BIN)

If the example plugins are going to sit in the main tree we should build
them (and ideally test they load/work during make check/tcg-check).

> diff --git a/plugins/exec-log/exec-log.c b/plugins/exec-log/exec-log.c
> new file mode 100644
> index 0000000..7fc7975
> --- /dev/null
> +++ b/plugins/exec-log/exec-log.c
> @@ -0,0 +1,18 @@
> +#include <stdint.h>
> +#include <stdio.h>
> +#include "plugins.h"
> +
> +bool plugin_init(const char *args)
> +{
> +    return true;
> +}
> +
> +bool plugin_needs_before_insn(uint64_t pc, void *cpu)
> +{
> +    return true;
> +}
> +
> +void plugin_before_insn(uint64_t pc, void *cpu)
> +{
> +    qemulib_log("executing instruction at %lx\n", pc);
> +}


--
Alex Benn=C3=A9e
