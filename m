Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E087DC47247
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 09:44:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADD7920675
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 09:44:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jxs7X6uP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADD7920675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVu7O-0007id-Tr
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 05:44:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51456)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jVu6C-0006WT-2K
 for qemu-devel@nongnu.org; Tue, 05 May 2020 05:42:48 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:56181
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jVu6B-0005Gg-BH
 for qemu-devel@nongnu.org; Tue, 05 May 2020 05:42:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588671766;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Mho+gTo6qBUQMtEy/b5PsKdMhmjKyMojIIyYmCXoDgs=;
 b=Jxs7X6uPqUW1VGObn5upmoSG6gtN/XuEtgTxV15r2Uuvzv2PjMSEakUHMcKLclWqTeOa3T
 0ZUI51T08GoXyVe13KslwuvOBV/lGpxhjX5ODh2yuGPufB6y044HG/SjhdWbqXSvVXKorb
 k/nFNGNK1rKDTDH6y7XniTostPxKLf4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-5ZDdjEEwO9imDaUH2RD9qA-1; Tue, 05 May 2020 05:42:43 -0400
X-MC-Unique: 5ZDdjEEwO9imDaUH2RD9qA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AB7A180183C;
 Tue,  5 May 2020 09:42:42 +0000 (UTC)
Received: from linux.fritz.box (ovpn-112-11.ams2.redhat.com [10.36.112.11])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B1B7C600F5;
 Tue,  5 May 2020 09:42:41 +0000 (UTC)
Date: Tue, 5 May 2020 11:42:40 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: Re: [PATCH 0/6] vmdk: Fix zero cluster handling
Message-ID: <20200505094240.GG5759@linux.fritz.box>
References: <20200430133007.170335-1-kwolf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200430133007.170335-1-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 00:37:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 30.04.2020 um 15:30 hat Kevin Wolf geschrieben:
> What I was really investigating is why 055 was so slow. I couldn't solve
> that, but instead I found out that our VMDK code for zero clusters and
> write_zeroes was completely broken. Apart from segfaults when zero
> clusters were actually enabled, this caused a compressed backup target
> to result in a bigger file than uncompressed with VMDK.
>=20
> This series tries to fix it (with one bonus performance patch).

Thanks for the review, fixed up the commit messages and applied.

If you were curious about the VMDK terminology, I looked it up and the
basic terms translate to qcow2 like this:

* grain directory =3D L1 table
* grain table =3D L2 table
* grain =3D cluster

"zeroed-grain GTE (grain table entry)" is the exact term used in the
VMDK spec for what we would call a zero cluster in qcow2.

Kevin


