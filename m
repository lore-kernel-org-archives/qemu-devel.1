Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 461B3C38BE3
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 18:27:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13A8D2084E
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 18:27:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BXwbBDSP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13A8D2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6IRZ-0004NX-9O
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 13:27:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57278)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1j6IQj-0003Vj-5j
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 13:26:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1j6IQh-0007Zi-Ia
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 13:26:08 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:47468
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1j6IQh-0007Xa-D0
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 13:26:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582568766;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HGGUwW06Scu7dzuB7dDyt/6QqFJcHZbTRNCUCNkkOTs=;
 b=BXwbBDSPDLcNIP5bx6/s0H62hB7lG1wM27VfhLwE++x6sraNpjwFFYS3dqMsoEhbxilyLh
 vQjyqJeC58Ofq+zwVzWh0LT5mAQl6OP26+LbYroVUHxKRWMCSAm/8aSSNHbD4hJj7Uo7gy
 ZZkeU5cEt99cUGdZZV+YR1jEmQe9sz0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216-dJrNhi-KNWG8rwiuNzdqIg-1; Mon, 24 Feb 2020 13:25:58 -0500
X-MC-Unique: dJrNhi-KNWG8rwiuNzdqIg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7069A8017DF;
 Mon, 24 Feb 2020 18:25:57 +0000 (UTC)
Received: from [10.3.116.90] (ovpn-116-90.phx2.redhat.com [10.3.116.90])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1870F5D9CD;
 Mon, 24 Feb 2020 18:25:57 +0000 (UTC)
Subject: Re: [PATCH] iotests: Fix cleanup path in some tests
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200224171631.384314-1-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <9224d842-faa6-678f-6a12-d76655db2743@redhat.com>
Date: Mon, 24 Feb 2020 12:25:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200224171631.384314-1-mreitz@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/24/20 11:16 AM, Max Reitz wrote:
> Some iotests leave behind some external data file when run for qcow2
> with -o data_file.  Fix that.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   tests/qemu-iotests/085 | 1 +
>   tests/qemu-iotests/087 | 6 ++++++
>   tests/qemu-iotests/279 | 2 +-
>   3 files changed, 8 insertions(+), 1 deletion(-)
> 

I'd LOVE for someone to take on a GSOC project to finish the work Jeff 
Cody once proposed on having iotests run each test in its own dedicated 
directory, such that files are left behind on failure for easy 
investigation, and cleanup is a snap of just deleting that directory on 
success.

But until then, adding manual cleanup where we missed it is correct.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


