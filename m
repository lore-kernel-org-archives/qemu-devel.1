Received: from eggs.gnu.org ([2001:4830:134:3::10]:55174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cK07s-0000D1-Kz
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 04:57:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cK07p-0006dJ-JO
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 04:57:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33864)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cK07p-0006cr-D8
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 04:57:25 -0500
References: <cover.1482164622.git.vpalatin@chromium.org>
	<85250fb0450b5b95232b39c82ab310a0632fd23f.1482164622.git.vpalatin@chromium.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fda5a694-d02f-269e-e155-1822276d74f6@redhat.com>
Date: Thu, 22 Dec 2016 10:57:20 +0100
MIME-Version: 1.0
In-Reply-To: <85250fb0450b5b95232b39c82ab310a0632fd23f.1482164622.git.vpalatin@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 3/4] Plumb the HAXM-based hardware
 acceleration support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vincent Palatin <vpalatin@chromium.org>, qemu-devel <qemu-devel@nongnu.org>
Cc: Yu Ning <yu.ning@linux.intel.com>, Stefan Weil <sw@weilnetz.de>, "Michael S . Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>



On 19/12/2016 17:24, Vincent Palatin wrote:
>  #else /* _WIN32 */
> -    abort();
> +    if (!qemu_cpu_is_self(cpu)) {
> +        CONTEXT context;
> +        if (SuspendThread(cpu->hThread) =3D=3D (DWORD)(-1)) {
> +            fprintf(stderr, "qemu:%s: GetLastError:%lu\n", __func__,
> +                    GetLastError());
> +            exit(1);
> +        }
> +
> +        /* On multi-core systems, we are not sure that the thread is a=
ctually
> +         * suspended until we can get the context.
> +         */
> +        context.ContextFlags =3D CONTEXT_CONTROL;
> +        while (GetThreadContext(cpu->hThread, &context) !=3D 0) {
> +            continue;
> +        }
> +
> +        if (hax_enabled()) {
> +            cpu->exit_request =3D 1;
> +        }

As mentioned in the reply to patch 4, please leave the cpu->exit_request
=3D 1 assignment to the caller.

Apart from the above change, can you check if there are some less
heavyeight methods to force an exit?  I can think of QueueUserAPC with
an empty pfnAPC here, and SleepEx(0, TRUE) in qemu_hax_cpu_thread_fn
before qemu_wait_io_event_common.

> +        if (ResumeThread(cpu->hThread) =3D=3D (DWORD)(-1)) {
> +            fprintf(stderr, "qemu:%s: GetLastError:%lu\n", __func__,
> +                    GetLastError());
> +            exit(1);
> +        }
> +    }

[...]

>=20
> +            /*
> +             * In Hax, the qemu allocate the virtual address, and HAX =
kernel
> +             * populate the memory with physical memory. Currently we =
have no
> +             * paging, so user should make sure enough free memory in =
advance
> +             */
> +            if (hax_enabled()) {
> +                int ret;
> +                ret =3D hax_populate_ram((uint64_t)(uintptr_t)new_bloc=
k->host,
> +                                       new_block->max_length);
> +                if (ret < 0) {
> +                    error_setg(errp, "Hax failed to populate ram");
> +                    return;
> +                }
> +            }
> +

Can you check if the interface at
http://marc.info/?l=3Dqemu-devel&m=3D148225154320642&q=3Draw would be goo=
d for
your purposes, and if so include that patch in your v6?

Otherwise looks great, so I'm confident we can add this in QEMU 2.9.

Paolo
