Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C3ECC33CB1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 10:05:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB4882073A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 10:05:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I5ZHICHl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB4882073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is21k-00068A-25
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 05:05:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43180)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1is216-0005i3-5m
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 05:04:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1is213-0004lx-HO
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 05:04:42 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52324
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1is213-0004lJ-CR
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 05:04:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579169080;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AzG81owBHyELpVG90Dxh8VMheJ24OKqb9oI6a8zuafE=;
 b=I5ZHICHlBMSYpFvXkhl0vQdEFc5yzuSgGUr9boQqwNMNWaBLGDP2kRiaBAbtZSHvJCXEaW
 fyln03pCAXc4amsBBl4+ShJuEnrWgUERQrSgjG8ZXE1LnKPWOC+v0OuNkukRpna8p1dOOs
 BXVU66prA4um8Zz93rd1JYb1e4aw9uw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-mmsIWepZMmOAp9mkBgGIAQ-1; Thu, 16 Jan 2020 05:04:38 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7FC7880259D
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2020 10:04:37 +0000 (UTC)
Received: from redhat.com (ovpn-117-192.ams2.redhat.com [10.36.117.192])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 852815C299;
 Thu, 16 Jan 2020 10:04:34 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH 1/4] qemu-file: Don't do IO after shutdown
In-Reply-To: <87d0bui0iw.fsf@secure.laptop> (Juan Quintela's message of "Wed, 
 08 Jan 2020 13:40:55 +0100")
References: <20191218050439.5989-1-quintela@redhat.com>
 <20191218050439.5989-2-quintela@redhat.com>
 <20191218122702.GF3707@work-vm> <20200108094944.GA3184@work-vm>
 <87d0bui0iw.fsf@secure.laptop>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Thu, 16 Jan 2020 11:04:32 +0100
Message-ID: <87wo9r90pb.fsf@secure.laptop>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: mmsIWepZMmOAp9mkBgGIAQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Juan Quintela <quintela@redhat.com> wrote:
> "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
>> * Dr. David Alan Gilbert (dgilbert@redhat.com) wrote:
>>> * Juan Quintela (quintela@redhat.com) wrote:

>>
>> diff --git a/migration/qemu-file.c b/migration/qemu-file.c
>> index 1e5543a279..bbb2b63927 100644
>> --- a/migration/qemu-file.c
>> +++ b/migration/qemu-file.c
>> @@ -63,11 +63,18 @@ struct QEMUFile {
>>   */
>>  int qemu_file_shutdown(QEMUFile *f)
>>  {
>> +    int ret;
>> +
>>      f->shutdown =3D true;
>>      if (!f->ops->shut_down) {
>>          return -ENOSYS;
>>      }
>> -    return f->ops->shut_down(f->opaque, true, true, NULL);
>> +    ret =3D f->ops->shut_down(f->opaque, true, true, NULL);
>> +
>> +    if (!f->last_error) {
>> +        qemu_file_set_error(f, -EIO);
>> +    }
>> +    return ret;
>>  }
>> =20
>>  /*
>>
>>
>> seems to fix it for me.
>
> will gve it a try later.


With this it passes my tests.

Thanks a lot.


