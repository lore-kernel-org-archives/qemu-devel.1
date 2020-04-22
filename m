Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 462B6C54FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 16:08:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1033220774
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 16:08:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OyzklpD6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1033220774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRHvk-0006c1-6f
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 12:08:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52320)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1jRHsJ-0002oe-Vs
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 12:05:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1jRHsF-0007ly-Qy
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 12:05:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23645
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1jRHsF-0007eR-B8
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 12:05:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587571517;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FD61kM4prKv0MRX0jf7+d+FRsN10wugBezZK7ZM89gg=;
 b=OyzklpD6O2zVJI+vbRvDNybqD+FM3egnVDcmWkhmCYg86o1lELwXikGLxXp05aTy5jNTQq
 Nks3AXh/E29ijy44Qq/5plVU5cIHwS033vx8biT+qQeU0zIdTG8sfXzXoy3i8w8IcE8MyB
 0bCYqfI/sTL19sCgjc4yTy45UurN8hw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404-4YAN2_xxOUqf0rIhvNqcYQ-1; Wed, 22 Apr 2020 12:05:15 -0400
X-MC-Unique: 4YAN2_xxOUqf0rIhvNqcYQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3E86B18C8C22;
 Wed, 22 Apr 2020 16:05:14 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-113-154.ams2.redhat.com
 [10.36.113.154])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5E06A19756;
 Wed, 22 Apr 2020 16:05:07 +0000 (UTC)
Subject: Re: [edk2-discuss] Load Option passing. Either bugs or my confusion.
To: Hou Qiming <hqm03ster@gmail.com>
References: <623b1855-285c-cce3-c806-c17e5fd217ea@redhat.com>
 <5211.1586899245384995995@groups.io>
 <a972450d-8834-ae87-e4e3-5263a41d1735@redhat.com>
 <20200420141303.dxjqgvmzglrjtsly@sirius.home.kraxel.org>
 <9aed493a-2187-cacd-5631-54fb9973509c@redhat.com>
 <CABSdmrm2qp=nMdu7N7kxxS9PVA25_pfnK_F3EimLuq8twPKjgg@mail.gmail.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <de03e16a-df14-c18b-31a0-ec025e7b2b65@redhat.com>
Date: Wed, 22 Apr 2020 18:05:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CABSdmrm2qp=nMdu7N7kxxS9PVA25_pfnK_F3EimLuq8twPKjgg@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=lersek@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 04:15:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: edk2-devel-groups-io <devel@edk2.groups.io>,
 qemu devel list <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 discuss@edk2.groups.io, valerij zaporogeci <vlrzprgts@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 04/22/20 09:42, Hou Qiming wrote:
> A little off topic thing: isn't the default resolution supposed to be
> 1024x768?

No.

> This is the Microsoft regulation which all my physical devices
> seem to follow:
> 
> https://docs.microsoft.com/en-us/windows-hardware/test/hlk/testref/6afc8979-df62-4d86-8f6a-99f05bbdc7f3

Key term being "Microsoft regulation".

The UEFI spec requires discrete ("plug-in") graphics devices to support
at least either 800x600x32 or 640x480x32.

And the edk2 (not just OVMF) default for the console resolution is
800x600. (See PcdVideoHorizontalResolution and
PcdVideoVerticalResolution in "MdeModulePkg/MdeModulePkg.dec".)

> And when the user provides an EDID one should parse it and set the default
> resolution to match it. But that's a less important feature.

It's more complex than you might think, and (to me personally) it seems
to require more time than its importance justifies.

https://bugzilla.redhat.com/show_bug.cgi?id=1749250

Laszlo


