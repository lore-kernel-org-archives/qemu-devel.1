Received: from eggs.gnu.org ([209.51.188.92]:33887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ggeWT-0003oy-0U
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 18:41:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ggeWS-00038j-4a
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 18:41:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47874)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ggeWR-00036r-Np
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 18:41:31 -0500
References: <20190102074114.26988-1-liq3ea@163.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a697a5a0-54e5-0a2f-8d6c-e204a095ff6c@redhat.com>
Date: Tue, 8 Jan 2019 00:41:09 +0100
MIME-Version: 1.0
In-Reply-To: <20190102074114.26988-1-liq3ea@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Li Qiang <liq3ea@163.com>, ehabkost@redhat.com, richard.henderson@linaro.org, imammedo@redhat.com, cota@braap.org, philmd@redhat.com
Cc: qemu-devel@nongnu.org

On 02/01/19 08:41, Li Qiang wrote:
> Commit 376692b9dc6(cpus: protect work list with work_mutex)
> initialize a work_mutex in cpu_common_initfn, however forget
> to destroy it. This will cause resource leak when hotunplug cpu
> or hotplug cpu fails.
> 
> Signed-off-by: Li Qiang <liq3ea@163.com>
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

Queued, thanks.

Paolo
