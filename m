Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D98C83001
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 16:31:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42E8B20746
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 16:31:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YPo96fxg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42E8B20746
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTT8j-0004VL-Av
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 12:31:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33190)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <joao.m.martins@oracle.com>) id 1jTT5O-0007hg-CW
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 12:28:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <joao.m.martins@oracle.com>) id 1jTT2W-0003hC-Tp
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 12:27:54 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:39756)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1jTT2W-0003h4-Ay
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 12:24:56 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03SGNRxl087258;
 Tue, 28 Apr 2020 16:24:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=ia2Wy9rUcK3VbudgTV66PLeEy8zQ0qRl4VzYWkTP4DQ=;
 b=YPo96fxg5lCnjOk4m8vdFdk4xFRKeVrjnwFuxOmqF4aEMRHhDt4tCae6EXvC4zWgz8cx
 nJ03QVPpfDbHn4kv2aojQLSITm2qC21RJSZs5u/WuB221hpVL3wvbF9CpLJk9zt8Z7NT
 4JX6pQpkJXoKpnH71PKoaJ1LVbZxDoItSzxnhjB921de0AiTWoD967YoRSidH2Ce0Ob1
 TvmmHKkkJ0OqTTIi79GlaOZeuJNeo3+YntQpZUFZI2ZU/Qa8V6pOv3UJFOnpATCEhCaR
 nBg3ELTtVtMEsZYmthaoJSkS33AzvNrPm7fcMFlhUAlgy9dxOOaMDGK/TJeLat8zrfE0 iQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2130.oracle.com with ESMTP id 30p01nqj6h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 Apr 2020 16:24:52 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03SGLuIW110996;
 Tue, 28 Apr 2020 16:22:51 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3020.oracle.com with ESMTP id 30mxx05x1s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 Apr 2020 16:22:51 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03SGMo2Z026920;
 Tue, 28 Apr 2020 16:22:50 GMT
Received: from [10.175.178.2] (/10.175.178.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 28 Apr 2020 09:22:50 -0700
Subject: Re: [PATCH v2 1/3] exec: fetch the alignment of Linux devdax pmem
 character device nodes
To: Jingqi Liu <jingqi.liu@intel.com>
References: <20200415033538.43329-1-jingqi.liu@intel.com>
 <20200415033538.43329-2-jingqi.liu@intel.com>
From: Joao Martins <joao.m.martins@oracle.com>
Message-ID: <e2dd8b7d-5342-0739-6724-410994a96cd6@oracle.com>
Date: Tue, 28 Apr 2020 17:22:47 +0100
MIME-Version: 1.0
In-Reply-To: <20200415033538.43329-2-jingqi.liu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9605
 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 spamscore=0 bulkscore=0
 suspectscore=1 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004280128
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9605
 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0 clxscore=1015
 phishscore=0 mlxlogscore=999 adultscore=0 priorityscore=1501 mlxscore=0
 suspectscore=1 malwarescore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004280128
Received-SPF: pass client-ip=156.151.31.86;
 envelope-from=joao.m.martins@oracle.com; helo=userp2130.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 11:32:26
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.86
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/15/20 4:35 AM, Jingqi Liu wrote:
> If the backend file is devdax pmem character device, the alignment
> specified by the option 'align=NUM' in the '-object memory-backend-file'
> needs to match the alignment requirement of the devdax pmem character device.
> 
> This patch uses the interfaces of libdaxctl to fetch the devdax pmem file
> 'align', so that we can compare it with the NUM of 'align=NUM'.
> The NUM needs to be larger than or equal to the devdax pmem file 'align'.
> 
> It also fixes the problem that mmap() returns failure in qemu_ram_mmap()
> when the NUM of 'align=NUM' is less than the devdax pmem file 'align'.
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Jingqi Liu <jingqi.liu@intel.com>

  Reviewed-by: Joao Martins <joao.m.martins@oracle.com>

I also no longer see the previous problem we talked in v1 wrt to ABI differences
between dax_pmem_compat (your case) vs dax_pmem|dax_hmem (my case). The @align
validation also occurs as expected.

> ---
>  exec.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 53 insertions(+), 1 deletion(-)
> 
> diff --git a/exec.c b/exec.c
> index de9d949902..2c3444e47e 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -77,6 +77,10 @@
>  
>  #include "monitor/monitor.h"
>  
> +#ifdef CONFIG_LIBDAXCTL
> +#include <daxctl/libdaxctl.h>
> +#endif
> +
>  //#define DEBUG_SUBPAGE
>  
>  #if !defined(CONFIG_USER_ONLY)
> @@ -1736,6 +1740,46 @@ static int64_t get_file_size(int fd)
>      return size;
>  }
>  
> +static int64_t get_file_align(int fd)
> +{
> +    int64_t align = -1;
> +#if defined(__linux__) && defined(CONFIG_LIBDAXCTL)
> +    struct stat st;
> +
> +    if (fstat(fd, &st) < 0) {
> +        return -errno;
> +    }
> +
> +    /* Special handling for devdax character devices */
> +    if (S_ISCHR(st.st_mode)) {
> +        g_autofree char *path = NULL;
> +        g_autofree char *rpath = NULL;
> +        struct daxctl_ctx *ctx;
> +        struct daxctl_region *region;
> +        int rc = 0;
> +
> +        path = g_strdup_printf("/sys/dev/char/%d:%d",
> +                    major(st.st_rdev), minor(st.st_rdev));
> +        rpath = realpath(path, NULL);
> +
> +        rc = daxctl_new(&ctx);
> +        if (rc) {
> +            return -1;
> +        }
> +
> +        daxctl_region_foreach(ctx, region) {
> +            if (strstr(rpath, daxctl_region_get_path(region))) {
> +                align = daxctl_region_get_align(region);
> +                break;
> +            }
> +        }
> +        daxctl_unref(ctx);
> +    }
> +#endif /* defined(__linux__) && defined(CONFIG_LIBDAXCTL) */
> +
> +    return align;
> +}
> +
>  static int file_ram_open(const char *path,
>                           const char *region_name,
>                           bool *created,
> @@ -2275,7 +2319,7 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
>  {
>      RAMBlock *new_block;
>      Error *local_err = NULL;
> -    int64_t file_size;
> +    int64_t file_size, file_align;
>  
>      /* Just support these ram flags by now. */
>      assert((ram_flags & ~(RAM_SHARED | RAM_PMEM)) == 0);
> @@ -2311,6 +2355,14 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
>          return NULL;
>      }
>  
> +    file_align = get_file_align(fd);
> +    if (file_align > 0 && mr && file_align > mr->align) {
> +        error_setg(errp, "backing store align 0x%" PRIx64
> +                   " is larger than 'align' option 0x" RAM_ADDR_FMT,
> +                   file_align, mr->align);
> +        return NULL;
> +    }
> +
>      new_block = g_malloc0(sizeof(*new_block));
>      new_block->mr = mr;
>      new_block->used_length = size;
> 

