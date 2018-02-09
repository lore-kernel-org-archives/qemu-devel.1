Received: from eggs.gnu.org ([2001:4830:134:3::10]:35363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <muriloo@linux.vnet.ibm.com>) id 1ekFHB-0001Gk-16
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 15:28:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <muriloo@linux.vnet.ibm.com>) id 1ekFH7-0001kq-Rl
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 15:28:05 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55980)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <muriloo@linux.vnet.ibm.com>)
	id 1ekFH7-0001kC-Jv
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 15:28:01 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w19KOlRX133308
	for <qemu-devel@nongnu.org>; Fri, 9 Feb 2018 15:27:59 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2g1fgf794r-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 09 Feb 2018 15:27:59 -0500
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <muriloo@linux.vnet.ibm.com>;
	Fri, 9 Feb 2018 13:27:58 -0700
References: <20180209193138.97198-1-yasmins@linux.vnet.ibm.com>
From: Murilo Opsfelder Araujo <muriloo@linux.vnet.ibm.com>
Date: Fri, 9 Feb 2018 18:27:53 -0200
MIME-Version: 1.0
In-Reply-To: <20180209193138.97198-1-yasmins@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <a41b6688-7b61-c988-03fe-9d55f2e13d26@linux.vnet.ibm.com>
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

Hi, Yasmin.

Congratulations on your first patch!

On 02/09/2018 05:31 PM, Yasmin Beatriz wrote:
> This patch intends to make a more specific message for when
> the system has not enough space to save guest memory.
> 
> Reported-by: yilzhang@redhat.com
> Cc: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
> Signed-off-by: Yasmin Beatriz <yasmins@linux.vnet.ibm.com>
> ---
>  dump.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/dump.c b/dump.c
> index e9dfed060a..eb56ff53f6 100644
> --- a/dump.c
> +++ b/dump.c
> @@ -106,6 +106,9 @@ static int fd_write_vmcore(const void *buf, size_t size, void *opaque)
> 
>      written_size = qemu_write_full(s->fd, buf, size);
>      if (written_size != size) {
> +        if (errno == ENOSPC) {
> +            return -ENOSPC;
> +        }
>          return -1;
>      }
> 
> @@ -364,7 +367,11 @@ static void write_data(DumpState *s, void *buf, int length, Error **errp)
> 
>      ret = fd_write_vmcore(buf, length, s);
>      if (ret < 0) {
> -        error_setg(errp, "dump: failed to save memory");
> +        if (ret == -ENOSPC) {
> +            error_setg(errp, "dump: not enough space to save memory");
> +        } else {
> +            error_setg(errp, "dump: failed to save memory");
> +        }

If fd_write_vmcore() returned -errno, as Daniel Barboza suggested, it
could be used in error_setg_errno(). Something like this:

diff --git a/dump.c b/dump.c
index e9dfed060a..313a7460a7 100644
--- a/dump.c
+++ b/dump.c
@@ -106,7 +106,7 @@ static int fd_write_vmcore(const void *buf, size_t
size, void *opaque)

     written_size = qemu_write_full(s->fd, buf, size);
     if (written_size != size) {
-        return -1;
+        return -errno;
     }

     return 0;
@@ -364,7 +364,7 @@ static void write_data(DumpState *s, void *buf, int
length, Error **errp)

     ret = fd_write_vmcore(buf, length, s);
     if (ret < 0) {
-        error_setg(errp, "dump: failed to save memory");
+        error_setg_errno(errp, ret, "dump: failed to save memory");
     } else {
         s->written_size += length;
     }

With this, other reasons of errno would also be considered, not only ENOSPC.

Cheers
Murilo
