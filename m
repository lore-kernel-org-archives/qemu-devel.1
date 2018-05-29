Received: from eggs.gnu.org ([2001:4830:134:3::10]:47472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fNasX-0005cH-EZ
	for qemu-devel@nongnu.org; Tue, 29 May 2018 05:25:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fNasT-0008SC-D1
	for qemu-devel@nongnu.org; Tue, 29 May 2018 05:25:17 -0400
References: <20180529030445.177867-1-tburgessdev@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e851ab0a-e019-f410-7356-3dfcd9b3a9d3@redhat.com>
Date: Tue, 29 May 2018 11:25:09 +0200
MIME-Version: 1.0
In-Reply-To: <20180529030445.177867-1-tburgessdev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] memory: bug 1720969: Make operations using
 MemoryRegionIoeventfd struct pass by pointer.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tristan Burgess <tburgessdev@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org

On 29/05/2018 05:04, Tristan Burgess wrote:
> This changes the functions memory_region_ioeventfd_equal, memory_region_ioeventfd_before, and their callers,
> to pass the MemoryRegionIoeventfd struct via pointer, instead of directly passing the struct. This saves on stack space
> and is considered safe practice.
> 
> Signed-off-by: Tristan Burgess <tburgessdev@gmail.com>
> ---
>  memory.c | 44 ++++++++++++++++++++++----------------------
>  1 file changed, 22 insertions(+), 22 deletions(-)
> 
> diff --git a/memory.c b/memory.c
> index fc7f9b782b..a2b9bb88f3 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -173,38 +173,38 @@ struct MemoryRegionIoeventfd {
>      EventNotifier *e;
>  };
>  
> -static bool memory_region_ioeventfd_before(MemoryRegionIoeventfd a,
> -                                           MemoryRegionIoeventfd b)
> +static bool memory_region_ioeventfd_before(MemoryRegionIoeventfd *a,
> +                                           MemoryRegionIoeventfd *b)
>  {
> -    if (int128_lt(a.addr.start, b.addr.start)) {
> +    if (int128_lt(a->addr.start, b->addr.start)) {
>          return true;
> -    } else if (int128_gt(a.addr.start, b.addr.start)) {
> +    } else if (int128_gt(a->addr.start, b->addr.start)) {
>          return false;
> -    } else if (int128_lt(a.addr.size, b.addr.size)) {
> +    } else if (int128_lt(a->addr.size, b->addr.size)) {
>          return true;
> -    } else if (int128_gt(a.addr.size, b.addr.size)) {
> +    } else if (int128_gt(a->addr.size, b->addr.size)) {
>          return false;
> -    } else if (a.match_data < b.match_data) {
> +    } else if (a->match_data < b->match_data) {
>          return true;
> -    } else  if (a.match_data > b.match_data) {
> +    } else  if (a->match_data > b->match_data) {
>          return false;
> -    } else if (a.match_data) {
> -        if (a.data < b.data) {
> +    } else if (a->match_data) {
> +        if (a->data < b->data) {
>              return true;
> -        } else if (a.data > b.data) {
> +        } else if (a->data > b->data) {
>              return false;
>          }
>      }
> -    if (a.e < b.e) {
> +    if (a->e < b->e) {
>          return true;
> -    } else if (a.e > b.e) {
> +    } else if (a->e > b->e) {
>          return false;
>      }
>      return false;
>  }
>  
> -static bool memory_region_ioeventfd_equal(MemoryRegionIoeventfd a,
> -                                          MemoryRegionIoeventfd b)
> +static bool memory_region_ioeventfd_equal(MemoryRegionIoeventfd *a,
> +                                          MemoryRegionIoeventfd *b)
>  {
>      return !memory_region_ioeventfd_before(a, b)
>          && !memory_region_ioeventfd_before(b, a);
> @@ -791,8 +791,8 @@ static void address_space_add_del_ioeventfds(AddressSpace *as,
>      while (iold < fds_old_nb || inew < fds_new_nb) {
>          if (iold < fds_old_nb
>              && (inew == fds_new_nb
> -                || memory_region_ioeventfd_before(fds_old[iold],
> -                                                  fds_new[inew]))) {
> +                || memory_region_ioeventfd_before(&fds_old[iold],
> +                                                  &fds_new[inew]))) {
>              fd = &fds_old[iold];
>              section = (MemoryRegionSection) {
>                  .fv = address_space_to_flatview(as),
> @@ -804,8 +804,8 @@ static void address_space_add_del_ioeventfds(AddressSpace *as,
>              ++iold;
>          } else if (inew < fds_new_nb
>                     && (iold == fds_old_nb
> -                       || memory_region_ioeventfd_before(fds_new[inew],
> -                                                         fds_old[iold]))) {
> +                       || memory_region_ioeventfd_before(&fds_new[inew],
> +                                                         &fds_old[iold]))) {
>              fd = &fds_new[inew];
>              section = (MemoryRegionSection) {
>                  .fv = address_space_to_flatview(as),
> @@ -1443,7 +1443,7 @@ static bool memory_region_dispatch_write_eventfds(MemoryRegion *mr,
>          ioeventfd.match_data = mr->ioeventfds[i].match_data;
>          ioeventfd.e = mr->ioeventfds[i].e;
>  
> -        if (memory_region_ioeventfd_equal(ioeventfd, mr->ioeventfds[i])) {
> +        if (memory_region_ioeventfd_equal(&ioeventfd, &mr->ioeventfds[i])) {
>              event_notifier_set(ioeventfd.e);
>              return true;
>          }
> @@ -2213,7 +2213,7 @@ void memory_region_add_eventfd(MemoryRegion *mr,
>      }
>      memory_region_transaction_begin();
>      for (i = 0; i < mr->ioeventfd_nb; ++i) {
> -        if (memory_region_ioeventfd_before(mrfd, mr->ioeventfds[i])) {
> +        if (memory_region_ioeventfd_before(&mrfd, &mr->ioeventfds[i])) {
>              break;
>          }
>      }
> @@ -2248,7 +2248,7 @@ void memory_region_del_eventfd(MemoryRegion *mr,
>      }
>      memory_region_transaction_begin();
>      for (i = 0; i < mr->ioeventfd_nb; ++i) {
> -        if (memory_region_ioeventfd_equal(mrfd, mr->ioeventfds[i])) {
> +        if (memory_region_ioeventfd_equal(&mrfd, &mr->ioeventfds[i])) {
>              break;
>          }
>      }
> 

Queued, thanks.

Paolo
