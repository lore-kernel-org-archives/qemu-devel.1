Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA4FC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 14:23:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92A1B20788
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 14:23:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JrwU8z69"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92A1B20788
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGkSy-0001Xz-TH
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 10:23:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57345)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jGkSK-0000iO-Js
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 10:23:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jGkSJ-0006lP-Df
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 10:23:00 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:48642)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jGkSJ-0006jD-5M
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 10:22:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585059778;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SXmSHmp0JkXZeiR5QvdVTCg1/d4bw7+STm6SnnAh+iE=;
 b=JrwU8z69J3HXHir0YNdRBh7vXg1Ut9hEetif0fnwF+ah5ktOuPsfXY0OwmgpBlEspEcNa+
 bcbYpH8BSYsNieI0wMRcXQP6anYIbwjT5gFTxjR69HMqA/uLAOZhj2vORJ8A1F56LDYUXE
 etSmYY+FyeR0KOcZ1+E+iK5Oz0I1Wo0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-t0Q1BkzjMcSVgatq-WOKJg-1; Tue, 24 Mar 2020 10:22:41 -0400
X-MC-Unique: t0Q1BkzjMcSVgatq-WOKJg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7724C18B9F82;
 Tue, 24 Mar 2020 14:22:40 +0000 (UTC)
Received: from [10.3.113.103] (ovpn-113-103.phx2.redhat.com [10.3.113.103])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1DDD55DA7C;
 Tue, 24 Mar 2020 14:22:39 +0000 (UTC)
Subject: Re: [PATCH v4 0/2] Replaced locks with lock guard macros
To: Richard Henderson <richard.henderson@linaro.org>,
 Daniel Brodsky <dnbrdsky@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>
References: <20200320123137.1937091-1-dnbrdsky@gmail.com>
 <158471180295.15515.1369533827289907154@39012742ff91>
 <20200323132556.GG261260@stefanha-x1.localdomain>
 <CA+ZmoZUFojqmMxNQ1bhGMzjML7OFgDt1GNbogGTw5rte5LD4iw@mail.gmail.com>
 <1b0fa063-6fe4-ad40-06b2-9c3f2f955a06@linaro.org>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <04a411d6-72e7-d2d2-15f9-895f6a765d22@redhat.com>
Date: Tue, 24 Mar 2020 09:22:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1b0fa063-6fe4-ad40-06b2-9c3f2f955a06@linaro.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: "open list:All patches CC here" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


>>> You can test locally by building with clang (llvm) instead of gcc:
>>>
>>>    ./configure --cc=clang
>>
>> Using --cc=clang is causing the following error in several different places:
>> qemu/target/ppc/translate.c:1894:18: error: result of comparison
>> 'target_ulong' (aka 'unsigned int') <= 4294967295
>> is always true [-Werror,-Wtautological-type-limit-compare]
>>          if (mask <= 0xffffffffu) {
>>              ~~~~ ^  ~~~~~~~~~~~
>>
>> these errors don't come up when building with gcc. Any idea how to fix
>> this? Or should I just suppress it?
> 
> I'm of the opinion that it should be suppressed.
> 
> This is the *correct* test for ppc64, and the warning for ppc32 is simply
> because target_ulong == uint32_t.  True is the correct result for ppc32.
> 
> We simply want the compiler to DTRT: simplify this test and remove the else as
> unreachable.

There may be ways to rewrite that expression to avoid triggering the 
warning on a 32-bit platform.  Untested, but does this help:

if (sizeof(mask) > 4 && mask <= 0xffffffffu) {

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


