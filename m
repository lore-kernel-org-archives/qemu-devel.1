Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C6FFC2BA19
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 08:55:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D8AD2084D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 08:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sk28YTZZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D8AD2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRXdj-0006XF-7y
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 04:55:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34736)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1jRXd4-0005vA-Gm
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 04:54:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1jRXd3-0004z4-L5
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 04:54:41 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:52454
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jRXd3-0004tR-4M
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 04:54:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587632079;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3obggGEhK9/La8IZUdIqOWktHXMKMTZxTBmKO/d2dMs=;
 b=Sk28YTZZgz9MgKC28ifyuLZ/mXJxgTWN2pxA/flKkJcNahX5DyXimcCkEdfeZIWhVsZHAo
 kb0qJYvjwTVGt4/EhNqcvou//qB5CtdxXZVEOLFh3/scDq81xAbV+RvyFt0hTNd3rNAH30
 fYJmoaQX7N4d5aKI5WB+iatwqMQ1gtU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-MkWsLQC-Pd-FjBuuK5O93w-1; Thu, 23 Apr 2020 04:54:37 -0400
X-MC-Unique: MkWsLQC-Pd-FjBuuK5O93w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DEDA418B9FFA;
 Thu, 23 Apr 2020 08:54:35 +0000 (UTC)
Received: from [10.72.13.168] (ovpn-13-168.pek2.redhat.com [10.72.13.168])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C24BB66834;
 Thu, 23 Apr 2020 08:54:31 +0000 (UTC)
Subject: Re: [PATCH 0/2] net/colo-compare.c: Expose "max_queue_size" to users
 and clean up
To: "Zhang, Chen" <chen.zhang@intel.com>, qemu-dev <qemu-devel@nongnu.org>
References: <20200411033824.19389-1-chen.zhang@intel.com>
 <716ca2bcd9e64c37a79509c468e18485@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <18466058-4184-2c6e-d740-2a1479395506@redhat.com>
Date: Thu, 23 Apr 2020 16:54:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <716ca2bcd9e64c37a79509c468e18485@intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 03:23:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Zhang Chen <zhangckid@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/4/23 =E4=B8=8B=E5=8D=883:31, Zhang, Chen wrote:
> Hi Jason,
>
> Please review this series when you free.
>
> Thanks
> Zhang Chen
>

Sure.

I wonder maybe it's better e.g you can review and collect the patches=20
that looks good and send them to me periodically?

Thanks


