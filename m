Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D38C3F2D1
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 11:48:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82568246AA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 11:48:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gG0cn5pR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82568246AA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7e8L-0001N9-HE
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 06:48:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41222)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1j7e6w-0007pz-WC
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 06:47:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1j7e6v-0001Cs-O2
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 06:47:18 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:25727
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1j7e6v-0001Cg-Jh
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 06:47:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582890437;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8BNdwFo6D4RM1QqMeGEYpq+rW47Ybe01Mt7n/8vbROk=;
 b=gG0cn5pRYiMIKef74bDIq4obeQxpwSth5bKn+DKNC+7p16pHddDWRB9XNsc4nS3KCim3mD
 lR3L94FBaUePrP18CAPjUTB8SFf9phX9BJZIYoyOjwws1sXY1bLACC2RrdxGwt6eoQD7+W
 LuAfhpwXdMe0fYZnUhtqi2InzHTyyNE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-pwc4kRDBOS6hnTXxdAScMw-1; Fri, 28 Feb 2020 06:47:12 -0500
X-MC-Unique: pwc4kRDBOS6hnTXxdAScMw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6650F8017CC;
 Fri, 28 Feb 2020 11:47:11 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-116-243.ams2.redhat.com
 [10.36.116.243])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 55CAE5D9CD;
 Fri, 28 Feb 2020 11:47:09 +0000 (UTC)
Subject: Re: [edk2-devel] A problem with live migration of UEFI virtual
 machines
To: Andrew Fish <afish@apple.com>, devel@edk2.groups.io
References: <tencent_BC7FD00363690990994E90F8@qq.com>
 <87sgjhxbtc.fsf@zen.linaroharston> <20200224152810.GX635661@redhat.com>
 <8b0ec286-9322-ee00-3729-6ec7ee8260a6@redhat.com>
 <3E8BB07B-8730-4AB8-BCB6-EA183FB589C5@apple.com>
 <465a5a84-cac4-de39-8956-e38771807450@redhat.com>
 <8F42F6F1-A65D-490D-9F2F-E12746870B29@apple.com>
 <6666a886-720d-1ead-8f7e-13e65dcaaeb4@redhat.com>
 <284BFC25-8534-4147-8616-DE7C410DB681@apple.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <2e3771cf-089c-aecd-49a7-3034a30fc443@redhat.com>
Date: Fri, 28 Feb 2020 12:47:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <284BFC25-8534-4147-8616-DE7C410DB681@apple.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: berrange@redhat.com, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 zhoujianjay <zhoujianjay@gmail.com>, discuss <discuss@edk2.groups.io>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 wuchenye1995 <wuchenye1995@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/28/20 05:04, Andrew Fish wrote:

> Maybe I was overcomplicating this. Given your explanation I think the part I'm missing is OVMF is implying FLASH layout, in this split model, based on the size of the OVMF_CODE.fd and OVMF_VARS.fd.  Given that if OVMF_CODE.fd gets bigger the variable address changes from a QEMU point of view. So basically it is the QEMU  API that is making assumptions about the relative layout of the FD in the split model that makes a migration to larger ROM not work.

No, QEMU does not make any assumptions here. QEMU simply grabs both
pflash chips (the order is not random, it can be specified on the
command line -- in fact the QEMU user is expected to specify in the
right order), and then QEMU maps them in decreasing address order from
4GB in guest-phys address space.

If we enlarge OVMF_CODE.fd, then the base address of the varstore
(PcdOvmfFlashNvStorageVariableBase) will sink. That's not a problem per
se, because QEMU doesn't know about PcdOvmfFlashNvStorageVariableBase at
all. QEMU will simply map the varstore, automatically, where the
enlarged OVMF_CODE.fd will look for it.

> Basically the -pflash API does not support changing the size of the ROM without moving NVRAM given the way it is currently defined.

Let me put it like this: the NVRAM gets moved by virtue of how OVMF is
built, and by how QEMU maps the pflash chips into guest-phys address
space. They are in sync, automatically.

The problem is when the NVRAM is internally restructured, or resized --
the new OVMF_CODE.fd binary will reflect this with changed PCDs, and
look for "stuff" at those addresses. But if you still try to use an old
(differently sized, or differently structured) varstore file, while QEMU
will happily map it, parts of the NVRAM will just not end up in places
where OVMF_CODE.fd expects them.

> 
> Given the above it seems like the 2 options are:
> 1) Pad OVMF_CODE.fd to be very large so there is room to grow.

There's already room to grow, *inside* OVMF_CODE.fd. As I've shown
elsewhere in this thread, even the 2MB build has approx. 457 KB free in
the DXEFV volume, even without link-time optimization and without
DEBUG/ASSERT stripping, if you don't enable additional features.

> 2) Add some feature to QUEM that allows the variable store address to not be based on OVMF_CODE.fd size. 

Yes, this has been proposed over time.

It wouldn't help with the case when you change the internal structure of
the NVRAM, and try to run an incompatible OVMF_CODE.fd against that.

> I did see this [1] and combined with your email I either understand, or I'm still confused? :)
> 
> I'm not saying we need to change anything, I'm just trying to make sure I understand how OVMF and QEMU are tied to together. 

I think the most interesting function for you could be
pc_system_flash_map(), in "hw/i386/pc_sysfw.c", in the QEMU source.

> 
> [1] https://www.redhat.com/archives/libvir-list/2019-January/msg01031.html


Thanks
Laszlo


