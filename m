Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A316C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 07:32:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0315621582
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 07:32:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QG5fGOuE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0315621582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihTp8-0007zO-6v
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 02:32:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43164)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1ihToU-0007Yk-Ku
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 02:32:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1ihToR-0006i5-OH
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 02:32:04 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:53952
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ihToR-0006ez-4x
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 02:32:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576654322;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rt6HwfmU9QHeug5F9fgGniACWg6h+Nc6+M1SSGuMRJw=;
 b=QG5fGOuEeB4vVug208pCpqa1iuFm3ljttZDT+3qQuWt5ltBhQtH5JXSibk0cKo8d4XCIt4
 l+lRaxB58afI21sVAeXA/1FiL77YzxwY23LB0A4Jqd3QPj1RKZvCQ46rC0INCjMe2G0PrP
 X6OAvm4VvzvWnkpZiBMIPbIbrogRMC0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-14-QpA4QzVJMQWVZ3tYjetIjA-1; Wed, 18 Dec 2019 02:32:00 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7280C1005502;
 Wed, 18 Dec 2019 07:31:59 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-42.ams2.redhat.com
 [10.36.116.42])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 193957D8FC;
 Wed, 18 Dec 2019 07:31:59 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A13ED11386A7; Wed, 18 Dec 2019 08:31:57 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PULL 34/34] nbd: assert that Error** is not NULL in
 nbd_iter_channel_error
References: <20191217062651.9687-1-armbru@redhat.com>
 <20191217062651.9687-35-armbru@redhat.com>
 <4135813b-af52-b743-858c-a86dbd3ebce3@redhat.com>
Date: Wed, 18 Dec 2019 08:31:57 +0100
In-Reply-To: <4135813b-af52-b743-858c-a86dbd3ebce3@redhat.com> (Eric Blake's
 message of "Tue, 17 Dec 2019 07:09:18 -0600")
Message-ID: <87imme84ya.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: QpA4QzVJMQWVZ3tYjetIjA-1
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eric Blake <eblake@redhat.com> writes:

> On 12/17/19 12:26 AM, Markus Armbruster wrote:
>> From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>
>> All callers of nbd_iter_channel_error() pass the address of a
>> local_err variable, and only call this function if an error has
>> already occurred, using this function to propagate that error.
>> This is already implied by its name (local_err instead of the classic
>> errp), but it is worth additionally stressing this by adding an
>> assertion to make it part of the function contract.
>>
>> The local_err parameter is not here to return information about
>> nbd_iter_channel_error failure. Instead it's assumed to be filled when
>> passed to the function. This is already stressed by its name
>> (local_err, instead of classic errp). Stress it additionally by
>> assertion.
>
> Redundant paragraph, but probably too late to worry about it now that
> we have a pull request.

I'll have to respin anyway.  I'll drop the second paragraph.


