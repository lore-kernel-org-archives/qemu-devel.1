Received: from eggs.gnu.org ([2001:4830:134:3::10]:56298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1ezLXF-0003w3-SC
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 08:11:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1ezLXA-0008Rr-E8
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 08:11:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42946)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1ezLXA-0008R1-5J
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 08:11:00 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w2NC9VOL045678
	for <qemu-devel@nongnu.org>; Fri, 23 Mar 2018 08:10:58 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2gw04jb83n-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 23 Mar 2018 08:10:58 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 23 Mar 2018 12:10:56 -0000
References: <20180309090006.10018-1-peterx@redhat.com>
	<20180309090006.10018-21-peterx@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 23 Mar 2018 13:10:51 +0100
MIME-Version: 1.0
In-Reply-To: <20180309090006.10018-21-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <1bd08e1d-b6ff-6b39-e053-599bddd1a208@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v8 20/23] monitor: enable IO thread for
 (qmp & !mux) typed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, Stefan Hajnoczi <shajnocz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>

As Max Reitz said, this breaks several qemu iotests. I can reproduce that on s390
e.g. with ./check -qcow2 030 in the qemu-iotest.

Why was this merged?


On 03/09/2018 10:00 AM, Peter Xu wrote:
> Start to use dedicate IO thread for QMP monitors that are not using
> MUXed chardev.
> 
> Reviewed-by: Fam Zheng <famz@redhat.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  monitor.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/monitor.c b/monitor.c
> index c6de5f123e..9e8ee2ed14 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -36,6 +36,7 @@
>  #include "net/slirp.h"
>  #include "chardev/char-fe.h"
>  #include "chardev/char-io.h"
> +#include "chardev/char-mux.h"
>  #include "ui/qemu-spice.h"
>  #include "sysemu/numa.h"
>  #include "monitor/monitor.h"
> @@ -4533,8 +4534,10 @@ static void monitor_qmp_setup_handlers_bh(void *opaque)
>  void monitor_init(Chardev *chr, int flags)
>  {
>      Monitor *mon = g_malloc(sizeof(*mon));
> +    /* Enable IOThread for QMPs that are not using MUX chardev backends. */
> +    bool use_io_thr = (!CHARDEV_IS_MUX(chr)) && (flags & MONITOR_USE_CONTROL);
> 
> -    monitor_data_init(mon, false, false);
> +    monitor_data_init(mon, false, use_io_thr);
> 
>      qemu_chr_fe_init(&mon->chr, chr, &error_abort);
>      mon->flags = flags;
> 
