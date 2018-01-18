Received: from eggs.gnu.org ([2001:4830:134:3::10]:50586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ecFa7-0002jb-6r
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 14:10:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ecFa4-00017Z-0C
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 14:10:35 -0500
References: <1516296842-136976-1-git-send-email-imammedo@redhat.com>
	<1516296842-136976-4-git-send-email-imammedo@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <4ce4d727-b010-8cdb-7d45-518265ba519e@redhat.com>
Date: Thu, 18 Jan 2018 20:10:06 +0100
MIME-Version: 1.0
In-Reply-To: <1516296842-136976-4-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [RFC v2 3/5] linux-user: prepare for
 switching to cpu_create() API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, qemu-s390x@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org

On 18.01.2018 18:34, Igor Mammedov wrote:
> temporarily add #ifdef CPU_RESOLVING_TYPE in linux-user/main.c
> so that  each target could gradually switch to cpu_create() and
> not converted yet could continue to use cpu_init().
> 
> Once all targets are converted
>     temporary ifdefs and cpu_init() API
> will be removed
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  linux-user/main.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/linux-user/main.c b/linux-user/main.c
> index 450eb3c..d481e8c 100644
> --- a/linux-user/main.c
> +++ b/linux-user/main.c
> @@ -44,6 +44,7 @@ static const char *argv0;
>  static int gdbstub_port;
>  static envlist_t *envlist;
>  static const char *cpu_model;
> +static const char *cpu_type;
>  unsigned long mmap_min_addr;
>  unsigned long guest_base;
>  int have_guest_base;
> @@ -3847,7 +3848,7 @@ void init_task_state(TaskState *ts)
>  CPUArchState *cpu_copy(CPUArchState *env)
>  {
>      CPUState *cpu = ENV_GET_CPU(env);
> -    CPUState *new_cpu = cpu_init(cpu_model);
> +    CPUState *new_cpu = cpu_create(cpu_type);
>      CPUArchState *new_env = new_cpu->env_ptr;
>      CPUBreakpoint *bp;
>      CPUWatchpoint *wp;
> @@ -4362,7 +4363,17 @@ int main(int argc, char **argv, char **envp)
>      tcg_exec_init(0);
>      /* NOTE: we need to init the CPU at this stage to get
>         qemu_host_page_size */
> +
> +#ifdef CPU_RESOLVING_TYPE
> +    cpu_type = cpu_parse_cpu_model(CPU_RESOLVING_TYPE, cpu_model);
> +    if (!cpu_type) {
> +        exit(1);
> +    }

That if-statement looks like it should be an assert(cpu_type) instead?

> +    cpu_create(cpu_type);
> +#else
>      cpu = cpu_init(cpu_model);
> +    cpu_type = object_class_get_name(object_get_class(OBJECT(cpu)));
> +#endif
>      env = cpu->env_ptr;
>      cpu_reset(cpu);

 Thomas
