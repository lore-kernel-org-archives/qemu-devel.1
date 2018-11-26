Received: from eggs.gnu.org ([2001:4830:134:3::10]:51090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gRDfm-0005bN-TR
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 04:59:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gRDfm-0002jy-2D
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 04:59:22 -0500
References: <1543226179-5135-1-git-send-email-liq3ea@gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <9382f2b5-89ea-04b4-de21-5fdbcec1fd47@vivier.eu>
Date: Mon, 26 Nov 2018 10:59:02 +0100
MIME-Version: 1.0
In-Reply-To: <1543226179-5135-1-git-send-email-liq3ea@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] target: hax: replace g_malloc with g_new0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, alex.bennee@linaro.org, philmd@redhat.com, armbru@redhat.com
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org

On 26/11/2018 10:56, Li Qiang wrote:
> And also the g_malloc doesn't need check return value,
> remove it.
> 
> Cc: qemu-trivial@nongnu.org
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Li Qiang <liq3ea@gmail.com>
> ---
>  target/i386/hax-all.c | 15 +++------------
>  1 file changed, 3 insertions(+), 12 deletions(-)
> 
> diff --git a/target/i386/hax-all.c b/target/i386/hax-all.c
> index d2e512856b..502ce6f0af 100644
> --- a/target/i386/hax-all.c
> +++ b/target/i386/hax-all.c
> @@ -154,13 +154,7 @@ int hax_vcpu_create(int id)
>          return 0;
>      }
>  
> -    vcpu = g_malloc(sizeof(struct hax_vcpu_state));
> -    if (!vcpu) {
> -        fprintf(stderr, "Failed to alloc vcpu state\n");
> -        return -ENOMEM;
> -    }
> -
> -    memset(vcpu, 0, sizeof(struct hax_vcpu_state));
> +    vcpu = g_new0(struct hax_vcpu_state, 1);
>  
>      ret = hax_host_create_vcpu(hax_global.vm->fd, id);
>      if (ret) {
> @@ -250,11 +244,8 @@ struct hax_vm *hax_vm_create(struct hax_state *hax)
>          return hax->vm;
>      }
>  
> -    vm = g_malloc(sizeof(struct hax_vm));
> -    if (!vm) {
> -        return NULL;
> -    }
> -    memset(vm, 0, sizeof(struct hax_vm));
> +    vm = g_new0(struct hax_vm, 1);
> +
>      ret = hax_host_create_vm(hax, &vm_id);
>      if (ret) {
>          fprintf(stderr, "Failed to create vm %x\n", ret);
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
