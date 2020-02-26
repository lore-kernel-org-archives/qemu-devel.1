Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B521C4BA0B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 07:44:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A51821D7E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 07:44:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gZd3P3xL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A51821D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6rNG-0001Fo-94
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 02:44:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47516)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j6rJv-0004Mb-SL
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 02:41:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j6rJt-0006c1-Qw
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 02:41:27 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:22738
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j6rJt-0006aY-NA
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 02:41:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582702884;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dYF7a8JyzBtDdYVvRKL3K9l8bplyJoGv9xj+cwhwRXA=;
 b=gZd3P3xL89ED4hPYDYk2L7i/1nap3tujd5V86FPf7kzQRiBORS5gXq9Cd52DfpETcOXGBo
 gd3uoDgbExhyykMqE6ki1rMuGqybIsJjJZf2DGwlZGtqDrv9ZzaCUJZWgVsQ5eqqP1V/tZ
 vDlbbN+nLCramejU+aa0fuXKuYnqMxY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-186-INC8K_4kN4GPctZJEukaQw-1; Wed, 26 Feb 2020 02:41:16 -0500
X-MC-Unique: INC8K_4kN4GPctZJEukaQw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3ACEE100726F;
 Wed, 26 Feb 2020 07:41:15 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-129.ams2.redhat.com
 [10.36.116.129])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8A7711CB;
 Wed, 26 Feb 2020 07:41:09 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1090811386A6; Wed, 26 Feb 2020 08:41:08 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v7 03/11] scripts: add coccinelle script to use auto
 propagated errp
References: <20200131130118.1716-1-vsementsov@virtuozzo.com>
 <20200131130118.1716-4-vsementsov@virtuozzo.com>
 <87v9nxwulz.fsf@dusky.pond.sub.org>
 <cff01a02-f99a-574d-c750-200da0c1d925@virtuozzo.com>
 <87wo8aesn0.fsf@dusky.pond.sub.org>
 <b53674e2-2484-4f18-fc3f-f2a2a3d6168b@virtuozzo.com>
Date: Wed, 26 Feb 2020 08:41:08 +0100
In-Reply-To: <b53674e2-2484-4f18-fc3f-f2a2a3d6168b@virtuozzo.com> (Vladimir
 Sementsov-Ogievskiy's message of "Tue, 25 Feb 2020 18:22:50 +0300")
Message-ID: <87a755aj8r.fsf@dusky.pond.sub.org>
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>,
 qemu-block@nongnu.org, Paul Durrant <paul@xen.org>, qemu-devel@nongnu.org,
 Laszlo Ersek <lersek@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Greg Kurz <groug@kaod.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Max Reitz <mreitz@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:

> 25.02.2020 15:52, Markus Armbruster wrote:
>> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
>>
>>> 23.02.2020 11:55, Markus Armbruster wrote:
>>>> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
>>>>
>>>>> Script adds ERRP_AUTO_PROPAGATE macro invocation where appropriate an=
d
>>>>> does corresponding changes in code (look for details in
>>>>> include/qapi/error.h)
>>>>>
>>>>> Usage example:
>>>>> spatch --sp-file scripts/coccinelle/auto-propagated-errp.cocci \
>>>>>    --macro-file scripts/cocci-macro-file.h --in-place --no-show-diff =
\
>>>>>    blockdev-nbd.c qemu-nbd.c {block/nbd*,nbd/*,include/block/nbd*}.[h=
c]
>>>>>
>>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com=
>
>>>>> ---
>>>>>
>>>>> CC: Eric Blake <eblake@redhat.com>
>>>>> CC: Kevin Wolf <kwolf@redhat.com>
>>>>> CC: Max Reitz <mreitz@redhat.com>
>>>>> CC: Greg Kurz <groug@kaod.org>
>>>>> CC: Stefano Stabellini <sstabellini@kernel.org>
>>>>> CC: Anthony Perard <anthony.perard@citrix.com>
>>>>> CC: Paul Durrant <paul@xen.org>
>>>>> CC: Stefan Hajnoczi <stefanha@redhat.com>
>>>>> CC: "Philippe Mathieu-Daud=C3=A9" <philmd@redhat.com>
>>>>> CC: Laszlo Ersek <lersek@redhat.com>
>>>>> CC: Gerd Hoffmann <kraxel@redhat.com>
>>>>> CC: Stefan Berger <stefanb@linux.ibm.com>
>>>>> CC: Markus Armbruster <armbru@redhat.com>
>>>>> CC: Michael Roth <mdroth@linux.vnet.ibm.com>
>>>>> CC: qemu-block@nongnu.org
>>>>> CC: xen-devel@lists.xenproject.org
>>>>>
>>>>>    include/qapi/error.h                          |   3 +
>>>>>    scripts/coccinelle/auto-propagated-errp.cocci | 158 ++++++++++++++=
++++
>>>>>    2 files changed, 161 insertions(+)
>>>>>    create mode 100644 scripts/coccinelle/auto-propagated-errp.cocci
>>>>>
>>>>> diff --git a/include/qapi/error.h b/include/qapi/error.h
>>>>> index b9452d4806..79f8e95214 100644
>>>>> --- a/include/qapi/error.h
>>>>> +++ b/include/qapi/error.h
>>>>> @@ -141,6 +141,9 @@
>>>>>     *         ...
>>>>>     *     }
>>>>>     *
>>>>> + * For mass conversion use script
>>>>> + *   scripts/coccinelle/auto-propagated-errp.cocci
>>>>> + *
>>>>>     *
>>>>>     * Receive and accumulate multiple errors (first one wins):
>>>>>     *     Error *err =3D NULL, *local_err =3D NULL;
>>>>
>>>> Extra blank line.
>>>>
>>>>> diff --git a/scripts/coccinelle/auto-propagated-errp.cocci b/scripts/=
coccinelle/auto-propagated-errp.cocci
>>>>> new file mode 100644
>>>>> index 0000000000..fb03c871cb
>>>>> --- /dev/null
>>>>> +++ b/scripts/coccinelle/auto-propagated-errp.cocci
>>>>> @@ -0,0 +1,158 @@
>>>>> +// Use ERRP_AUTO_PROPAGATE (see include/qapi/error.h)
>>>>> +//
>>>>> +// Copyright (c) 2020 Virtuozzo International GmbH.
>>>>> +//
>>>>> +// This program is free software; you can redistribute it and/or mod=
ify
>>>>> +// it under the terms of the GNU General Public License as published=
 by
>>>>> +// the Free Software Foundation; either version 2 of the License, or
>>>>> +// (at your option) any later version.
>>>>> +//
>>>>> +// This program is distributed in the hope that it will be useful,
>>>>> +// but WITHOUT ANY WARRANTY; without even the implied warranty of
>>>>> +// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>>>> +// GNU General Public License for more details.
>>>>> +//
>>>>> +// You should have received a copy of the GNU General Public License
>>>>> +// along with this program.  If not, see <http://www.gnu.org/license=
s/>.
>>>>> +//
>>>>> +// Usage example:
>>>>> +// spatch --sp-file scripts/coccinelle/auto-propagated-errp.cocci \
>>>>> +//  --macro-file scripts/cocci-macro-file.h --in-place --no-show-dif=
f \
>>>>> +//  blockdev-nbd.c qemu-nbd.c {block/nbd*,nbd/*,include/block/nbd*}.=
[hc]
>>>>> +
>>>>> +@rule0@
>>>>> +// Add invocation to errp-functions where necessary
>>>>> +// We should skip functions with "Error *const *errp"
>>>>> +// parameter, but how to do it with coccinelle?
>>>>> +// I don't know, so, I skip them by function name regex.
>>>>> +// It's safe: if we did not skip some functions with
>>>>> +// "Error *const *errp", ERRP_AUTO_PROPAGATE invocation
>>>>> +// will fail to compile, because of const violation.
>>>>
>>>> Not skipping a function we should skip fails to compile.
>>>>
>>>> What about skipping a function we should not skip?
>>>
>>> Then it will not be updated.. Not good but I don't have better solution=
.
>>> Still, I hope, function called *error_append_*_hint will not return err=
or
>>> through errp pointer.
>>
>> Seems likely.  I just dislike inferring behavior from name patterns.
>>
>> Ideally, we recognize the true exceptional pattern instead, i.e. the
>> presence of const.  But figuring out how to make Coccinelle do that for
>> us may be more trouble than it's worth.
>>
>> Hmm...  Coccinelle matches the parameter even with const due to what it
>> calls "isomorphism".  Can I disable it?  *Tinker* *tinker*
>>
>> diff --git a/scripts/coccinelle/auto-propagated-errp.cocci b/scripts/coc=
cinelle/auto-propagated-errp.cocci
>> index fb03c871cb..0c4414bff3 100644
>> --- a/scripts/coccinelle/auto-propagated-errp.cocci
>> +++ b/scripts/coccinelle/auto-propagated-errp.cocci
>> @@ -20,15 +20,11 @@
>>   //  --macro-file scripts/cocci-macro-file.h --in-place --no-show-diff =
\
>>   //  blockdev-nbd.c qemu-nbd.c {block/nbd*,nbd/*,include/block/nbd*}.[h=
c]
>>   -@rule0@
>> +@rule0 disable optional_qualifier@
>>   // Add invocation to errp-functions where necessary
>> -// We should skip functions with "Error *const *errp"
>> -// parameter, but how to do it with coccinelle?
>> -// I don't know, so, I skip them by function name regex.
>> -// It's safe: if we did not skip some functions with
>> -// "Error *const *errp", ERRP_AUTO_PROPAGATE invocation
>> -// will fail to compile, because of const violation.
>> -identifier fn !~ "error_append_.*_hint";
>> +// Disable optional_qualifier to skip functions with "Error *const *err=
p"
>> +// parameter,
>> +identifier fn;
>>   identifier local_err, ERRP;
>>   @@
>>
>> Could you verify this results in the same tree-wide change as your
>> version?
>
> Yes, no difference. Thanks!

Excellent!

[...]
>> Let's see whether I got it:
>>
>> * The first rule (rule0) adds ERRP_AUTO_PROPAGATE() to all functions
>>    that take an Error ** parameter, and either pass it error_prepend() o=
r
>>    error_append_hint(), or use local_err, and don't have
>>    ERRP_AUTO_PROPAGATE() already, except it skips the ones named
>>    error_append_FOO_hint().  Uff.
>>
>>    The "use local_err" part is an approximation of "use local_err +
>>    error_propagate()".
>>
>>    The "except for the ones named error_append_FOO_hint()" part is an
>>    approximation of "except for the ones taking an Error *const *
>>    parameter".
>>
>>    ERRP_AUTO_PROPAGATE() requires the Error ** parameter to be named
>>    @errp, which need not be the case.  The next rule fixes it up:
>>
>> * The second rule ensures the parameter is named @errp wherever the
>>    first rule applied, renaming if necessary.
>>
>>    Correct?
>>
>>    Incorrect transformation followed by fixup is not ideal, because it
>>    can trip up reviewers.  But ideal is too expensive; this is good
>>    enough.
>>
>> * The third rule (rule1) ensures functions that take an Error **errp
>>    parameter don't declare local_err, except it skips the ones named
>>    error_append_FOO_hint().
>>
>>    In isolation, this rule makes no sense.  To make sense of it, we need
>>    context:
>>
>>    * Subsequent rules remove all uses of @errp from any function where
>
> of local_err
>
>>      rule1 matches.
>>
>>    * Preceding rules ensure any function where rule1 matches has
>>      ERRP_AUTO_PROPAGATE().
>>
>>    Correct?
>
> Oh, yes, everything is correct.

Thank you!

>>
>>    The need for this much context is hard on reviewers.  Good enough for
>>    transforming the tree now, but I'd hate having to make sense of this
>>    again in six months.
>
> Ohh, yes. Far from good design. I can try to reorder chunks a bit.

Please don't spend too much effort on it.  The script is primarily for
helping us convert the whole tree within a short time span.  We may also
use it later to convert instances of the old pattern that have crept
back.  We hopefully won't have to change the script then.  Readability
is not as important as it is for code we expect to be read again and
again over a long time.

[...]


