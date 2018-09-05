Received: from eggs.gnu.org ([2001:4830:134:3::10]:57472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <viktor.prutyanov@phystech.edu>) id 1fxYT3-0005hl-Sp
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 10:07:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <viktor.prutyanov@phystech.edu>) id 1fxYSx-0004AN-N7
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 10:07:37 -0400
Received: from mail-it0-x242.google.com ([2607:f8b0:4001:c0b::242]:40005)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <viktor.prutyanov@phystech.edu>)
	id 1fxYSv-00049M-LZ
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 10:07:29 -0400
Received: by mail-it0-x242.google.com with SMTP id h23-v6so9591240ita.5
	for <qemu-devel@nongnu.org>; Wed, 05 Sep 2018 07:07:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1535567456-6904-1-git-send-email-viktor.prutyanov@virtuozzo.com>
References: <1535567456-6904-1-git-send-email-viktor.prutyanov@virtuozzo.com>
From: =?UTF-8?B?0J/RgNGD0YLRjNGP0L3QvtCyLCDQktC40LrRgtC+0YAg0JLQu9Cw0LTQuNC80LjRgNC+0LLQuA==?=
	=?UTF-8?B?0Yc=?= <viktor.prutyanov@phystech.edu>
Date: Wed, 5 Sep 2018 17:06:47 +0300
Message-ID: <CAAnhEgonET_q6r244W0-RnuFQwTw7DAK-c65H+RXV5DMvLFxuQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] dump: fix Windows dump memory run mapping
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, Roman Kagan <rkagan@virtuozzo.com>

2018-08-29 21:30 GMT+03:00 Viktor Prutyanov <viktor.prutyanov@virtuozzo.com>:
>
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
> --
> 2.7.4
>

ping
