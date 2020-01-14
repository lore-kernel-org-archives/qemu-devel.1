Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A36C33CB1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 11:12:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E009F206D5
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 11:12:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RhaUqoFG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E009F206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irK7s-0005oC-Jg
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 06:12:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49821)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1irK4A-000187-O3
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 06:08:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1irK46-0001l2-VV
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 06:08:58 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:25372
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1irK46-0001ku-Rr
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 06:08:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579000134;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z/MpjnFQgqN6nzSfUgJEJmsHul7cU1/GPe4ID35gJBM=;
 b=RhaUqoFG9hVzh+yDv5U/5/oTuilubr6fDlNwp2c7X2BJ3THdefFuGGvZS7xQTrQfWCbHlk
 fXxGkw7N7+mg6vu3BTvgUG618RkAGoytHTK88jJ2CT4FP8DsKi/KFKFQrI+hKRWcTzYiOC
 Y/lgcmPFrJdw83M0H6ZT0G7f66+qAbQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-_wnIRf2WPTaq1cqzxlz35g-1; Tue, 14 Jan 2020 06:08:52 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D8C10DB20;
 Tue, 14 Jan 2020 11:08:51 +0000 (UTC)
Received: from redhat.com (unknown [10.36.118.29])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 577551036D02;
 Tue, 14 Jan 2020 11:08:51 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v3 1/2] migration: Fix incorrect integer->float conversion
 caught by clang
In-Reply-To: <874kwygxxt.fsf@dusky.pond.sub.org> (Markus Armbruster's message
 of "Tue, 14 Jan 2020 11:00:14 +0100")
References: <20191122080039.12771-1-armbru@redhat.com>
 <20191122080039.12771-2-armbru@redhat.com> <87zhgoi93z.fsf@trasno.org>
 <87r220qa5p.fsf@dusky.pond.sub.org>
 <874kwygxxt.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Tue, 14 Jan 2020 12:08:49 +0100
Message-ID: <87a76qwb0e.fsf@secure.laptop>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: _wnIRf2WPTaq1cqzxlz35g-1
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
Reply-To: quintela@redhat.com
Cc: Fangrui Song <i@maskray.me>, richard.henderson@linaro.org,
 qemu-devel@nongnu.org, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Markus Armbruster <armbru@redhat.com> wrote:
> Markus Armbruster <armbru@redhat.com> writes:
>
>> Juan Quintela <quintela@redhat.com> writes:
>>
>>> Markus Armbruster <armbru@redhat.com> wrote:
>>>> From: Fangrui Song <i@maskray.me>
>>>>
>>>> Clang does not like qmp_migrate_set_downtime()'s code to clamp double
>>>> @value to 0..INT64_MAX:
>>>>
>>>>     qemu/migration/migration.c:2038:24: error: implicit conversion
>>>> from 'long' to 'double' changes value from 9223372036854775807 to
>>>> 9223372036854775808 [-Werror,-Wimplicit-int-float-conversion]
>>>>
>>>> The warning will be enabled by default in clang 10. It is not
>>>> available for clang <=3D 9.
>>>>
>>>> The clamp is actually useless; @value is checked to be within
>>>> 0..MAX_MIGRATE_DOWNTIME_SECONDS immediately before.  Delete it.
>>>>
>>>> While there, make the conversion from double to int64_t explicit.
>>>>
>>>> Signed-off-by: Fangrui Song <i@maskray.me>
>>>> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>>>> [Patch split, commit message improved]
>>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>>
>>> Reviewed-by: Juan Quintela <quintela@redhat.com>
>>>
>>> Should I get this through migration tree, or are you going to pull it?
>>
>> Plase take this patch through the migration tree.
>
> Ping...

It was on my last pull request (with didn't work due to ...)
And it is on the pull request sent 30 mins ago O:-)

Later, Juan.


