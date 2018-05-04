Received: from eggs.gnu.org ([2001:4830:134:3::10]:39151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1fEcDz-0005qv-TB
	for qemu-devel@nongnu.org; Fri, 04 May 2018 11:02:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1fEcDy-0000wI-Lv
	for qemu-devel@nongnu.org; Fri, 04 May 2018 11:02:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40920
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1fEcDy-0000lR-H9
	for qemu-devel@nongnu.org; Fri, 04 May 2018 11:02:18 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w44ExrLw015972
	for <qemu-devel@nongnu.org>; Fri, 4 May 2018 11:02:14 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2hrqpspge1-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 04 May 2018 11:02:13 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
	Fri, 4 May 2018 16:02:11 +0100
References: <20180504131605.22816-1-cohuck@redhat.com>
From: Halil Pasic <pasic@linux.ibm.com>
Date: Fri, 4 May 2018 17:02:07 +0200
MIME-Version: 1.0
In-Reply-To: <20180504131605.22816-1-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <3597f256-cc9d-c1a2-9fa1-b8d2d1d3d3d7@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] s390x/css: disabled subchannels cannot be
 status pending
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org

Could we somehow get 'fix' or something similar into the title?

Also do we need cc stable for this? I guess this is broken
for a while now.

On 05/04/2018 03:16 PM, Cornelia Huck wrote:
> The 3270 code will try to post an attention interrupt when the
> 3270 emulator (e.g. x3270) attaches. If the guest has not yet
> enabled the subchannel for the 3270 device, we will give it a
> spurious status during msch when it does so later.

Maybe something like 'The spurious status will preclude the successful
execution of msch (e.g. when the guest later tries to enable
the subchannel).' I had difficulties getting your sentence right-away.

> 
> To fix this, just don't do anything in css_conditional_io_interrupt()
> if the subchannel is not enabled. The 3270 code will work fine with
> that, and the other user of this function (virtio-ccw) never
> attempts to post an interrupt for a disabled device to begin with.
> 

And I guess vfio-ccw is also unaffected, as the passed through
stuff is going to handle this correctly on the lower levels.

> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>

Overall I agree with the patch.

Acked-by: Halil Pasic <pasic@linux.ibm.com>

> ---
>   hw/s390x/css.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
> index 301bf1772f..56c3fa8c89 100644
> --- a/hw/s390x/css.c
> +++ b/hw/s390x/css.c
> @@ -616,6 +616,14 @@ void css_inject_io_interrupt(SubchDev *sch)
>   
>   void css_conditional_io_interrupt(SubchDev *sch)

Loosely related:
What is the semantic difference between css_inject_io_interrupt and
this css_conditional_io_interrup? The css_conditional_io_interrupt
could be 'unsolicited' or 'virtio notification'. This function also
relies on the serialization of io instructions or?

Also there is this paragraph to be considered if this is indeed
about unsolicited:
"""
The subchannel and device status associated with
an unsolicited interruption condition is never merged
with that of any currently existing interruption condi-
tion. If the subchannel is currently status pending, the
unsolicited interruption condition is held in abeyance
in either the channel subsystem or the device, as
appropriate, until the status-pending condition has
been cleared.
"""


>   {
> +    /*
> +     * If the subchannel is not enabled, it is not made status pending
> +     * (see PoP p. 16-17, "Status Control").
> +     */

In not sure about the reference. We usually don't do that or? And the page
number may change. I would probably just drop the PoP reference.

> +    if (!(sch->curr_status.pmcw.flags & PMCW_FLAGS_MASK_ENA)) {
> +        return;
> +    }
> +

We don't have a scenario where the guest is expected to do some 'recovery'
after being educated about some condition by the means of an alert-status,
do we?

I also wonder if this is the right place to handle the problem. The
3870 also manipulates scsw.dstat before calling this. And I'm not sure
where/if is that cleared, or if it's OK to leave it set...

Regards,
Halil
