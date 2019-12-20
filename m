Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C9EC43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 21:06:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 027BA206DA
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 21:06:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MnXjjyhr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 027BA206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiPU4-0007JH-85
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 16:06:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34626)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iiPT8-0006VO-AH
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 16:05:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iiPT6-0005x2-U6
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 16:05:53 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54309
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iiPT6-0005rC-Oa
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 16:05:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576875951;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IcrvJAUUbnugmXYWwFB5hHrbfxcnBOT3SBBdCc15zOY=;
 b=MnXjjyhrS9MmSO2934UaYs+ZtdrDbBCb7m22Y78HWeIMVCy+Ndrx6qhdj4XoS3skSPO09N
 d2SJe2pP7YO+DbQ0nsPJUystPXAODLuQ8hFIVVzi4r51Ta4pEcZ8CQQw7MXuFAUiE0Lgmq
 kuv0BdmL5X78A++sE4EbEDCsRJ/Tx+s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-1P-vsUqcO1KRcQwiZcZSsA-1; Fri, 20 Dec 2019 16:05:48 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 818BF800D50;
 Fri, 20 Dec 2019 21:05:47 +0000 (UTC)
Received: from [10.3.116.246] (ovpn-116-246.phx2.redhat.com [10.3.116.246])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 697D55DA32;
 Fri, 20 Dec 2019 21:05:44 +0000 (UTC)
Subject: Re: [PATCH] block/rbd: Add support for ceph namespaces
To: Florian Florensa <fflorensa@online.net>, dillaman@redhat.com
References: <20191219133416.671431-1-fflorensa@online.net>
 <20191219145125.iwhxhzmt5mow5pea@steredhat>
 <20191220141125.wxlm4eizbwie6522@flash.localdomain>
 <CA+aFP1DuNzvWZo7d8sFX6UEYV175HKm0Wo9PJWyHs91dA_WkHQ@mail.gmail.com>
 <20191220171704.7qlh6gmulsvj45db@flash.localdomain>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <e0137b36-ca9c-8ed6-72f7-50f48948b25a@redhat.com>
Date: Fri, 20 Dec 2019 15:05:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191220171704.7qlh6gmulsvj45db@flash.localdomain>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: 1P-vsUqcO1KRcQwiZcZSsA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/20/19 11:17 AM, Florian Florensa wrote:

>>>> The patch LGTM, but I'd like to use 'namespace' instead of cryptic
>>>> 'nspace'. (as BlockdevOptionsNVMe did)
>>>> What do you think?
>>>>
>>> Yes no worries, I can rename it to 'rbd_namespace' to avoid any possible
>>> confusion, is this Ok for you ?
>>
>> We use "pool_namespace" in the rbd CLI if you are trying to avoid the
>> word "namespace".
>>
> Yes I wanted to avoid namespace because it looks like the qapi generated
> code changes the name to something like q_namespace, will use
> pool_namespace in the v2.

The whole point of the mangling of 'q_namespace' in the C code is so 
that you can have a SANE name in the qapi, without tripping up 
compilation in a C++ compiler where 'namespace' is a reserved word 
(since we do have parts of qemu compiled by c++).  I'd go with just 
'namespace', rather than 'pool-namespace' (note that if you DO go with a 
longer name, we prefer - over _ in qapi names).

>>>> With those fixed:
>>>>
>>>> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

But see my other comment upthread about making the new parameter 
optional, to avoid breaks with older qapi clients.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


