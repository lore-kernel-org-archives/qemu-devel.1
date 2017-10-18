Received: from eggs.gnu.org ([2001:4830:134:3::10]:55075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e4vqc-0000Rh-OM
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 17:25:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e4vqZ-0003OZ-JW
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 17:25:54 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:45158)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e4vqZ-0003ON-Ev
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 17:25:51 -0400
Received: by mail-qk0-x241.google.com with SMTP id f199so8056734qke.2
	for <qemu-devel@nongnu.org>; Wed, 18 Oct 2017 14:25:51 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171017121714.24714-1-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <5ef97dd7-ff46-0746-ada7-2de1ad7baa1e@amsat.org>
Date: Wed, 18 Oct 2017 18:25:47 -0300
MIME-Version: 1.0
In-Reply-To: <20171017121714.24714-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] watch_mem_write: implement 8-byte accesses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Andrew.Baumann@microsoft.com, rth@twiddle.net

On 10/17/2017 09:17 AM, Paolo Bonzini wrote:
> Aligned 8-byte memory writes by a 64-bit target on a 64-bit host should
> always turn into atomic 8-byte writes on the host, however a write
> write watchpoint would end up tearing the 8-byte write into two 4-byte
> writes in access_with_adjusted_size().
> 
> Reported-by: Andrew Baumann <Andrew.Baumann@microsoft.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  exec.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/exec.c b/exec.c
> index b58bc4eff7..db5ae23118 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -2503,6 +2503,9 @@ static MemTxResult watch_mem_read(void *opaque, hwaddr addr, uint64_t *pdata,
>      case 4:
>          data = address_space_ldl(as, addr, attrs, &res);
>          break;
> +    case 8:
> +        data = address_space_ldq(as, addr, attrs, &res);
> +        break;
>      default: abort();
>      }
>      *pdata = data;
> @@ -2528,6 +2531,9 @@ static MemTxResult watch_mem_write(void *opaque, hwaddr addr,
>      case 4:
>          address_space_stl(as, addr, val, attrs, &res);
>          break;
> +    case 8:
> +        address_space_stq(as, addr, val, attrs, &res);
> +        break;
>      default: abort();
>      }
>      return res;
> @@ -2537,6 +2543,16 @@ static const MemoryRegionOps watch_mem_ops = {
>      .read_with_attrs = watch_mem_read,
>      .write_with_attrs = watch_mem_write,
>      .endianness = DEVICE_NATIVE_ENDIAN,
> +    .valid = {
> +        .min_access_size = 1,
> +        .max_access_size = 8,
> +        .unaligned = false,
> +    },
> +    .impl = {
> +        .min_access_size = 1,
> +        .max_access_size = 8,
> +        .unaligned = false,
> +    },
>  };
>  
>  static MemTxResult flatview_write(FlatView *fv, hwaddr addr, MemTxAttrs attrs,
> 
