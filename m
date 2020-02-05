Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A590BC35247
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 01:44:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A27420658
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 01:44:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A27420658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izWDo-0002Vl-OF
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 20:44:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55752)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <muriloo@linux.ibm.com>) id 1izVqK-0003Hr-BQ
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 20:20:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <muriloo@linux.ibm.com>) id 1izVqI-0001mO-HN
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 20:20:32 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37560
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <muriloo@linux.ibm.com>)
 id 1izVqI-0001cE-Ah
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 20:20:30 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 0161J7N6043815; Wed, 5 Feb 2020 20:20:28 -0500
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2xyhn3ecn6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 05 Feb 2020 20:20:27 -0500
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0161KRsp046628;
 Wed, 5 Feb 2020 20:20:27 -0500
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.10])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2xyhn3ecmv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 05 Feb 2020 20:20:27 -0500
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
 by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 0161DgF2007732;
 Thu, 6 Feb 2020 01:20:26 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28]) by ppma02dal.us.ibm.com with ESMTP id 2xykc9kjkq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 06 Feb 2020 01:20:26 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com
 [9.57.199.110])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 0161KPg845023666
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 6 Feb 2020 01:20:26 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E2C01AE06A;
 Thu,  6 Feb 2020 01:20:25 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 243DFAE05F;
 Thu,  6 Feb 2020 01:20:25 +0000 (GMT)
Received: from localhost (unknown [9.85.199.146])
 by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTPS;
 Thu,  6 Feb 2020 01:20:24 +0000 (GMT)
From: Murilo Opsfelder =?ISO-8859-1?Q?Ara=FAjo?= <muriloo@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v1 08/13] util/mmap-alloc: Prepare for resizable mmaps
Date: Wed, 05 Feb 2020 20:00:08 -0300
Message-ID: <2036195.sfUKtyktLc@kermit.br.ibm.com>
Organization: IBM
In-Reply-To: <20200203183125.164879-9-david@redhat.com>
References: <20200203183125.164879-1-david@redhat.com>
 <20200203183125.164879-9-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-02-05_06:2020-02-04,
 2020-02-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 impostorscore=0 malwarescore=0 suspectscore=1 phishscore=0 clxscore=1015
 adultscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 lowpriorityscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002060006
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Greg Kurz <groug@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello, David.

On Monday, February 3, 2020 3:31:20 PM -03 David Hildenbrand wrote:
> When shrinking a mmap we want to re-reserve the already populated area.
> When growing a memory region, we want to populate starting with a given
> fd_offset. Prepare by allowing to pass these parameters.
> 
> Also, let's make sure we always process full pages, to avoid
> unmapping/remapping pages that are already in use when
> growing/shrinking. (existing callers seem to guarantee this, but that's
> not obvious)
> 
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Greg Kurz <groug@kaod.org>
> Cc: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  util/mmap-alloc.c | 32 +++++++++++++++++++++-----------
>  1 file changed, 21 insertions(+), 11 deletions(-)
> 
> diff --git a/util/mmap-alloc.c b/util/mmap-alloc.c
> index f043ccb0ab..63ad6893b7 100644
> --- a/util/mmap-alloc.c
> +++ b/util/mmap-alloc.c
> @@ -83,12 +83,12 @@ size_t qemu_mempath_getpagesize(const char *mem_path)
>  }
> 
>  /*
> - * Reserve a new memory region of the requested size to be used for mapping
> - * from the given fd (if any).
> + * Reserve a new memory region of the requested size or re-reserve parts
> + * of an existing region to be used for mapping from the given fd (if any).
> */
> -static void *mmap_reserve(size_t size, int fd)
> +static void *mmap_reserve(void *ptr, size_t size, int fd)
>  {
> -    int flags = MAP_PRIVATE;
> +    int flags = MAP_PRIVATE | (ptr ? MAP_FIXED : 0);
> 
>  #if defined(__powerpc64__) && defined(__linux__)
>      /*
> @@ -111,19 +111,23 @@ static void *mmap_reserve(size_t size, int fd)
>      flags |= MAP_ANONYMOUS;
>  #endif
> 
> -    return mmap(0, size, PROT_NONE, flags, fd, 0);
> +    return mmap(ptr, size, PROT_NONE, flags, fd, 0);
>  }
> 
>  /*
>   * Populate memory in a reserved region from the given fd (if any).
>   */
> -static void *mmap_populate(void *ptr, size_t size, int fd, bool shared,
> -                           bool is_pmem)
> +static void *mmap_populate(void *ptr, size_t size, int fd, size_t
> fd_offset, +                           bool shared, bool is_pmem)
>  {
>      int map_sync_flags = 0;
>      int flags = MAP_FIXED;
>      void *new_ptr;
> 
> +    if (fd == -1) {
> +        fd_offset = 0;
> +    }
> +
>      flags |= fd == -1 ? MAP_ANONYMOUS : 0;
>      flags |= shared ? MAP_SHARED : MAP_PRIVATE;
>      if (shared && is_pmem) {
> @@ -131,7 +135,7 @@ static void *mmap_populate(void *ptr, size_t size, int
> fd, bool shared, }
> 
>      new_ptr = mmap(ptr, size, PROT_READ | PROT_WRITE, flags |
> map_sync_flags, -                   fd, 0);
> +                   fd, fd_offset);
>      if (new_ptr == MAP_FAILED && map_sync_flags) {
>          if (errno == ENOTSUP) {
>              char *proc_link = g_strdup_printf("/proc/self/fd/%d", fd);
> @@ -153,7 +157,7 @@ static void *mmap_populate(void *ptr, size_t size, int
> fd, bool shared, * If mmap failed with MAP_SHARED_VALIDATE | MAP_SYNC, we
> will try * again without these flags to handle backwards compatibility. */
> -        new_ptr = mmap(ptr, size, PROT_READ | PROT_WRITE, flags, fd, 0);
> +        new_ptr = mmap(ptr, size, PROT_READ | PROT_WRITE, flags, fd,
> fd_offset); }
>      return new_ptr;
>  }
> @@ -178,13 +182,16 @@ void *qemu_ram_mmap(int fd,
>      size_t offset, total;
>      void *ptr, *guardptr;
> 
> +    /* we can only map whole pages */
> +    size = QEMU_ALIGN_UP(size, pagesize);
> +

Caller already rounds up size to block->page_size.

Why this QEMU_ALIGN_UP is necessary?

>      /*
>       * Note: this always allocates at least one extra page of virtual
> address * space, even if size is already aligned.
>       */
>      total = size + align;

If size was aligned above with pagesize boundary, why would this align be 
necessary?

Can the pagesize differ from memory region align?

> 
> -    guardptr = mmap_reserve(total, fd);
> +    guardptr = mmap_reserve(0, total, fd);
>      if (guardptr == MAP_FAILED) {
>          return MAP_FAILED;
>      }
> @@ -195,7 +202,7 @@ void *qemu_ram_mmap(int fd,
> 
>      offset = QEMU_ALIGN_UP((uintptr_t)guardptr, align) -
> (uintptr_t)guardptr;
> 
> -    ptr = mmap_populate(guardptr + offset, size, fd, shared, is_pmem);
> +    ptr = mmap_populate(guardptr + offset, size, fd, 0, shared, is_pmem);
>      if (ptr == MAP_FAILED) {
>          munmap(guardptr, total);
>          return MAP_FAILED;
> @@ -221,6 +228,9 @@ void qemu_ram_munmap(int fd, void *ptr, size_t size)
>  {
>      const size_t pagesize = mmap_pagesize(fd);
> 
> +    /* we can only map whole pages */
> +    size = QEMU_ALIGN_UP(size, pagesize);
> +

I'm trying to understand why this align is necessary, too.

>      if (ptr) {
>          /* Unmap both the RAM block and the guard page */
>          munmap(ptr, size + pagesize);

-- 
Murilo

