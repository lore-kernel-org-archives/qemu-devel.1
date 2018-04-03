Received: from eggs.gnu.org ([2001:4830:134:3::10]:53792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f3Olq-0003ZS-9M
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 12:26:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f3Oln-0000dd-JD
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 12:26:54 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:53591)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f3Oln-0000cW-CJ
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 12:26:51 -0400
Received: by mail-wm0-x244.google.com with SMTP id p9so34704836wmc.3
	for <qemu-devel@nongnu.org>; Tue, 03 Apr 2018 09:26:51 -0700 (PDT)
References: <20180330133525.10994-1-jcmvbkbc@gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180330133525.10994-1-jcmvbkbc@gmail.com>
Date: Tue, 03 Apr 2018 17:26:48 +0100
Message-ID: <87vad8cl2v.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] linux-user: call cpu_copy under clone_lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>


Max Filippov <jcmvbkbc@gmail.com> writes:

> cpu_copy adds newly created CPU object to container/machine/unattached,
> but does it w/o proper locking. As a result when multiple threads are
> created rapidly QEMU may abort with the following message:
>
>   GLib-CRITICAL **: g_hash_table_iter_next: assertion
>   'ri->version =3D=3D ri->hash_table->version' failed
>
>   ERROR:qemu/qom/object.c:1663:object_get_canonical_path_component:
>   code should not be reached
>
> Move cpu_copy invocation under clone_lock to fix that.

So my main concern is are we duplicating something already (should be?)
handled by fork_start/fork_end?

This serialises forks and ensures things like the cpu_list (which ~ a
thread list for linux-user) are updated safely.

>
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> ---
>  linux-user/syscall.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 889abbda1e65..18ea79140f16 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -6346,6 +6346,10 @@ static int do_fork(CPUArchState *env, unsigned int=
 flags, abi_ulong newsp,
>
>          ts =3D g_new0(TaskState, 1);
>          init_task_state(ts);
> +
> +        /* Grab a mutex so that thread setup appears atomic.  */
> +        pthread_mutex_lock(&clone_lock);
> +
>          /* we create a new CPU instance. */
>          new_env =3D cpu_copy(env);
>          /* Init regs that differ from the parent.  */
> @@ -6364,9 +6368,6 @@ static int do_fork(CPUArchState *env, unsigned int =
flags, abi_ulong newsp,
>              cpu_set_tls (new_env, newtls);
>          }
>
> -        /* Grab a mutex so that thread setup appears atomic.  */
> -        pthread_mutex_lock(&clone_lock);
> -
>          memset(&info, 0, sizeof(info));
>          pthread_mutex_init(&info.mutex, NULL);
>          pthread_mutex_lock(&info.mutex);


--
Alex Benn=C3=A9e
