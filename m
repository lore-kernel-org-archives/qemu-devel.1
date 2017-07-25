Received: from eggs.gnu.org ([2001:4830:134:3::10]:42322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dZzuv-000112-DY
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 09:30:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dZzuu-0001jS-DK
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 09:30:29 -0400
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:35863)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dZzuu-0001i9-58
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 09:30:28 -0400
Received: by mail-wr0-x229.google.com with SMTP id y43so119067771wrd.3
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 06:30:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170725131931.GC23343@stefanha-x1.localdomain>
References: <150091574424.30739.4131793221953168474.stgit@frigg.lan>
	<20170725131931.GC23343@stefanha-x1.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Jul 2017 14:30:06 +0100
Message-ID: <CAFEAcA_pmFYZ_y9E5D0c70G2oA62vb+KBXnxbp_Sg39kuNeREA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 00/13] instrument: Add basic event
 instrumentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: =?UTF-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>, "Emilio G. Cota" <cota@braap.org>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

On 25 July 2017 at 14:19, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> Instead I suggest adding a trace backend generates calls to registered
> "callback" functions:
>
>   $ cat >my-instrumentation.c
>   #include "trace/control.h"
>
>   static void my_cpu_in(unsigned int addr, char size, unsigned int val)
>   {
>       printf("my_cpu_in\n");
>   }
>
>   static void my_init(void)
>   {
>       trace_register_event_callback("cpu_in", my_cpu_in);
>       trace_enable_events("cpu_in");
>   }
>   trace_init(my_init);
>
>   $ ./configure --enable-trace-backends=log,callback && make -j4
>
> This is still a clean interface that allows instrumentation code to be
> kept separate from the trace event call sites.
>
> The instrumentation code gets compiled into QEMU, but that shouldn't be
> a huge burden since QEMU's Makefiles only recompile changed source
> files (only the first build is slow).

Is your proposal that my-instrumentation.c gets compiled into
QEMU at this point? That doesn't seem like a great idea to
me, because it means you can only use this tracing if you
build QEMU yourself, and distros won't enable it and so
lots of our users won't have convenient access to it.
I'd much rather see a cleanly designed plugin interface
(which we should be able to implement in a manner that doesn't
let the plugin monkey patch arbitrary parts of QEMU beyond
what can already be achieved via LD_PRELOAD).

thanks
-- PMM
