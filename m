Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B5ABC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 14:36:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36BC9218AC
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 14:36:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OkASNTd1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36BC9218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihaQw-0002cV-Cl
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 09:36:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40692)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1ihaQD-0002BC-Oo
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 09:35:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1ihaQA-00066L-KE
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 09:35:27 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28262
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ihaQA-0005x0-28
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 09:35:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576679724;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=chc+NO6EzxR3Xe+tFW07bj3ra1eKkJrJFk5+HMRqEPk=;
 b=OkASNTd1RNTY+IyRfXwRyNGwUdAf9mlC3znEzmoZsXd3FLNuyEI1D/SVX2swKQMzDVOuGG
 w5KZP0O8tg0qImJAo4G7yb+gqCezF508EiwjmO2DKH2Vw/IXlvZ5B0Khu5z4go5gw47E0j
 BdojAPLtNOl5FdSZwPCW0wqHSdGghnc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-cvFH1N7jOGeWRRgatz-CQA-1; Wed, 18 Dec 2019 09:35:22 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A72BB1011EB2
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 14:35:21 +0000 (UTC)
Received: from redhat.com (ovpn-117-244.ams2.redhat.com [10.36.117.244])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 24B3260303;
 Wed, 18 Dec 2019 14:35:20 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH 1/4] qemu-file: Don't do IO after shutdown
In-Reply-To: <20191218122702.GF3707@work-vm> (David Alan Gilbert's message of
 "Wed, 18 Dec 2019 12:27:02 +0000")
References: <20191218050439.5989-1-quintela@redhat.com>
 <20191218050439.5989-2-quintela@redhat.com>
 <20191218122702.GF3707@work-vm>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Wed, 18 Dec 2019 15:35:17 +0100
Message-ID: <87d0cl66sa.fsf@trasno.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: cvFH1N7jOGeWRRgatz-CQA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> * Juan Quintela (quintela@redhat.com) wrote:
>> Be sure that we are not doing neither read/write after shutdown of the
>> QEMUFile.
>>=20
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>  migration/qemu-file.c | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
>>=20
>> diff --git a/migration/qemu-file.c b/migration/qemu-file.c
>> index 26fb25ddc1..1e5543a279 100644
>> --- a/migration/qemu-file.c
>> +++ b/migration/qemu-file.c
>> @@ -53,6 +53,8 @@ struct QEMUFile {
>> =20
>>      int last_error;
>>      Error *last_error_obj;
>> +    /* has the file has been shutdown */
>> +    bool shutdown;
>>  };
>> =20
>>  /*
>> @@ -61,6 +63,7 @@ struct QEMUFile {
>>   */
>>  int qemu_file_shutdown(QEMUFile *f)
>>  {
>> +    f->shutdown =3D true;
>>      if (!f->ops->shut_down) {
>>          return -ENOSYS;
>>      }
>> @@ -214,6 +217,9 @@ void qemu_fflush(QEMUFile *f)
>>          return;
>>      }
>> =20
>> +    if (f->shutdown) {
>> +        return;
>> +    }
>
> OK, I did wonder if you need to free the iovec.

I will think about this one.

>>      if (f->iovcnt > 0) {
>>          expect =3D iov_size(f->iov, f->iovcnt);
>>          ret =3D f->ops->writev_buffer(f->opaque, f->iov, f->iovcnt, f->=
pos,
>> @@ -328,6 +334,10 @@ static ssize_t qemu_fill_buffer(QEMUFile *f)
>>      f->buf_index =3D 0;
>>      f->buf_size =3D pending;
>> =20
>> +    if (f->shutdown) {
>> +        return 0;
>> +    }
>
> I also wondered if perhaps an error would be reasonable here; but I'm
> not sure what a read(2) does after a shutdown(2).

A fast google shows that it is .... implementation dependant.  And
worse, only really works for sockets.


> Still,
>
>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Thanks.


