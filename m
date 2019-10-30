Return-Path: <SRS0=68uo=YX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8ED0CA9EC5
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 18:55:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76411204FD
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 18:55:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W1ABqc85"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76411204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPt87-00026t-40
	for qemu-devel@archiver.kernel.org; Wed, 30 Oct 2019 14:55:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57789)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iPt5Y-0000KC-JR
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 14:53:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iPt5W-0007X4-3y
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 14:52:59 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:53156
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iPt5V-0007U4-Op
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 14:52:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572461576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W02ieKYuaIf4u8q8JgNUMADgfea+mHEzFAtbd6swuMI=;
 b=W1ABqc85rbXQXV8To5RN/V5BMkq3qVi1zPu1/gYVdVgGH3PL5aafntY2A+g9hljB6EJBxK
 JfRK2aorupel05hggCtskYl0/n9FzYtYpFfpNEA2MJVx3M2NxIzcrfWPTxqq5GNY9MtUr9
 o0Web6sL83Y4n+22lFlet0qSNKBEX+k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24-P99ofJ2IN-2JnpOQXXYRSg-1; Wed, 30 Oct 2019 14:52:52 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E756C1800D6B;
 Wed, 30 Oct 2019 18:52:51 +0000 (UTC)
Received: from work-vm (ovpn-116-18.ams2.redhat.com [10.36.116.18])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 22C0160BE0;
 Wed, 30 Oct 2019 18:52:50 +0000 (UTC)
Date: Wed, 30 Oct 2019 18:52:48 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: geoff@hostfission.com
Subject: Re: RFC: New device for zero-copy VM memory access
Message-ID: <20191030185248.GC3114@work-vm>
References: <c83fe0e7157562c3c17598917977eb4d@hostfission.com>
MIME-Version: 1.0
In-Reply-To: <c83fe0e7157562c3c17598917977eb4d@hostfission.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: P99ofJ2IN-2JnpOQXXYRSg-1
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* geoff@hostfission.com (geoff@hostfission.com) wrote:
> Hi All,
>=20
> Over the past week, I have been working to come up with a solution to the
> memory transfer performance issues that hinder the Looking Glass Project.
>=20
> Currently Looking Glass works by using the IVSHMEM shared memory device
> which
> is fed by an application that captures the guest's video output. While th=
is
> works it is sub-optimal because we first have to perform a CPU copy of th=
e
> captured frame into shared RAM, and then back out again for display. Beca=
use
> the destination buffers are allocated by closed proprietary code (DirectX=
,
> or
> NVidia NvFBC) there is no way to have the frame placed directly into the
> IVSHMEM shared ram.
>=20
> This new device, currently named `introspection` (which needs a more
> suitable
> name, porthole perhaps?), provides a means of translating guest physical
> addresses to host virtual addresses, and finally to the host offsets in R=
AM
> for
> file-backed memory guests. It does this by means of a simple protocol ove=
r a
> unix socket (chardev) which is supplied the appropriate fd for the VM's
> system
> RAM. The guest (in this case, Windows), when presented with the address o=
f a
> userspace buffer and size, will mlock the appropriate pages into RAM and
> pass
> guest physical addresses to the virtual device.

Hi Geroggrey,
  I wonder if the same thing can be done by using the existing vhost-user
mechanism.

  vhost-user is intended for implementing a virtio device outside of the
qemu process; so it has a character device that qemu passes commands down
to the other process, where qemu mostly passes commands via the virtio
queues.   To be able to read the virtio queues, the external process
mmap's the same memory as the guest - it gets passed a 'set mem table'
command by qemu that includes fd's for the RAM, and includes base/offset
pairs saying that a particular chunk of RAM is mapped at a particular
guest physical address.

  Whether or not you make use of virtio queues, I think the mechanism
for the device to tell the external process the mappings might be what
you're after.

Dave

> This device and the windows driver have been designed in such a way that
> it's a
> utility device for any project and/or application that could make use of =
it.
> The PCI subsystem vendor and device ID are used to provide a means of dev=
ice
> identification in cases where multiple devices may be in use for differin=
g
> applications. This also allows one common driver to be used for any other
> projects wishing to build on this device.
>=20
> My ultimate goal is to get this to a state where it could be accepted
> upstream
> into Qemu at which point Looking Glass would be modified to use it instea=
d
> of
> the IVSHMEM device.
>=20
> My git repository with the new device can be found at:
> https://github.com/gnif/qemu
>=20
> The new device is:
> https://github.com/gnif/qemu/blob/master/hw/misc/introspection.c
>=20
> Looking Glass:
> https://looking-glass.hostfission.com/
>=20
> The windows driver, while working, needs some cleanup before the source i=
s
> published. I intend to maintain both this device and the windows driver
> including producing a signed Windows 10 driver if Redhat are unwilling or
> unable.
>=20
> Kind Regards,
> Geoffrey McRae
>=20
> HostFission
> https://hostfission.com
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


