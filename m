Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D31C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 01:34:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 426112076E
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 01:34:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fK735Hww"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 426112076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8ZTN-0004QP-FZ
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 21:34:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34222)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k8ZSq-0003vZ-Ia
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 21:34:00 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:50981
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k8ZSp-0002mT-2H
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 21:34:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597887238;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N0/yWD34uNTfSRnuLrUHsOJAaeb4NKyeLvDPEJsBIeY=;
 b=fK735Hww42D6QZ9T5TgPC6URftttpv+if+jlkZIkYZBggykDAfYsBYCG/wyCU+4hE64XLe
 ikl6M9tur3sqaBeAoj+uVIB4qOrm43AtvodlfTcCT1c3IUlgMpNMZ5J7Zjl+RAktFUztSM
 1FRaXwtd2Cijg1pCYyD+xi4AjTQXtCQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-hd96oWc1Mxua5mFtCPvhLg-1; Wed, 19 Aug 2020 21:33:43 -0400
X-MC-Unique: hd96oWc1Mxua5mFtCPvhLg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B2F5D10066FB;
 Thu, 20 Aug 2020 01:33:42 +0000 (UTC)
Received: from [10.3.112.136] (ovpn-112-136.phx2.redhat.com [10.3.112.136])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EC08019C78;
 Thu, 20 Aug 2020 01:33:38 +0000 (UTC)
Subject: Re: [PATCH v7 0/7] coroutines: generate wrapper code
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <20200610100336.23451-1-vsementsov@virtuozzo.com>
 <20200727124840.GC386429@stefanha-x1.localdomain>
 <c610e7b2-9c1a-30fd-4217-e1bcb812ec7c@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <76c463e6-0d63-d25d-8095-e87db97c5081@redhat.com>
Date: Wed, 19 Aug 2020 20:33:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <c610e7b2-9c1a-30fd-4217-e1bcb812ec7c@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 20:12:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: fam@euphon.net, kwolf@redhat.com, ehabkost@redhat.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>, crosa@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/27/20 7:59 AM, Vladimir Sementsov-Ogievskiy wrote:
> 27.07.2020 15:48, Stefan Hajnoczi wrote:
>> On Wed, Jun 10, 2020 at 01:03:29PM +0300, Vladimir Sementsov-Ogievskiy 
>> wrote:
>>> Hi all!
>>>
>>> The aim of the series is to reduce code-duplication and writing
>>> parameters structure-packing by hand around coroutine function wrappers.
>>>
>>> Benefits:
>>>   - no code duplication
>>>   - less indirection
>>
>> Please add documentation so others know when and how to use this.
>>
>> I suggest adding a docs/devel/coroutine-wrapper.rst document and adding
>> a code comment to #define generated_co_wrapper pointing to the
>> documentation.
>>
>> Please rename coroutine-wrapper.py to block-coroutine-wrapper.py since
>> it is specific to the block layer.
>>
> 
> OK, will do. Thanks for taking a look!

As this series touched Makefile to add a generated .c, you'll also need 
to rebase that part to apply on top of Paolo's meson conversion (cc'ing 
him if you need help figuring it out)

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


