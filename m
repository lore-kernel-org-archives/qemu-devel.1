Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A79C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 18:51:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B300720748
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 18:51:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fbwBuYil"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B300720748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZJSb-0005qX-So
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 13:51:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40160)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iZJRT-0005Ow-QX
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 13:50:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iZJRR-0001wb-Uh
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 13:50:34 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60239
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iZJRR-0001w2-Qr
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 13:50:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574707832;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=J378fW98y9q8scTiZTf0yllU79yF1n3q5WJ9nsyBerw=;
 b=fbwBuYil6yacJ1RqgE7vRssMvuYGRouYrFdx2FR8MsL42+WPXk4VR/DS13tCNqRzNWKKHA
 F74S4QhdtrsfNPKjdr+PKQo0kgkzAmDWq8jzGk/wvOHpQ9e1g+5v14Mlgnv4/Ax0J3hpRJ
 ZwBab9Pp45SZjFoXV1pJOYeDtB/Abn0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-136-ArO9t6BTOrq_TPoy77Fo7Q-1; Mon, 25 Nov 2019 13:50:30 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2519219057A0
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2019 18:50:30 +0000 (UTC)
Received: from work-vm (ovpn-116-74.ams2.redhat.com [10.36.116.74])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AB75E10016DA;
 Mon, 25 Nov 2019 18:50:23 +0000 (UTC)
Date: Mon, 25 Nov 2019 18:50:21 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org
Subject: virtiofsd: Where should it live?
Message-ID: <20191125185021.GB3767@work-vm>
MIME-Version: 1.0
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: ArO9t6BTOrq_TPoy77Fo7Q-1
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
Cc: mszeredi@redhat.com, berrange@redhat.com, vgoyal@redhat.com,
 stefanha@redhat.com, marcandre.lureau@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,
  There's been quite a bit of discussion about where virtiofsd, our
implemenation of a virtiofs daemon, should live.  I'd like to get
this settled now, because I'd like to tidy it up for the next
qemu cycle.

For reference it's based on qemu's livhost-user+chunks of libfuse.
It can't live in libfuse because we change enough of the library
to break their ABI.  It's C, and we've got ~100 patches - which
we can split into about 3 chunks.

Some suggestions so far:
  a) In contrib
     This is my current working assumption; the main objection is it's
     a bit big and pulls in a chunk of libfuse.

  b) In a submodule

  c) Just separate

Your suggestions/ideas please.  My preference is (a).

Dave

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


