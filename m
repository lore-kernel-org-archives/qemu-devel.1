Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C262C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 10:52:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8C97206BF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 10:52:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aL3Gphdk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8C97206BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZuwF-0007Lw-4J
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 05:52:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37567)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iZuv4-0006Ga-3L
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 05:51:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iZuuz-0003XR-D6
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 05:51:37 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39734
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iZuux-0003W4-K5
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 05:51:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574851889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/Br8Ybj1SQ1U8Q1fTxY9T9GmdVVUVRLeIcs10Q2OO5E=;
 b=aL3GphdkLYmeXgCmcu/W56wrxd0vB6mr33a17ngwul+B5+4MXFB/rpG+yu7JiKkqDl3ASb
 FlJ60Tr6PvNxuYlt2dnsmm7MQtc3Tr7OnZ0LLBA8Qw5bLN05vzexwD5E5wf39LSD2Ryzg5
 GLhDzsosArKjanE9aRfsUXuD4cFo9FA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-5uPi27aTOdCbmwahSCEcRQ-1; Wed, 27 Nov 2019 05:51:26 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2BC601856A8E;
 Wed, 27 Nov 2019 10:51:25 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.46])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 291631001DE1;
 Wed, 27 Nov 2019 10:51:23 +0000 (UTC)
Date: Wed, 27 Nov 2019 10:51:21 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Daniel Cho <danielcho@qnap.com>, chen.zhang@intel.com, lukasstraub2@web.de
Subject: Re: Network connection with COLO VM
Message-ID: <20191127105121.GA3017@work-vm>
References: <CA+XQNE4eP8tfHB5eV8813bqaE+L5yooBDFCdbMWJPysvev4UKg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CA+XQNE4eP8tfHB5eV8813bqaE+L5yooBDFCdbMWJPysvev4UKg@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: 5uPi27aTOdCbmwahSCEcRQ-1
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Daniel Cho (danielcho@qnap.com) wrote:
> Hello everyone,
>=20
> Could we ssh to colo VM (means PVM & SVM are starting)?
>=20

Lets cc in Zhang Chen and Lukas Straub.

> SSH will connect to colo VM for a while, but it will disconnect with erro=
r
> *client_loop: send disconnect: Broken pipe*
>=20
> It seems to colo VM could not keep network session.
>=20
> Does it be a known issue?

That sounds like the COLO proxy is getting upset; it's supposed
to compare packets sent by the primary and secondary and only
send one to the outside - you shouldn't be talking directly to
the guest, but always via the proxy.  See docs/colo-proxy.txt

Dave

> Best Regard,
> Daniel Cho
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


