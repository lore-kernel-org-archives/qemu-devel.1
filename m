Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 126ABC33CA9
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 20:23:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7DC8214AF
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 20:23:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SfmjpMCA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7DC8214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ir6Fe-0004F3-Tv
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 15:23:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48692)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1ir6Ev-00033q-6q
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 15:23:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1ir6Et-0007kF-7w
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 15:23:08 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:36337
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ir6Et-0007jG-4b
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 15:23:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578946986;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PJyFnWgz0nf7Cg6OaS6TNSwYEJ2gLStF2/lXnbBHvao=;
 b=SfmjpMCAWGnZvXgUKGY/1wh5bnT4w0/WuOJ89/koIS762JIl6aJgQwFUi/TmmCzRXaLoZ1
 YH9aHKoDTEWeK5jTElgTKKTaVA17FfpBz7+gXXKJQGrMDQB+VdOIqAsKWaccANkgx5HUsc
 UuMs+zomERk7kn3uCzvlmqBKpjW+JZo=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-9yfLHHNbNj6Oxi7kVLSEhg-1; Mon, 13 Jan 2020 15:23:03 -0500
Received: by mail-qk1-f200.google.com with SMTP id a73so6745696qkg.5
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2020 12:23:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=25vembt0SSWCmatgReqPJR12Kdh7gxUqpVgSdunfnW8=;
 b=k+BNW2wkdig9+u2DjroB8mmAARelyHZifC0A8BmnQSR/pcz4rbSpDZTEKGl+XhigVl
 x4fgelRZ0Rbwm5RFKsq/B31SV+Y8mVN9cBzdm5FbCXqzZbau7ylcbNBiEntwFWNPDll1
 Az8FWEJXvH2p18IlS/fLRjU+jG4szD772/hd8fr0bgIpdM5ZAH8+ns2nL7koCY2gFEHv
 UOt9JKJk661siXDJ4dXpDtKX+X9TsZZsojwNvdYyrwTsbJpxdAAw/5WXJMSC4hgILJ0f
 SNnkyLKlZ3ZKBd0+s8PY53PHkoSDstTX9mWvr3AsJmB3/TaafuWRPC4cgQROun3xQVwV
 LjSA==
X-Gm-Message-State: APjAAAVkWvnpCWhbcACzXtgF7YitSpXgsQU1B9MQ5v4Noj6+S5H5+HjG
 nKGk3jOHawfSoxRjIGvS+ERiotmZ4rV5j6CU7wM1ZVkJh7Xe8sIRJBcD32P1hs1uf48A58N0tu7
 f0cZlcNH43BJSi/A=
X-Received: by 2002:a37:4dc4:: with SMTP id
 a187mr18337162qkb.436.1578946983254; 
 Mon, 13 Jan 2020 12:23:03 -0800 (PST)
X-Google-Smtp-Source: APXvYqxy8LlXSo5O0qopdDrM3oDK7m384TOuQBDGUmDcXzufwuKlTDr2+BNeYdghYt+wUTNhqgeTEw==
X-Received: by 2002:a37:4dc4:: with SMTP id
 a187mr18337152qkb.436.1578946983038; 
 Mon, 13 Jan 2020 12:23:03 -0800 (PST)
Received: from xz-x1 ([104.156.64.74])
 by smtp.gmail.com with ESMTPSA id i90sm6294954qtd.49.2020.01.13.12.23.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jan 2020 12:23:02 -0800 (PST)
Date: Mon, 13 Jan 2020 15:23:01 -0500
From: Peter Xu <peterx@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v12 05/13] virtio-iommu: Endpoint and domains structs and
 helpers
Message-ID: <20200113202301.GD201624@xz-x1>
References: <20200109144319.15912-1-eric.auger@redhat.com>
 <20200109144319.15912-6-eric.auger@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200109144319.15912-6-eric.auger@redhat.com>
X-MC-Unique: 9yfLHHNbNj6Oxi7kVLSEhg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: peter.maydell@linaro.org, kevin.tian@intel.com, tnowicki@marvell.com,
 jean-philippe@linaro.org, quintela@redhat.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com, bharatb.linux@gmail.com, qemu-arm@nongnu.org,
 mst@redhat.com, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jan 09, 2020 at 03:43:11PM +0100, Eric Auger wrote:

[...]

> +VirtIOIOMMUEndpoint *virtio_iommu_get_endpoint(VirtIOIOMMU *s, uint32_t =
ep_id);
> +VirtIOIOMMUEndpoint *virtio_iommu_get_endpoint(VirtIOIOMMU *s, uint32_t =
ep_id)

Is the extra definition trying to workaround the compiler
warning/error?

I'm not sure whether it's only me who prefer this, but again I'd
really perfer we move the function into the caller patch, add "static"
as needed altogether, even if that patch can be big.

> +{
> +    VirtIOIOMMUEndpoint *ep;
> +
> +    ep =3D g_tree_lookup(s->endpoints, GUINT_TO_POINTER(ep_id));
> +    if (ep) {
> +        return ep;
> +    }
> +    if (!virtio_iommu_mr(s, ep_id)) {

Could I ask when this will trigger?

> +        return NULL;
> +    }
> +    ep =3D g_malloc0(sizeof(*ep));
> +    ep->id =3D ep_id;
> +    trace_virtio_iommu_get_endpoint(ep_id);
> +    g_tree_insert(s->endpoints, GUINT_TO_POINTER(ep_id), ep);
> +    return ep;
> +}

Thanks,

--=20
Peter Xu


