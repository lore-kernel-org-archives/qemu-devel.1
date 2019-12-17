Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BDC1C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 15:12:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAA872146E
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 15:12:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cehVoMaK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAA872146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihEWb-0006hx-3L
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 10:12:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43102)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1ihEVj-0006Eg-An
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 10:11:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1ihEVi-0004x4-8r
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 10:11:43 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:35462
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ihEVi-0004wu-5A
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 10:11:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576595501;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=35u70OWtsp0slotQFnDlNrNjJADUe5iAIgUvN/eINno=;
 b=cehVoMaKiF42wcRMP7uZsiqDR2x0x0nHM3TKA1qXXhnQJV88abBua2vQrH6MN9lDe3QPwd
 35siUd/X34I4KLLuZ9DlNjDxs07qzo4uMesHkHyRan36wG0yrN5vlWf1DNoCexrq9RGF5O
 SCzoRIPDyosd0tsUEC3AKM128jcmQRk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-crd-nmU6Pwmek63_wMc1RA-1; Tue, 17 Dec 2019 10:11:39 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E0F5F8017DF;
 Tue, 17 Dec 2019 15:11:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-42.ams2.redhat.com
 [10.36.116.42])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AEB4D51;
 Tue, 17 Dec 2019 15:11:38 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 41D4811386A7; Tue, 17 Dec 2019 16:11:37 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH RFC] qapi: Allow getting flat output from
 'query-named-block-nodes'
References: <42dae98e1f6a9f444f48a20192f45195337824f0.1576246045.git.pkrempa@redhat.com>
 <836c1a18-b67d-0426-2137-8f464e4e5c9b@redhat.com>
 <87lfrbjtdu.fsf@dusky.pond.sub.org>
 <fa269c43-f966-54a7-6589-46f28138ea15@redhat.com>
Date: Tue, 17 Dec 2019 16:11:37 +0100
In-Reply-To: <fa269c43-f966-54a7-6589-46f28138ea15@redhat.com> (Eric Blake's
 message of "Tue, 17 Dec 2019 07:15:41 -0600")
Message-ID: <87k16vaswm.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: crd-nmU6Pwmek63_wMc1RA-1
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eric Blake <eblake@redhat.com> writes:

> On 12/17/19 1:36 AM, Markus Armbruster wrote:
>
>> Un-snipping the QAPI schema change:
>
> Sorry about that...
>
>>
>>>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>>>> index 0cf68fea14..bd651106bd 100644
>>>> --- a/qapi/block-core.json
>>>> +++ b/qapi/block-core.json
>>>> @@ -1752,6 +1752,8 @@
>>>>   #
>>>>   # Get the named block driver list
>>>>   #
>>>> +# @flat: don't recurse into backing images if true. Default is false =
(Since 5.0)
>>>> +#
>>>>   # Returns: the list of BlockDeviceInfo
>>>>   #
>>>>   # Since: 2.0
>>
>> What does it mean not to recurse?  Sounds like flat: false asks for a
>> subset of the full set.  How exactly is the subset defined?
>
> Bike-shedding:
>
> Would it be easier to explain as:
>
> @recurse: If true, include child information in each node (note that
> this can result in redundant output). Default is true (since 5.0)
>
> and then pass false when you don't want recursion, with it being more
> obvious that using the new flag results in more compact output with no
> loss of information.

Adds a bit of information, namely that the information suppressed by
recurse: false is actually redundant.

The command's doc comment is weak: it doesn't really specify what
exactly is returned.  Simply omitting redundant information always
should still conform to this weak spec.  Of course, what really counts
isn't spec conformance, but meeting client expectations.  I don't even
understand what exactly gets returned, let alone how clients use it.

The doc comment needs to be judged by someone with actual knowledge in
this area.


