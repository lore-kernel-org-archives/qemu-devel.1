Return-Path: <SRS0=5JRQ=YY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A78F0CA9ECB
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 15:23:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 736F120873
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 15:23:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=hostfission.com header.i=@hostfission.com header.b="Yrnbyzry"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 736F120873
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=hostfission.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQCIc-000494-50
	for qemu-devel@archiver.kernel.org; Thu, 31 Oct 2019 11:23:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55823)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <geoff@hostfission.com>) id 1iQCH0-0002V1-RC
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 11:22:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <geoff@hostfission.com>) id 1iQCGz-0007DC-Oo
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 11:22:06 -0400
Received: from mail1.hostfission.com ([139.99.139.48]:58858)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <geoff@hostfission.com>) id 1iQCGg-0006x7-8P
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 11:22:05 -0400
Received: from www1.hostfission.com (www1.hostfission.com [139.99.139.52])
 by mail1.hostfission.com (Postfix) with ESMTP id 713374BAD9;
 Fri,  1 Nov 2019 02:21:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hostfission.com;
 s=mail; t=1572535304;
 bh=OUPftAVpTYbpHsLLd1SXCi5AYLkCnRJQ4xHwimXggW4=;
 h=To:Subject:Date:From:Cc:In-Reply-To:References:From;
 b=YrnbyzryjDmAuPTOXizbc07KV4uk9Un/OvMjrt9ygud9wccAgWlg+FjB1Epw5WY4y
 bUIq6o3uPTA+6BPyCNGZdOJ3acqhsoABplmkWa0PcswUf8YSW0G2yLaNZrnDAnK06P
 xHZSVQ2p3FaxZBGbgBeiBrQPQBRKgmcdFR24PahM=
Received: by www1.hostfission.com (Postfix, from userid 1000)
 id 6A5BB80500; Fri,  1 Nov 2019 02:21:44 +1100 (AEDT)
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: RFC: New device for zero-copy VM memory access
X-PHP-Originating-Script: 0:rcube.php
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Fri, 01 Nov 2019 02:21:44 +1100
From: geoff@hostfission.com
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, QEMU Developers
 <qemu-devel@nongnu.org>
In-Reply-To: <CAFEAcA8uWCQY8GwtH4oHU8ybXsvmYaB4Qa5hnxyd+344WFjJ_Q@mail.gmail.com>
References: <c83fe0e7157562c3c17598917977eb4d@hostfission.com>
 <20191030185248.GC3114@work-vm>
 <88f1c3701740665b0ebe2f24c8ce7ade@hostfission.com>
 <20191031132443.GB3128@work-vm>
 <b36330ecd38ce872982df4d41d3d4695@hostfission.com>
 <CAFEAcA8uWCQY8GwtH4oHU8ybXsvmYaB4Qa5hnxyd+344WFjJ_Q@mail.gmail.com>
Message-ID: <b87d5b2fb84ac0a3c98a62dcc0c19077@hostfission.com>
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



On 2019-11-01 01:52, Peter Maydell wrote:
> On Thu, 31 Oct 2019 at 14:26, <geoff@hostfission.com> wrote:
>> As the author of Looking Glass, I also have to consider the 
>> maintenance
>> and the complexity of implementing the vhost protocol into the 
>> project.
>> At this time a complete Porthole client can be implemented in 150 
>> lines
>> of C without external dependencies, and most of that is boilerplate
>> socket code. This IMO is a major factor in deciding to avoid 
>> vhost-user.
> 
> This is essentially a proposal that we should make our project and
> code more complicated so that your project and code can be simpler.
> I hope you can see why this isn't necessarily an argument that will 
> hold
> very much weight for us :-)

Certainly, I do which is why I am still going to see about using vhost,
however, a device that uses vhost is likely more complex then the device
as it stands right now and as such more maintenance would be involved on
your end also. Or have I missed something in that vhost-user can be used
directly as a device?

> 
> thanks
> -- PMM

