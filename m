Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAECDC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 19:31:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B59F121D7E
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 19:31:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xgle7tSD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B59F121D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuiC7-0004uM-10
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 14:31:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45983)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iufqc-0002OM-CL
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 12:00:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iufqa-0001Bk-Ce
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 12:00:49 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:23073
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iufqa-0001B3-6o
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 12:00:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579798847;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1LTlK9BPpBPWVhUe2/nYFwda5B43kIn5516Mm6IRHKc=;
 b=Xgle7tSDbsMg/vwoXb1FSWy8YGgCUOFzpFx8uuINZxMt9NdCg3Eh8mofM9+nQrNQJ/Q8mk
 S49etLs6kYgn2ChTYqGTBA5qqGvtNYoPXPSOvI23N7I9TPAj55ls+1/RyX6MTnlMEsMsn8
 baqMvpi2Sz05RymDl/y7dfbzF1T/HwI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-99V88OnTNO6v2moUe6CvnQ-1; Thu, 23 Jan 2020 12:00:04 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BD477801FC7;
 Thu, 23 Jan 2020 17:00:01 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-109.ams2.redhat.com [10.36.117.109])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B72CA85750;
 Thu, 23 Jan 2020 16:59:56 +0000 (UTC)
Date: Thu, 23 Jan 2020 17:59:55 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Felipe Franciosi <felipe@nutanix.com>
Subject: Re: [PATCH] iscsi: Cap block count from GET LBA STATUS (CVE-2020-1711)
Message-ID: <20200123165955.GB5021@linux.fritz.box>
References: <20200123124357.124019-1-felipe@nutanix.com>
MIME-Version: 1.0
In-Reply-To: <20200123124357.124019-1-felipe@nutanix.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 99V88OnTNO6v2moUe6CvnQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Peter Turschmid <peter.turschm@nutanix.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Peter Lieven <pl@kamp.de>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>, P J P <ppandit@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 23.01.2020 um 13:44 hat Felipe Franciosi geschrieben:
> When querying an iSCSI server for the provisioning status of blocks (via
> GET LBA STATUS), Qemu only validates that the response descriptor zero's
> LBA matches the one requested. Given the SCSI spec allows servers to
> respond with the status of blocks beyond the end of the LUN, Qemu may
> have its heap corrupted by clearing/setting too many bits at the end of
> its allocmap for the LUN.
>=20
> A malicious guest in control of the iSCSI server could carefully program
> Qemu's heap (by selectively setting the bitmap) and then smash it.
>=20
> This limits the number of bits that iscsi_co_block_status() will try to
> update in the allocmap so it can't overflow the bitmap.
>=20
> Signed-off-by: Felipe Franciosi <felipe@nutanix.com>
> Signed-off-by: Peter Turschmid <peter.turschm@nutanix.com>
> Signed-off-by: Raphael Norwitz <raphael.norwitz@nutanix.com>

Thanks, applied to the block branch.

Kevin


