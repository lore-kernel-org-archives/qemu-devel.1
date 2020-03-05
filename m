Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A23C3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 05:43:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E8DF208C3
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 05:43:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LBg8zxOZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E8DF208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9jHk-0003Bb-P3
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 00:43:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52859)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j9jH0-0002ke-5m
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 00:42:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j9jGy-0000CJ-Qu
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 00:42:17 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:20371
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j9jGy-0000B6-FZ
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 00:42:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583386934;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cNlNie8KDLU15dF15Psv3u8PsrTjRvu2FZAQs+n8xAw=;
 b=LBg8zxOZRb7cx96ZfdVxIP+haRNhZ+PFiUb44CxETjOhJq9i0XOvmr2PaxTTgyq7p4rSsB
 jNX08ama87+PHKGqFwRS1JgPXYHl5Y3AhuecqudHP6qR8tyteI+QMXxguCC1h0vn5t+jkx
 BzrsNg9ULtqxzt1E9TKshaerZTQS0OE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-SGlDoSRcOTa07EcHMnaxLw-1; Thu, 05 Mar 2020 00:42:13 -0500
X-MC-Unique: SGlDoSRcOTa07EcHMnaxLw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2617B800D50;
 Thu,  5 Mar 2020 05:42:12 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-129.ams2.redhat.com
 [10.36.116.129])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CF3768B777;
 Thu,  5 Mar 2020 05:42:11 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5B20511386A6; Thu,  5 Mar 2020 06:42:10 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH 4/4] qapi: Brush off some (py)lint
References: <20200227144531.24309-1-armbru@redhat.com>
 <20200227144531.24309-5-armbru@redhat.com>
 <6b7e0d73-6840-3a6a-9d33-0adcec0d4c84@redhat.com>
 <87y2sgpmz7.fsf@dusky.pond.sub.org>
 <d2ac72a0-cfc4-c258-623a-6cc0a03e0c1f@redhat.com>
Date: Thu, 05 Mar 2020 06:42:10 +0100
In-Reply-To: <d2ac72a0-cfc4-c258-623a-6cc0a03e0c1f@redhat.com> (John Snow's
 message of "Wed, 4 Mar 2020 14:27:20 -0500")
Message-ID: <87mu8v1hot.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: mdroth@linux.vnet.ibm.com, qemu-devel@nongnu.org, ehabkost@redhat.com,
 crosa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

John Snow <jsnow@redhat.com> writes:

> On 3/4/20 3:01 AM, Markus Armbruster wrote:
>> John Snow <jsnow@redhat.com> writes:
>>=20
>>> On 2/27/20 9:45 AM, Markus Armbruster wrote:
>>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>>
>>> I wrote some pylint cleanup for iotests recently, too. Are you targetin=
g
>>> a subset of pylint errors to clean here?
>>>
>>> (Do any files pass 100%?)
>>=20
>> Surely you're joking, Mr. Snow!
>>=20
>> I'm chipping away at pylint's gripes.  I ran it with the following
>> messages disabled:
>>=20
>>     bad-whitespace,
>>     fixme,
>>     invalid-name,
>>     missing-docstring,
>>     too-few-public-methods,
>>     too-many-arguments,
>>     too-many-branches,
>>     too-many-instance-attributes,
>>     too-many-lines,
>>     too-many-locals,
>>     too-many-statements,
>>     unused-argument,
>>     unused-wildcard-import,
>>=20
>> These are not all obviously useless.  They're just not what I want to
>> focus on right now.
>>=20
>
> Yes, understood - so my approach is disable what I don't intend to fix,
> commit the pylintrc to prevent backslide, and move on.
>
> I think we have a difference in what a pylintrc means to us (the goal
> vs. the current status.)
>
> I didn't mean "100% without caveats", just "100% in some subset of checks=
".
>
> (I assume the answer is still no.)

To turn the answer into a yes, I'd have to disable the messages below,
and some of them I'd rather keep.

Tacking

    # pylint: disable=3D...

to existing troublemakers may or may not be worth the ugliness (it needs
to go on the same line, which almost invariably makes it awkwardly long).

>> Remaining:
>>=20
>> 1 x C0330: Wrong continued indentation (remove 19 spaces).
>>=20
>>     Accident, will fix in v2.
>>=20
>> 8 x R0201: Method could be a function (no-self-use)
>>=20
>>     Yes, but the override in a sub-class does use self.
>>=20
>> 2 x W0212: Access to a protected member _body of a client class (protect=
ed-access)
>>=20
>>     Needs cleanup, but not now.
>>=20
>> 6 x W0401: Wildcard import qapi.common (wildcard-import)
>>=20
>>     Not sure I care.  I'd prefer not to have more wildcard imports,
>>     though.
>>=20
>> 2 x W0603: Using the global statement (global-statement)
>>=20
>>     Cleanup is non-trivial.  Not now.
>>=20
>> I also ran pycodestyle-3:
>>=20
>> 1 x E127 continuation line over-indented for visual indent
>>=20
>>     Same as pylint's C0330, will fix in v2.
>>=20
>> 3 x E261 at least two spaces before inline comment
>>=20
>>     I blame Emacs.  Left for another day.
>>=20
>> 8 x E501 line too long
>>=20
>>     Left for another day.
>>=20
>> 1 x E713 test for membership should be 'not in'
>>=20
>>     I missed that one, will fix in v2.
>>=20
>>> Consider checking in a pylintrc file that lets others run the same
>>> subset of pylint tests as you are doing so that we can prevent future
>>> regressions.
>>=20
>> Working towards it, slowly.
>>=20
>>> Take a peek at [PATCH v6 0/9] iotests: use python logging=E2=80=8B
>>>
>>> Thanks for this series. I had a very similar series sitting waiting to
>>> go out, but this goes further in a few places.
>>=20
>> Thanks!
>>=20


