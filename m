Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F30FC10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 11:09:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD5372083E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 11:09:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD5372083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46543 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEXa8-0008R6-VI
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 07:09:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hEXHu-0001lg-3q
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 06:50:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hEXHt-0006fH-4h
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 06:50:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39289)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>)
	id 1hEXHq-0006ZF-RO; Thu, 11 Apr 2019 06:50:31 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C136CAC08E;
	Thu, 11 Apr 2019 10:50:28 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-116-245.ams2.redhat.com
	[10.36.116.245])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 39F1B1001E67;
	Thu, 11 Apr 2019 10:50:25 +0000 (UTC)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 11 Apr 2019 12:50:24 +0200
Message-Id: <20190411105025.97397-1-sgarzare@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.38]);
	Thu, 11 Apr 2019 10:50:28 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH RFC 0/1] block/rbd: increase dynamically the
 image size
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, Josh Durgin <jdurgin@redhat.com>,
	qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190411105024.zrDG1Qgn67bhV4zlRRRI703D0Ih-jsFP_IpueYmd9L4@z>

RBD APIs don't allow us to write more than the maximum size of the file s=
et
with rbd_create() or rbd_resize(), so we are not able to create/use a qco=
w2
image with the rbd driver.

What I found is the following:
- when qcow2 uses the rbd driver, the new file is created (rbd_create)
  with the size equals to 0. (qemu_opt_get_size_del(opts,
  BLOCK_OPT_SIZE, 0) returns 0 in qemu_rbd_co_create_opts())
- the file is truncated (implemented with rbd_resize) to 0 before to
  write the qcow2 header.
- the "size" parameter passed to rbd_create() or rbd_resize() is
  interpreted as the maximum size of the file, this means that all
  writes that exceed that size, fails and returns -22.

As a workaround, I'm checking if the RW operations exceed the maximum
size and then I'll resize the file. It works, but I'm not sure it is the
right way.

Any suggestions?

Thanks,
Stefano

Stefano Garzarella (1):
  block/rbd: increase dynamically the image size

 block/rbd.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

--=20
2.20.1


