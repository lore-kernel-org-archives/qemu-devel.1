Received: from eggs.gnu.org ([2001:4830:134:3::10]:53848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1e41pR-0002zF-IU
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 05:37:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1e41pN-000634-Im
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 05:36:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53620)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1e41pN-00062r-Cu
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 05:36:53 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 60F1D356D9
	for <qemu-devel@nongnu.org>; Mon, 16 Oct 2017 09:36:52 +0000 (UTC)
References: <20171016091802.11532-1-david@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <ccae3743-2b8e-bca5-a124-10242f477836@redhat.com>
Date: Mon, 16 Oct 2017 11:36:50 +0200
MIME-Version: 1.0
In-Reply-To: <20171016091802.11532-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1] memory: call log_start after region_add
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 16.10.2017 11:18, David Hildenbrand wrote:
> It might be confusing for some listener implementations that implement
> both, region_add and log_start (e.g. KVM) if we call log_start before an
> actual region was added using region_add.
> 
> This makes current KVM code trigger an assertion
> ("kvm_section_update_flags: error finding slot"). So let's just reverse
> the order instead of tolerating log_start on yet unknown regions.
> 
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  memory.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/memory.c b/memory.c
> index 5e6351a6c1..f39b8592bf 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -2607,12 +2607,12 @@ static void listener_add_address_space(MemoryListener *listener,
>              .offset_within_address_space = int128_get64(fr->addr.start),
>              .readonly = fr->readonly,
>          };
> -        if (fr->dirty_log_mask && listener->log_start) {
> -            listener->log_start(listener, &section, 0, fr->dirty_log_mask);
> -        }
>          if (listener->region_add) {
>              listener->region_add(listener, &section);
>          }
> +        if (fr->dirty_log_mask && listener->log_start) {
> +            listener->log_start(listener, &section, 0, fr->dirty_log_mask);
> +        }
>      }
>      if (listener->commit) {
>          listener->commit(listener);
> 

... deciding to tolerate it in KVM instead (just as it used to be), so
please ignore this patch.

-- 

Thanks,

David
