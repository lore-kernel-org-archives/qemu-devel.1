Received: from eggs.gnu.org ([209.51.188.92]:56125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gqcjR-00074F-FH
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 06:48:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gqchI-0003Wc-7K
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 06:45:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49514)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gqchG-0003Re-7U
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 06:45:56 -0500
References: <20181210182816.2014-1-pbonzini@redhat.com>
	<20181210182816.2014-8-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <53f250f3-3455-5fad-14bc-27a9c439ecca@redhat.com>
Date: Mon, 4 Feb 2019 12:45:42 +0100
MIME-Version: 1.0
In-Reply-To: <20181210182816.2014-8-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] valgrind errors (was: [PATCH 7/8] qemu/queue.h:
 simplify reverse access to QTAILQ)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, Richard Henderson <rth@twiddle.net>

On 2018-12-10 19:28, Paolo Bonzini wrote:
> The new definition of QTAILQ does not require passing the headname,
> remove it.

 Hi Paolo,

when running current QEMU master branch with valgrind, I get
"Conditional jump or move depends on uninitialised value" errors. I've
bisected it to your patch series here. Everything is still fine and calm
with f481ee2d5e3d77c12a4c9a7756b8c2612aad84c6 ("qemu/queue.h: typedef
QTAILQ heads"), but starting with commit
eae3eb3e185028d6e862db747e3b7397600d6762 ("qemu/queue.h: simplify
reverse access to QTAILQ"), I now get:

=3D=3D14580=3D=3D Thread 3:
=3D=3D14580=3D=3D Conditional jump or move depends on uninitialised value=
(s)
=3D=3D14580=3D=3D    at 0x40C267: tcg_reg_alloc (tcg.c:3123)
=3D=3D14580=3D=3D    by 0x40F8FB: tcg_reg_alloc_op (tcg.c:3506)
=3D=3D14580=3D=3D    by 0x40F8FB: tcg_gen_code (tcg.c:3948)
=3D=3D14580=3D=3D    by 0x47FAFF: tb_gen_code (translate-all.c:1748)
=3D=3D14580=3D=3D    by 0x47E153: tb_find (cpu-exec.c:404)
=3D=3D14580=3D=3D    by 0x47E153: cpu_exec (cpu-exec.c:724)
=3D=3D14580=3D=3D    by 0x43D981: tcg_cpu_exec (cpus.c:1429)
=3D=3D14580=3D=3D    by 0x43FB4F: qemu_tcg_cpu_thread_fn (cpus.c:1733)
=3D=3D14580=3D=3D    by 0x879075: qemu_thread_start (qemu-thread-posix.c:=
502)
=3D=3D14580=3D=3D    by 0xB528DD4: start_thread (in /usr/lib64/libpthread=
-2.17.so)
=3D=3D14580=3D=3D    by 0xB83BB3C: clone (in /usr/lib64/libc-2.17.so)

Unfortunately, the commits in between do not compile, so I can not
determine the exact commit that introduced the problem, but it
definitely seems to happen due to your queue rework. Could you please
have a look?

 Thanks,
  Thomas
