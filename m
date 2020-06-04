Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 030B3C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 09:10:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5E602077D
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 09:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X3jyQOYo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5E602077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgltP-0005hL-43
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 05:10:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53794)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1jglsi-0004lp-6V
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 05:09:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23850
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1jglsg-0005sD-OQ
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 05:09:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591261785;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ahalv+0V/G1nISWzjqRyM11/DubG9KRM7EMm7qYESgs=;
 b=X3jyQOYoHP8aX+xhhW0Y3WZdELYGus9vxxstKiT+NIaasM7+Yk5h16lhEpEg62z4vzTM9C
 WPasTozNUJ2Mx349Y4A0ZUD3t7vbS2BU/nCYRcKUbogMr2q+PJBjvdZ2fafkNUMOD5NZU4
 HXqTFZDGKunWoDxAWr6u0U7Ya1Q6h5c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-2QPCRuSnNWmU8EsGLgk2jw-1; Thu, 04 Jun 2020 05:09:44 -0400
X-MC-Unique: 2QPCRuSnNWmU8EsGLgk2jw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3ACDF1902EA2;
 Thu,  4 Jun 2020 09:09:42 +0000 (UTC)
Received: from [10.40.193.170] (unknown [10.40.193.170])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5724A6AD0C;
 Thu,  4 Jun 2020 09:09:33 +0000 (UTC)
Subject: Re: [PATCH] numa: forbid '-numa node, mem' for 5.1 and newer machine
 types
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20200602084151.480567-1-imammedo@redhat.com>
From: Michal Privoznik <mprivozn@redhat.com>
Message-ID: <ac504671-b836-32f8-1231-0ff0724ca7c6@redhat.com>
Date: Thu, 4 Jun 2020 11:09:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200602084151.480567-1-imammedo@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mprivozn@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 01:12:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, ehabkost@redhat.com, mst@redhat.com,
 libvir-list@redhat.com, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 pbonzini@redhat.com, rth@twiddle.net, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/2/20 10:41 AM, Igor Mammedov wrote:
> Deprecation period is run out and it's a time to flip the switch
> introduced by cd5ff8333a.  Disable legacy option for new machine
> types (since 5.1) and amend documentation.
> 
> '-numa node,memdev' shall be used instead of disabled option
> with new machine types.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>   - rebased on top of current master
>   - move compat mode from 4.2 to 5.0
> 
> CC: peter.maydell@linaro.org
> CC: ehabkost@redhat.com
> CC: marcel.apfelbaum@gmail.com
> CC: mst@redhat.com
> CC: pbonzini@redhat.com
> CC: rth@twiddle.net
> CC: david@gibson.dropbear.id.au
> CC: libvir-list@redhat.com
> CC: qemu-arm@nongnu.org
> CC: qemu-ppc@nongnu.org
> ---
>   docs/system/deprecated.rst | 17 -----------------
>   hw/arm/virt.c              |  2 +-
>   hw/core/numa.c             |  6 ++++++
>   hw/i386/pc.c               |  1 -
>   hw/i386/pc_piix.c          |  1 +
>   hw/i386/pc_q35.c           |  1 +
>   hw/ppc/spapr.c             |  2 +-
>   qemu-options.hx            |  9 +++++----
>   8 files changed, 15 insertions(+), 24 deletions(-)

This works with libvirt perfectly.

Reviewed-by: Michal Privoznik <mprivozn@redhat.com>

Michal


