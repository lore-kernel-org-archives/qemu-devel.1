Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D5C6C54FCF
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 15:40:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38FFA2073E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 15:40:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38FFA2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH88s-0004br-BU
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 11:40:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44620)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <muriloo@linux.ibm.com>) id 1jH84O-0005bg-D0
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 11:35:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <muriloo@linux.ibm.com>) id 1jH84N-0004cY-1W
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 11:35:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:12006
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <muriloo@linux.ibm.com>)
 id 1jH84M-0004cH-RX
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 11:35:50 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02PFXwN7124840; Wed, 25 Mar 2020 11:35:50 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ywet52y3h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Mar 2020 11:35:50 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 02PFY2tS125108;
 Wed, 25 Mar 2020 11:35:49 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com
 [169.53.41.122])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ywet52y2n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Mar 2020 11:35:49 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
 by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 02PFZAZi029623;
 Wed, 25 Mar 2020 15:35:48 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24]) by ppma04dal.us.ibm.com with ESMTP id 2ywawg2wnh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Mar 2020 15:35:48 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com
 [9.57.199.110])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 02PFZlni41812242
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 25 Mar 2020 15:35:47 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D10C0AE060;
 Wed, 25 Mar 2020 15:35:47 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E6F62AE05C;
 Wed, 25 Mar 2020 15:35:46 +0000 (GMT)
Received: from localhost (unknown [9.85.207.6])
 by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTPS;
 Wed, 25 Mar 2020 15:35:46 +0000 (GMT)
From: Murilo Opsfelder =?ISO-8859-1?Q?Ara=FAjo?= <muriloo@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v4 03/15] util: vfio-helpers: Factor out removal from
 qemu_vfio_undo_mapping()
Date: Wed, 25 Mar 2020 11:45:51 -0300
Message-ID: <2516375.9XiQzmnd3r@kermit.br.ibm.com>
Organization: IBM
In-Reply-To: <20200305142945.216465-4-david@redhat.com>
References: <20200305142945.216465-1-david@redhat.com>
 <20200305142945.216465-4-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.645
 definitions=2020-03-25_08:2020-03-24,
 2020-03-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 clxscore=1015 phishscore=0
 malwarescore=0 lowpriorityscore=0 mlxscore=0 suspectscore=5
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003250124
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

On Thursday, March 5, 2020 11:29:33 AM -03 David Hildenbrand wrote:
> Factor it out and properly use it where applicable. Make
> qemu_vfio_undo_mapping() look like qemu_vfio_do_mapping(), passing the
> size and iova, not the mapping.
>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---

Acked-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>

>  util/vfio-helpers.c | 43 +++++++++++++++++++++++++++----------------
>  1 file changed, 27 insertions(+), 16 deletions(-)
>
> diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
> index 7085ca702c..f0c77f0d69 100644
> --- a/util/vfio-helpers.c
> +++ b/util/vfio-helpers.c
> @@ -518,6 +518,20 @@ static IOVAMapping *qemu_vfio_add_mapping(QEMUVFIOState
> *s, return insert;
>  }
>
> +/**
> + * Remove the mapping from @s and free it.
> + */
> +static void qemu_vfio_remove_mapping(QEMUVFIOState *s, IOVAMapping
> *mapping) +{
> +    const int index = mapping - s->mappings;
> +
> +    assert(index >= 0 && index < s->nr_mappings);
> +    memmove(mapping, &s->mappings[index + 1],
> +            sizeof(s->mappings[0]) * (s->nr_mappings - index - 1));
> +    s->nr_mappings--;
> +    s->mappings = g_renew(IOVAMapping, s->mappings, s->nr_mappings);
> +}
> +
>  /* Do the DMA mapping with VFIO. */
>  static int qemu_vfio_do_mapping(QEMUVFIOState *s, void *host, size_t size,
>                                  uint64_t iova)
> @@ -539,29 +553,22 @@ static int qemu_vfio_do_mapping(QEMUVFIOState *s, void
> *host, size_t size, }
>
>  /**
> - * Undo the DMA mapping from @s with VFIO, and remove from mapping list.
> + * Undo the DMA mapping from @s with VFIO.
>   */
> -static void qemu_vfio_undo_mapping(QEMUVFIOState *s, IOVAMapping *mapping)
> +static void qemu_vfio_undo_mapping(QEMUVFIOState *s, size_t size, uint64_t
> iova) {
> -    int index;
>      struct vfio_iommu_type1_dma_unmap unmap = {
>          .argsz = sizeof(unmap),
>          .flags = 0,
> -        .iova = mapping->iova,
> -        .size = mapping->size,
> +        .iova = iova,
> +        .size = size,
>      };
>
> -    index = mapping - s->mappings;
> -    assert(mapping->size > 0);
> -    assert(QEMU_IS_ALIGNED(mapping->size, qemu_real_host_page_size));
> -    assert(index >= 0 && index < s->nr_mappings);
> +    assert(size > 0);
> +    assert(QEMU_IS_ALIGNED(size, qemu_real_host_page_size));
>      if (ioctl(s->container, VFIO_IOMMU_UNMAP_DMA, &unmap)) {
>          error_report("VFIO_UNMAP_DMA failed: %s", strerror(errno));
>      }
> -    memmove(mapping, &s->mappings[index + 1],
> -            sizeof(s->mappings[0]) * (s->nr_mappings - index - 1));
> -    s->nr_mappings--;
> -    s->mappings = g_renew(IOVAMapping, s->mappings, s->nr_mappings);
>  }
>
>  /* Check if the mapping list is (ascending) ordered. */
> @@ -621,7 +628,7 @@ int qemu_vfio_dma_map(QEMUVFIOState *s, void *host,
> size_t size, assert(qemu_vfio_verify_mappings(s));
>              ret = qemu_vfio_do_mapping(s, host, size, iova0);
>              if (ret) {
> -                qemu_vfio_undo_mapping(s, mapping);
> +                qemu_vfio_remove_mapping(s, mapping);
>                  goto out;
>              }
>              s->low_water_mark += size;
> @@ -681,7 +688,8 @@ void qemu_vfio_dma_unmap(QEMUVFIOState *s, void *host)
>      if (!m) {
>          goto out;
>      }
> -    qemu_vfio_undo_mapping(s, m);
> +    qemu_vfio_undo_mapping(s, m->size, m->iova);
> +    qemu_vfio_remove_mapping(s, m);
>  out:
>      qemu_mutex_unlock(&s->lock);
>  }
> @@ -698,7 +706,10 @@ void qemu_vfio_close(QEMUVFIOState *s)
>          return;
>      }
>      while (s->nr_mappings) {
> -        qemu_vfio_undo_mapping(s, &s->mappings[s->nr_mappings - 1]);
> +        IOVAMapping *m = &s->mappings[s->nr_mappings - 1];
> +
> +        qemu_vfio_undo_mapping(s, m->size, m->iova);
> +        qemu_vfio_remove_mapping(s, m);
>      }
>      ram_block_notifier_remove(&s->ram_notifier);
>      qemu_vfio_reset(s);


--
Murilo

