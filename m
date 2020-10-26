Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBDB0C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 20:17:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4519E21BE5
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 20:17:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fflb1VZ1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4519E21BE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX8vU-0003ct-9A
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 16:17:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38038)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1kX8hq-0003IF-NN
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 16:03:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41552)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1kX8hn-0005ib-4R
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 16:03:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603742577;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h5jjLFFyX3oluQ//0CwI9lz4wFu7ukaPK7LUN/44tUo=;
 b=Fflb1VZ1Fi+Mknjp/zL+aBuSiQ8z59E1kkFADjWPw3H3w8JCggm8Q9rK3lkKtaBDxJaqKU
 BhiO4PQc+/LEG3aI4nfBvp8YY/RMHeBrNmivDTWDAeS+G4/nd9I6dGMjlnWVuniI1hlVgU
 Wyazt7wwhmidMDCy76O5aiQv+hFFvF8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-821VuqxPP_OJLf-d-feDoA-1; Mon, 26 Oct 2020 16:02:56 -0400
X-MC-Unique: 821VuqxPP_OJLf-d-feDoA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DCA12100746A;
 Mon, 26 Oct 2020 20:02:54 +0000 (UTC)
Received: from [10.36.112.194] (ovpn-112-194.ams2.redhat.com [10.36.112.194])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0E1FE5C1BB;
 Mon, 26 Oct 2020 20:02:46 +0000 (UTC)
Subject: Re: [PATCH v2 12/19] util/vfio-helpers: Let qemu_vfio_do_mapping()
 propagate Error
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20201026105504.4023620-1-philmd@redhat.com>
 <20201026105504.4023620-13-philmd@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <bd1cc1c9-3553-d252-3ca9-a23bc1035170@redhat.com>
Date: Mon, 26 Oct 2020 21:02:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20201026105504.4023620-13-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=eric.auger@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/25 21:03:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.167, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Philippe,

On 10/26/20 11:54 AM, Philippe Mathieu-Daudé wrote:
> Pass qemu_vfio_do_mapping() an Error* argument so it can propagate
> any error to callers. Replace error_report() which only report
> to the monitor by the more generic error_setg_errno().
> 
> Reviewed-by: Fam Zheng <fam@euphon.net>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  util/vfio-helpers.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
> index c03fe0b7156..2c4598d7faa 100644
> --- a/util/vfio-helpers.c
> +++ b/util/vfio-helpers.c
> @@ -609,7 +609,7 @@ static IOVAMapping *qemu_vfio_add_mapping(QEMUVFIOState *s,
>  
>  /* Do the DMA mapping with VFIO. */
>  static int qemu_vfio_do_mapping(QEMUVFIOState *s, void *host, size_t size,
> -                                uint64_t iova)
> +                                uint64_t iova, Error **errp)
>  {
>      struct vfio_iommu_type1_dma_map dma_map = {
>          .argsz = sizeof(dma_map),
> @@ -621,7 +621,7 @@ static int qemu_vfio_do_mapping(QEMUVFIOState *s, void *host, size_t size,
>      trace_qemu_vfio_do_mapping(s, host, iova, size);
>  
>      if (ioctl(s->container, VFIO_IOMMU_MAP_DMA, &dma_map)) {
> -        error_report("VFIO_MAP_DMA failed: %s", strerror(errno));
> +        error_setg_errno(errp, errno, "VFIO_MAP_DMA failed");
>          return -errno;
>      }
>      return 0;
> @@ -757,7 +757,7 @@ int qemu_vfio_dma_map(QEMUVFIOState *s, void *host, size_t size,
There are other error cases in qemu_vfio_dma_map() where you must set
errp. Otherwise the caller may, in the future test the returned value
and incorrectly handle the errp.

Thanks

Eric
>                  goto out;
>              }
>              assert(qemu_vfio_verify_mappings(s));
> -            ret = qemu_vfio_do_mapping(s, host, size, iova0);
> +            ret = qemu_vfio_do_mapping(s, host, size, iova0, errp);
>              if (ret) {
>                  qemu_vfio_undo_mapping(s, mapping, NULL);
>                  goto out;
> @@ -768,7 +768,7 @@ int qemu_vfio_dma_map(QEMUVFIOState *s, void *host, size_t size,
>                  ret = -ENOMEM;
>                  goto out;
>              }
> -            ret = qemu_vfio_do_mapping(s, host, size, iova0);
> +            ret = qemu_vfio_do_mapping(s, host, size, iova0, errp);
>              if (ret) {
>                  goto out;
>              }
> 


