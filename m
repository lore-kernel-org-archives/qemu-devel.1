Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7425C43331
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 14:35:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF16320777
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 14:35:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF16320777
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH787-0008Vx-V3
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 10:35:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35772)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <muriloo@linux.ibm.com>) id 1jH774-0007MN-3G
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 10:34:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <muriloo@linux.ibm.com>) id 1jH772-0006hg-OV
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 10:34:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50376
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <muriloo@linux.ibm.com>)
 id 1jH772-0006f4-Iu
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 10:34:32 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02PEXuJY042742; Wed, 25 Mar 2020 10:34:29 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 30077u4gf9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Mar 2020 10:34:29 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 02PEYKfQ044986;
 Wed, 25 Mar 2020 10:34:29 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0b-001b2d01.pphosted.com with ESMTP id 30077u4gdp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Mar 2020 10:34:28 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 02PEVNjo030111;
 Wed, 25 Mar 2020 14:34:27 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28]) by ppma03dal.us.ibm.com with ESMTP id 2ywaw9te3b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Mar 2020 14:34:27 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 02PEYQuT48169344
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 25 Mar 2020 14:34:26 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 82B07AC060;
 Wed, 25 Mar 2020 14:34:26 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D59F4AC059;
 Wed, 25 Mar 2020 14:34:25 +0000 (GMT)
Received: from localhost (unknown [9.85.207.6])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTPS;
 Wed, 25 Mar 2020 14:34:25 +0000 (GMT)
From: Murilo Opsfelder =?ISO-8859-1?Q?Ara=FAjo?= <muriloo@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v4 02/15] util: vfio-helpers: Remove Error parameter from
 qemu_vfio_undo_mapping()
Date: Wed, 25 Mar 2020 11:32:15 -0300
Message-ID: <2294930.3xjZc7L5jH@kermit.br.ibm.com>
Organization: IBM
In-Reply-To: <20200305142945.216465-3-david@redhat.com>
References: <20200305142945.216465-1-david@redhat.com>
 <20200305142945.216465-3-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.645
 definitions=2020-03-25_07:2020-03-24,
 2020-03-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxlogscore=999
 mlxscore=0 lowpriorityscore=0 adultscore=0 phishscore=0 impostorscore=0
 suspectscore=1 malwarescore=0 priorityscore=1501 spamscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003250117
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
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 Peter Xu <peterx@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thursday, March 5, 2020 11:29:32 AM -03 David Hildenbrand wrote:
> Everybody discards the error. Let's error_report() instead so this error
> doesn't get lost.
>
> This is now the same error handling as in qemu_vfio_do_mapping(). However,
> we don't report any errors via the return value to the caller. This seems
> to be one of these "will never happen, but let's better print an error
> because the caller can't handle it either way" cases.
>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---

Acked-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>

>  util/vfio-helpers.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
> index f31aa77ffe..7085ca702c 100644
> --- a/util/vfio-helpers.c
> +++ b/util/vfio-helpers.c
> @@ -541,8 +541,7 @@ static int qemu_vfio_do_mapping(QEMUVFIOState *s, void
> *host, size_t size, /**
>   * Undo the DMA mapping from @s with VFIO, and remove from mapping list.
>   */
> -static void qemu_vfio_undo_mapping(QEMUVFIOState *s, IOVAMapping *mapping,
> -                                   Error **errp)
> +static void qemu_vfio_undo_mapping(QEMUVFIOState *s, IOVAMapping *mapping)
>  {
>      int index;
>      struct vfio_iommu_type1_dma_unmap unmap = {
> @@ -557,7 +556,7 @@ static void qemu_vfio_undo_mapping(QEMUVFIOState *s,
> IOVAMapping *mapping, assert(QEMU_IS_ALIGNED(mapping->size,
> qemu_real_host_page_size)); assert(index >= 0 && index < s->nr_mappings);
>      if (ioctl(s->container, VFIO_IOMMU_UNMAP_DMA, &unmap)) {
> -        error_setg_errno(errp, errno, "VFIO_UNMAP_DMA failed");
> +        error_report("VFIO_UNMAP_DMA failed: %s", strerror(errno));
>      }
>      memmove(mapping, &s->mappings[index + 1],
>              sizeof(s->mappings[0]) * (s->nr_mappings - index - 1));
> @@ -622,7 +621,7 @@ int qemu_vfio_dma_map(QEMUVFIOState *s, void *host,
> size_t size, assert(qemu_vfio_verify_mappings(s));
>              ret = qemu_vfio_do_mapping(s, host, size, iova0);
>              if (ret) {
> -                qemu_vfio_undo_mapping(s, mapping, NULL);
> +                qemu_vfio_undo_mapping(s, mapping);
>                  goto out;
>              }
>              s->low_water_mark += size;
> @@ -682,7 +681,7 @@ void qemu_vfio_dma_unmap(QEMUVFIOState *s, void *host)
>      if (!m) {
>          goto out;
>      }
> -    qemu_vfio_undo_mapping(s, m, NULL);
> +    qemu_vfio_undo_mapping(s, m);
>  out:
>      qemu_mutex_unlock(&s->lock);
>  }
> @@ -699,7 +698,7 @@ void qemu_vfio_close(QEMUVFIOState *s)
>          return;
>      }
>      while (s->nr_mappings) {
> -        qemu_vfio_undo_mapping(s, &s->mappings[s->nr_mappings - 1], NULL);
> +        qemu_vfio_undo_mapping(s, &s->mappings[s->nr_mappings - 1]);
>      }
>      ram_block_notifier_remove(&s->ram_notifier);
>      qemu_vfio_reset(s);


--
Murilo

