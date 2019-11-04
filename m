Return-Path: <SRS0=KlJF=Y4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A6DCA9EA0
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 10:27:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6EEE21D81
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 10:27:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hsjAOc0c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6EEE21D81
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRZaP-0007y5-VH
	for qemu-devel@archiver.kernel.org; Mon, 04 Nov 2019 05:27:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52564)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1iRZZi-0007Nu-E3
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 05:27:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1iRZZg-0008D0-Mj
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 05:27:05 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23438
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1iRZZg-0008Bv-JC
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 05:27:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572863222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tURwZ63BPo80VtAQPXC3zwqhJ4bi3VRG/GbSa8ByDWM=;
 b=hsjAOc0cPDCCJfqIqG08EhbvWCgcHO1cq+pzZ8ls7rY3/8Y7ku/98WwQliKiGcnCWSBWB8
 kp+EUJwv5DzsKQhl3VnXNeoc4IozNx+IlRdZZTJA+P5BdCusLKCtXtbJrlUveJSNXGoT+3
 47XLBpRDKcgAaJe8D/0RevyaDSxcBjo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-eyjzZU57OGq6nrzFJ_MgIw-1; Mon, 04 Nov 2019 05:26:59 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 52955107ACC2;
 Mon,  4 Nov 2019 10:26:58 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-69.ams2.redhat.com
 [10.36.116.69])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E42355D9CD;
 Mon,  4 Nov 2019 10:26:57 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id B5EA211AAA; Mon,  4 Nov 2019 11:26:56 +0100 (CET)
Date: Mon, 4 Nov 2019 11:26:56 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: geoff@hostfission.com
Subject: Re: RFC: New device for zero-copy VM memory access
Message-ID: <20191104102656.caomxar3xbv2wd5n@sirius.home.kraxel.org>
References: <c83fe0e7157562c3c17598917977eb4d@hostfission.com>
MIME-Version: 1.0
In-Reply-To: <c83fe0e7157562c3c17598917977eb4d@hostfission.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: eyjzZU57OGq6nrzFJ_MgIw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

  Hi,

> This new device, currently named `introspection` (which needs a more
> suitable name, porthole perhaps?), provides a means of translating
> guest physical addresses to host virtual addresses, and finally to the
> host offsets in RAM for file-backed memory guests. It does this by
> means of a simple protocol over a unix socket (chardev) which is
> supplied the appropriate fd for the VM's system RAM. The guest (in
> this case, Windows), when presented with the address of a userspace
> buffer and size, will mlock the appropriate pages into RAM and pass
> guest physical addresses to the virtual device.

So, if I understand things correctly, the workflow looks like this:

  (1) guest allocates buffers, using guest ram.
  (2) guest uses these buffers as render target for the gpu (pci-assigned I=
 guess?).
  (3) guest passes guest physical address to qemu (via porthole device).
  (4) qemu translates gpa into file offset and passes offsets to
      the client application.
  (5) client application maps all guest ram, then uses the offsets from
      qemu to find the buffers.  Then goes displaying these buffers I guess=
.

Correct?

Performance aside for now, is it an option for your use case to simply
use both an emulated display device and the assigned gpu, then configure
screen mirroring inside the guest to get the guest display scanned out
to the host?

cheers,
  Gerd


