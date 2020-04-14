Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9921BC2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 10:04:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E23A2072D
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 10:04:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AlPi3Kxk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E23A2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOIR8-0004lo-Js
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 06:04:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34714)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jOIQN-0003vu-Ql
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 06:04:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jOIQM-0001aC-8G
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 06:04:11 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:43630
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jOIQM-0001Zi-2G
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 06:04:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586858649;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K3/9PAsRVLGzUvdFOhxXxSRuwc/IHBzXF6b6U4JVseM=;
 b=AlPi3KxkdeiEmAQPP17m7KUz2yXHsEpXuklp6eN9kpheNk2eg68/pRozBCgCJyPKsLqzMh
 TtjeI6Oac7YY+9sdhYcRd74OCy17S+Dfx7v35fvhmgusc81fIcCC2Jca4tj06oexlx8ASB
 YaWjposQkztaPV3UokTkhuP31PVW1bc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-442-ULNyNPOMM9eTciiXVMKHSw-1; Tue, 14 Apr 2020 06:04:06 -0400
X-MC-Unique: ULNyNPOMM9eTciiXVMKHSw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EF35D18B9FC1;
 Tue, 14 Apr 2020 10:04:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-20.ams2.redhat.com
 [10.36.113.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BA51B5C1B0;
 Tue, 14 Apr 2020 10:04:05 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3C7A611385C8; Tue, 14 Apr 2020 12:04:04 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH for-5.1 4/8] qemu-option: Avoid has_help_option() in
 qemu_opts_parse_noisily()
References: <20200409153041.17576-1-armbru@redhat.com>
 <20200409153041.17576-5-armbru@redhat.com>
 <4f38f94d-5c7a-c00f-c7dc-8bc28de4fd39@redhat.com>
Date: Tue, 14 Apr 2020 12:04:04 +0200
In-Reply-To: <4f38f94d-5c7a-c00f-c7dc-8bc28de4fd39@redhat.com> (Eric Blake's
 message of "Thu, 9 Apr 2020 13:07:31 -0500")
Message-ID: <871roqwfhn.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eric Blake <eblake@redhat.com> writes:

> On 4/9/20 10:30 AM, Markus Armbruster wrote:
>> When opts_parse() sets @invalidp to true, qemu_opts_parse_noisily()
>> uses has_help_option() to decide whether to print help.  This parses
>> the input string a second time, in a slightly different way.
>>
>> Easy to avoid: replace @invalidp by @help_wanted.
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   util/qemu-option.c | 20 ++++++++++----------
>>   1 file changed, 10 insertions(+), 10 deletions(-)
>>
>
>> -    opts =3D opts_parse(list, params, permit_abbrev, false, &invalidp, =
&err);
>> +    opts =3D opts_parse(list, params, permit_abbrev, false, &help_wante=
d, &err);
>>       if (err) {
>> -        if (invalidp && has_help_option(params)) {
>> +        if (help_wanted) {
>
> Yep, that is cleaner.  Should there be testsuite coverage changing as
> a result of this?

Hmm.  I guess the actual question is whether this patch changes
behavior.

@invalidp gets set to true when opt_set() runs into an unknown @name.

Aside: can't happend when opts_accepts_any(); such options can't rely on
qemu_opts_parse_noisily() providing help.

One reason for unknown @name is the user asking for help.  We want to
provide it then.  To find out, we use has_help_option(), which parses
certain corner cases differently.  PATCH 1 demonstrates it can return
false incorrectly for certain corner cases.  This patch fixes
qemu_opts_parse_noisily() to provide help as it should even for these
corner cases.

What about this:

* I put PATCH 5 "qemu-option: Fix has_help_option()'s sloppy parsing"
  before this one, so that this one doesn't change behavior.

* I adjust this one's commit message accordingly: scratch ", in a
  slightly different way".

Do we care enough to further document the bug fix in PATCH 5's commit
message?  Even find an actual CLI option that reproduces the bug?  I
doubt it.  This is all about silly corner cases involving ','.

Perhaps has_help_option() can also return true incorrectly.  I doubt we
care.

> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!


