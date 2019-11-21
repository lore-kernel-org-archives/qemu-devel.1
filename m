Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B164C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 05:19:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA5E220748
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 05:19:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SRgmVxpf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA5E220748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXesY-0006Sj-3a
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 00:19:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33429)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1iXerD-0005z8-P7
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 00:18:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1iXerA-0001r8-PF
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 00:18:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55029
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1iXerA-0001q4-B0
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 00:18:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574313494;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y+G9eV5DJNZH0V64wJxENl/AhM/A7DFDEJTkoEgxEUQ=;
 b=SRgmVxpfDNPew6IHbKvPZkkPzgTec6PfNi478/x4/h39nXAKMhomU0shBrKYiiD2Xlz0ot
 UlScFO6zSB0MgGSoISQhUqXfwGbmXf3hPv2rjZbEC87tBT94F2K+tsRzD0D3Cy53e6rziw
 TsakM5o50dg8Z3WOU1eyFcfxJ/1e7Cw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-H0TuwCNwOAmpoqp3_FsOKw-1; Thu, 21 Nov 2019 00:18:11 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8A4F61005509;
 Thu, 21 Nov 2019 05:18:10 +0000 (UTC)
Received: from [10.72.12.204] (ovpn-12-204.pek2.redhat.com [10.72.12.204])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 44EBB608BB;
 Thu, 21 Nov 2019 05:18:01 +0000 (UTC)
Subject: Re: [PATCH v3 0/4] net/virtio: fixes for failover
To: "Michael S. Tsirkin" <mst@redhat.com>, Jens Freimann <jfreimann@redhat.com>
References: <20191120154951.27877-1-jfreimann@redhat.com>
 <20191120105606-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <b6c29f19-c6f4-c03f-81f3-6d665b7e48fc@redhat.com>
Date: Thu, 21 Nov 2019 13:18:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191120105606-mutt-send-email-mst@kernel.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: H0TuwCNwOAmpoqp3_FsOKw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2019/11/20 =E4=B8=8B=E5=8D=8811:56, Michael S. Tsirkin wrote:
> On Wed, Nov 20, 2019 at 04:49:47PM +0100, Jens Freimann wrote:
>> This series fixes bugs found by coverity and one reported by David
>> Gilbert.
>
> Looks good.  Jason can you merge this pls?


Yes, applied.

Thanks


>
>> v2->v3:
>>   * change patch description and subject of patch 3/4
>>
>> Jens Freimann (4):
>>    net/virtio: fix dev_unplug_pending
>>    net/virtio: return early when failover primary alread added
>>    net/virtio: fix re-plugging of primary device
>>    net/virtio: return error when device_opts arg is NULL
>>
>>   hw/net/virtio-net.c | 58 +++++++++++++++++++++++++++++----------------
>>   migration/savevm.c  |  3 ++-
>>   2 files changed, 40 insertions(+), 21 deletions(-)
>>
>> --=20
>> 2.21.0


