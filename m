Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7655AC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 01:39:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D6C92077D
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 01:39:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b39jap70"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D6C92077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKBIf-0006WN-AY
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 21:39:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57468)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1jKBI4-000657-TA
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 21:38:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1jKBI1-0005wS-0j
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 21:38:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36363
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1jKBI0-0005vm-Nl
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 21:38:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585877911;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sxKKBZOSjS4SdoY0/0z3b/PmUuVXiHXvMP0+Tr+BScs=;
 b=b39jap70qI69lNa9rEFB9cQXC2mYmULAhQnSw3knntpcLy411xzrk2elgWT+Cn9JSea+zA
 Hh+E1q29+QLtiT4tqZQoWq2BMUFhG7y70U5MseFueeqaFUTjcgaJ8M0eXKJadRJ5LrzPql
 bnga8MnSW555S/42i/BmD/TdfUaqKw4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-28-a4PVFsVwOPqZ0ekjeyc6JQ-1; Thu, 02 Apr 2020 21:38:28 -0400
X-MC-Unique: a4PVFsVwOPqZ0ekjeyc6JQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 901EE477;
 Fri,  3 Apr 2020 01:38:26 +0000 (UTC)
Received: from [10.72.13.110] (ovpn-13-110.pek2.redhat.com [10.72.13.110])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BDFA160BF1;
 Fri,  3 Apr 2020 01:38:06 +0000 (UTC)
Subject: Re: [PATCH v2 00/22] intel_iommu: expose Shared Virtual Addressing to
 VMs
To: Peter Xu <peterx@redhat.com>
References: <1585542301-84087-1-git-send-email-yi.l.liu@intel.com>
 <984e6f47-2717-44fb-7ff2-95ca61d1858f@redhat.com>
 <20200402134601.GJ7174@xz-x1>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <02544abd-17d8-e5e1-788c-b4a5ddd3a382@redhat.com>
Date: Fri, 3 Apr 2020 09:38:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200402134601.GJ7174@xz-x1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
 Liu Yi L <yi.l.liu@intel.com>, kvm@vger.kernel.org, mst@redhat.com,
 jun.j.tian@intel.com, qemu-devel@nongnu.org, eric.auger@redhat.com,
 alex.williamson@redhat.com, pbonzini@redhat.com, hao.wu@intel.com,
 yi.y.sun@intel.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/4/2 =E4=B8=8B=E5=8D=889:46, Peter Xu wrote:
> On Thu, Apr 02, 2020 at 04:33:02PM +0800, Jason Wang wrote:
>>> The complete QEMU set can be found in below link:
>>> https://github.com/luxis1999/qemu.git: sva_vtd_v10_v2
>>
>> Hi Yi:
>>
>> I could not find the branch there.
> Jason,
>
> He typed wrong... It's actually (I found it myself):
>
> https://github.com/luxis1999/qemu/tree/sva_vtd_v10_qemu_v2


Aha, I see.

Thanks


>


