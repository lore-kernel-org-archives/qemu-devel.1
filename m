Received: from eggs.gnu.org ([209.51.188.92]:39391)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1gm0xH-00067f-M2
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:39:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1gm0x5-0000i5-Qj
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:39:15 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46818)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1gm0x3-0000eB-8Z
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:39:09 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x0MErb8Y082480
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 09:57:06 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2q63st4j7c-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 09:57:06 -0500
Received: from localhost
	by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
	Tue, 22 Jan 2019 14:57:03 -0000
Date: Tue, 22 Jan 2019 15:56:56 +0100
From: Halil Pasic <pasic@linux.ibm.com>
In-Reply-To: <20190121110354.2247-2-cohuck@redhat.com>
References: <20190121110354.2247-1-cohuck@redhat.com>
	<20190121110354.2247-2-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20190122155656.0ecd292e@oc2783563651>
Subject: Re: [Qemu-devel] [PATCH v2 1/5] vfio-ccw: make it safe to access
 channel programs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Eric Farman <farman@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org

On Mon, 21 Jan 2019 12:03:50 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> When we get a solicited interrupt, the start function may have
> been cleared by a csch, but we still have a channel program
> structure allocated. Make it safe to call the cp accessors in
> any case, so we can call them unconditionally.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  drivers/s390/cio/vfio_ccw_cp.c | 3 +++
>  drivers/s390/cio/vfio_ccw_cp.h | 2 ++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
> index 70a006ba4d05..714987ceea9a 100644
> --- a/drivers/s390/cio/vfio_ccw_cp.c
> +++ b/drivers/s390/cio/vfio_ccw_cp.c
> @@ -335,6 +335,7 @@ static void cp_unpin_free(struct channel_program *cp)
>  	struct ccwchain *chain, *temp;
>  	int i;
>  
> +	cp->initialized = false;
>  	list_for_each_entry_safe(chain, temp, &cp->ccwchain_list, next) {
>  		for (i = 0; i < chain->ch_len; i++) {
>  			pfn_array_table_unpin_free(chain->ch_pat + i,
> @@ -701,6 +702,8 @@ int cp_init(struct channel_program *cp, struct device *mdev, union orb *orb)
>  	 */
>  	cp->orb.cmd.c64 = 1;
>  
> +	cp->initialized = true;
> +
>  	return ret;
>  }
>  
> diff --git a/drivers/s390/cio/vfio_ccw_cp.h b/drivers/s390/cio/vfio_ccw_cp.h
> index a4b74fb1aa57..3c20cd208da5 100644
> --- a/drivers/s390/cio/vfio_ccw_cp.h
> +++ b/drivers/s390/cio/vfio_ccw_cp.h
> @@ -21,6 +21,7 @@
>   * @ccwchain_list: list head of ccwchains
>   * @orb: orb for the currently processed ssch request
>   * @mdev: the mediated device to perform page pinning/unpinning
> + * @initialized: whether this instance is actually initialized
>   *
>   * @ccwchain_list is the head of a ccwchain list, that contents the
>   * translated result of the guest channel program that pointed out by
> @@ -30,6 +31,7 @@ struct channel_program {
>  	struct list_head ccwchain_list;
>  	union orb orb;
>  	struct device *mdev;
> +	bool initialized;
>  };
>  
>  extern int cp_init(struct channel_program *cp, struct device *mdev,

I fail to see how is this patch delivering on the promise made by it's
title. I see only code that sets cp->initialized but none that reads it.
The follow-up patches don't seem to care for cp->initialized either.

Regards,
Halil
