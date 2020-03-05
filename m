Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2071FC3F2CD
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 14:34:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFF9F2073D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 14:34:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BuRfxcpn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFF9F2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9rZf-0003La-0u
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 09:34:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35870)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1j9rY5-0000hq-CV
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 09:32:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1j9rY4-0003XS-2U
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 09:32:29 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37830
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1j9rY3-0003Ws-UU
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 09:32:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583418747;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RH9DzqKHDivFvpFtqVzHnKT1qfAPENXHjniwkNggmGE=;
 b=BuRfxcpnXoGl6mVGcxhQCpCgEzZc0CBki+ecUhCWLvGyzIsPeRB4MbZdD9yamEF4hof7kM
 14l9kR4sXL2GBKiC1R+ZUiLuIhpoC7nYmTrFJLWnyAbEVG/CnIlA3qyoQUCz06JCuK3nFZ
 GlC0ElrwmDTYUFZAGnAQrPnYrnKu34w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-n0mPh_S2PhGMYpF9KqmJlg-1; Thu, 05 Mar 2020 09:32:25 -0500
X-MC-Unique: n0mPh_S2PhGMYpF9KqmJlg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0F615100DFD0;
 Thu,  5 Mar 2020 14:32:24 +0000 (UTC)
Received: from [10.3.117.177] (ovpn-117-177.phx2.redhat.com [10.3.117.177])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9641C84D90;
 Thu,  5 Mar 2020 14:32:20 +0000 (UTC)
Subject: Re: [PATCH v2 0/9] hw, ui, virtfs-proxy-helper: Reduce QEMU
 .data/.rodata/.bss footprint
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <20200305124525.14555-1-philmd@redhat.com>
 <20200305134229.GB2112347@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <5bcca2de-16bc-4026-23cc-1bf3f18cf9a2@redhat.com>
Date: Thu, 5 Mar 2020 08:32:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200305134229.GB2112347@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>, qemu-trivial@nongnu.org,
 Jason Wang <jasowang@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org,
 Greg Kurz <groug@kaod.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/5/20 7:42 AM, Daniel P. Berrang=C3=A9 wrote:
> On Thu, Mar 05, 2020 at 01:45:16PM +0100, Philippe Mathieu-Daud=C3=A9 wro=
te:
>> Since v1:
>> - merged 2 series
>> - reworked hw/usb/quirks
>> - added R-b/A-b tags
>>
>> This series reduce the footprint of the QEMU binary:
>> .bss: 106KiB (moved to .heap)
>=20
> Did this actually have an impact on the binary size, or just on the
> size the elf-dissector reports ?  I'm not very familiar with ELF,
> but Wikipedia's description of BSS makes me question it...
>=20
>    "Typically only the length of the bss section, but no data,
>     is stored in the object file. The program loader allocates
>     memory for the bss section when it loads the program. On
>     some platforms, some or all of the bss section is initialized
>     to zeroes. Unix-like systems and Windows initialize the bss
>     section to zero"
>=20
> This suggests .bss has no on-disk overhead, only runtime overhead,
> which is presumably going to be the same with heap allocations.

Or even LESS overhead.  Heap allocationhave unspecified contents=20
requiring runtime effort (true, some implementations of malloc() handle=20
large allocations specially as anonymous mmap initially backed by=20
/dev/zero, so that those allocations start life 0-allocated, but you=20
can't rely on that optimization), while .bss is required by the C=20
language to be 0 initialized (and you CAN rely on the OS implementing=20
that as efficiently as possible, generally by starting with COW mapping=20
initially backed by the zero page).

In fact, on nbdkit, we hit an interesting case where using .bss instead=20
of .rodata is actually beneficial:
https://www.redhat.com/archives/libguestfs/2019-July/msg00074.html
Marking a large array that will always consist only of zero bytes as=20
const actually pessimized the image size and load time, because the=20
addition of const moved the array from .bss into .rodata.

>=20
>> .data: 1MiB
>> .rodata: 4.34MiB
>=20
> These looks useful though in terms of disk footprint.

Yes. Smaller data structures allow for smaller binaries and faster loading.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


