Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC4CC38A2A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 19:43:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CF462082E
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 19:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UwKz1NzI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CF462082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWmQr-0007YS-5T
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 15:43:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34730)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jWmNu-0004Le-N6
 for qemu-devel@nongnu.org; Thu, 07 May 2020 15:40:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27417
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jWmNt-0002Ed-57
 for qemu-devel@nongnu.org; Thu, 07 May 2020 15:40:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588880439;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hofnAB2Re/dqo9fJcQcSEF2cwk3KUk1xyagOVNlVm5Q=;
 b=UwKz1NzIFnpZBz4DGbSwGzSKjWBawK0RRnAeupldKlgk9lR2tZSlplhz4q7EPpVh4kzGe8
 2Eo2d591m2yseajvwcHEMaweyAUud3auxnAHmCmaSi7zpMn7gKCjbt1o/NaHU2ijQI7Q1q
 +rJFuARGPkwP4ZgqMYXLyUnKQrVlBIc=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-477-butfeajjPKmfEDIGcsopBQ-1; Thu, 07 May 2020 15:40:35 -0400
X-MC-Unique: butfeajjPKmfEDIGcsopBQ-1
Received: by mail-qk1-f199.google.com with SMTP id l19so6941016qki.14
 for <qemu-devel@nongnu.org>; Thu, 07 May 2020 12:40:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Ncw8rl44dhQ7t9UFrlATFwoUE+F3BVWlDH/VwEe4u/k=;
 b=MNaktoHoTzWiqdlMbCRMTDlJOqvEaHlcaj9Ytf29eJDr+vZ5msGDN1S9asuJpzmUSD
 oPnz0y+euBOKYcjuNlCEod9d6XZ7GN329MivEAIzYIa2qnPtiu6MJ7fKaIUJ7O1+h764
 uIKbU9mq/sPiDr5Nerv7a/GfbKzRx/icTH8aYnnAmes1+Ued1iKFDCmaPiszubdYiPwf
 sTENsTZooahwA+yLt61unTlZKKO+4zp+08Uq5Y4V+1Rixn2p9jVDFV7vdK9RIj8bhp2p
 1Y3wUCI9X9CCR2AjPzX8LziucDuzALAe9C/U6xjKppuCYuzACRti48nq7ryNI09gpj62
 UfEQ==
X-Gm-Message-State: AGi0PuZ6EQQzhre3rRs1pB8dOuKyZ1pBsguvq8JNY0kzTB2C1JRF4Aqf
 1YBK2IYhm4J6i0UbPHLwzqtrfCuXLDXiU3ZLvbAIl6I8N/EAqjtAZrcEvmScnqoUv9TEa3sCMH9
 XPqMS5yhkmAhyUks=
X-Received: by 2002:aed:3788:: with SMTP id j8mr15327799qtb.113.1588880435274; 
 Thu, 07 May 2020 12:40:35 -0700 (PDT)
X-Google-Smtp-Source: APiQypJJDGMSyFxTGcGY+kbJkTLzoQxspeP+QmZvO6dcAfeecgQ+rGTM3BIBhx33ckchcaH6hQwMPA==
X-Received: by 2002:aed:3788:: with SMTP id j8mr15327771qtb.113.1588880434999; 
 Thu, 07 May 2020 12:40:34 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id h13sm5108006qti.32.2020.05.07.12.40.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2020 12:40:34 -0700 (PDT)
Date: Thu, 7 May 2020 15:40:32 -0400
From: Peter Xu <peterx@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH 2/5] virtio-iommu: Implement RESV_MEM probe request
Message-ID: <20200507194032.GL228260@xz-x1>
References: <20200507143201.31080-1-eric.auger@redhat.com>
 <20200507143201.31080-3-eric.auger@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200507143201.31080-3-eric.auger@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=peterx@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 03:56:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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

On Thu, May 07, 2020 at 04:31:58PM +0200, Eric Auger wrote:

[...]

> @@ -452,17 +520,33 @@ static void virtio_iommu_handle_command(VirtIODevic=
e *vdev, VirtQueue *vq)
>          case VIRTIO_IOMMU_T_UNMAP:
>              tail.status =3D virtio_iommu_handle_unmap(s, iov, iov_cnt);
>              break;
> +        case VIRTIO_IOMMU_T_PROBE:
> +        {
> +            struct virtio_iommu_req_tail *ptail;
> +            uint8_t *buf =3D g_malloc0(s->config.probe_size + sizeof(tai=
l));
> +
> +            ptail =3D (struct virtio_iommu_req_tail *)
> +                        (buf + s->config.probe_size);
> +            ptail->status =3D virtio_iommu_handle_probe(s, iov, iov_cnt,=
 buf);
> +
> +            sz =3D iov_from_buf(elem->in_sg, elem->in_num, 0,
> +                              buf, s->config.probe_size + sizeof(tail));
> +            g_free(buf);
> +            assert(sz =3D=3D s->config.probe_size + sizeof(tail));
> +            goto push;
> +        }
>          default:
>              tail.status =3D VIRTIO_IOMMU_S_UNSUPP;
>          }
> -        qemu_mutex_unlock(&s->mutex);
> =20
>  out:
>          sz =3D iov_from_buf(elem->in_sg, elem->in_num, 0,
>                            &tail, sizeof(tail));
>          assert(sz =3D=3D sizeof(tail));
> =20
> -        virtqueue_push(vq, elem, sizeof(tail));
> +push:
> +        qemu_mutex_unlock(&s->mutex);

I think we can't move this unlock to here because otherwise "goto out" coul=
d
potentially try to unlock it without locked first.  Thanks,

> +        virtqueue_push(vq, elem, sz);
>          virtio_notify(vdev, vq);
>          g_free(elem);
>      }

--=20
Peter Xu


