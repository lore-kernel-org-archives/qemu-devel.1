Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 945C7C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 19:51:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E86524673
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 19:51:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dZBbXCmB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E86524673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idJd0-0001MF-Go
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 14:51:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53699)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1idJbI-0007zx-AX
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 14:49:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1idJbE-0005aq-Bi
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 14:49:14 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23499
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1idJb7-0005Wh-4Z
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 14:49:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575661742;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9mglkLeSMgatG2QuCuv8J26Cg/iVIUGIcRnZXgy5kHc=;
 b=dZBbXCmBxqPkvNOWWdSKTG2Z5K9XJqH0oHxREn55IBAk8R7haoA/1AJQMEfqJi5CbwWLsG
 HpmxWy/lygM6HwrhZ0hLQobZoNQMzq26p0VToxxhVJcc0a1CKSTs+TQTBOoKypwdc4xvSW
 MFpR5DI1+ILvCkVwT/O2feoFVMNURHU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-wkclNKJuNu2BvfumVAoTEw-1; Fri, 06 Dec 2019 14:49:00 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C002F134C21;
 Fri,  6 Dec 2019 19:48:59 +0000 (UTC)
Received: from [10.3.116.171] (ovpn-116-171.phx2.redhat.com [10.3.116.171])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D806619C4F;
 Fri,  6 Dec 2019 19:48:53 +0000 (UTC)
Subject: Re: [PATCH for-4.2?] block/qcow2-bitmap: fix crash bug in
 qcow2_co_remove_persistent_dirty_bitmap
To: John Snow <jsnow@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20191205193049.30666-1-vsementsov@virtuozzo.com>
 <22af83d1-91e2-ab71-2dc4-349b5b24d1d8@redhat.com>
 <990da2e0-8223-b257-254d-a27659ef1d24@redhat.com>
 <6a74ae0a-e377-0f70-c347-0307580d7981@virtuozzo.com>
 <36655f7a-7ea5-e80a-ebfd-5b19c90622c0@redhat.com>
 <8c7c5f50-1899-3457-e1bc-77d8fee87de7@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <e9df8d8f-abce-820d-fa25-4c41c0666bba@redhat.com>
Date: Fri, 6 Dec 2019 13:48:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <8c7c5f50-1899-3457-e1bc-77d8fee87de7@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: wkclNKJuNu2BvfumVAoTEw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Peter Krempa <pkrempa@redhat.com>,
 "libvirt-list@redhat.com" <libvirt-list@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/6/19 1:02 PM, John Snow wrote:

>>> I'm afraid that the only thing is not remove persistent bitmaps, which
>>> were never synced to the image. So, instead the sequence above, we need
>>>
>>>
>>> 1. create persistent bitmap A
>>> 2. shutdown vm
>>> 3. start vm
>>> 4. create persistent bitmap B
>>> 5. remember, that we want to remove bitmap B after vm shutdown
>>> ...
>>>  =A0=A0 some other operations
>>> ...
>>> 6. vm shutdown
>>> 7. start vm in stopped mode, and remove all bitmaps marked for removing
>>> 8. stop vm
>>>
>>> But, I think that in real circumstances, vm shutdown is rare thing...

Part of me wonders if we would have detected this MUCH sooner if I had=20
gotten my wish of having the qcow2 metadata updated on creation of any=20
persistent bitmap (not actually writing out the bitmap itself, just=20
updating the bitmap table to mark that there is a new persistent=20
inconsistent bitmap), so that a) qemu-img info -U can see the persistent=20
bitmap's existence, and b) an unexpected abrupt crash of qemu does not=20
lose the existence of the bitmap.  At the time I raised the question,=20
the push-back at the time was a desire to minimize writes to the qcow2=20
metadata at all costs, warranting our current extreme code contortions=20
to keep persistent bitmaps were kept in memory only until VM shutdown.=20
But had we been doing it, we would spot problems like this without=20
having to do VM shutdown, and our code might actually be simpler than=20
our current contortions.  Maybe we should still revisit that decision=20
(of course, that question is independent of this patch, and therefore=20
5.0 material at earliest).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


