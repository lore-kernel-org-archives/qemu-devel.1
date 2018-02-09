Received: from eggs.gnu.org ([2001:4830:134:3::10]:59523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1ekExJ-0004B1-OI
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 15:07:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1ekExG-0004ML-Lo
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 15:07:33 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40286)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1ekExG-0004Lg-DK
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 15:07:30 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w19K7IOf099022
	for <qemu-devel@nongnu.org>; Fri, 9 Feb 2018 15:07:28 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2g1c3n9ak8-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 09 Feb 2018 15:07:27 -0500
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Fri, 9 Feb 2018 15:07:26 -0500
References: <20180209193138.97198-1-yasmins@linux.vnet.ibm.com>
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Fri, 9 Feb 2018 18:07:21 -0200
MIME-Version: 1.0
In-Reply-To: <20180209193138.97198-1-yasmins@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <1f0c05ec-511a-374d-4be0-7a01a9630867@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] dump: Show custom message for ENOSPC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yasmin Beatriz <yasmins@linux.vnet.ibm.com>, qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-trivial@nongnu.org, joserz@linux.vnet.ibm.com

Hi Yasmin,

On 02/09/2018 05:31 PM, Yasmin Beatriz wrote:
> This patch intends to make a more specific message for when
> the system has not enough space to save guest memory.
>
> Reported-by: yilzhang@redhat.com
> Cc: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
> Signed-off-by: Yasmin Beatriz <yasmins@linux.vnet.ibm.com>
> ---
>   dump.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/dump.c b/dump.c
> index e9dfed060a..eb56ff53f6 100644
> --- a/dump.c
> +++ b/dump.c
> @@ -106,6 +106,9 @@ static int fd_write_vmcore(const void *buf, size_t size, void *opaque)
>
>       written_size = qemu_write_full(s->fd, buf, size);
>       if (written_size != size) {
> +        if (errno == ENOSPC) {
> +            return -ENOSPC;
> +        }
You can do like this:


      if (written_size != size) {
+        return -errno;
+     }


Everyone is checking for a negative "ret" to see if an error occurred in 
qemu_write_full.
There is no negative errno AFAIK, so you can spare one "if" clause there 
and still
check for -ENOSPC down there.

It might be worth checking if this code can't be baked into 
qemu_write_full too.



Thanks,


Daniel

>           return -1;
>       }
>
> @@ -364,7 +367,11 @@ static void write_data(DumpState *s, void *buf, int length, Error **errp)
>
>       ret = fd_write_vmcore(buf, length, s);
>       if (ret < 0) {
> -        error_setg(errp, "dump: failed to save memory");
> +        if (ret == -ENOSPC) {
> +            error_setg(errp, "dump: not enough space to save memory");
> +        } else {
> +            error_setg(errp, "dump: failed to save memory");
> +        }
>       } else {
>           s->written_size += length;
>       }
