Return-Path: <SRS0=68uo=YX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC54CA9EAF
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 08:11:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED2F120874
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 08:11:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=hostfission.com header.i=@hostfission.com header.b="XGUT4VFZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED2F120874
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=hostfission.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPj4O-0001W7-W7
	for qemu-devel@archiver.kernel.org; Wed, 30 Oct 2019 04:11:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36391)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <geoff@hostfission.com>) id 1iPj3Z-0000xr-PW
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 04:10:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <geoff@hostfission.com>) id 1iPj3Y-0004ae-H1
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 04:10:17 -0400
Received: from mail1.hostfission.com ([139.99.139.48]:40226)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <geoff@hostfission.com>) id 1iPj3X-0004ZC-VJ
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 04:10:16 -0400
Received: from www1.hostfission.com (www1.hostfission.com [139.99.139.52])
 by mail1.hostfission.com (Postfix) with ESMTP id AA96B4BA4C
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2019 19:10:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hostfission.com;
 s=mail; t=1572423013;
 bh=R6arvBKnPbqKU5ZcOWa2cn9Kki7DOeNMPrQuxC1gUVA=;
 h=To:Subject:Date:From:In-Reply-To:References:From;
 b=XGUT4VFZM5dDKcL5/tdqgFPJP1uJ0pC5Lv8MPgoso4+f43UljPa01NhSHO/u6ziQi
 xyVgp/qv0pRlWKEMQwMu0r3L3KL2zuGXFMdjOgHU9yoKtJ9uh4L6u9BJ1nLN5SvrJ0
 ofiEkCRRAe+hL/JaEoKsEaGPPaWgftTQ8a26X5XE=
Received: by www1.hostfission.com (Postfix, from userid 1000)
 id A85CD83F86; Wed, 30 Oct 2019 19:10:13 +1100 (AEDT)
To: qemu-devel@nongnu.org
Subject: Re: RFC: New device for zero-copy VM memory access
X-PHP-Originating-Script: 0:rcube.php
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Wed, 30 Oct 2019 19:10:13 +1100
From: geoff@hostfission.com
In-Reply-To: <028c23b219913d1f734d95a05d2b5809@hostfission.com>
References: <c83fe0e7157562c3c17598917977eb4d@hostfission.com>
 <028c23b219913d1f734d95a05d2b5809@hostfission.com>
Message-ID: <7d2b69593ebeff8238e5f642ca58661f@hostfission.com>
X-Sender: geoff@hostfission.com
User-Agent: Roundcube Webmail/1.2.3
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 139.99.139.48
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

The windows driver source is now available also.

https://github.com/gnif/Porthole-Guest-Driver

I have also opted to rename the device to 'porthole', hopefully this 
name is
acceptable.

On 2019-10-30 09:53, geoff@hostfission.com wrote:
> Just to follow this up, here is a sample client application for this 
> device
> 
> https://gist.github.com/gnif/77e7fb54604b42a1a98ecb8bf3d2cf46
> 
> -Geoff
> 
> On 2019-10-30 01:31, geoff@hostfission.com wrote:
>> Hi All,
>> 
>> Over the past week, I have been working to come up with a solution to 
>> the
>> memory transfer performance issues that hinder the Looking Glass 
>> Project.
>> 
>> Currently Looking Glass works by using the IVSHMEM shared memory 
>> device which
>> is fed by an application that captures the guest's video output. While 
>> this
>> works it is sub-optimal because we first have to perform a CPU copy of 
>> the
>> captured frame into shared RAM, and then back out again for display. 
>> Because
>> the destination buffers are allocated by closed proprietary code 
>> (DirectX, or
>> NVidia NvFBC) there is no way to have the frame placed directly into 
>> the
>> IVSHMEM shared ram.
>> 
>> This new device, currently named `introspection` (which needs a more 
>> suitable
>> name, porthole perhaps?), provides a means of translating guest 
>> physical
>> addresses to host virtual addresses, and finally to the host offsets 
>> in RAM for
>> file-backed memory guests. It does this by means of a simple protocol 
>> over a
>> unix socket (chardev) which is supplied the appropriate fd for the 
>> VM's system
>> RAM. The guest (in this case, Windows), when presented with the 
>> address of a
>> userspace buffer and size, will mlock the appropriate pages into RAM 
>> and pass
>> guest physical addresses to the virtual device.
>> 
>> This device and the windows driver have been designed in such a way 
>> that it's a
>> utility device for any project and/or application that could make use 
>> of it.
>> The PCI subsystem vendor and device ID are used to provide a means of 
>> device
>> identification in cases where multiple devices may be in use for 
>> differing
>> applications. This also allows one common driver to be used for any 
>> other
>> projects wishing to build on this device.
>> 
>> My ultimate goal is to get this to a state where it could be accepted 
>> upstream
>> into Qemu at which point Looking Glass would be modified to use it 
>> instead of
>> the IVSHMEM device.
>> 
>> My git repository with the new device can be found at:
>> https://github.com/gnif/qemu
>> 
>> The new device is:
>> https://github.com/gnif/qemu/blob/master/hw/misc/introspection.c
>> 
>> Looking Glass:
>> https://looking-glass.hostfission.com/
>> 
>> The windows driver, while working, needs some cleanup before the 
>> source is
>> published. I intend to maintain both this device and the windows 
>> driver
>> including producing a signed Windows 10 driver if Redhat are unwilling 
>> or
>> unable.
>> 
>> Kind Regards,
>> Geoffrey McRae
>> 
>> HostFission
>> https://hostfission.com

