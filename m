Received: from eggs.gnu.org ([208.118.235.92]:47369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1geeB7-0002kQ-O7
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 05:55:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1geeB0-00031l-VP
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 05:55:13 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45510)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1geeB0-00030e-MY
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 05:55:06 -0500
Received: by mail-wr1-f65.google.com with SMTP id t6so30046313wrr.12
	for <qemu-devel@nongnu.org>; Wed, 02 Jan 2019 02:55:05 -0800 (PST)
References: <20190102074114.26988-1-liq3ea@163.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <64cb4e3a-2bb6-1aba-d91b-426a132b0038@redhat.com>
Date: Wed, 2 Jan 2019 11:55:02 +0100
MIME-Version: 1.0
In-Reply-To: <20190102074114.26988-1-liq3ea@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] qom: cpu: destroy work_mutex in
 cpu_common_finalize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@163.com>, ehabkost@redhat.com, richard.henderson@linaro.org, imammedo@redhat.com, cota@braap.org, pbonzini@redhat.com
Cc: qemu-devel@nongnu.org

On 1/2/19 8:41 AM, Li Qiang wrote:
> Commit 376692b9dc6(cpus: protect work list with work_mutex)
> initialize a work_mutex in cpu_common_initfn, however forget
> to destroy it. This will cause resource leak when hotunplug cpu
> or hotplug cpu fails.
> 

Long standing leak ;)

Maybe add:

Fixes: 376692b9dc6

> Signed-off-by: Li Qiang <liq3ea@163.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  qom/cpu.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/qom/cpu.c b/qom/cpu.c
> index 9ad1372d57..367ebf9d61 100644
> --- a/qom/cpu.c
> +++ b/qom/cpu.c
> @@ -380,6 +380,9 @@ static void cpu_common_initfn(Object *obj)
>  
>  static void cpu_common_finalize(Object *obj)
>  {
> +    CPUState *cpu = CPU(obj);
> +
> +    qemu_mutex_destroy(&cpu->work_mutex);
>  }
>  
>  static int64_t cpu_common_get_arch_id(CPUState *cpu)
> 
