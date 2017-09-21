Received: from eggs.gnu.org ([2001:4830:134:3::10]:39434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dv0HQ-0002kZ-5M
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 08:08:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dv0HM-00038f-OQ
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 08:08:32 -0400
References: <1505988260-8483-1-git-send-email-frederic.konrad@adacore.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7a95c1d0-908b-121b-aaf7-df0f859b30b5@redhat.com>
Date: Thu, 21 Sep 2017 14:08:23 +0200
MIME-Version: 1.0
In-Reply-To: <1505988260-8483-1-git-send-email-frederic.konrad@adacore.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] memory: avoid a name clash with access
 macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: KONRAD Frederic <frederic.konrad@adacore.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org

On 21/09/2017 12:04, KONRAD Frederic wrote:
> This avoids a name clash with the access macro on windows 64:
> 
> make
> 	CHK version_gen.h
>   CC      aarch64-softmmu/memory.o
> /home/konrad/qemu/memory.c: In function 'access_with_adjusted_size':
> /home/konrad/qemu/memory.c:591:73: error: macro "access" passed 7 arguments, \
>                          but takes just 2
>                          (size - access_size - i) * 8, access_mask, attrs);
>                                                                          ^
> 
> Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>
> ---
>  memory.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/memory.c b/memory.c
> index b9920a6..2b90117 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -560,13 +560,14 @@ static MemTxResult access_with_adjusted_size(hwaddr addr,
>                                        unsigned size,
>                                        unsigned access_size_min,
>                                        unsigned access_size_max,
> -                                      MemTxResult (*access)(MemoryRegion *mr,
> -                                                            hwaddr addr,
> -                                                            uint64_t *value,
> -                                                            unsigned size,
> -                                                            unsigned shift,
> -                                                            uint64_t mask,
> -                                                            MemTxAttrs attrs),
> +                                      MemTxResult (*access_fn)
> +                                                  (MemoryRegion *mr,
> +                                                   hwaddr addr,
> +                                                   uint64_t *value,
> +                                                   unsigned size,
> +                                                   unsigned shift,
> +                                                   uint64_t mask,
> +                                                   MemTxAttrs attrs),
>                                        MemoryRegion *mr,
>                                        MemTxAttrs attrs)
>  {
> @@ -587,12 +588,12 @@ static MemTxResult access_with_adjusted_size(hwaddr addr,
>      access_mask = -1ULL >> (64 - access_size * 8);
>      if (memory_region_big_endian(mr)) {
>          for (i = 0; i < size; i += access_size) {
> -            r |= access(mr, addr + i, value, access_size,
> +            r |= access_fn(mr, addr + i, value, access_size,
>                          (size - access_size - i) * 8, access_mask, attrs);
>          }
>      } else {
>          for (i = 0; i < size; i += access_size) {
> -            r |= access(mr, addr + i, value, access_size, i * 8,
> +            r |= access_fn(mr, addr + i, value, access_size, i * 8,
>                          access_mask, attrs);
>          }
>      }
> 

Queued, thanks.

Paolo
