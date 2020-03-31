Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AAD8C2D0F1
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 14:43:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 077142071A
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 14:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UaiHlFpw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 077142071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJI6z-0005nW-3u
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 10:43:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53033)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jJI6B-0005Fn-Kg
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 10:42:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1jJI69-0003Yk-2V
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 10:42:38 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:49597
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1jJI67-0003Vv-Gq
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 10:42:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585665754;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FbkmzYkwBozL5a0Lq9btU+1+oMDIYOAjyEn/ktRL05E=;
 b=UaiHlFpwaTpWnA/duyhlHoVzMUv26sGLs1B5vqs1qIRMuQycc2V8G4fU0ZqtwGh5sKDtDT
 EGGDwKwxqUzTPNKXflSqm/jXM7Vf16BDjSI2zRn/WLuJTZV5I+cEoYqkBVFsbkvzmQSfNS
 gR5PkLy6b2W21a0zjOPBxq5+pHc4R1U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-QKHcToKgN7esnUyqWANe5A-1; Tue, 31 Mar 2020 10:42:32 -0400
X-MC-Unique: QKHcToKgN7esnUyqWANe5A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C0C281005514;
 Tue, 31 Mar 2020 14:42:30 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-49.ams2.redhat.com
 [10.36.112.49])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5C81F177F7;
 Tue, 31 Mar 2020 14:42:26 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 6850B9D12; Tue, 31 Mar 2020 16:42:25 +0200 (CEST)
Date: Tue, 31 Mar 2020 16:42:25 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Cameron Esfahani <dirty@apple.com>
Subject: Re: [PATCH v1] usb: Add read support for HCIVERSION register to XHCI
Message-ID: <20200331144225.67dadl6crwd57qvi@sirius.home.kraxel.org>
References: <20200330214444.43494-1-dirty@apple.com>
 <71ec6105-b2f7-4805-c235-645c25a0b201@redhat.com>
 <C89783E6-965B-4C0B-BB2F-6CB52D47F625@apple.com>
MIME-Version: 1.0
In-Reply-To: <C89783E6-965B-4C0B-BB2F-6CB52D47F625@apple.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Robert Mustacchi <rm@fingolfin.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Cameron Esfahani via <qemu-devel@nongnu.org>,
 Paul Menzel <pmenzel@molgen.mpg.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Mar 31, 2020 at 02:57:56AM -0700, Cameron Esfahani wrote:
> Philippe -
> From what I've seen, access size has nothing to do with alignment.
>=20
> What the code in access_with_adjusted_size() will do is make sure that "s=
ize" is >=3D min_access_size and <=3D max_access_size.
>=20
> So reading 2-bytes from address 2 turns into reading 4-bytes from address=
 2: xhci_cap_read() is called with reg 2, size 4.

Ouch.  I didn't expect xhci being called like that.  IMO memory.c should
do properly aligned 4-byte reads, then extract the bytes needed, i.e.
2-byte read @ both offset 0 and 2 would result in xhci being called with
a 4-byte read at offset 0, then memory.c would extract the lower or upper
bytes and return them to the guest.

> It seems like we should also change impl.min_access_size for xhci_cap_ops=
 to be 2.
>=20
> But, after that, to support people doing strange things like reading
> traditionally 4-byte values as 2 2-byte values, we probably need to
> change xhci_cap_read() to handle every memory range in steps of
> 2-bytes.

Well, the point of having MemoryRegionOps.valid and MemoryRegionOps.impl
in the first place is to allow memory.c handle this on behalf of the
device, so we don't end up reinventing the wheel in each and every
device ...

So, I think xhci is correct and memory.c has a bug somewhere (and it
seems Philippe is on track pinning it down ...)

cheers,
  Gerd


