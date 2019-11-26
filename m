Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E65CC432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 18:36:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 154B22073F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 18:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PlSCBgqH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 154B22073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZfhN-000627-P5
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 13:36:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55004)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tasleson@redhat.com>) id 1iZfdL-0000pu-3B
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 13:32:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tasleson@redhat.com>) id 1iZfRT-0005Uy-Im
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 13:20:04 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:28965
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tasleson@redhat.com>) id 1iZfRS-0005SU-VG
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 13:20:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574792400;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hGc5IeRdQXTLWSO1OjW/sXUHjgBlWWWtEJIRb5/BoYU=;
 b=PlSCBgqHT8mLeWiliSZLw6CAH6COZQ9/+VGpii00RCYHip3lH1fLnhrf56ZAeoUslAQXCG
 Y3hRD6oSOtd0IqLWmaUMt5RhH7RsUGEJEOH5dWDowrD0EbYz1yE87j44gWuN72NdH89aF2
 m4qiJzhXmq4upegG4ziM8d6zhwjkjbg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-152-YYW9KPVZMqiniDxeNOQSFg-1; Tue, 26 Nov 2019 13:19:59 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2A18980183C;
 Tue, 26 Nov 2019 18:19:58 +0000 (UTC)
Received: from [10.10.112.50] (ovpn-112-50.rdu2.redhat.com [10.10.112.50])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 47DD45C21A;
 Tue, 26 Nov 2019 18:19:56 +0000 (UTC)
Subject: Re: [RFC 0/4] POC: Generating realistic block errors
To: Stefan Hajnoczi <stefanha@gmail.com>
References: <20190919194847.18518-1-tasleson@redhat.com>
 <20190920092226.GH14365@stefanha-x1.localdomain>
 <32a302d7-b85a-991b-4366-2a82e38a9382@redhat.com>
 <0752f1c5-ed79-bda4-ad53-6b2566cc35a2@redhat.com>
 <20191121103012.GE439743@stefanha-x1.localdomain>
From: Tony Asleson <tasleson@redhat.com>
Organization: Red Hat
Message-ID: <376e4a8d-e910-605e-9dbe-be0162a3cc1e@redhat.com>
Date: Tue, 26 Nov 2019 12:19:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191121103012.GE439743@stefanha-x1.localdomain>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: YYW9KPVZMqiniDxeNOQSFg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
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
Reply-To: tasleson@redhat.com
Cc: kwolf@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/21/19 4:30 AM, Stefan Hajnoczi wrote:
> blkdebug can inject EIO when a specific LBA is accessed.  Is that
> enough for what you want to do?  Then you can reuse and maybe extend
> blkdebug.

Not exactly.  For SCSI, I would like to be able to return different
types of device errors on reads eg. 03/1101, 03/1600 and writes.  The
SCSI sense data needs to include the first block in error for the
transfer.  It would be good to also have the ability to include things
like SCSI check conditions with recoverable errors too.

I've been experimenting with blkdebug, to learn more and to see how it
would need to be extended.  One thing that I was trying to understand is
how an EIO from blkdebug gets translated into a bus/device specific
error.  At the moment I'm not sure.  I've been trying to figure out the
layering.  I think that blkdebug sits between the device specific model
and the underlying block representation on disk.  Thus it injects error
return values when accessing the underlying data, but that could be
incorrect.  If it is correct I should see some code that translates the
EIO to something transport/device specific.  Although I don't understand
how returning an ENOSPC from read_aio in blkdebug would get translated
for a SCSI disk as it doesn't make sense to me (one of the examples in
the documentation).  Actually I don't know how getting ENOSPC on a read
could happen?

During my blkdebug experimentation, I've been using lsi53c895a  with
scsi-disk and thus far I've not been able to generate a read error back
to the guest kernel.  I've managed to abort qemu with an assert and hang
qemu without being able to get an error back to the guest kernel.  I
wrote up one of them: https://bugs.launchpad.net/qemu/+bug/1853898 .
Specifying a specific sector hasn't worked for me yet.  I'm still trying
to figure out how to enable tracing/debugging etc. to see what I'm going
incorrectly.

If someone can point me to any relevant docs, diagrams, talks etc. that
would be greatly appreciated.  I've been looking in the source tree docs
directory and the source code itself and things I've found from web
searches.

Thanks,
Tony



