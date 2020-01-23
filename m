Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62BD9C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 14:08:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CCF820684
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 14:08:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VkRwqigL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CCF820684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iudA3-0004LI-Qv
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 09:08:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46167)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1iubQr-0007cC-D5
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 07:17:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1iubQq-0001lG-9M
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 07:17:57 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:30822
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1iubQq-0001l3-5h
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 07:17:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579781875;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9uQd2c8aaLxJ4dHp0X3GeXb8bmhw3rqvGNTRN6GIPsY=;
 b=VkRwqigL2RW1C8LUAnfnUudbFWv5uOYvyqAUF1O9+9DReJ5O6YIp9aSEOwKY3cTJvhL+Vd
 W4wDSEBU7BMcOcyQJi6ihRnaVzXdBbrvT7735oZiGsSoqeGzd6oTo9WJc9ublIYeGPX5LT
 Q3AVF33+Wcynw4t4Y0xvJn+0aCbRAIs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-IysfI9I9Olq0XBkmLLa3Kw-1; Thu, 23 Jan 2020 07:17:51 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C7EBA8010C5
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 12:17:50 +0000 (UTC)
Received: from redhat.com (ovpn-116-168.ams2.redhat.com [10.36.116.168])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 59BB210016E8;
 Thu, 23 Jan 2020 12:17:50 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v3 00/21] Multifd Migration Compression
In-Reply-To: <20200123115831.36842-1-quintela@redhat.com> (Juan Quintela's
 message of "Thu, 23 Jan 2020 12:58:10 +0100")
References: <20200123115831.36842-1-quintela@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Thu, 23 Jan 2020 13:17:47 +0100
Message-ID: <87o8uu9xjo.fsf@secure.laptop>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: IysfI9I9Olq0XBkmLLa3Kw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "Daniel P. =?utf-8?Q?Ber?= =?utf-8?Q?rang=C3=A9?=" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Juan Quintela <quintela@redhat.com> wrote:
> [v3]
> - rebased on top of upstream + previous multifd cancel series
> - split multifd code into its own file (multifd.[ch])
> - split zstd/zlib compression methods (multifd-zstd/zlib.c)
> - use qemu module feauture to avoid ifdefs
>   (my understanding is that zlib needs to be present, but
>   we setup zstd only if it is not there or is disabled)
> - multifd-method: none|zlib|zstd
>
>   As far as I can see, there is no easy way to convince qapi that zstd
>   option could/couldn't be there depending on compliation flags. I
>   ended just checking in migrate_parameters_check() if it is enabled
>   and giving an error message otherwise.
>
> Questions:
> - I am "reusing" the compress-level parameter for both zstd and zlib,
>   but it poses a problem:
>   * zlib values: 1-9 (default: 6?)
>   * zstd values: 1-19 (default: 3)
> So, what should I do:
>   * create multifd-zstd-level and multifd-zlib-level (easier)
>   * reuse compress-level, and change its maximum values depending on
>     multifd-method
>   * any other good option?
>
> Please, review.
>
> [v2] - rebase on top of previous arguments posted to the list -
> introduces zlib compression - introduces zstd compression
>
> Please help if you know anything about zstd/zlib compression.
>
> This puts compression on top of multifd. Advantages about current
> compression:
>
> - We copy all pages in a single packet and then compress the whole
>   thing.
>
> - We reuse the compression stream for all the packets sent through the
>   same channel.
>
> - We can select nocomp/zlib/zstd levels of compression.
>
> Please, review.
>
> Juan Quintela (21):
>   migration-test: Use g_free() instead of free()
>   multifd: Make sure that we don't do any IO after an error
>   qemu-file: Don't do IO after shutdown
>   migration-test: Make sure that multifd and cancel works
>   migration: Create migration_is_running()
>   migration: Don't send data if we have stopped

This patches are from my previous series.  I forgot to pass the -b
option to git-publish.  Please ignore them.

Sorry, Juan.


