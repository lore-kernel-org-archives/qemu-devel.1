Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE4EC55185
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 15:21:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 589B52074B
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 15:21:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DT4lZSKD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 589B52074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRHC4-00021I-Bs
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 11:21:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34202)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jRH9y-0000C7-I8
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 11:19:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jRH9x-0005IM-8p
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 11:19:33 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:51915
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jRH9w-0005Cj-Op
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 11:19:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587568770;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qx4pw8kBq4tb2J8PGZGMaM3Bf18uCecJJoWmN0tqpt8=;
 b=DT4lZSKDWoSJBQcHObgwsV7aCGBwhzzOVPCHnM8VmpZYC+W4P1FybACBqFJ1wDaS4JE2qG
 oWR3AIwtBcHMDQvtP7GzLfMkMJ1ZDe/TqoZ5NuXi/+ILzDVC1eeiGLG1a7JpmjiBqB4c7e
 oUtKOMEsDHC38ll6g6RQlefEIyGy5ks=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-499-QfQ3MqMWMGSCdjYpyqK9zg-1; Wed, 22 Apr 2020 11:19:23 -0400
X-MC-Unique: QfQ3MqMWMGSCdjYpyqK9zg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 74D4114E3
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2020 15:19:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 42E52600D2;
 Wed, 22 Apr 2020 15:19:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id AF45F11358BC; Wed, 22 Apr 2020 17:19:20 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v2 12/14] tests/test-logging: Fix test for -dfilter
 0..0xffffffffffffffff
References: <20200422130719.28225-1-armbru@redhat.com>
 <20200422130719.28225-13-armbru@redhat.com>
 <8b72369a-482c-a32f-648d-050c22dadf2e@redhat.com>
Date: Wed, 22 Apr 2020 17:19:20 +0200
In-Reply-To: <8b72369a-482c-a32f-648d-050c22dadf2e@redhat.com> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Wed, 22 Apr 2020 15:35:06
 +0200")
Message-ID: <87v9lrv98n.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 02:12:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> Hi Markus,
>
> On 4/22/20 3:07 PM, Markus Armbruster wrote:
>> Fixes: 58e19e6e7914354242a67442d0006f9e31684d1a
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   tests/test-logging.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/tests/test-logging.c b/tests/test-logging.c
>> index 6387e4933f..8580b82420 100644
>> --- a/tests/test-logging.c
>> +++ b/tests/test-logging.c
>> @@ -73,10 +73,10 @@ static void test_parse_range(void)
>>       g_assert(qemu_log_in_addr_range(UINT64_MAX));
>>       g_assert_false(qemu_log_in_addr_range(UINT64_MAX - 1));
>>   -    qemu_set_dfilter_ranges("0..0xffffffffffffffff", &err);
>> +    qemu_set_dfilter_ranges("0..0xffffffffffffffff", &error_abort);
>
> Why sometime use this form, ...
>
>>       g_assert(qemu_log_in_addr_range(0));
>>       g_assert(qemu_log_in_addr_range(UINT64_MAX));
>> -
>> +
>>       qemu_set_dfilter_ranges("2..1", &err);
>>       error_free_or_abort(&err);
>
> ... and then this other form?

The first form crashes when the function sets an error.

The second from crashes when the function doesn't set an error, or else
frees the error.

All clear?


