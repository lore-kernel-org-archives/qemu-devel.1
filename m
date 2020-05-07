Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A35C38A2A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 19:48:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF3F8208E4
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 19:48:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ESa5421Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF3F8208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWmVf-0001wg-2U
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 15:48:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35974)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jWmUh-0000rC-Sk
 for qemu-devel@nongnu.org; Thu, 07 May 2020 15:47:44 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:32034
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jWmUg-0007jD-O5
 for qemu-devel@nongnu.org; Thu, 07 May 2020 15:47:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588880860;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mLKVmH1ls+kYXz+5pCKktKJ3qcZgCDjtDWhwK4TV2Mk=;
 b=ESa5421QQd9a4BFqZCZTlJWwgxJoO+EajqMeLg/7uovo5QBWDkLLcOXWV28LLBgR+VwYGL
 n1udHqeImp1Mjajv/B1od7N/oJwLx8nydnUwHxTmSjJPXabjhfHNe5SF/+DzwX92lidYUN
 T5WmFnC0Ul/BjTFnhnGM52mxkVGDVVg=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-10-5COjRv5jPPOuYfLXHXRMPg-1; Thu, 07 May 2020 15:47:39 -0400
X-MC-Unique: 5COjRv5jPPOuYfLXHXRMPg-1
Received: by mail-qv1-f72.google.com with SMTP id cr5so6931969qvb.14
 for <qemu-devel@nongnu.org>; Thu, 07 May 2020 12:47:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=u19rLATa+GYdi/491nIpqQREZ59j6qVODpl8FKRo430=;
 b=jhTUOvyDtjuYVQ0Z1NmJd9dRphyUW/Q601sTJ12A/Ukis95pPdAxtvZZ9qFvUDQ7pu
 k6YrvOSZExYfls2FUfN1O4DsRwn20EN7tlXhR65JfFRcIICxvcBQGcEXPBqgcgJ7/EZB
 otc14wpjTfP3TBbQi63U77fvIU2yQq6JVSJ+za2E8JlviZWExGW5ekp+HTyfvkcqXh9Q
 QAaD1C6yKFayUkXdYI2yS5SBYkh8bXJxf51gx8kEZygao6uAJsdFZMv6Um1F/AKSHsaK
 uprVn+MTA0JcVUZ9Vfw9tm/8Se5uMxJ9KYVScPkzoHEkuVr1zi1V0kmU35c2/h8f1m86
 EebA==
X-Gm-Message-State: AGi0PuauAgLDcfTjkl4o9jyYckkGEGxuQjhSqM/qQfQfd20+CKNNVtZF
 KY7xAiQ4noaBEluPOVliXCweG3Y791XhvR4YDdvA5GPDmW0gccTTDGZ96oPOrNfIFb58JYjOSiJ
 qogdZO6j7kN9FJG8=
X-Received: by 2002:a37:9cce:: with SMTP id f197mr15252685qke.35.1588880858714; 
 Thu, 07 May 2020 12:47:38 -0700 (PDT)
X-Google-Smtp-Source: APiQypLLbEIbSRQctbcJLH3n5kiPKl25RqA3E/dSmYGIHZNUViYCJK0uYV6Ibkp7pBtpaCnqXhgKGA==
X-Received: by 2002:a37:9cce:: with SMTP id f197mr15252664qke.35.1588880858488; 
 Thu, 07 May 2020 12:47:38 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id n31sm5198815qtc.36.2020.05.07.12.47.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2020 12:47:37 -0700 (PDT)
Date: Thu, 7 May 2020 15:47:36 -0400
From: Peter Xu <peterx@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH 3/5] virtio-iommu: Handle reserved regions in the
 translation process
Message-ID: <20200507194736.GM228260@xz-x1>
References: <20200507143201.31080-1-eric.auger@redhat.com>
 <20200507143201.31080-4-eric.auger@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200507143201.31080-4-eric.auger@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=peterx@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 02:00:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, jean-philippe@linaro.org, mst@redhat.com,
 qemu-devel@nongnu.org, armbru@redhat.com, qemu-arm@nongnu.org,
 bbhushan2@marvell.com, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi, Eric,

On Thu, May 07, 2020 at 04:31:59PM +0200, Eric Auger wrote:
> @@ -640,6 +641,24 @@ static IOMMUTLBEntry virtio_iommu_translate(IOMMUMem=
oryRegion *mr, hwaddr addr,
>          goto unlock;
>      }
> =20
> +    for (i =3D 0; i < s->nb_reserved_regions; i++) {
> +        if (interval.low >=3D s->reserved_regions[i].low &&
> +            interval.low <=3D s->reserved_regions[i].high) {

Should this be s/low/high/?

For this case (high=3D=3Dlow+1) I guess maybe it's also easier to use "addr=
 >=3D low
&& addr < high".

Thanks,

> +            switch (s->reserved_regions[i].type) {
> +            case VIRTIO_IOMMU_RESV_MEM_T_MSI:
> +                entry.perm =3D flag;
> +                break;
> +            case VIRTIO_IOMMU_RESV_MEM_T_RESERVED:
> +            default:
> +                virtio_iommu_report_fault(s, VIRTIO_IOMMU_FAULT_R_MAPPIN=
G,
> +                                          VIRTIO_IOMMU_FAULT_F_ADDRESS,
> +                                          sid, addr);
> +                break;
> +            }
> +            goto unlock;
> +        }
> +    }
> +
>      if (!ep->domain) {
>          if (!bypass_allowed) {
>              error_report_once("%s %02x:%02x.%01x not attached to any dom=
ain",
> --=20
> 2.20.1
>=20

--=20
Peter Xu


