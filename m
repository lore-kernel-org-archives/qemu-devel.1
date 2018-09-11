Received: from eggs.gnu.org ([2001:4830:134:3::10]:36663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fziLQ-0007pk-2d
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 09:04:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fziJF-0004w7-5t
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 09:02:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41312 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fziJE-0004vj-W1
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 09:02:25 -0400
References: <1535567456-6904-1-git-send-email-viktor.prutyanov@virtuozzo.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6dc33499-9fb0-9b50-1a70-062b8a19df42@redhat.com>
Date: Tue, 11 Sep 2018 15:02:21 +0200
MIME-Version: 1.0
In-Reply-To: <1535567456-6904-1-git-send-email-viktor.prutyanov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] dump: fix Windows dump memory run mapping
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Viktor Prutyanov <viktor.prutyanov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, rkagan@virtuozzo.com, viktor.prutyanov@phystech.edu

On 29/08/2018 20:30, Viktor Prutyanov wrote:
> We should map and use guest memory run by parts if it can't be mapped as
> a whole.
> After this patch, continuos guest physical memory blocks which are not
> continuos in host virtual address space will be processed correctly.
> 
> Signed-off-by: Viktor Prutyanov <viktor.prutyanov@virtuozzo.com>
> ---
>  win_dump.c | 40 ++++++++++++++++++++++------------------
>  1 file changed, 22 insertions(+), 18 deletions(-)
> 
> diff --git a/win_dump.c b/win_dump.c
> index b15c191..aa39d9c 100644
> --- a/win_dump.c
> +++ b/win_dump.c
> @@ -30,28 +30,32 @@ static size_t write_run(WinDumpPhyMemRun64 *run, int fd, Error **errp)
>      void *buf;
>      uint64_t addr = run->BasePage << TARGET_PAGE_BITS;
>      uint64_t size = run->PageCount << TARGET_PAGE_BITS;
> -    uint64_t len = size;
> +    uint64_t len, l;
> +    size_t total = 0;
>  
> -    buf = cpu_physical_memory_map(addr, &len, false);
> -    if (!buf) {
> -        error_setg(errp, "win-dump: failed to map run");
> -        return 0;
> -    }
> -    if (len != size) {
> -        error_setg(errp, "win-dump: failed to map entire run");
> -        len = 0;
> -        goto out_unmap;
> -    }
> +    while (size) {
> +        len = size;
>  
> -    len = qemu_write_full(fd, buf, len);
> -    if (len != size) {
> -        error_setg(errp, QERR_IO_ERROR);
> -    }
> +        buf = cpu_physical_memory_map(addr, &len, false);
> +        if (!buf) {
> +            error_setg(errp, "win-dump: failed to map physical range"
> +                             " 0x%016lx-0x%016lx", addr, addr + size - 1);
> +            return 0;
> +        }
> +
> +        l = qemu_write_full(fd, buf, len);
> +        cpu_physical_memory_unmap(buf, addr, false, len);
> +        if (l != len) {
> +            error_setg(errp, QERR_IO_ERROR);
> +            return 0;
> +        }
>  
> -out_unmap:
> -    cpu_physical_memory_unmap(buf, addr, false, len);
> +        addr += l;
> +        size -= l;
> +        total += l;
> +    }
>  
> -    return len;
> +    return total;
>  }
>  
>  static void write_runs(DumpState *s, WinDumpHeader64 *h, Error **errp)
> 

Queued, thanks.

Paolo
