Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FFDFC35247
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 21:03:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBD2A20720
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 21:03:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBD2A20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izRpQ-0005h9-3k
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 16:03:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58691)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <muriloo@linux.ibm.com>) id 1izQUG-0002GJ-0a
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 14:37:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <muriloo@linux.ibm.com>) id 1izQUE-00086u-P6
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 14:37:23 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:3606
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <muriloo@linux.ibm.com>)
 id 1izQUE-000845-Ja
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 14:37:22 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 015JTw2q089348; Wed, 5 Feb 2020 14:37:19 -0500
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2xyhmh2v8j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 05 Feb 2020 14:37:19 -0500
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 015JU1Tf089982;
 Wed, 5 Feb 2020 14:37:18 -0500
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com
 [169.55.91.170])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2xyhmh2v7v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 05 Feb 2020 14:37:18 -0500
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
 by ppma02wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 015JPHrV009351;
 Wed, 5 Feb 2020 19:37:18 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by ppma02wdc.us.ibm.com with ESMTP id 2xykc9f5ff-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 05 Feb 2020 19:37:18 +0000
Received: from b03ledav006.gho.boulder.ibm.com
 (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 015JbHwU50921802
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 5 Feb 2020 19:37:17 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4F45BC605A;
 Wed,  5 Feb 2020 19:37:17 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 33F38C6055;
 Wed,  5 Feb 2020 19:37:15 +0000 (GMT)
Received: from kermit.br.ibm.com (unknown [9.85.196.245])
 by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTPS;
 Wed,  5 Feb 2020 19:37:14 +0000 (GMT)
Subject: Re: [PATCH v1 05/13] util/mmap-alloc: Factor out calculation of
 pagesize to mmap_pagesize()
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20200203183125.164879-1-david@redhat.com>
 <20200203183125.164879-6-david@redhat.com>
From: =?UTF-8?Q?Murilo_Opsfelder_Ara=c3=bajo?= <muriloo@linux.ibm.com>
Organization: IBM
Message-ID: <fb151947-c50b-0000-1b9c-a503ee0b9aee@linux.ibm.com>
Date: Wed, 5 Feb 2020 16:37:13 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200203183125.164879-6-david@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-02-05_06:2020-02-04,
 2020-02-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0
 spamscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 mlxscore=0
 clxscore=1011 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002050149
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
X-Mailman-Approved-At: Wed, 05 Feb 2020 16:02:17 -0500
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
Reply-To: muriloo@linux.ibm.com
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Greg Kurz <groug@kaod.org>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello, David.

On 2/3/20 3:31 PM, David Hildenbrand wrote:
> Factor it out and add a comment.
> 
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
> Cc: Greg Kurz <groug@kaod.org>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>

> ---
>   util/mmap-alloc.c | 21 ++++++++++++---------
>   1 file changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/util/mmap-alloc.c b/util/mmap-alloc.c
> index 27dcccd8ec..82f02a2cec 100644
> --- a/util/mmap-alloc.c
> +++ b/util/mmap-alloc.c
> @@ -82,17 +82,27 @@ size_t qemu_mempath_getpagesize(const char *mem_path)
>       return qemu_real_host_page_size;
>   }
>   
> +static inline size_t mmap_pagesize(int fd)
> +{
> +#if defined(__powerpc64__) && defined(__linux__)
> +    /* Mappings in the same segment must share the same page size */
> +    return qemu_fd_getpagesize(fd);
> +#else
> +    return qemu_real_host_page_size;
> +#endif
> +}
> +
>   void *qemu_ram_mmap(int fd,
>                       size_t size,
>                       size_t align,
>                       bool shared,
>                       bool is_pmem)
>   {
> +    const size_t pagesize = mmap_pagesize(fd);
>       int flags;
>       int map_sync_flags = 0;
>       int guardfd;
>       size_t offset;
> -    size_t pagesize;
>       size_t total;
>       void *guardptr;
>       void *ptr;
> @@ -113,7 +123,6 @@ void *qemu_ram_mmap(int fd,
>        * anonymous memory is OK.
>        */
>       flags = MAP_PRIVATE;
> -    pagesize = qemu_fd_getpagesize(fd);
>       if (fd == -1 || pagesize == qemu_real_host_page_size) {
>           guardfd = -1;
>           flags |= MAP_ANONYMOUS;
> @@ -123,7 +132,6 @@ void *qemu_ram_mmap(int fd,
>       }
>   #else
>       guardfd = -1;
> -    pagesize = qemu_real_host_page_size;
>       flags = MAP_PRIVATE | MAP_ANONYMOUS;
>   #endif
>   
> @@ -198,15 +206,10 @@ void *qemu_ram_mmap(int fd,
>   
>   void qemu_ram_munmap(int fd, void *ptr, size_t size)
>   {
> -    size_t pagesize;
> +    const size_t pagesize = mmap_pagesize(fd);
>   
>       if (ptr) {
>           /* Unmap both the RAM block and the guard page */
> -#if defined(__powerpc64__) && defined(__linux__)
> -        pagesize = qemu_fd_getpagesize(fd);
> -#else
> -        pagesize = qemu_real_host_page_size;
> -#endif
>           munmap(ptr, size + pagesize);
>       }
>   }
> 

-- 
Murilo

