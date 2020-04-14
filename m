Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB770C2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 08:01:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E73D2072D
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 08:01:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J9SBERxo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E73D2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOGVb-00055n-Kg
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 04:01:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47680)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jOGUQ-0004TC-IX
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 04:00:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jOGUL-0006z6-Ir
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 04:00:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56179
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jOGUL-0006wi-FH
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 04:00:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586851208;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uxUsp4CFGKO8Bikjw1NplmgxnfC4yI9i6yZffu2BPPo=;
 b=J9SBERxoG2cslEev4Rw7uBJXVkokMkceNCr06MiVhlSCSr6UL0evBAhO6TQ9LOS2Wy4022
 o2pY8I0tdSVCoiwx8g/GTFapk8twM607l28s+hKZFGowMIwf8Ed+iYvsdwkHPoFW06AvhV
 Nrqaqq6E83JVkLUl88SIJm5PaMayzyA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-4XbdlED2P1SBex9OhLuLUg-1; Tue, 14 Apr 2020 04:00:07 -0400
X-MC-Unique: 4XbdlED2P1SBex9OhLuLUg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 27BC71007278;
 Tue, 14 Apr 2020 08:00:06 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-20.ams2.redhat.com
 [10.36.113.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A46C3271B2;
 Tue, 14 Apr 2020 08:00:05 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1345411385C8; Tue, 14 Apr 2020 10:00:04 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH] .gitignore: include common build sub-directories
References: <20200413162902.7985-1-alex.bennee@linaro.org>
 <2c489489-f459-f029-029e-74bfbfc70e49@redhat.com>
 <87imi38433.fsf@linaro.org>
 <d97c8034-2a9f-fe26-c70b-49b4d19f800d@redhat.com>
Date: Tue, 14 Apr 2020 10:00:04 +0200
In-Reply-To: <d97c8034-2a9f-fe26-c70b-49b4d19f800d@redhat.com> (Eric Blake's
 message of "Mon, 13 Apr 2020 16:42:53 -0500")
Message-ID: <875ze2zed7.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.120
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
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eric Blake <eblake@redhat.com> writes:

> On 4/13/20 4:32 PM, Alex Benn=C3=A9e wrote:
>>
>> Eric Blake <eblake@redhat.com> writes:
>>
>>> On 4/13/20 11:29 AM, Alex Benn=C3=A9e wrote:
>>>> As out-of-tree builds become more common (or rather building in a
>>>> subdir) we can add a lot of load to "git ls-files" as it hunts down
>>>> sub-directories that are irrelevant to the source tree. This is
>>>> especially annoying if you have a prompt that attempts to summarise
>>>> the current git status on command completion.
>>>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>>> ---
>>>>    .gitignore | 2 ++
>>>>    1 file changed, 2 insertions(+)
>>>> diff --git a/.gitignore b/.gitignore
>>>> index 0c5af83aa74..7757dc08a08 100644
>>>> --- a/.gitignore
>>>> +++ b/.gitignore
>>>> @@ -141,6 +141,8 @@ cscope.*
>>>>    tags
>>>>    TAGS
>>>>    docker-src.*
>>>> +build
>>>> +builds
>>>
>>> Would 'build-*' be worth adding as well?
>>
>> Sure - I'll add it to v2.
>
> Or even consolidate it into a single pattern: build* (which would
> allow 'build', 'builds', 'build1', 'build23', 'build-fedora',
> 'build-bug1234', ...)

The looser the pattern, the higher the risk of unwanted matches.

Would be less of an issue if we had a cleaner source root directory.


