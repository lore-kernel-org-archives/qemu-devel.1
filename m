Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C3BC432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 19:42:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3EF62075C
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 19:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="edQOuQSL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3EF62075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZgjd-0002Cv-Ue
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 14:42:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35342)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iZgWD-0004q0-7S
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 14:29:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iZgWA-00055m-Ht
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 14:28:59 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43577
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iZgWA-00050N-4z
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 14:28:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574796537;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E/f05AhfRlijT905GBH5ACQCpomx91fj/cLrfI7MfSM=;
 b=edQOuQSL0K9dicoz7vkWfSoMjwP6OJBSEHXiAra/hpjH7eyC7XMo4QDs6M7NiQy24VN7jH
 AUuhhrLEPPrSZvsch3a0a5UiNef9SJ0a72YpPx/yiWAsU3ikE3SiB3lg32QNkvhc68Rrx3
 X+g5hlyTr0BR4kLi8qcXYyBOmXrrHyQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-0QUmBU03NmGfHYw78tJv8A-1; Tue, 26 Nov 2019 14:28:55 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AF7A1107ACE4;
 Tue, 26 Nov 2019 19:28:54 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-171.ams2.redhat.com [10.36.117.171])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B0ADE5D6BE;
 Tue, 26 Nov 2019 19:28:53 +0000 (UTC)
Date: Tue, 26 Nov 2019 20:28:52 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Tony Asleson <tasleson@redhat.com>
Subject: Re: [RFC 0/4] POC: Generating realistic block errors
Message-ID: <20191126192852.GE5889@linux.fritz.box>
References: <20190919194847.18518-1-tasleson@redhat.com>
 <20190920092226.GH14365@stefanha-x1.localdomain>
 <32a302d7-b85a-991b-4366-2a82e38a9382@redhat.com>
 <0752f1c5-ed79-bda4-ad53-6b2566cc35a2@redhat.com>
 <20191121103012.GE439743@stefanha-x1.localdomain>
 <376e4a8d-e910-605e-9dbe-be0162a3cc1e@redhat.com>
MIME-Version: 1.0
In-Reply-To: <376e4a8d-e910-605e-9dbe-be0162a3cc1e@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 0QUmBU03NmGfHYw78tJv8A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 26.11.2019 um 19:19 hat Tony Asleson geschrieben:
> On 11/21/19 4:30 AM, Stefan Hajnoczi wrote:
> > blkdebug can inject EIO when a specific LBA is accessed.  Is that
> > enough for what you want to do?  Then you can reuse and maybe extend
> > blkdebug.
>=20
> Not exactly.  For SCSI, I would like to be able to return different
> types of device errors on reads eg. 03/1101, 03/1600 and writes.  The
> SCSI sense data needs to include the first block in error for the
> transfer.  It would be good to also have the ability to include things
> like SCSI check conditions with recoverable errors too.
>=20
> I've been experimenting with blkdebug, to learn more and to see how it
> would need to be extended.  One thing that I was trying to understand is
> how an EIO from blkdebug gets translated into a bus/device specific
> error.  At the moment I'm not sure.  I've been trying to figure out the
> layering.  I think that blkdebug sits between the device specific model
> and the underlying block representation on disk.  Thus it injects error
> return values when accessing the underlying data, but that could be
> incorrect.  If it is correct I should see some code that translates the
> EIO to something transport/device specific.

The point where the device calls into the generic block layer is where
the functions that start with blk_ are called (blk_aio_pwritev() and
blk_aio_preadv() are probably the most interesting ones).

The callback path in scsi-disk is not that easy to follow, but in the
end, error returns should result in scsi_handle_rw_error() being called
where error codes are translated into SCSI sense codes.

> Although I don't understand how returning an ENOSPC from read_aio in
> blkdebug would get translated for a SCSI disk as it doesn't make sense
> to me (one of the examples in the documentation).  Actually I don't
> know how getting ENOSPC on a read could happen?

That scenario doesn't make a lot of sense to me either, but blkdebug can
just inject any error code, even nonsensical ones.

> During my blkdebug experimentation, I've been using lsi53c895a  with
> scsi-disk and thus far I've not been able to generate a read error back
> to the guest kernel.  I've managed to abort qemu with an assert and hang
> qemu without being able to get an error back to the guest kernel.  I
> wrote up one of them: https://bugs.launchpad.net/qemu/+bug/1853898 .
> Specifying a specific sector hasn't worked for me yet.  I'm still trying
> to figure out how to enable tracing/debugging etc. to see what I'm going
> incorrectly.

Note that depending on the rerror/werror options, QEMU may not deliver
errors to the guest, but stop VMs instead. If the monitor is still
responsive, it's likely that you just got a stopped VM rather than a
hanging QEMU.

The default is that the VM is stopped for ENOSPC and other errors are
delivered to the guest.

Kevin


