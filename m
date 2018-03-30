Received: from eggs.gnu.org ([2001:4830:134:3::10]:46046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1f1ua3-0007fJ-DR
	for qemu-devel@nongnu.org; Fri, 30 Mar 2018 10:00:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1f1uZy-0002xb-Dc
	for qemu-devel@nongnu.org; Fri, 30 Mar 2018 10:00:35 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:55829)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1f1uZy-0002x3-3Y
	for qemu-devel@nongnu.org; Fri, 30 Mar 2018 10:00:30 -0400
References: <20180330133525.10994-1-jcmvbkbc@gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <eeb2f9a7-61fe-5307-cd37-fb14db7e309b@vivier.eu>
Date: Fri, 30 Mar 2018 16:00:24 +0200
MIME-Version: 1.0
In-Reply-To: <20180330133525.10994-1-jcmvbkbc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] linux-user: call cpu_copy under clone_lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Filippov <jcmvbkbc@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

Le 30/03/2018 à 15:35, Max Filippov a écrit :
> cpu_copy adds newly created CPU object to container/machine/unattached,
> but does it w/o proper locking. As a result when multiple threads are
> created rapidly QEMU may abort with the following message:
> 
>   GLib-CRITICAL **: g_hash_table_iter_next: assertion
>   'ri->version == ri->hash_table->version' failed
> 
>   ERROR:qemu/qom/object.c:1663:object_get_canonical_path_component:
>   code should not be reached

Also reported in https://bugs.launchpad.net/qemu/+bug/1756519

> Move cpu_copy invocation under clone_lock to fix that.
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
> @@ -6346,6 +6346,10 @@ static int do_fork(CPUArchState *env, unsigned int flags, abi_ulong newsp,
>  
>          ts = g_new0(TaskState, 1);
>          init_task_state(ts);
> +
> +        /* Grab a mutex so that thread setup appears atomic.  */
> +        pthread_mutex_lock(&clone_lock);
> +
>          /* we create a new CPU instance. */
>          new_env = cpu_copy(env);
>          /* Init regs that differ from the parent.  */
> @@ -6364,9 +6368,6 @@ static int do_fork(CPUArchState *env, unsigned int flags, abi_ulong newsp,
>              cpu_set_tls (new_env, newtls);
>          }
>  
> -        /* Grab a mutex so that thread setup appears atomic.  */
> -        pthread_mutex_lock(&clone_lock);
> -
>          memset(&info, 0, sizeof(info));
>          pthread_mutex_init(&info.mutex, NULL);
>          pthread_mutex_lock(&info.mutex);
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
