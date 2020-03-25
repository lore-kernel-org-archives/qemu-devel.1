Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E010C1975A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 15:37:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E7982073E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 15:37:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E7982073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH85Y-0006Lj-7a
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 11:37:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44545)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <muriloo@linux.ibm.com>) id 1jH843-000506-V6
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 11:35:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <muriloo@linux.ibm.com>) id 1jH842-0004Nd-4F
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 11:35:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44752
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <muriloo@linux.ibm.com>)
 id 1jH841-0004NH-Tq
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 11:35:30 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02PFYdL4008856; Wed, 25 Mar 2020 11:35:29 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ywewvh3kc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Mar 2020 11:35:29 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 02PFZ2lh011953;
 Wed, 25 Mar 2020 11:35:28 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com
 [169.63.214.131])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ywewvh3jn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Mar 2020 11:35:28 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
 by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 02PFZCIQ016257;
 Wed, 25 Mar 2020 15:35:28 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24]) by ppma01dal.us.ibm.com with ESMTP id 2ywawm2v4e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Mar 2020 15:35:27 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com
 [9.57.199.110])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 02PFZQGF52625818
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 25 Mar 2020 15:35:26 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DC7F8AE05F;
 Wed, 25 Mar 2020 15:35:26 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 312DFAE05C;
 Wed, 25 Mar 2020 15:35:26 +0000 (GMT)
Received: from localhost (unknown [9.85.207.6])
 by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTPS;
 Wed, 25 Mar 2020 15:35:25 +0000 (GMT)
From: Murilo Opsfelder =?ISO-8859-1?Q?Ara=FAjo?= <muriloo@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v4 13/15] util: oslib: Resizeable anonymous allocations
 under POSIX
Date: Wed, 25 Mar 2020 12:20:50 -0300
Message-ID: <2163860.jru0uo9y1b@kermit.br.ibm.com>
Organization: IBM
In-Reply-To: <20200305142945.216465-14-david@redhat.com>
References: <20200305142945.216465-1-david@redhat.com>
 <20200305142945.216465-14-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.645
 definitions=2020-03-25_07:2020-03-24,
 2020-03-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 suspectscore=5 spamscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 bulkscore=0 phishscore=0 mlxscore=0 adultscore=0 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003250123
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
 "Michael S . Tsirkin" <mst@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>, qemu-devel@nongnu.org,
 Peter Xu <peterx@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thursday, March 5, 2020 11:29:43 AM -03 David Hildenbrand wrote:
> Introduce qemu_anon_ram_alloc_resizeable() and qemu_anon_ram_resize().
> Implement them under POSIX and make them return NULL under WIN32.
>
> Under POSIX, we make use of resizeable mmaps. An implementation under
> WIN32 is theoretically possible AFAIK and can be added later.
>
> In qemu_anon_ram_free(), rename the size parameter to max_size, to make
> it clearer that we have to use the maximum size when freeing resizeable
> anonymous allocations.
>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Cc: Stefan Weil <sw@weilnetz.de>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---

Acked-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>

>  include/qemu/osdep.h |  6 +++++-
>  util/oslib-posix.c   | 37 ++++++++++++++++++++++++++++++++++---
>  util/oslib-win32.c   | 14 ++++++++++++++
>  util/trace-events    |  4 +++-
>  4 files changed, 56 insertions(+), 5 deletions(-)
>
> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> index 9bd3dcfd13..a1ea9e043d 100644
> --- a/include/qemu/osdep.h
> +++ b/include/qemu/osdep.h
> @@ -311,8 +311,12 @@ int qemu_daemon(int nochdir, int noclose);
>  void *qemu_try_memalign(size_t alignment, size_t size);
>  void *qemu_memalign(size_t alignment, size_t size);
>  void *qemu_anon_ram_alloc(size_t size, uint64_t *align, bool shared);
> +void *qemu_anon_ram_alloc_resizeable(size_t size, size_t max_size,
> +                                     uint64_t *align, bool shared);
> +bool qemu_anon_ram_resize(void *ptr, size_t old_size, size_t new_size,
> +                          bool shared);
>  void qemu_vfree(void *ptr);
> -void qemu_anon_ram_free(void *ptr, size_t size);
> +void qemu_anon_ram_free(void *ptr, size_t max_size);
>
>  #define QEMU_MADV_INVALID -1
>
> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
> index 897e8f3ba6..34b1ce74b7 100644
> --- a/util/oslib-posix.c
> +++ b/util/oslib-posix.c
> @@ -223,16 +223,47 @@ void *qemu_anon_ram_alloc(size_t size, uint64_t
> *alignment, bool shared) return ptr;
>  }
>
> +void *qemu_anon_ram_alloc_resizeable(size_t size, size_t max_size,
> +                                     uint64_t *alignment, bool shared)
> +{
> +    size_t align = QEMU_VMALLOC_ALIGN;
> +    void *ptr = qemu_ram_mmap_resizeable(-1, size, max_size, align, shared,
> +                                         false);
> +
> +    if (ptr == MAP_FAILED) {
> +        return NULL;
> +    }
> +
> +    if (alignment) {
> +        *alignment = align;
> +    }
> +
> +    trace_qemu_anon_ram_alloc_resizeable(size, max_size, ptr);
> +    return ptr;
> +}
> +
> +bool qemu_anon_ram_resize(void *ptr, size_t old_size, size_t new_size,
> +                          bool shared)
> +{
> +    bool resized = qemu_ram_mmap_resize(ptr, -1, old_size, new_size,
> shared, +                                        false);
> +
> +    if (resized) {
> +        trace_qemu_anon_ram_resize(old_size, new_size, ptr);
> +    }
> +    return resized;
> +}
> +
>  void qemu_vfree(void *ptr)
>  {
>      trace_qemu_vfree(ptr);
>      free(ptr);
>  }
>
> -void qemu_anon_ram_free(void *ptr, size_t size)
> +void qemu_anon_ram_free(void *ptr, size_t max_size)
>  {
> -    trace_qemu_anon_ram_free(ptr, size);
> -    qemu_ram_munmap(-1, ptr, size);
> +    trace_qemu_anon_ram_free(ptr, max_size);
> +    qemu_ram_munmap(-1, ptr, max_size);
>  }
>
>  void qemu_set_block(int fd)
> diff --git a/util/oslib-win32.c b/util/oslib-win32.c
> index e9b14ab178..c034fdfe01 100644
> --- a/util/oslib-win32.c
> +++ b/util/oslib-win32.c
> @@ -90,6 +90,20 @@ void *qemu_anon_ram_alloc(size_t size, uint64_t *align,
> bool shared) return ptr;
>  }
>
> +void *qemu_anon_ram_alloc_resizeable(size_t size, size_t max_size,
> +                                     uint64_t *align, bool shared)
> +{
> +    /* resizeable ram not implemented yet */
> +    return NULL;
> +}
> +
> +bool qemu_anon_ram_resize(void *ptr, size_t old_size, size_t new_size,
> +                          bool shared)
> +{
> +    /* resizeable ram not implemented yet */
> +    return false;
> +}
> +
>  void qemu_vfree(void *ptr)
>  {
>      trace_qemu_vfree(ptr);
> diff --git a/util/trace-events b/util/trace-events
> index a4d39eca5e..24a6f1a1e1 100644
> --- a/util/trace-events
> +++ b/util/trace-events
> @@ -46,8 +46,10 @@ qemu_co_mutex_unlock_return(void *mutex, void *self)
> "mutex %p self %p" # oslib-posix.c
>  qemu_memalign(size_t alignment, size_t size, void *ptr) "alignment %zu size
> %zu ptr %p" qemu_anon_ram_alloc(size_t size, void *ptr) "size %zu ptr %p"
> +qemu_anon_ram_alloc_resizeable(size_t size, size_t max_size, void *ptr)
> "size %zu max_size %zu ptr %p" +qemu_anon_ram_resize(size_t old_size,
> size_t new_size, void *ptr) "old_size %zu new_size %zu ptr %p"
> qemu_vfree(void *ptr) "ptr %p"
> -qemu_anon_ram_free(void *ptr, size_t size) "ptr %p size %zu"
> +qemu_anon_ram_free(void *ptr, size_t max_size) "ptr %p max_size %zu"
>
>  # hbitmap.c
>  hbitmap_iter_skip_words(const void *hb, void *hbi, uint64_t pos, unsigned
> long cur) "hb %p hbi %p pos %"PRId64" cur 0x%lx"


--
Murilo

