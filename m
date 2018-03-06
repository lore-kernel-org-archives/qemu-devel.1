Received: from eggs.gnu.org ([2001:4830:134:3::10]:58941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1et7Jd-00080z-6z
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 02:47:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1et7JZ-00054i-9X
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 02:47:17 -0500
Received: from mail-it0-x243.google.com ([2607:f8b0:4001:c0b::243]:33560)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1et7JZ-00054A-4J
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 02:47:13 -0500
Received: by mail-it0-x243.google.com with SMTP id w19so11834396ite.0
	for <qemu-devel@nongnu.org>; Mon, 05 Mar 2018 23:47:12 -0800 (PST)
References: <20180305083655.6186-1-pbonzini@redhat.com>
	<20180305083655.6186-8-pbonzini@redhat.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <59de5f91-c71c-27bc-7e93-74f5f02013ce@ozlabs.ru>
Date: Tue, 6 Mar 2018 18:47:08 +1100
MIME-Version: 1.0
In-Reply-To: <20180305083655.6186-8-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 7/7] address_space_rw:
 address_space_to_flatview needs RCU lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-stable@nongnu.org

On 05/03/18 19:36, Paolo Bonzini wrote:
> address_space_rw is calling address_space_to_flatview but it can
> be called outside the RCU lock.  To fix it, transform flatview_rw
> into address_space_rw, since flatview_rw is otherwise unused.
> 
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>



> ---
>  exec.c | 28 ++++++++++------------------
>  1 file changed, 10 insertions(+), 18 deletions(-)
> 
> diff --git a/exec.c b/exec.c
> index 070eaff3e7..8a99114c69 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -3177,24 +3177,6 @@ static MemTxResult flatview_read(FlatView *fv, hwaddr addr,
>                                    addr1, l, mr);
>  }
>  
> -static MemTxResult flatview_rw(FlatView *fv, hwaddr addr, MemTxAttrs attrs,
> -                               uint8_t *buf, int len, bool is_write)
> -{
> -    if (is_write) {
> -        return flatview_write(fv, addr, attrs, (uint8_t *)buf, len);
> -    } else {
> -        return flatview_read(fv, addr, attrs, (uint8_t *)buf, len);
> -    }
> -}
> -
> -MemTxResult address_space_rw(AddressSpace *as, hwaddr addr,
> -                             MemTxAttrs attrs, uint8_t *buf,
> -                             int len, bool is_write)
> -{
> -    return flatview_rw(address_space_to_flatview(as),
> -                       addr, attrs, buf, len, is_write);
> -}
> -
>  MemTxResult address_space_read_full(AddressSpace *as, hwaddr addr,
>                                      MemTxAttrs attrs, uint8_t *buf, int len)
>  {
> @@ -3228,6 +3210,16 @@ MemTxResult address_space_write(AddressSpace *as, hwaddr addr,
>      return result;
>  }
>  
> +MemTxResult address_space_rw(AddressSpace *as, hwaddr addr, MemTxAttrs attrs,
> +                             uint8_t *buf, int len, bool is_write)
> +{
> +    if (is_write) {
> +        return address_space_write(as, addr, attrs, buf, len);
> +    } else {
> +        return address_space_read_full(as, addr, attrs, buf, len);
> +    }
> +}
> +
>  void cpu_physical_memory_rw(hwaddr addr, uint8_t *buf,
>                              int len, int is_write)
>  {
> 


-- 
Alexey
