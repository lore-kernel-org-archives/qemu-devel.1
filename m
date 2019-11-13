Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF5AEC43331
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 09:29:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA35F2196E
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 09:29:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hWuk4C5Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA35F2196E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUoxR-00057V-3M
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 04:29:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45278)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iUowo-0004bp-Tj
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 04:28:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iUowo-0001Jw-0v
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 04:28:22 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:30144
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iUown-0001J9-TJ
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 04:28:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573637301;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lX/RYQGaSR4ElmSy26R6x9qPqktQPym3MrRZqVoi0ac=;
 b=hWuk4C5ZgoHLwqi9xuvQ90VwxrxRpYMg+XdhIG0fkOOWl2tYf708jSUx9glESEeHcQTwiF
 if/W/6WRF0225+rrPAw3QzzARS/VoImBnMzQzsN21iQ/As7LwrN8cuDyoZ8mNoMprfD+NQ
 m7kqZjslFZZrIk3VCXY00xC3D12YmNw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-qBgmVkMmNe-VH54_vYgwZg-1; Wed, 13 Nov 2019 04:28:18 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6E4241944689;
 Wed, 13 Nov 2019 09:28:17 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-169.ams2.redhat.com [10.36.117.169])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3E4845889;
 Wed, 13 Nov 2019 09:28:15 +0000 (UTC)
Date: Wed, 13 Nov 2019 10:28:13 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Alberto Garcia <berto@igalia.com>
Subject: Re: [PATCH 2/2] iotests: Test multiple blockdev-snapshot calls
Message-ID: <20191113092813.GB6471@linux.fritz.box>
References: <20191108085312.27049-1-kwolf@redhat.com>
 <20191108085312.27049-3-kwolf@redhat.com>
 <w51lfsqsakn.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
In-Reply-To: <w51lfsqsakn.fsf@maestria.local.igalia.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: qBgmVkMmNe-VH54_vYgwZg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 08.11.2019 um 15:32 hat Alberto Garcia geschrieben:
> On Fri 08 Nov 2019 09:53:12 AM CET, Kevin Wolf wrote:
> > +# Test large write to a qcow2 image
>=20
> This doesn't belong here I guess :)

Yes, fixed.

> I wonder if this test could go in 245 instead.

The headline for 245 is "Test cases for the QMP 'x-blockdev-reopen'
command", so I don't think so?

We end up testing the reopen code, but only as a side effect of
snapshotting, not through x-blockdev-reopen.

Kevin


