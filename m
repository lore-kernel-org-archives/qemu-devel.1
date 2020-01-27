Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 507EFC2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 15:33:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B049214D8
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 15:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rvnew5CG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B049214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw6Nw-0003Mq-9W
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 10:33:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48073)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1iw6N6-0002WF-Kg
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 10:32:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1iw6N4-0006Fj-FU
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 10:32:15 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59513
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1iw6N4-0006FK-BN
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 10:32:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580139133;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h487JrLQSu0OQg51IRtDiX7dFGtFpTPjap7U740ZTww=;
 b=Rvnew5CGIDGw5f+Nh1soE0aHJRU9sDQpp+0PrD09frb1lHwwLnIuS7B/HcemIsdI6gtAmd
 TKKqCeu5qEPtK2kL1h7+Mt4LJ41z5MFJaI5pjRPt9OX0RlMCa6x78Skao+deeYqsvhCjxX
 LIGOdj2zoFGEEdj6OyFwSa+fdxz3O1E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-uVGiV0w0Mk-Z3-MOH_VbAw-1; Mon, 27 Jan 2020 10:32:05 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0FD0F801F94;
 Mon, 27 Jan 2020 15:32:04 +0000 (UTC)
Received: from redhat.com (ovpn-116-91.ams2.redhat.com [10.36.116.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 748295C1D6;
 Mon, 27 Jan 2020 15:32:03 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH 1/2] migration/compress: compress QEMUFile is not writable
In-Reply-To: <20191107115910.GG2816@work-vm> (David Alan Gilbert's message of
 "Thu, 7 Nov 2019 11:59:10 +0000")
References: <20191012023932.1863-1-richardw.yang@linux.intel.com>
 <20191012023932.1863-2-richardw.yang@linux.intel.com>
 <20191107115910.GG2816@work-vm>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Mon, 27 Jan 2020 16:32:01 +0100
Message-ID: <87v9ow29vy.fsf@secure.laptop>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: uVGiV0w0Mk-Z3-MOH_VbAw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Wei Yang <richardw.yang@linux.intel.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> * Wei Yang (richardw.yang@linux.intel.com) wrote:
>> We open a file with empty_ops for compress QEMUFile, which means this is
>> not writable.
>
> That explanation sounds reasonable; but I'm confused by the history of
> this;  the code was added by Liang Li in :
>
>   b3be289 qemu-file: Fix qemu_put_compression_data flaw
>
>   ( https://www.mail-archive.com/qemu-devel@nongnu.org/msg368974.html )
>
> with almost exactly the opposite argument;  can we figure out why?

Comment of that patch is wrong, code agrees with this patch.
The patch that went in does:

-        return 0;
+        if (!qemu_file_is_writable(f)) {
+            return -1;
+        }
+        qemu_fflush(f);
+        blen =3D IO_BUF_SIZE - sizeof(int32_t);
+        if (blen < compressBound(size)) {
+            return -1;
+        }

i.e. it move from return 0 to return -1 if we are not able to write, or
if we are not able to get enough space.

>> @@ -756,14 +753,7 @@ ssize_t qemu_put_compression_data(QEMUFile *f, z_st=
ream *stream,
>>      ssize_t blen =3D IO_BUF_SIZE - f->buf_index - sizeof(int32_t);
>> =20
>>      if (blen < compressBound(size)) {
>> -        if (!qemu_file_is_writable(f)) {
>> -            return -1;
>> -        }
>> -        qemu_fflush(f);
>> -        blen =3D IO_BUF_SIZE - sizeof(int32_t);
>> -        if (blen < compressBound(size)) {
>> -            return -1;
>> -        }
>> +        return -1;
>>      }

This moves from trying some things to just return -1.

And patch is ok.  compression file has a file with empty_os, so
qemu_fflush() will not help at all.

Reviewed-by: Juan Quintela <quintela@redhat.com>


Thanks, Juan.


