Received: from eggs.gnu.org ([2001:4830:134:3::10]:60953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fSQrE-0002jp-7Q
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 13:43:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fSQrA-0000Zu-0B
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 13:43:56 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:36444)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fSQr9-0000ZW-Pz
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 13:43:51 -0400
Received: by mail-qk0-x242.google.com with SMTP id a195-v6so13432230qkg.3
	for <qemu-devel@nongnu.org>; Mon, 11 Jun 2018 10:43:51 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180611171007.4165-1-peter.maydell@linaro.org>
	<20180611171007.4165-4-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <42fb1f59-e684-0136-30fc-cee9d8737d88@amsat.org>
Date: Mon, 11 Jun 2018 14:43:48 -0300
MIME-Version: 1.0
In-Reply-To: <20180611171007.4165-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 3/3] exec.c: Use stn_p() and ldn_p()
 instead of explicit switches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, patches@linaro.org

On 06/11/2018 02:10 PM, Peter Maydell wrote:
> Now we have stn_p() and ldn_p() we can use them in various
> functions in exec.c that used to have their own switch-on-size code.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  exec.c | 112 +++++----------------------------------------------------
>  1 file changed, 8 insertions(+), 104 deletions(-)
> 
> diff --git a/exec.c b/exec.c
> index 90b47cde7b1..1fa2cdb874f 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -2544,22 +2544,7 @@ static void notdirty_mem_write(void *opaque, hwaddr ram_addr,
>      memory_notdirty_write_prepare(&ndi, current_cpu, current_cpu->mem_io_vaddr,
>                           ram_addr, size);
>  
> -    switch (size) {
> -    case 1:
> -        stb_p(qemu_map_ram_ptr(NULL, ram_addr), val);
> -        break;
> -    case 2:
> -        stw_p(qemu_map_ram_ptr(NULL, ram_addr), val);
> -        break;
> -    case 4:
> -        stl_p(qemu_map_ram_ptr(NULL, ram_addr), val);
> -        break;
> -    case 8:
> -        stq_p(qemu_map_ram_ptr(NULL, ram_addr), val);
> -        break;
> -    default:
> -        abort();
> -    }
> +    stn_p(qemu_map_ram_ptr(NULL, ram_addr), size, val);
>      memory_notdirty_write_complete(&ndi);
>  }
>  
> @@ -2739,22 +2724,8 @@ static MemTxResult subpage_read(void *opaque, hwaddr addr, uint64_t *data,
>      if (res) {
>          return res;
>      }
> -    switch (len) {
> -    case 1:
> -        *data = ldub_p(buf);
> -        return MEMTX_OK;
> -    case 2:
> -        *data = lduw_p(buf);
> -        return MEMTX_OK;
> -    case 4:
> -        *data = (uint32_t)ldl_p(buf);
> -        return MEMTX_OK;
> -    case 8:
> -        *data = ldq_p(buf);
> -        return MEMTX_OK;
> -    default:
> -        abort();
> -    }
> +    *data = ldn_p(buf, len);
> +    return MEMTX_OK;
>  }
>  
>  static MemTxResult subpage_write(void *opaque, hwaddr addr,
> @@ -2768,22 +2739,7 @@ static MemTxResult subpage_write(void *opaque, hwaddr addr,
>             " value %"PRIx64"\n",
>             __func__, subpage, len, addr, value);
>  #endif
> -    switch (len) {
> -    case 1:
> -        stb_p(buf, value);
> -        break;
> -    case 2:
> -        stw_p(buf, value);
> -        break;
> -    case 4:
> -        stl_p(buf, value);
> -        break;
> -    case 8:
> -        stq_p(buf, value);
> -        break;
> -    default:
> -        abort();
> -    }
> +    stn_p(buf, len, value);
>      return flatview_write(subpage->fv, addr + subpage->base, attrs, buf, len);
>  }
>  
> @@ -3129,34 +3085,8 @@ static MemTxResult flatview_write_continue(FlatView *fv, hwaddr addr,
>              l = memory_access_size(mr, l, addr1);
>              /* XXX: could force current_cpu to NULL to avoid
>                 potential bugs */
> -            switch (l) {
> -            case 8:
> -                /* 64 bit write access */
> -                val = ldq_p(buf);
> -                result |= memory_region_dispatch_write(mr, addr1, val, 8,
> -                                                       attrs);
> -                break;
> -            case 4:
> -                /* 32 bit write access */
> -                val = (uint32_t)ldl_p(buf);
> -                result |= memory_region_dispatch_write(mr, addr1, val, 4,
> -                                                       attrs);
> -                break;
> -            case 2:
> -                /* 16 bit write access */
> -                val = lduw_p(buf);
> -                result |= memory_region_dispatch_write(mr, addr1, val, 2,
> -                                                       attrs);
> -                break;
> -            case 1:
> -                /* 8 bit write access */
> -                val = ldub_p(buf);
> -                result |= memory_region_dispatch_write(mr, addr1, val, 1,
> -                                                       attrs);
> -                break;
> -            default:
> -                abort();
> -            }
> +            val = ldn_p(buf, l);
> +            result |= memory_region_dispatch_write(mr, addr1, val, l, attrs);
>          } else {
>              /* RAM case */
>              ptr = qemu_ram_ptr_length(mr->ram_block, addr1, &l, false);
> @@ -3217,34 +3147,8 @@ MemTxResult flatview_read_continue(FlatView *fv, hwaddr addr,
>              /* I/O case */
>              release_lock |= prepare_mmio_access(mr);
>              l = memory_access_size(mr, l, addr1);
> -            switch (l) {
> -            case 8:
> -                /* 64 bit read access */
> -                result |= memory_region_dispatch_read(mr, addr1, &val, 8,
> -                                                      attrs);
> -                stq_p(buf, val);
> -                break;
> -            case 4:
> -                /* 32 bit read access */
> -                result |= memory_region_dispatch_read(mr, addr1, &val, 4,
> -                                                      attrs);
> -                stl_p(buf, val);
> -                break;
> -            case 2:
> -                /* 16 bit read access */
> -                result |= memory_region_dispatch_read(mr, addr1, &val, 2,
> -                                                      attrs);
> -                stw_p(buf, val);
> -                break;
> -            case 1:
> -                /* 8 bit read access */
> -                result |= memory_region_dispatch_read(mr, addr1, &val, 1,
> -                                                      attrs);
> -                stb_p(buf, val);
> -                break;
> -            default:
> -                abort();
> -            }
> +            result |= memory_region_dispatch_read(mr, addr1, &val, l, attrs);
> +            stn_p(buf, l, val);
>          } else {
>              /* RAM case */
>              ptr = qemu_ram_ptr_length(mr->ram_block, addr1, &l, false);
> 
