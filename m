Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A29AC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 14:50:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8173206F5
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 14:50:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BDmknDBb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8173206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKNeC-0002Gx-2I
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 10:50:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44780)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jKNdO-0001qf-GI
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 10:49:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1jKNdN-0000dv-GH
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 10:49:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40985
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1jKNdN-0000cd-CB
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 10:49:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585925364;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XqIFfPaja508cOpcL0/rROrYdrZZLRizsRZBk78lhoE=;
 b=BDmknDBbOyjNot7EUg6+cj1OscRKkKOT6t3nJvqKIlYDzPlzH0hq/UhfTc4DN6UAPz8WNg
 GeNd/HAK0RqLqLuUFO7L63PAjIRTlF3z1NPbI5Kgt3Ysw/F//X8V+jQX+3LOM4E9CQp6uz
 BtuASV+oVvjamU70vrwCnFuGh7I488g=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231--ByamJX3M62NIlSO_wUiOw-1; Fri, 03 Apr 2020 10:49:23 -0400
X-MC-Unique: -ByamJX3M62NIlSO_wUiOw-1
Received: by mail-wm1-f71.google.com with SMTP id e16so2134563wmh.5
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2020 07:49:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=2yQcmseEyeVg6GPm96uWfFnmAMUahKPoXBAjzFAW3yI=;
 b=L+FWs31GqQ/Cbedh44ifHhH9Q+aqSYk+tOhKSYZLQ0Etwd+arqvOPWVMxrM01ZnUBS
 useC/fOMQ98PBag50Df48kx93Clriqe1bJc+ib7lrMeL0FK5US7vXiBGarsH/nNfbay7
 weBvkF23bVGY4DkhMaOV0fZ+SF1gW/WTsMtCTZJBvJCPWE8i0uMDVNlN55zvtAtP/jVo
 HFoH9ZxnEnilMqtXlC85KA+w5qoIxClle1YKmePJJ+aJ6/vQFa+aXhV161ASmh909LXh
 DWJRNn6IEqEHZ95u+YoiO3QD6SPH79ENdXcVgIMIPPY+pnCh8xH2WlvU/u9WVjB3WXyX
 TeSw==
X-Gm-Message-State: AGi0PuZrp5WjQ7m3LbPatTj6Pa7r1zZeY2MRHS1WffrW45Oc6FnmKNZD
 +bBSBuKU8Z3bOyIuzwb7XN4/5cA+No8QfkYJA8nOaEoJAjmo4nT8VDZk6PzO4JciOvsYuTqovF3
 qW+ricUi8ZgUjMpM=
X-Received: by 2002:a5d:4844:: with SMTP id n4mr1876789wrs.314.1585925362129; 
 Fri, 03 Apr 2020 07:49:22 -0700 (PDT)
X-Google-Smtp-Source: APiQypJ0AZHkfLKjPMnhj2b2pI772WnqimjJzNleJGck0W25rIEhP0qlqVTo5gotJo7M/k58Z4J98w==
X-Received: by 2002:a5d:4844:: with SMTP id n4mr1876773wrs.314.1585925361963; 
 Fri, 03 Apr 2020 07:49:21 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::3])
 by smtp.gmail.com with ESMTPSA id a13sm12168426wrh.80.2020.04.03.07.49.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2020 07:49:21 -0700 (PDT)
Date: Fri, 3 Apr 2020 10:49:16 -0400
From: Peter Xu <peterx@redhat.com>
To: Liu Yi L <yi.l.liu@intel.com>
Subject: Re: [PATCH v2 22/22] intel_iommu: modify x-scalable-mode to be
 string option
Message-ID: <20200403144916.GM103677@xz-x1>
References: <1585542301-84087-1-git-send-email-yi.l.liu@intel.com>
 <1585542301-84087-23-git-send-email-yi.l.liu@intel.com>
MIME-Version: 1.0
In-Reply-To: <1585542301-84087-23-git-send-email-yi.l.liu@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

On Sun, Mar 29, 2020 at 09:25:01PM -0700, Liu Yi L wrote:
> Intel VT-d 3.0 introduces scalable mode, and it has a bunch of capabiliti=
es
> related to scalable mode translation, thus there are multiple combination=
s.
> While this vIOMMU implementation wants simplify it for user by providing
> typical combinations. User could config it by "x-scalable-mode" option. T=
he
> usage is as below:
>=20
> "-device intel-iommu,x-scalable-mode=3D["legacy"|"modern"|"off"]"
>=20
>  - "legacy": gives support for SL page table
>  - "modern": gives support for FL page table, pasid, virtual command
>  - "off": no scalable mode support
>  -  if not configured, means no scalable mode support, if not proper
>     configured, will throw error
>=20
> Note: this patch is supposed to be merged when  the whole vSVA patch seri=
es
> were merged.
>=20
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Yi Sun <yi.y.sun@linux.intel.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

--=20
Peter Xu


