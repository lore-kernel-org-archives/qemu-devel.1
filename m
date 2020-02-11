Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C1B8C352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 11:24:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB83E206D7
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 11:24:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KB2qFUU9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB83E206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1Tex-000347-4U
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 06:24:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44075)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1j1Te5-0002D6-W5
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 06:24:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1j1Te5-000121-4m
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 06:24:01 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23533
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1j1Te3-00010s-LX
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 06:24:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581420239;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MvlzGYURZVN/vFWZsr2Nh0izaX72IaJ0YdDvyIw0PHs=;
 b=KB2qFUU9fcqVtlV0UBJydUKdYkXtQ2HbHtqinJO7+bTWXGPqpFpwAHeI6Am6RivprCWoV4
 5JoUAt7TdhAuc86+DTzjIYt5sMCINg0v28oRkOHiKx/sE7c/nvvMXsRpX3T7zf/TtbwtMJ
 XdZY0R4Vxezl0t/nb2VXHtWuvLdSM6U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-314-voqjd8-yMmWdHMyapEUuIw-1; Tue, 11 Feb 2020 06:23:55 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 698801800D42
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 11:23:54 +0000 (UTC)
Received: from redhat.com (ovpn-117-143.ams2.redhat.com [10.36.117.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F04B65C109;
 Tue, 11 Feb 2020 11:23:53 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v5 3/8] multifd: Make no compression operations into its
 own structure
In-Reply-To: <20200207184528.GR3302@work-vm> (David Alan Gilbert's message of
 "Fri, 7 Feb 2020 18:45:28 +0000")
References: <20200129115655.10414-1-quintela@redhat.com>
 <20200129115655.10414-4-quintela@redhat.com>
 <20200207184528.GR3302@work-vm>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Tue, 11 Feb 2020 12:23:51 +0100
Message-ID: <87tv3xfjug.fsf@secure.laptop>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: voqjd8-yMmWdHMyapEUuIw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> * Juan Quintela (quintela@redhat.com) wrote:
>> It will be used later.
>>=20
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>
>> diff --git a/migration/multifd.h b/migration/multifd.h
>> index d8b0205977..c7fea4914c 100644
>> --- a/migration/multifd.h
>> +++ b/migration/multifd.h
>> @@ -25,6 +25,10 @@ int multifd_queue_page(QEMUFile *f, RAMBlock *block, =
ram_addr_t offset);
>> =20
>>  #define MULTIFD_FLAG_SYNC (1 << 0)
>> =20
>> +/* We reserve 3 bits for METHODS */
>> +#define MULTIFD_FLAG_METHOD_MASK (7 << 1)
>> +#define MULTIFD_FLAG_NOCOMP (1 << 1)
>> +
>
> Doesn't the 'NOCOMP' value have to be 0 for it to not break
> compatibility with existing multifd?

You are right.  fixing on next resend.

Thanks.


