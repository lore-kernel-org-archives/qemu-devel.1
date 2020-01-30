Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9221FC33C9E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 08:57:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C4B9206F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 08:57:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="efCVGSo0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C4B9206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ix5du-0003WU-K1
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 03:57:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39116)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1ix5dI-00034F-1s
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 03:57:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1ix5dG-0003PS-9z
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 03:57:03 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:41127
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ix5dG-0003PB-6P
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 03:57:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580374621;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wbF773wWAR+6MPvLvI6D+OUALUQq2jMy4JAkEvCWGLA=;
 b=efCVGSo0mM3W1pJpbAteYefho9jAjo52R2obaYuQTtLqOCT52h2SCpMJGCkqhNMdSzIyVN
 2QokExaxK2R4HhRkh8jGwrRp+I2xab99fczeYB/dcE7kZUZAubaCYk7MAMjZtmDRvsXPaQ
 DnjTW3vrYFG2EMJGCv6lk85IQy+WJqw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-TaQxKFftPt6MC6U7Zoo-mQ-1; Thu, 30 Jan 2020 03:56:58 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CEC0F10054E3
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 08:56:57 +0000 (UTC)
Received: from redhat.com (unknown [10.36.118.31])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5D17E5E241;
 Thu, 30 Jan 2020 08:56:57 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v5 4/8] multifd: Add multifd-zlib-level parameter
In-Reply-To: <87eevhxtfv.fsf@dusky.pond.sub.org> (Markus Armbruster's message
 of "Thu, 30 Jan 2020 09:03:00 +0100")
References: <20200129115655.10414-1-quintela@redhat.com>
 <20200129115655.10414-5-quintela@redhat.com>
 <87eevhxtfv.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Thu, 30 Jan 2020 09:56:54 +0100
Message-ID: <871rrhz5ih.fsf@secure.laptop>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: TaQxKFftPt6MC6U7Zoo-mQ-1
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
>> It will indicate which level use for compression.
>>
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>
> This is slightly confusing (there is no zlib compression), unless you
> peek at the next patch (which adds zlib compression).
>
> Three ways to make it less confusing:
>
> * Squash the two commits

As a QAPI begginer, I feel it easier to put it in a different patch.  It
makes it also easier to add other parameters, just copy whatewer is here.

> * Swap them: first add zlib compression with level hardcoded to 1, then
>   make the level configurable.

That could work.

> * Have the first commit explain itself better.  Something like
>
>     multifd: Add multifd-zlib-level parameter
>
>     This parameter specifies zlib compression level.  The next patch
>     will put it to use.

Will take this approach.
The reason that I put the qapi bits first is that I *know* how to do
them.  Once that I got approval for how to add one parameter, I add the
rest exactly the same.

For the rest of the patch, it needs to be developed, and normally needs
more iterations.

>
> For QAPI:
> Acked-by: Markus Armbruster <armbru@redhat.com>

Thanks very much.

Later, Juan.


