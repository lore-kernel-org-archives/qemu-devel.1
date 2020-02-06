Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E277C35247
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 23:47:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 499F62064C
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 23:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CEb/UXtA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 499F62064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izqs4-00089m-Gd
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 18:47:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47851)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1izqrK-0007in-Ns
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 18:46:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1izqrJ-0003GH-Oa
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 18:46:58 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:29327
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1izqrJ-0003F4-Kr
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 18:46:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581032817;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X47pO3lu5cGVkAsAKKHgdenNefvj4gVX7pwZsZW6t6M=;
 b=CEb/UXtAw4G6cCc0SHgJr0FZelX6xLpHQvVouSB1fejHRhuHD1CFDoYRyXZzU8yw6SmjI1
 VDMT1hCYbA8q7wY3rkcDnW4oH93+jE8yNEJybAuv4w96Zz8DmSlcsyrTAnCgAB6+gpUjJL
 sMUPfLl3r/Lnmuvx5bwSgWYO9zpRzEI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-ikEtoRUZNfiX6hzNp2JyPg-1; Thu, 06 Feb 2020 18:46:53 -0500
Received: by mail-wr1-f71.google.com with SMTP id w17so287718wrr.9
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 15:46:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=X47pO3lu5cGVkAsAKKHgdenNefvj4gVX7pwZsZW6t6M=;
 b=t2oy1pG8X+fhTjKk62+2BKsLvGMQzShPuxD9sE/8Fe1vZIUu7OtrrTrc8cYXGA8y2l
 jLyDLBEaEfjS7TbDvrzCVDfWuuHGVMBuJ4YRRmexGXDGRCL52S4+yE46/594/6Zfvemz
 bOG1LbvdP2AixuoUYhO7CmCNhIVahLZRpVLWnL2GmD63F61P3Kjn3iuT9vsLaUTmgqxK
 /QUNLnsuabQk8sBNU6dI1Dj1CYr/sHtYkA6Fu9MFNEAZW6sokLYXwmYgnP3prELEGyj7
 hflE/BUMGmJt5KGxd2h1FAI4NdDS4SG/k8rujldyKUJadBZ+8e8mfAJNu7Wxel3LonyR
 mZ1w==
X-Gm-Message-State: APjAAAWAEsjO4TIUUe7ATuENxeB3rwHtGzTbLhONPkAyXtVMpJ4pFT8V
 SBSxdfioi6vWo5t0Evbn+EA1XEMfWCFrA6zYEi179ua/eA/Ut4ZTOfI8hIT9be0X6JesYatMgmU
 9m8ikybMDr+VqAnU=
X-Received: by 2002:adf:d850:: with SMTP id k16mr504861wrl.216.1581032812627; 
 Thu, 06 Feb 2020 15:46:52 -0800 (PST)
X-Google-Smtp-Source: APXvYqxJXOY9lvayoP01tqlb5oyzKzvF+8DLdc5EGgLMBxMN1mONesM8wukF0U4iGNPUSVoKcn4Feg==
X-Received: by 2002:adf:d850:: with SMTP id k16mr504834wrl.216.1581032812396; 
 Thu, 06 Feb 2020 15:46:52 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:a9f0:cbc3:a8a6:fc56?
 ([2001:b07:6468:f312:a9f0:cbc3:a8a6:fc56])
 by smtp.gmail.com with ESMTPSA id u14sm1060884wrm.51.2020.02.06.15.46.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2020 15:46:52 -0800 (PST)
Subject: Re: VW ELF loader
To: Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>
References: <f881c2e7-be92-9695-6e19-2dd88cbc63c1@ozlabs.ru>
 <e3ee4b4d-1b24-2900-4304-05fa521a9b47@redhat.com>
 <20200203012842.GD52446@umbus.fritz.box>
 <ec81cca1-d5fb-3f1e-b433-3328d81a117e@redhat.com>
 <de7e4d34-eb63-904c-3475-7feee154c72c@ozlabs.ru>
 <8420784f-b4c7-9864-8534-b94dbc5f74ff@redhat.com>
 <20200205055851.GH60221@umbus.fritz.box>
 <73105e0b-c0a0-009f-aeba-fec818d3088c@redhat.com>
 <23090d06-320e-91b5-f73e-c17e065fcad8@ozlabs.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <dbea9886-04d8-f9fe-f79d-31d8abe76615@redhat.com>
Date: Fri, 7 Feb 2020 00:46:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <23090d06-320e-91b5-f73e-c17e065fcad8@ozlabs.ru>
Content-Language: en-US
X-MC-Unique: ikEtoRUZNfiX6hzNp2JyPg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
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
Cc: Christian Borntraeger <borntraeger@de.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Cornelia Huck <conny@cornelia-huck.de>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/02/20 00:23, Alexey Kardashevskiy wrote:
>> Right, not unlike what you get with vof=on. :)  I'm not against at all
>> that idea.  I just don't understand what you refer to below as (2).
>> Does petitboot not have the problem because it kexecs the new kernel?
> 
> Petitboot does not have this problem *if* it runs without SLOF, i.e.
> directly via -kernel and -initrd and uses OF CI (cut down version, about
> v3-v4 of my patchset, without block devices and grub lookup). In this
> case there is one device tree instance, fully synchronized with the
> machine state.
> 
> If there is still SLOF and (2) is happening, then petitboot is screwed
> as any other kernel.

Ok, so "minimal pseudo-OpenFirmware in QEMU" is doable and can get
everything right; it's just work to set up PCI and do all that other
do_driver_stuff(), so you can either do it yourself or use
Linux+petitboot.  Is this correct?

Also, can a normal distro kernel run via -kernel/-initrd + the minimal
firmware in QEMU?

Paolo


