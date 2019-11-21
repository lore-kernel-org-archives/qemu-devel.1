Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D108CC432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 15:19:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98EAA20674
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 15:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="haxNLptw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98EAA20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXoEo-0002i6-Ox
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 10:19:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48682)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iXoD1-0001hc-Ez
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 10:17:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iXoCw-0006Lm-GY
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 10:17:27 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:38369
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iXoCw-00068g-Ch
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 10:17:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574349441;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NG2MiFOJr7nb8kWg++Tn4/M+EBAlkiIkt2K8a8ND5vM=;
 b=haxNLptwlh5rT4NY5DWlI2M6Skq1LHd15acPpH4H84Fb8FdJVyrK4y+kbGSjbteA9or8xa
 DMJDD0eS7t0A+8Hxagk9o6gccGrmq6leRwVSRHOLL/9/mc8T+6v5ptMR4aW3RLFvmTKPxu
 WNDqonL4UkHoHy3Or6w6gFIhNmlVbu0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-VcsDVkLZPTKrsBOismsRqg-1; Thu, 21 Nov 2019 10:17:17 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 00D048024D2;
 Thu, 21 Nov 2019 15:17:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BEEA2101F942;
 Thu, 21 Nov 2019 15:17:15 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 423F61138606; Thu, 21 Nov 2019 16:17:14 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH v4 00/14] block: Try to create well-typed json:{} filenames
References: <20190624173935.25747-1-mreitz@redhat.com>
 <1bfddc02-54db-b0d7-d530-e55e5c372b30@redhat.com>
 <ac11d6b2-f871-0389-dfc2-a286f60853d3@redhat.com>
 <875zjmrg7a.fsf@dusky.pond.sub.org>
Date: Thu, 21 Nov 2019 16:17:14 +0100
In-Reply-To: <875zjmrg7a.fsf@dusky.pond.sub.org> (Markus Armbruster's message
 of "Thu, 14 Nov 2019 09:54:17 +0100")
Message-ID: <8736ehb6o5.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: VcsDVkLZPTKrsBOismsRqg-1
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
Cc: Kevin Wolf <kwolf@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Markus Armbruster <armbru@redhat.com> writes:

> Max Reitz <mreitz@redhat.com> writes:
>
>> On 13.09.19 13:49, Max Reitz wrote:
>>> Another gentle ping.
>>
>> And another.
>
> Conflicts with the refactoring merged in commit 69717d0f890.  Please
> accept my apologies for the inconvenience caused by the excessive delay.
>
> I'll try to review anyway.

I reviewed the proposed changes to the QAPI schema language, and they
look reasonable enough to justify a rebase.

Thanks!


