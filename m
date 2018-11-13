Received: from eggs.gnu.org ([2001:4830:134:3::10]:60281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1gMTNJ-00038Q-3h
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 02:44:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1gMTNF-0004vm-Nh
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 02:44:41 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:37540)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liam.merwick@oracle.com>)
	id 1gMTNF-0004ty-DL
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 02:44:37 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
	by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id
	wAD7hXEh100363
	for <qemu-devel@nongnu.org>; Tue, 13 Nov 2018 07:44:35 GMT
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
	by userp2130.oracle.com with ESMTP id 2nnwg18qn2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <qemu-devel@nongnu.org>; Tue, 13 Nov 2018 07:44:35 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
	by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wAD7iYFR020151
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK) for <qemu-devel@nongnu.org>; Tue, 13 Nov 2018 07:44:34 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
	by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wAD7iYm0023227
	for <qemu-devel@nongnu.org>; Tue, 13 Nov 2018 07:44:34 GMT
References: <20181113070320.16147-1-kraxel@redhat.com>
From: Liam Merwick <liam.merwick@oracle.com>
Message-ID: <b96361ca-19a9-87e0-02cf-3682a2889514@oracle.com>
Date: Tue, 13 Nov 2018 07:44:32 +0000
MIME-Version: 1.0
In-Reply-To: <20181113070320.16147-1-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] slirp: add tftp tracing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org


On 13/11/2018 07:03, Gerd Hoffmann wrote:
> Useful when debugging pxeboot, to see what the guest tries to do.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Liam Merwick <liam.merwick@oracle.com>


> ---
>   Makefile.objs      | 1 +
>   slirp/tftp.c       | 3 +++
>   slirp/trace-events | 5 +++++
>   3 files changed, 9 insertions(+)
>   create mode 100644 slirp/trace-events
> 
> diff --git a/Makefile.objs b/Makefile.objs
> index 1e1ff387d7..31852eaf8f 100644
> --- a/Makefile.objs
> +++ b/Makefile.objs
> @@ -251,6 +251,7 @@ trace-events-subdirs += net
>   trace-events-subdirs += qapi
>   trace-events-subdirs += qom
>   trace-events-subdirs += scsi
> +trace-events-subdirs += slirp
>   trace-events-subdirs += target/arm
>   trace-events-subdirs += target/i386
>   trace-events-subdirs += target/mips
> diff --git a/slirp/tftp.c b/slirp/tftp.c
> index a9bc4bb1b6..735b57aa55 100644
> --- a/slirp/tftp.c
> +++ b/slirp/tftp.c
> @@ -26,6 +26,7 @@
>   #include "slirp.h"
>   #include "qemu-common.h"
>   #include "qemu/cutils.h"
> +#include "trace.h"
>   
>   static inline int tftp_session_in_use(struct tftp_session *spt)
>   {
> @@ -204,6 +205,7 @@ static void tftp_send_error(struct tftp_session *spt,
>     struct mbuf *m;
>     struct tftp_t *tp;
>   
> +  trace_slirp_tftp_error(msg);
>     m = m_get(spt->slirp);
>   
>     if (!m) {
> @@ -323,6 +325,7 @@ static void tftp_handle_rrq(Slirp *slirp, struct sockaddr_storage *srcsas,
>         break;
>       }
>     }
> +  trace_slirp_tftp_rrq(req_fname);
>   
>     /* check mode */
>     if ((pktlen - k) < 6) {
> diff --git a/slirp/trace-events b/slirp/trace-events
> new file mode 100644
> index 0000000000..ff8f656e8c
> --- /dev/null
> +++ b/slirp/trace-events
> @@ -0,0 +1,5 @@
> +# See docs/devel/tracing.txt for syntax documentation.
> +
> +# slirp/tftp.c
> +slirp_tftp_rrq(const char *file) "file: %s"
> +slirp_tftp_error(const char *file) "msg: %s"
> 
