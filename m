Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03471C33CB1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 16:02:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0A98207FF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 16:02:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XDuWS5Sa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0A98207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is7bT-0004vU-Sq
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 11:02:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37664)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <rjones@redhat.com>) id 1is7Zq-0003jg-1U
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 11:00:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rjones@redhat.com>) id 1is7Zm-0005aE-A2
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 11:00:57 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:30264
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <rjones@redhat.com>) id 1is7Zm-0005a1-6H
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 11:00:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579190453;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QY3y3n8oMBLyjRhEFbm8Oi1kFEm7Eylb41TSMMKkUSM=;
 b=XDuWS5SatEO4rLMMqh64Gxh/0Ik1F7sUJOTGRFfgMswLhP1FW9dmqZC1J62ZUe2f1av90V
 5v+KUJiwvdSGZlZPHHV3MFgwuD/qn7Yyf8HAk59Ddvdq/EluhoKeSW+aFkAVpMqG5RoGR9
 Wm2JTVs8TdFpAj2HeC3yEAxYdrcgJtk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-96-sclrRCzgOM-GPeoXmMafpg-1; Thu, 16 Jan 2020 11:00:46 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D47F5107ACC7;
 Thu, 16 Jan 2020 16:00:45 +0000 (UTC)
Received: from localhost (ovpn-117-237.ams2.redhat.com [10.36.117.237])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 69E0A60C84;
 Thu, 16 Jan 2020 16:00:45 +0000 (UTC)
Date: Thu, 16 Jan 2020 16:00:44 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: Bug? qemu-img convert to preallocated image makes it sparse
Message-ID: <20200116160044.GS3888@redhat.com>
References: <20200116141352.GA32053@redhat.com>
 <7586b832-ecd2-e766-6781-3a25f382c9ed@redhat.com>
 <20200116145048.GG9470@linux.fritz.box>
 <5fcb531c-24ef-6e91-294d-517631c5a2cb@redhat.com>
 <03ebf1f7ad780fca65dfc7486e860beb33c71d20.camel@redhat.com>
MIME-Version: 1.0
In-Reply-To: <03ebf1f7ad780fca65dfc7486e860beb33c71d20.camel@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: sclrRCzgOM-GPeoXmMafpg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Kevin Wolf <kwolf@redhat.com>, sgarzare@redhat.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jan 16, 2020 at 05:38:03PM +0200, Maxim Levitsky wrote:
> How about doing write zeros without discard only in this particular case =
(convert to existing image)
> Basically omitting the BDRV_REQ_MAY_UNMAP flag to blk_co_pwrite_zeroes.
> It will be slow, but maybe for this particular case, it is acceptable?

I should probably say that we don't want to break the other case
(which is likely more important) where we write a sparse source to a
sparse target and want the target to contain only the union of the two
sparse maps, not fully allocated :-)

It would be fine, I think, to have a new "make this disk fully
allocated" operation.  qemu-img resize could almost do it with a
request to add 0 extra bytes, but the --preallocation flag only
applies to the new space.

Rich.

--=20
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjon=
es
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-top is 'top' for virtual machines.  Tiny program with many
powerful monitoring features, net stats, disk stats, logging, etc.
http://people.redhat.com/~rjones/virt-top


