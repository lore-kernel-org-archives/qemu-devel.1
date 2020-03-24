Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E04C2BAEE
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 18:37:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D0BA2076F
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 18:37:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SRilqEsk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D0BA2076F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGoQU-0002pk-Fk
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 14:37:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41562)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jGoPX-0002ML-P7
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 14:36:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1jGoPU-0008Nb-C2
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 14:36:23 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:41714)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1jGoPU-0008NR-8p
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 14:36:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585074980;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ReqtXCsTEiPdJvNrfygmxposiqKDncQFnQdw9yq0swE=;
 b=SRilqEskFc1UF55szyqWb9DNFZAQNSBCR42S1Q4t0FTgnurvYspcoHuYEroVL5aAtbn3xG
 7mERyDRGbxakiVyTyhMPBg2RYf+bPfSZomgtASj1vVPpbVXJbiH+uMf/8Ebdz4KI+1CnEI
 zkQfaJeZ4h59zZHpINmnVtYT9BKNguQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-C2YhzQXXPRWERf1iwRbQxQ-1; Tue, 24 Mar 2020 14:36:18 -0400
X-MC-Unique: C2YhzQXXPRWERf1iwRbQxQ-1
Received: by mail-wm1-f71.google.com with SMTP id 2so260199wmf.1
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2020 11:36:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=i4A/xqWSGLtPDET9zjSQHOttB/0+koxppHPGSrmNT/M=;
 b=YSkTWlRjVDdfVsFMEM8i3m7HUFWp98Q51ZQcMZDob1LyRlGhIIl96t8nQEji1TOcdE
 AOxjkQj8HzeKBSk8UVIpA0jM7UXZxloNpk3RFC9vP8Oy3Dvv4tPK2chDyESlEtmhBc+8
 MvOyL7j6Ote35y2gejdut5AIN/3uw2W/zbrdNq/j8p0rdGONn/gXorz6aKAwtdrFwMS9
 2QlZxIoERWEPs5yd3tSAtLYXLiwbLpJ2kaSamW8xnhIUc3x5TLUPZVXJsjViLmFf4BdR
 rkVTg/bYivVHUXUDJNTIaY5+mhtQkAHcSAcCILpPNiD1wskqSV+DWP7+EwPvE3frfCdP
 ID5Q==
X-Gm-Message-State: ANhLgQ0giqewiXzBnCUx954u4VYS4sD6mUSNrRAiQJEimChcoquMtVK0
 IYs3wAcXo/XNfGy/+yzPtl70ONSVbaj81nEvPSJrZNHmTRfo85ZA2b3yeXlg9sx0HhWyIkqtPX6
 iRMWwem6jtLu2m/M=
X-Received: by 2002:a5d:4acd:: with SMTP id y13mr3531509wrs.61.1585074976858; 
 Tue, 24 Mar 2020 11:36:16 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vswjB7Y+RnrWBQSeLWj9J4uwH9jrlwONHl7Gfp7nEUBIP16iMzsQGvZ9SX3IEZQ+jsiACKa8g==
X-Received: by 2002:a5d:4acd:: with SMTP id y13mr3531473wrs.61.1585074976615; 
 Tue, 24 Mar 2020 11:36:16 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id b15sm29609833wru.70.2020.03.24.11.36.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2020 11:36:15 -0700 (PDT)
Date: Tue, 24 Mar 2020 14:36:11 -0400
From: Peter Xu <peterx@redhat.com>
To: Liu Yi L <yi.l.liu@intel.com>
Subject: Re: [PATCH v1 21/22] intel_iommu: process PASID-based Device-TLB
 invalidation
Message-ID: <20200324183611.GF127076@xz-x1>
References: <1584880579-12178-1-git-send-email-yi.l.liu@intel.com>
 <1584880579-12178-22-git-send-email-yi.l.liu@intel.com>
MIME-Version: 1.0
In-Reply-To: <1584880579-12178-22-git-send-email-yi.l.liu@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: jean-philippe@linaro.org, kevin.tian@intel.com,
 Jacob Pan <jacob.jun.pan@linux.intel.com>, Yi Sun <yi.y.sun@linux.intel.com>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org, mst@redhat.com,
 jun.j.tian@intel.com, qemu-devel@nongnu.org, eric.auger@redhat.com,
 alex.williamson@redhat.com, pbonzini@redhat.com, hao.wu@intel.com,
 yi.y.sun@intel.com, Richard Henderson <rth@twiddle.net>,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Mar 22, 2020 at 05:36:18AM -0700, Liu Yi L wrote:
> This patch adds an empty handling for PASID-based Device-TLB
> invalidation. For now it is enough as it is not necessary to
> propagate it to host for passthru device and also there is no
> emulated device has device tlb.
>=20
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Yi Sun <yi.y.sun@linux.intel.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>

OK this patch seems to be mostly meaningless... but OK since you've
wrote it... :)

Reviewed-by: Peter Xu <peterx@redhat.com>

--=20
Peter Xu


