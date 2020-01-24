Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACFE5C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 11:09:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78978214AF
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 11:09:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xdsr8IFq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78978214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuwq2-0002NM-NP
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 06:09:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58972)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1iuwpH-0001Zm-8O
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 06:08:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1iuwpF-0005fP-LF
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 06:08:34 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:54698
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1iuwpF-0005dw-0F
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 06:08:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579864112;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1r/ewa/+zbJ9ZNGJoCfFWBTEQSjvSMePjpalvv8JQ9I=;
 b=Xdsr8IFqtgg48OD7zcraNKsgLk9RVe2se9Eybkur+BhX+FeANTo4eCZjNkx1HmJDo9ySqt
 PJ/1HI0KscYCmvLPuOUcFeKDBxZlpoB4UsfXtKsmr4AaewvKRDgyetviFfgTTkdkga8Awv
 xkrEPpj3ziylWuQcDhCJ9dftq67V27I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-HZGmObWlNHmm1SVzf6gEMg-1; Fri, 24 Jan 2020 06:08:30 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 770658010CA
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 11:08:29 +0000 (UTC)
Received: from redhat.com (unknown [10.36.118.61])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E1399620D8;
 Fri, 24 Jan 2020 11:08:28 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH v3 01/21] migration-test: Use g_free() instead of free()
In-Reply-To: <20200124103907.GC824327@redhat.com> ("Daniel P. =?utf-8?Q?Be?=
 =?utf-8?Q?rrang=C3=A9=22's?=
 message of "Fri, 24 Jan 2020 10:39:07 +0000")
References: <20200123115831.36842-1-quintela@redhat.com>
 <20200123115831.36842-2-quintela@redhat.com>
 <20200124103907.GC824327@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Fri, 24 Jan 2020 12:08:26 +0100
Message-ID: <87v9p13ydx.fsf@secure.laptop>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: HZGmObWlNHmm1SVzf6gEMg-1
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
Reply-To: quintela@redhat.com
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
> On Thu, Jan 23, 2020 at 12:58:11PM +0100, Juan Quintela wrote:
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>  tests/qtest/migration-test.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
>> index 26e2e77289..b6a74a05ce 100644
>> --- a/tests/qtest/migration-test.c
>> +++ b/tests/qtest/migration-test.c
>> @@ -1291,7 +1291,7 @@ static void test_multifd_tcp(void)
>>      wait_for_serial("dest_serial");
>>      wait_for_migration_complete(from);
>>      test_migrate_end(from, to, true);
>> -    free(uri);
>> +    g_free(uri);
>
> Not an objection to this patch, just a general FYI.
>
> Our min glib guarantees that g_malloc/g_free are always using the
> system allocator. So using free() is not a correctness problem
> these days.

Ok.  But the rest of the file uses g_malloc/g_free and friends O:-)

> In general I'd suggest eliminating both free() and g_free(), and instead
> annotating the variable decl for automatic free. eg
>
>   g_autofree char *uri =3D NULL;

I will investigate this, thanks.

Later, Juan.


