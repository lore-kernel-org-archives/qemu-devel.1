Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41420C33CB1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 14:15:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07BA32077B
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 14:15:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q8WiRhfk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07BA32077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is5vL-0007n8-Uw
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 09:15:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49781)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <rjones@redhat.com>) id 1is5uO-0006lG-Jd
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 09:14:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rjones@redhat.com>) id 1is5uL-0005dv-1y
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 09:14:04 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:55449
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <rjones@redhat.com>) id 1is5uK-0005cK-Ua
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 09:14:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579184038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ZveQj1LFTWiYdGDJswQVsZyoOvvwQTRsf7Ry6Olo5j0=;
 b=Q8WiRhfkJqkLVnPSwZODDtqSeJwWGCXXgopyxNokju8P8OJuRLgDN5f4ywsl6+IeTq/LhZ
 RgpGEVyhL3pxUB8HTDnCeBO8pj3EpUqnra/UeQAwE3j6nY6ae6DJgsOxU1G85uBPSoLX95
 7KtWaCAhWPKbUKbBXzA+lLHLH4uRKGc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-288-A-sqFkd3P-eeZb-1wsiK3A-1; Thu, 16 Jan 2020 09:13:54 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DC7181800D48;
 Thu, 16 Jan 2020 14:13:53 +0000 (UTC)
Received: from localhost (ovpn-117-237.ams2.redhat.com [10.36.117.237])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 66C6B5DA32;
 Thu, 16 Jan 2020 14:13:53 +0000 (UTC)
Date: Thu, 16 Jan 2020 14:13:52 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com,
 mlevitsk@redhat.com, sgarzare@redhat.com
Subject: Bug? qemu-img convert to preallocated image makes it sparse
Message-ID: <20200116141352.GA32053@redhat.com>
MIME-Version: 1.0
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: A-sqFkd3P-eeZb-1wsiK3A-1
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I'm not necessarily saying this is a bug, but a change in behaviour in
qemu has caused virt-v2v to fail.  The reproducer is quite simple.

Create sparse and preallocated qcow2 files of the same size:

  $ qemu-img create -f qcow2 sparse.qcow2 50M
  Formatting 'sparse.qcow2', fmt=3Dqcow2 size=3D52428800 cluster_size=3D655=
36 lazy_refcounts=3Doff refcount_bits=3D16

  $ qemu-img create -f qcow2 prealloc.qcow2 50M -o preallocation=3Dfalloc,c=
ompat=3D1.1
  Formatting 'prealloc.qcow2', fmt=3Dqcow2 size=3D52428800 compat=3D1.1 clu=
ster_size=3D65536 preallocation=3Dfalloc lazy_refcounts=3Doff refcount_bits=
=3D16

  $ du -m sparse.qcow2 prealloc.qcow2=20
  1 sparse.qcow2
  51=09prealloc.qcow2

Now copy the sparse file into the preallocated file using the -n
option so qemu-img doesn't create the target:

  $ qemu-img convert -p -n -f qcow2 -O qcow2 sparse.qcow2 prealloc.qcow2
      (100.00/100%)

In new qemu that makes the target file sparse:

  $ du -m sparse.qcow2 prealloc.qcow2=20
  1 sparse.qcow2
  1 prealloc.qcow2         <-- should still be 51

In old qemu the target file remained preallocated, which is what
I and virt-v2v are expecting.

I bisected this to the following commit:

4d7c487eac1652dfe4498fe84f32900ad461d61b is the first bad commit
commit 4d7c487eac1652dfe4498fe84f32900ad461d61b
Author: Max Reitz <mreitz@redhat.com>
Date:   Wed Jul 24 19:12:29 2019 +0200

    qemu-img: Fix bdrv_has_zero_init() use in convert
   =20
    bdrv_has_zero_init() only has meaning for newly created images or image
    areas.  If qemu-img convert did not create the image itself, it cannot
    rely on bdrv_has_zero_init()'s result to carry any meaning.
   =20
    Signed-off-by: Max Reitz <mreitz@redhat.com>
    Message-id: 20190724171239.8764-2-mreitz@redhat.com
    Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
    Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
    Signed-off-by: Max Reitz <mreitz@redhat.com>

 qemu-img.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

Reverting this commit on the current master branch restores the
expected behaviour.

Thoughts?

Rich.

--=20
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjon=
es
Read my programming and virtualization blog: http://rwmj.wordpress.com
libguestfs lets you edit virtual machines.  Supports shell scripting,
bindings from many languages.  http://libguestfs.org


