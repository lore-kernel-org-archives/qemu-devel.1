Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A087DC3B1A1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 16:24:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71054247BB
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 16:24:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CMfNgPa1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71054247BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2dlv-0003Js-N1
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 11:24:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59201)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mprivozn@redhat.com>) id 1j2dlB-0002fG-Kg
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 11:24:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mprivozn@redhat.com>) id 1j2dlA-0007NN-Jb
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 11:24:09 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25861
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mprivozn@redhat.com>) id 1j2dlA-0007N8-Go
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 11:24:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581697448;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VVPauwVrW1vv9xbtdeOaHyo/Tx5zOz4gZm0eDRFyRKc=;
 b=CMfNgPa1GUnuUjGvHBESIwXVUA1n6Z8S/V+gmcJjc/vIOyvBsD/R4bA+M9V5jPT+bu0uMX
 gg3ASHJNjlugtBAjXCEr60eSnTJl5Geq8/vs8n3jLSATJ9P80ILzYjzjqUAA/lxmktUX84
 cxzH+xoHMJ3Lhsc9DcFjtK3NilcMwHs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-MFtFr7tIPZm4dP05FYQA5w-1; Fri, 14 Feb 2020 11:24:00 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 645DC18A5500;
 Fri, 14 Feb 2020 16:23:59 +0000 (UTC)
Received: from [10.43.2.30] (unknown [10.43.2.30])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 58E385C1C3;
 Fri, 14 Feb 2020 16:23:56 +0000 (UTC)
Subject: Re: [PATCH] Report stringified errno in VFIO related errors
To: Alex Williamson <alex.williamson@redhat.com>
References: <2dc5a0962a38b912e4fa4900f9813b7ea1a9273c.1581670009.git.mprivozn@redhat.com>
 <ef161708-2ecc-8d51-7dae-6a860659a8a9@redhat.com>
 <20200214084946.5220404b@x1.home>
From: Michal Privoznik <mprivozn@redhat.com>
Message-ID: <6cfca864-6a5e-2455-8618-1da98131cdba@redhat.com>
Date: Fri, 14 Feb 2020 17:23:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200214084946.5220404b@x1.home>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: MFtFr7tIPZm4dP05FYQA5w-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/14/20 4:49 PM, Alex Williamson wrote:
> On Fri, 14 Feb 2020 10:19:50 +0100
> Michal Privoznik <mprivozn@redhat.com> wrote:
> 
>>
>> Do you guys want me to file a bug?
> 
> Probably a good idea.  Thanks,

Since I'm reproducing this against upstream, I've reported it here:

https://bugs.launchpad.net/qemu/+bug/1863333

Michal


