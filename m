Received: from eggs.gnu.org ([2001:4830:134:3::10]:58040)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1e4261-0000X1-KG
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 05:54:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1e425y-0005Zm-8J
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 05:54:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59894)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1e425y-0005ZY-21
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 05:54:02 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DA36BC04AC48
	for <qemu-devel@nongnu.org>; Mon, 16 Oct 2017 09:54:00 +0000 (UTC)
References: <20171016094121.16455-1-david@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <650c557c-4c1c-181e-75b5-bcb58ddb2746@redhat.com>
Date: Mon, 16 Oct 2017 11:53:59 +0200
MIME-Version: 1.0
In-Reply-To: <20171016094121.16455-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1] kvm: tolerate non-existing slot for
 log_start and log_stop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, Paolo Bonzini <pbonzini@redhat.com>

On 16.10.2017 11:41, David Hildenbrand wrote:
> log_start might be called by memory.c just before registering the
> section. So we can actually get a log_start without a region_add, which
> we can silently ignore.
> 
> This makes current KVM code trigger an assertion
> ("kvm_section_update_flags: error finding slot").
> 
> Also, if we want to trap every access to a section, we might not have a
> slot. So let's just tolerate if we don't have a slot.
> 
> Fixes: 343562e8fa22 ("kvm: kvm_log_start/stop are only called with known sections")
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  accel/kvm/kvm-all.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 90c88b517d..64de8461e0 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -394,8 +394,11 @@ static int kvm_section_update_flags(KVMMemoryListener *kml,
>  
>      mem = kvm_lookup_matching_slot(kml, start_addr, size);
>      if (!mem) {
> -        fprintf(stderr, "%s: error finding slot\n", __func__);
> -        abort();
> +        /*
> +         * log_start() might be called before region_add(), and sometimes
> +         * we don't have a slot as we want to trap every access.
> +         */
> +        return 0;
>      }
>  
>      return kvm_slot_update_flags(kml, mem, section->mr);
> 

I'll also send a patch for log_sync(), dropping the same assert.

Looks like adding these assertions was counter productive :)

-- 

Thanks,

David
