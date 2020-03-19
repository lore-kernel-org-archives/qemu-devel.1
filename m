Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E80C4332B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 20:54:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7468D20774
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 20:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B2PnfwHO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7468D20774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jF2BP-0006Iw-Kw
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 16:54:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42945)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jF2AP-00051l-Lv
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 16:53:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jF2AO-0004NT-8z
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 16:53:25 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:34912)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jF2AO-0004NP-5V
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 16:53:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584651203;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MewPVfiDuxFNqh/JVlM7h5mKRw1l12myAOHcbLDqwNM=;
 b=B2PnfwHOnmRIVf0CKLdAVRqzn75VUdxKgpvNAAfyeMyPh1eBvp7+kdHhYdxSBE1cON0Ad3
 PxkwraxQDeIiTyGAeN8pd64DohrNJghdDK2rtIU34qyeST6oWvRKMUmWZ65UbL+CFx+CY1
 zs3O7DsCRdzFf+Z56tMU//puKIuYbx4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-243-S2gzw_yKNkWT4UsVaWbHOQ-1; Thu, 19 Mar 2020 16:53:20 -0400
X-MC-Unique: S2gzw_yKNkWT4UsVaWbHOQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0D6BE18C35A0;
 Thu, 19 Mar 2020 20:53:19 +0000 (UTC)
Received: from [10.3.112.193] (ovpn-112-193.phx2.redhat.com [10.3.112.193])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0CBFC6269F;
 Thu, 19 Mar 2020 20:53:10 +0000 (UTC)
Subject: Re: [PATCH] lockable: replaced locks with lock guard macros where
 appropriate
To: qemu-devel@nongnu.org, dnbrdsky@gmail.com
References: <158464628614.8795.7072935999807888220@39012742ff91>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <d734a44f-b2d6-150f-ca82-160e334d99c8@redhat.com>
Date: Thu, 19 Mar 2020 15:53:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <158464628614.8795.7072935999807888220@39012742ff91>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, quintela@redhat.com, pl@kamp.de,
 armbru@redhat.com, mreitz@redhat.com, alex.williamson@redhat.com,
 kraxel@redhat.com, ronniesahlberg@gmail.com, pbonzini@redhat.com,
 dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/19/20 2:31 PM, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20200319161925.1818377-2-dnbrdsky@gmail.com/
> 
> 
> 
> Hi,
> 
> This series failed the asan build test. Please find the testing commands and
> their output below. If you have Docker installed, you can probably reproduce it
> locally.
> 
> === TEST SCRIPT BEGIN ===
> #!/bin/bash
> export ARCH=x86_64
> make docker-image-fedora V=1 NETWORK=1
> time make docker-test-debug@fedora TARGET_LIST=x86_64-softmmu J=14 NETWORK=1
> === TEST SCRIPT END ===
> 
>    CC      trace-root.o
>    CC      accel/kvm/trace.o
>    CC      accel/tcg/trace.o
> /tmp/qemu-test/src/util/thread-pool.c:213:5: error: unused variable 'qemu_lockable_auto__COUNTER__' [-Werror,-Wunused-variable]
>      QEMU_LOCK_GUARD(&pool->lock);
>      ^
> /tmp/qemu-test/src/include/qemu/lockable.h:173:29: note: expanded from macro 'QEMU_LOCK_GUARD'

Hmm. This one is a different failure than the other patchew warnings 
about variable redefinition; but is still evidence that it is missing 
your "[PATCH] misc: fix __COUNTER__ macro to be referenced properly". 
At any rate, the fact that we have a compiler warning about an unused 
variable (when in reality it IS used by the auto-cleanup attribute) is 
annoying; we may have to further tweak QEMU_LOCK_GUARD to add an 
__attribute__((unused)) to shut up this particular compiler false positive.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


