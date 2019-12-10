Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 695EAC43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 19:37:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EC2C20652
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 19:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iX3P+7ev"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EC2C20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ielJr-0006xf-CM
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 14:37:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58840)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1ielIy-0006Pq-97
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 14:36:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1ielIx-0000xU-Cp
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 14:36:20 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:22389
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ielIx-0000xD-9j
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 14:36:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576006578;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eb7AmweRNmrhfF8rgwPCRN+jvonKHTPSJaOP2AIRHTU=;
 b=iX3P+7evtIfo3Phl5HDlAAcm0RimoPH8ht1tuOLWG5UvB0DZipfOdFdA4fZVgckAmVExYG
 5i7ADHJ3sziaLbyCn7LGJeVTR/TYfQnRL61xIbnaAcYbuhaZLioxfrjzdOOlQzSquAMPyf
 qJYMPm4Fks/sfIE6Roz0z7FRgCn5JxM=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-D8JDykuwN9-UJX_8f-3bAg-1; Tue, 10 Dec 2019 14:36:17 -0500
Received: by mail-qt1-f198.google.com with SMTP id z12so2686663qts.15
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2019 11:36:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=VoST2cwgUReKtnPRy2fmQ6MgjrANU6LbhWvd8CWPERw=;
 b=IgusvQ7rM6HjbzQjV+eTqsaoviR+mVktt7LcfJUVI6vqJydq/Q4JTMRyF7wm8Fi24O
 YEykn8TkchYP+DxRYfIO+LCFvYhMXcRbp5hAjXR5xLKy6MSELxPPeurenC7xlcQyOxPy
 HdyjXxbkvWRaAz4FTDDgchby99InWKTmqW+zCqRNYLP8iCmUWdUYkjsauJBPJrwxQke4
 fHQAlcSpjpO6LD2Ja/pnx/AqAHj96M4YPmW7qwUkJDe9sHLSC4myXL6Op7FoUWYczWTg
 4odljfo5Dt3q/waGx7YtWbQCyAGBtRd+8PWLSRzPOvbkEpM6ggLP3h29RlIhfRDQuGri
 GuYQ==
X-Gm-Message-State: APjAAAXa8F0IAFSpwj+fbgw3L6cU2iBOs/HNkM1gBl07rEfAiOv5mj32
 cIr02otPvT4epcwYzVLvrcBIduW23X3F2nSJ6eN1P5PL21aAzl8m7MCwVUQ6jAnAr7rJPhoekl9
 cU3mA1Y/pquZr//8=
X-Received: by 2002:a37:a1c1:: with SMTP id k184mr17377459qke.66.1576006576116; 
 Tue, 10 Dec 2019 11:36:16 -0800 (PST)
X-Google-Smtp-Source: APXvYqy6Pmiy5TUMNv2yF1r9Mvi1s/hqqOLCZTm4OKvM+baGtNRR/oQKW9ZvzOM7z30W7+Kjf9p5tA==
X-Received: by 2002:a37:a1c1:: with SMTP id k184mr17377436qke.66.1576006575903; 
 Tue, 10 Dec 2019 11:36:15 -0800 (PST)
Received: from xz-x1 ([104.156.64.74])
 by smtp.gmail.com with ESMTPSA id d32sm1456168qtd.31.2019.12.10.11.36.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2019 11:36:15 -0800 (PST)
Date: Tue, 10 Dec 2019 14:36:13 -0500
From: Peter Xu <peterx@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH for-5.0 v11 13/20] virtio-iommu: Implement probe request
Message-ID: <20191210193613.GK3352@xz-x1>
References: <20191122182943.4656-1-eric.auger@redhat.com>
 <20191122182943.4656-14-eric.auger@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191122182943.4656-14-eric.auger@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-MC-Unique: D8JDykuwN9-UJX_8f-3bAg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: yang.zhong@intel.com, peter.maydell@linaro.org, kevin.tian@intel.com,
 tnowicki@marvell.com, mst@redhat.com, jean-philippe.brucker@arm.com,
 quintela@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 bharatb.linux@gmail.com, qemu-arm@nongnu.org, dgilbert@redhat.com,
 eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Nov 22, 2019 at 07:29:36PM +0100, Eric Auger wrote:
> This patch implements the PROBE request. At the moment,
> no reserved regions are returned as none are registered
> per device. Only a NONE property is returned.
>=20
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

--=20
Peter Xu


