Received: from eggs.gnu.org ([2001:4830:134:3::10]:58872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1et7JP-0007qL-Qc
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 02:47:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1et7JL-0004uU-Ti
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 02:47:03 -0500
Received: from mail-io0-x22b.google.com ([2607:f8b0:4001:c06::22b]:46183)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1et7JL-0004uF-OR
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 02:46:59 -0500
Received: by mail-io0-x22b.google.com with SMTP id p78so21017561iod.13
	for <qemu-devel@nongnu.org>; Mon, 05 Mar 2018 23:46:59 -0800 (PST)
References: <20180305083655.6186-1-pbonzini@redhat.com>
	<20180305083655.6186-7-pbonzini@redhat.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <49f71401-8f88-e4ae-4f9b-8547c5ed6498@ozlabs.ru>
Date: Tue, 6 Mar 2018 18:46:54 +1100
MIME-Version: 1.0
In-Reply-To: <20180305083655.6186-7-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 6/7] address_space_map:
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
> address_space_map is calling address_space_to_flatview but it can
> be called outside the RCU lock.  The function itself is calling
> rcu_read_lock/rcu_read_unlock, just in the wrong place, so the
> fix is easy.
> 
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>


> ---
>  exec.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/exec.c b/exec.c
> index 177583c2ee..070eaff3e7 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -3464,7 +3464,7 @@ void *address_space_map(AddressSpace *as,
>      hwaddr l, xlat;
>      MemoryRegion *mr;
>      void *ptr;
> -    FlatView *fv = address_space_to_flatview(as);
> +    FlatView *fv;
>  
>      if (len == 0) {
>          return NULL;
> @@ -3472,6 +3472,7 @@ void *address_space_map(AddressSpace *as,
>  
>      l = len;
>      rcu_read_lock();
> +    fv = address_space_to_flatview(as);
>      mr = flatview_translate(fv, addr, &xlat, &l, is_write);
>  
>      if (!memory_access_is_direct(mr, is_write)) {
> 


-- 
Alexey
