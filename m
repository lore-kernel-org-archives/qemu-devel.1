Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B00F2C33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 13:13:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79DD42072A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 13:13:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C58zbeTl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79DD42072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioofW-00074Y-M9
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 08:13:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38438)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1iooW2-00036a-Ni
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 08:03:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1iooW0-00078c-Q4
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 08:03:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23962
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1iooW0-000789-Li
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 08:03:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578402199;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gL62l4ua0R4eJbl2NloECOZYkAZeMhcRjHctJTe9BMw=;
 b=C58zbeTl4xYITduS0Vlg6cn/fqAsoMdAWqmBjPYdOoJqWGzm1GWr+12CjZmTSArvM8YTgp
 qrA1scUlSOM4poLoe/YXfIoC54/c+vCsrUSNdNt/GFds8Rql5fs1wuX8jgIdjR+sJghZyM
 ZUtyWOZN+QROHOKP5rTkxhou75GrhgA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-405-Zmr_PzW5O-6kIGEhs4TWKQ-1; Tue, 07 Jan 2020 08:03:18 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 05E641005516
 for <qemu-devel@nongnu.org>; Tue,  7 Jan 2020 13:03:17 +0000 (UTC)
Received: from redhat.com (ovpn-116-141.ams2.redhat.com [10.36.116.141])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 601EC1C4;
 Tue,  7 Jan 2020 13:03:16 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v2 06/10] migration: Add multifd-compress parameter
In-Reply-To: <20200103175708.GR3804@work-vm> (David Alan Gilbert's message of
 "Fri, 3 Jan 2020 17:57:08 +0000")
References: <20191218020119.3776-1-quintela@redhat.com>
 <20191218020119.3776-7-quintela@redhat.com>
 <20200103175708.GR3804@work-vm>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Tue, 07 Jan 2020 14:03:13 +0100
Message-ID: <87v9pnpgfi.fsf@trasno.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: Zmr_PzW5O-6kIGEhs4TWKQ-1
X-Mimecast-Spam-Score: 0
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
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:

>> +#
>> +##
>> +{ 'enum': 'MultifdCompress',
>> +  'data': [ 'none' ] }
>> +
>>  ##
>>  # @MigrationParameter:
>>  #
>> @@ -586,6 +599,9 @@
>>  # @max-cpu-throttle: maximum cpu throttle percentage.
>>  #                    Defaults to 99. (Since 3.1)
>>  #
>> +# @multifd-compress: Which compression method to use.
>> +#                    Defaults to none. (Since 4.1)
>> +#
>
> 5.0 I guess!

changed.

>
> Except for the Since 4.1's:
>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>

Thanks, Juan.


