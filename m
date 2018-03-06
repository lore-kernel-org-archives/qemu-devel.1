Received: from eggs.gnu.org ([2001:4830:134:3::10]:58820)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1et7JE-0007fv-44
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 02:46:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1et7JD-0004qE-3W
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 02:46:52 -0500
Received: from mail-it0-x244.google.com ([2607:f8b0:4001:c0b::244]:34350)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1et7JC-0004q2-UN
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 02:46:51 -0500
Received: by mail-it0-x244.google.com with SMTP id n128so11819291ith.1
	for <qemu-devel@nongnu.org>; Mon, 05 Mar 2018 23:46:50 -0800 (PST)
References: <20180305083655.6186-1-pbonzini@redhat.com>
	<20180305083655.6186-6-pbonzini@redhat.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <dd7d2a9d-7fd4-0e98-ba72-f2c5e0b2cc71@ozlabs.ru>
Date: Tue, 6 Mar 2018 18:46:45 +1100
MIME-Version: 1.0
In-Reply-To: <20180305083655.6186-6-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 5/7] address_space_access_valid:
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
> address_space_access_valid is calling address_space_to_flatview but it can
> be called outside the RCU lock.  To fix it, push the rcu_read_lock/unlock
> pair up from flatview_access_valid to address_space_access_valid.
> 
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>

> ---
>  exec.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/exec.c b/exec.c
> index 55b7452bd7..177583c2ee 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -3391,7 +3391,6 @@ static bool flatview_access_valid(FlatView *fv, hwaddr addr, int len,
>      MemoryRegion *mr;
>      hwaddr l, xlat;
>  
> -    rcu_read_lock();
>      while (len > 0) {
>          l = len;
>          mr = flatview_translate(fv, addr, &xlat, &l, is_write);
> @@ -3406,15 +3405,20 @@ static bool flatview_access_valid(FlatView *fv, hwaddr addr, int len,
>          len -= l;
>          addr += l;
>      }
> -    rcu_read_unlock();
>      return true;
>  }
>  
>  bool address_space_access_valid(AddressSpace *as, hwaddr addr,
>                                  int len, bool is_write)
>  {
> -    return flatview_access_valid(address_space_to_flatview(as),
> -                                 addr, len, is_write);
> +    FlatView *fv;
> +    bool result;
> +
> +    rcu_read_lock();
> +    fv = address_space_to_flatview(as);
> +    result = flatview_access_valid(fv, addr, len, is_write);
> +    rcu_read_unlock();
> +    return result;
>  }
>  
>  static hwaddr
> 


-- 
Alexey
