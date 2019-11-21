Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6164C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 08:31:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E15A20718
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 08:31:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IBuDIktS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E15A20718
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXhsc-0008W2-Jb
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 03:31:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56294)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1iXhrN-00084x-Cq
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 03:30:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1iXhrJ-0007uU-3F
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 03:30:39 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:27725
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1iXhrI-0007uF-R2
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 03:30:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574325035;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zFW3XN/WEk4LYm3JdVE6Rn7JPqVcjZDjgc08yx+s8rQ=;
 b=IBuDIktS4XMy6fLsLwnypr8wxufg95uBed0FkmG4gwddktPt5QJmb06Xauw40CTi5HibAv
 XYvZX3rZgPW2AedpQGiiXqnWzja79a6NAxe5nfvc1/YCMuGUBSLDeJfMHTUMZU8EVKQpSY
 zCmCzl8sygwRaP3YhWikZlipiOBbrCg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-flwLKeskP-mmNJqLo7IUqA-1; Thu, 21 Nov 2019 03:30:34 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B7D5F801FCF;
 Thu, 21 Nov 2019 08:30:32 +0000 (UTC)
Received: from redhat.com (ovpn-116-218.ams2.redhat.com [10.36.116.218])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 045415DAB0;
 Thu, 21 Nov 2019 08:30:31 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH] pseries: disable migration-test if /dev/kvm cannot be used
In-Reply-To: <e96b3dd9-05d3-d260-852a-13423ed9b8cc@redhat.com> (Laurent
 Vivier's message of "Thu, 21 Nov 2019 09:08:22 +0100")
References: <20191120170955.242900-1-lvivier@redhat.com>
 <87zhgpn1dt.fsf@trasno.org>
 <e96b3dd9-05d3-d260-852a-13423ed9b8cc@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
Date: Thu, 21 Nov 2019 09:30:27 +0100
Message-ID: <87v9rdmy1o.fsf@trasno.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: flwLKeskP-mmNJqLo7IUqA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Reply-To: quintela@redhat.com
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Cole Robinson <crobinso@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Laurent Vivier <lvivier@redhat.com> wrote:
> On 21/11/2019 08:18, Juan Quintela wrote:
>> Laurent Vivier <lvivier@redhat.com> wrote:
>>> On ppc64, migration-test only works with kvm_hv, and we already
>>> have a check to verify the module is loaded.
>>>
>>> kvm_hv module can be loaded in memory and /sys/module/kvm_hv exists,
>>> but on some systems (like build systems) /dev/kvm can be missing
>>> (by administrators choice).
>>>
>>> And as kvm_hv exists test-migration is started but QEMU falls back to
>>> TCG because it cannot be used:
>>>
>>>     Could not access KVM kernel module: No such file or directory
>>>     failed to initialize KVM: No such file or directory
>>>     Back to tcg accelerator
>>>
>>> And as the test is done with TCG, it fails.
>>>
>>> As for s390x, we must check for the existence and the access rights
>>> of /dev/kvm.
>>>
>>> Reported-by: Cole Robinson <crobinso@redhat.com>
>>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
>>=20
>> Reviewed-by: Juan Quintela <quintela@redhat.com>
>>=20
>> Oh, why it is so difficult!!!
>>=20
>> Thanks, Juan.
>>=20
>
> David,
>
> could you add this one too to your ppc-for-4.2 queue?

I was about to ask if you preffered it to go through the migration tree.

David?

Later, Juan.


