Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEFC9C32771
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 09:51:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9877820673
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 09:51:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mb+SHFZr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9877820673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipUTb-00063u-Qc
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 04:51:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59924)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1ipUSb-0005cZ-Ba
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 04:50:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1ipUSZ-0005Yc-Op
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 04:50:36 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52701
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ipUSZ-0005Vd-GP
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 04:50:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578563432;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VuX+qcg0QQrWCA0S2lv5KwXESV4MGilM3W5kuGOX6eU=;
 b=Mb+SHFZrgLOH3JZ4fIE7E8OvCVo8HSxNAvx1khIU1RL3rOmAcX7Dq27GEluMWirEgTAJ7s
 Eu+8tlhzSyrFT28ZJSk2s5jQd5zwV1SjArZp3GIEEz3C+N+3sqI0W3aKu1IAJdJW0InCSW
 fGik6ybuKV+Bt10UwCwnHQunMCwXx+Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-373-wHwMkwcdMmKk7B9XLG69Ag-1; Thu, 09 Jan 2020 04:50:28 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D855C184B1E4;
 Thu,  9 Jan 2020 09:50:27 +0000 (UTC)
Received: from redhat.com (ovpn-116-22.ams2.redhat.com [10.36.116.22])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3ED0B1001B11;
 Thu,  9 Jan 2020 09:50:27 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Subject: Re: [PATCH 0/2] not use multifd during postcopy
In-Reply-To: <20200106012640.GA15834@richard> (Wei Yang's message of "Mon, 6
 Jan 2020 09:26:40 +0800")
References: <20191025232000.25857-1-richardw.yang@linux.intel.com>
 <20191216023539.GB21865@richard> <20200106012640.GA15834@richard>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Thu, 09 Jan 2020 10:50:25 +0100
Message-ID: <87v9plyn4u.fsf@secure.laptop>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: wHwMkwcdMmKk7B9XLG69Ag-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
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
Reply-To: quintela@redhat.com
Cc: dgilbert@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Wei Yang <richardw.yang@linux.intel.com> wrote:
> On Mon, Dec 16, 2019 at 10:35:39AM +0800, Wei Yang wrote:
>>Would this one be picked up this time?
>
> Happy new year to all.
>
> Can I ask the plan for this patch set?

queued

>
>>
>>On Sat, Oct 26, 2019 at 07:19:58AM +0800, Wei Yang wrote:
>>>We don't support multifd during postcopy, but user still could enable
>>>both multifd and postcopy. This leads to migration failure.
>>>
>>>Patch 1 does proper cleanup, otherwise we may have data corruption.
>>>Patch 2 does the main job.
>>>
>>>BTW, current multifd synchronization method needs a cleanup. Will send a=
nother
>>>patch set.
>>>
>>>Wei Yang (2):
>>>  migration/multifd: clean pages after filling packet
>>>  migration/multifd: not use multifd during postcopy
>>>
>>> migration/ram.c | 15 ++++++++++-----
>>> 1 file changed, 10 insertions(+), 5 deletions(-)
>>>
>>>--=20
>>>2.17.1
>>
>>--=20
>>Wei Yang
>>Help you, Help me


