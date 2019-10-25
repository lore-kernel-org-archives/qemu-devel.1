Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA5BCA9EAF
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 02:13:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0543921929
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 02:13:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Evov4UvH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0543921929
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNp6R-0000EI-4j
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 22:13:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38335)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1iNp5l-00074j-38
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 22:12:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1iNp5i-0003Al-DZ
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 22:12:39 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:58399
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1iNp5i-0003AZ-9C
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 22:12:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571969556;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8pC4mfix42XwL2WjAqNzcNWErMqXf9/XtuMk8Up6HCQ=;
 b=Evov4UvHWdaEvvjdNgGJSD4NNNlvYCpLpyM3tFiUxz3nSAdh1/WPcNJPAiPUk3XjHnaGbe
 hcjl8k8QG9yZ2xn+Ax3ZWGlcTvvNEJUBYcoDm8zr4vsOYsxUKTPDqDUmTaB66B7MsgCp+X
 9K/5JeBZHrdodg41iOntNnjpmyiTYA0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-T7dOV6laPGaFMzoMQ5K8IQ-1; Thu, 24 Oct 2019 22:12:32 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A2F301005500;
 Fri, 25 Oct 2019 02:12:31 +0000 (UTC)
Received: from [10.72.12.158] (ovpn-12-158.pek2.redhat.com [10.72.12.158])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 11145600C6;
 Fri, 25 Oct 2019 02:12:24 +0000 (UTC)
Subject: Re: [PATCH v4 2/2] virtio-net: prevent offloads reset on migration
To: Mikhail Sennikovsky <mikhail.sennikovskii@cloud.ionos.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <1570802284-3064-1-git-send-email-mikhail.sennikovskii@cloud.ionos.com>
 <1570802284-3064-2-git-send-email-mikhail.sennikovskii@cloud.ionos.com>
 <20191011101256-mutt-send-email-mst@kernel.org>
 <CALHVEJYEaoUaWAzhK0313EXdu2ccyfRvDHGVB2EkkT2p33y4xA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <c5a265d5-8131-f9f7-f465-3ce87277c4b0@redhat.com>
Date: Fri, 25 Oct 2019 10:12:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CALHVEJYEaoUaWAzhK0313EXdu2ccyfRvDHGVB2EkkT2p33y4xA@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: T7dOV6laPGaFMzoMQ5K8IQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Cc: qemu-devel@nongnu.org, stefanha@redhat.com,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2019/10/24 =E4=B8=8B=E5=8D=889:53, Mikhail Sennikovsky wrote:
> Hi Guys,
>
> Sorry I was on vacation last week, so did not track it much.
> Seems like the patch has not been applied yet. Is this because there
> are still some concerns about the way of fixing the problem?
>
> Regards,
> Mikhail


Applied.

Thanks


