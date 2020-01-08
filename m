Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B8B5C282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 13:02:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 643C6206F0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 13:02:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IVJpXUu9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 643C6206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipAyz-0003LC-9L
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 08:02:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34725)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1ipAck-0005cA-U1
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:39:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1ipAci-0008Hv-69
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:39:45 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:31253
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ipAci-0008HF-1T
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:39:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578487183;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4+TS0nQmTlVo2nhUseZ6PlP0uxHPUsELi34gf94fJFE=;
 b=IVJpXUu90MjmxGfZGAiTRdE5JGyNr3I8ey4mzBezfmAmEPSS4g8DhrdIbW4sdjqzAzRIxj
 TzhErbHSjsqjuS23XBJLFUxiQrTx/sjnjVs04ogsL2uSjb4UmRGMHGw/adOC2GNurg58SB
 d8W/FIk7pzhjobLO3nRUEgDbs+UvxHM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-OLbXjUdvMn2NQuCafsZRQA-1; Wed, 08 Jan 2020 07:39:41 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0FA7C800EBF
 for <qemu-devel@nongnu.org>; Wed,  8 Jan 2020 12:39:41 +0000 (UTC)
Received: from redhat.com (unknown [10.36.118.112])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5830E5D9E1;
 Wed,  8 Jan 2020 12:39:40 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH] runstate: ignore finishmigrate -> prelaunch transition
In-Reply-To: <e0557fa4-e5b3-3f83-e002-b22d81e7561f@redhat.com> (Laurent
 Vivier's message of "Wed, 18 Dec 2019 17:21:17 +0100")
References: <20191129115132.285988-1-lvivier@redhat.com>
 <20191206195230.GJ2878@work-vm>
 <b782071a-c522-0e50-ed49-152964fe6bd4@redhat.com>
 <e0557fa4-e5b3-3f83-e002-b22d81e7561f@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Wed, 08 Jan 2020 13:39:36 +0100
Message-ID: <87imlmi0l3.fsf@secure.laptop>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: OLbXjUdvMn2NQuCafsZRQA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Laurent Vivier <lvivier@redhat.com> wrote:
> Ping?
>
> Thanks,
> Laurent
>
> On 12/12/2019 20:40, Laurent Vivier wrote:
>> On 06/12/2019 20:52, Dr. David Alan Gilbert wrote:
>>> * Laurent Vivier (lvivier@redhat.com) wrote:
>>>> Commit 1bd71dce4bf2 tries to prevent a finishmigrate -> prelaunch
>>>> transition by exiting at the beginning of the main_loop_should_exit()
>>>> function if the state is already finishmigrate.
>>>>
>>>> As the finishmigrate state is set in the migration thread it can
>>>> happen concurrently to the function. The migration thread and the
>>>> function are normally protected by the iothread mutex and thus the
>>>> state should no evolve between the start of the function and its end.
>>>>
>>>> Unfortunately during the function life the lock is released by
>>>> pause_all_vcpus() just before the point we need to be sure we are
>>>> not in finishmigrate state and if the migration thread is waiting
>>>> for the lock it will take the opportunity to change the state
>>>> to finishmigrate.
>>>
>>> Ewww.
>>> I hate those short wakeups for pause_all_vcpus; I'm sure there are load=
s
>>> more corners that break.
>>>
>>> Still, I _think_ this is an improvement, so:
>>>
>>> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>>>
>>=20
>> Who volunteers to take this in his queue?

Reviewed-by: Juan Quintela <quintela@redhat.com>

queued


