Received: from eggs.gnu.org ([2001:4830:134:3::10]:47050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gNEYz-0001ya-CY
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 05:07:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gNEYv-0003GO-Nq
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 05:07:53 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34255)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gNEYv-00034i-Dr
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 05:07:49 -0500
Received: by mail-wm1-f68.google.com with SMTP id f1-v6so15431630wmg.1
	for <qemu-devel@nongnu.org>; Thu, 15 Nov 2018 02:07:28 -0800 (PST)
References: <1542261954-4060-1-git-send-email-liq3ea@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a71c8807-6a4d-2dca-6f82-c9a93721d1fb@redhat.com>
Date: Thu, 15 Nov 2018 11:07:25 +0100
MIME-Version: 1.0
In-Reply-To: <1542261954-4060-1-git-send-email-liq3ea@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] target: hax: replace g_malloc with
 g_malloc0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, laurent@vivier.eu
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org

On 15/11/18 7:05, Li Qiang wrote:
> And also the g_malloc doesn't need check return value,
> remove it.
> 
> Cc: qemu-trivial@nongnu.org
> 
> Signed-off-by: Li Qiang <liq3ea@gmail.com>
> ---
>   target/i386/hax-all.c | 15 +++------------
>   1 file changed, 3 insertions(+), 12 deletions(-)
> 
> diff --git a/target/i386/hax-all.c b/target/i386/hax-all.c
> index d2e512856b..a460c605af 100644
> --- a/target/i386/hax-all.c
> +++ b/target/i386/hax-all.c
> @@ -154,13 +154,7 @@ int hax_vcpu_create(int id)
>           return 0;
>       }
>   
> -    vcpu = g_malloc(sizeof(struct hax_vcpu_state));
> -    if (!vcpu) {
> -        fprintf(stderr, "Failed to alloc vcpu state\n");
> -        return -ENOMEM;
> -    }
> -
> -    memset(vcpu, 0, sizeof(struct hax_vcpu_state));
> +    vcpu = g_malloc0(sizeof(struct hax_vcpu_state));

Can you use the g_new form?

        vcpu = g_new0(struct hax_vcpu_state, 1);

>   
>       ret = hax_host_create_vcpu(hax_global.vm->fd, id);
>       if (ret) {
> @@ -250,11 +244,8 @@ struct hax_vm *hax_vm_create(struct hax_state *hax)
>           return hax->vm;
>       }
>   
> -    vm = g_malloc(sizeof(struct hax_vm));
> -    if (!vm) {
> -        return NULL;
> -    }
> -    memset(vm, 0, sizeof(struct hax_vm));
> +    vm = g_malloc0(sizeof(struct hax_vm));

Ditto.

> +
>       ret = hax_host_create_vm(hax, &vm_id);
>       if (ret) {
>           fprintf(stderr, "Failed to create vm %x\n", ret);
> 

This patch as it or using g_new0:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
