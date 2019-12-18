Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7CFDC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 10:59:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D0E82176D
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 10:59:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E1n1WVS+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D0E82176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihX3L-00030l-Ek
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 05:59:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42842)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1ihX2h-0002bc-UK
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 05:59:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1ihX2c-0000UB-Nn
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 05:58:58 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:51429
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ihX2c-0000MX-I9
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 05:58:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576666733;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AHt/UUwaYaRT3otXQdV9pPDDr0xMOR1B/Xz0G8NLCxg=;
 b=E1n1WVS+eczG8SEDRX2xeSvqcXWH5GfyjVWXE1O4O25oh5W9DDl9lcZInetG79lVn9bU5y
 U9lcgaARjiHLQY0EHbaLcrxNXW/+CohwDnPYyAoTbofjuZE5gwDb9Rxr4tq0HvQzq+lQsK
 l4NL/TutRmMYOnjjwaBs/3kOuO3EUp4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-117-mX8FA7XuPbWCgX-d2Lg_mQ-1; Wed, 18 Dec 2019 05:58:50 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 75AB21183E0F
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 10:58:49 +0000 (UTC)
Received: from redhat.com (ovpn-117-244.ams2.redhat.com [10.36.117.244])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EB1A15C28D;
 Wed, 18 Dec 2019 10:58:48 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v2 01/10] migration-test: Create cmd_soure and cmd_target
In-Reply-To: <bd9939c4-9eff-9028-03bd-93e14f3defcd@redhat.com> (Thomas Huth's
 message of "Wed, 18 Dec 2019 11:40:24 +0100")
References: <20191218015520.2881-1-quintela@redhat.com>
 <20191218015520.2881-2-quintela@redhat.com>
 <bd9939c4-9eff-9028-03bd-93e14f3defcd@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Wed, 18 Dec 2019 11:58:47 +0100
Message-ID: <87pngl6gt4.fsf@trasno.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: mX8FA7XuPbWCgX-d2Lg_mQ-1
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thomas Huth <thuth@redhat.com> wrote:
> On 18/12/2019 02.55, Juan Quintela wrote:
>> We are repeating almost everything for each machine while creating the
>> command line for migration.  And once for source and another for
>> destination.  We start putting there opts_src and opts_dst.
>>=20
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>  tests/migration-test.c | 44 ++++++++++++++++++++++++------------------
>>  1 file changed, 25 insertions(+), 19 deletions(-)
>>=20
>> diff --git a/tests/migration-test.c b/tests/migration-test.c
>> index a5343fdc66..fbddcf2317 100644
>> --- a/tests/migration-test.c
>> +++ b/tests/migration-test.c
>> @@ -557,6 +557,7 @@ static int test_migrate_start(QTestState **from, QTe=
stState **to,
>>                                 const char *opts_dst)
>>  {
>>      gchar *cmd_src, *cmd_dst;
>> +    gchar *cmd_source, *cmd_target;
>
> The naming looks quite unfortunate to me ... "cmd_src" can easily be
> mixed up with "cmd_source" ... but maybe you could do it without these
> additional variables (see below) ...

[...]

> May I suggest to qtest_initf() here instead:
>
>   *from =3D qtest_initf("%s %s", cmd_src, opts_src);
>
>   *to =3D qtest_initf("%s %s", cmd_dst, opts_dst);
>
>
> And maybe you could even move the extra_opts here, too? e.g.:
>
>   *from =3D qtest_initf("%s %s %s", cmd_src, extra_opts ?: "", opts_src);
>
>   *to =3D qtest_initf("%s %s %s", cmd_dst,  extra_opts ?: "", opts_dst);
>
>  Thomas

I do that on later patches.  But the _final_ better name that I could
get with was "cmd_source".  cmd_src ends being arch_source.

About using qtest_initf():

- I didn't knew it's existence (O:-)
- I was considering about merning the command parts of cmd_source/target
  But arrived to the conclusion that it was more complicated to have it
  share it, that to repeat it.  But you need to look at the last patch
  to arrive to one conclusion.

Thanks, Juan.


