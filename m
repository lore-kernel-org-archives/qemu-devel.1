Received: from eggs.gnu.org ([2001:4830:134:3::10]:60407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fFbic-00028p-QY
	for qemu-devel@nongnu.org; Mon, 07 May 2018 04:42:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fFbiZ-0007eb-NB
	for qemu-devel@nongnu.org; Mon, 07 May 2018 04:42:02 -0400
References: <20180504131605.22816-1-cohuck@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <9d5c99ad-9055-1785-3e52-eb56485b4ed6@redhat.com>
Date: Mon, 7 May 2018 10:41:49 +0200
MIME-Version: 1.0
In-Reply-To: <20180504131605.22816-1-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH] s390x/css: disabled
 subchannels cannot be status pending
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>
Cc: Halil Pasic <pasic@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org

On 04.05.2018 15:16, Cornelia Huck wrote:
> The 3270 code will try to post an attention interrupt when the
> 3270 emulator (e.g. x3270) attaches. If the guest has not yet
> enabled the subchannel for the 3270 device, we will give it a
> spurious status during msch when it does so later.
> 
> To fix this, just don't do anything in css_conditional_io_interrupt()
> if the subchannel is not enabled. The 3270 code will work fine with
> that, and the other user of this function (virtio-ccw) never
> attempts to post an interrupt for a disabled device to begin with.
> 
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  hw/s390x/css.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
> index 301bf1772f..56c3fa8c89 100644
> --- a/hw/s390x/css.c
> +++ b/hw/s390x/css.c
> @@ -616,6 +616,14 @@ void css_inject_io_interrupt(SubchDev *sch)
>  
>  void css_conditional_io_interrupt(SubchDev *sch)
>  {
> +    /*
> +     * If the subchannel is not enabled, it is not made status pending
> +     * (see PoP p. 16-17, "Status Control").
> +     */
> +    if (!(sch->curr_status.pmcw.flags & PMCW_FLAGS_MASK_ENA)) {
> +        return;
> +    }
> +
>      /*
>       * If the subchannel is not currently status pending, make it pending
>       * with alert status.
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb
