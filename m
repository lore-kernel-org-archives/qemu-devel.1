Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A725EC33C9E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 09:12:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E87820702
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 09:12:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MW74ljRO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E87820702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ix5sL-0005uc-LM
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 04:12:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43347)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1ix5rp-0005T8-9j
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 04:12:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1ix5rn-0008Od-OX
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 04:12:04 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42180
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ix5rn-0008OR-LK
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 04:12:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580375522;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R9mnBHTjiA3/Yk2ewKXfxOuz7mEQj6weD9mLyvxc8/k=;
 b=MW74ljROfcrbQSdIaCK73BeWjBGiVEIrCofxBULWwvvfJzcpTVZzZQnsNJHX+k0twHPwr2
 DuXToN93rCIOF3RY7iBmh357ULqm35eMyvNGqLWpAoC/Jxey25UGGcGMvlF1hglvtEWPp8
 96Q00P1fWsDMweWIcoEFavnf0ADxWZ4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-XeOyEu1APWaZFqpCh6zubQ-1; Thu, 30 Jan 2020 04:11:56 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 03CFB107ACC4
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 09:11:56 +0000 (UTC)
Received: from redhat.com (unknown [10.36.118.31])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6B18C10018FF;
 Thu, 30 Jan 2020 09:11:55 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v5 1/8] multifd: Add multifd-method parameter
In-Reply-To: <87lfppxtum.fsf@dusky.pond.sub.org> (Markus Armbruster's message
 of "Thu, 30 Jan 2020 08:54:09 +0100")
References: <20200129115655.10414-1-quintela@redhat.com>
 <20200129115655.10414-2-quintela@redhat.com>
 <87lfppxtum.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Thu, 30 Jan 2020 10:11:52 +0100
Message-ID: <87wo99xq93.fsf@secure.laptop>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: XeOyEu1APWaZFqpCh6zubQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Reply-To: quintela@redhat.com
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, "Dr. David
 Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Markus Armbruster <armbru@redhat.com> wrote:
> Juan Quintela <quintela@redhat.com> writes:
>
>> This will store the compression method to use.  We start with none.
>>
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>
> I don't remember giving my R-by.  I gave my Acked-by for
> [PATCH v2 06/10] migration: Add multifd-compress parameter
> Message-ID: <87d0cku5hq.fsf@dusky.pond.sub.org>
> https://lists.nongnu.org/archive/html/qemu-devel/2019-12/msg04153.html

> If I did give my R-by for a later revision, let me know.

Hi

Ouch, I *thought* that you got confused.  It happens to me all the time.
Apologies.
So, how I should I put that Acked-by: in the commit?



> One small suggestion below.

Thanks.

>> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> [...]
>> diff --git a/qapi/migration.json b/qapi/migration.json
>> index b7348d0c8b..96a126751c 100644
>> --- a/qapi/migration.json
>> +++ b/qapi/migration.json
>> @@ -488,6 +488,19 @@
>>  ##
>>  { 'command': 'query-migrate-capabilities', 'returns':
>> ['MigrationCapabilityStatus']}
>> =20
>> +##
>> +# @MultiFDMethod:
>> +#
>> +# An enumeration of multifd compression.
>
> Suggest "compression methods."

will do.

Sorry again for the missunderstanding.

Later, Juan.


