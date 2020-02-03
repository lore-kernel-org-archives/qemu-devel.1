Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80407C3524D
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 09:19:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46A662080D
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 09:19:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aXPi6pdB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46A662080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyXtW-0007Dz-CT
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 04:19:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48574)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iyXm3-0003bp-Le
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 04:12:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iyXm2-00050U-Lc
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 04:12:07 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:34165
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iyXm2-0004yS-Gd
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 04:12:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580721125;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fp+UhiDy4u57Fi+ZK8xRw/SxdVkCdSqmBS1/oQCWWnk=;
 b=aXPi6pdBoGcaCaQYj9UUoH7NZ5TCYyo9Fw83N6ro7UnkXhYd/3Qczt+ZJoEMyzKWwL4dFF
 dmIIkz0l3swvGUqXShppGzgLSjndsa0Q1Fue52NqYYwo0DS3LZwRgXXHJwkIaStsWxWAnA
 Uc8SajVYNFi2VM6PogfDol3D5bVsHkw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-7s1O8UUyNGa0q-JZvudvxg-1; Mon, 03 Feb 2020 04:12:03 -0500
Received: by mail-wr1-f72.google.com with SMTP id d8so7867251wrq.12
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 01:12:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fp+UhiDy4u57Fi+ZK8xRw/SxdVkCdSqmBS1/oQCWWnk=;
 b=YQhDQ46ukWBWWtDEQlidSYP9l1OmvPVLJLr1x+o7K6P4WHd9V30uptnPdyfh0wPvmR
 DjHZNxAVr7JMWScEcGltwdpuc1efV19uGtnXi4JBBEIzIZUSwW2XtwhJUmRlosp12hku
 cajqvJyFympQ3vCMMq2dMOPG06Mh0fRwuntS6EoXT/bPMbz/oaB1gMyNsmHen4OCz6Dm
 ObvYlchoLkfvafNfaddm5KATF44qdbjHOG0xLXqgcIo6BlsB33+7S9OvDdlCJq9sBYe4
 sN+vFy97CHkBT3EO7ylaW/fRc6eC2VXFGW9R2lQJkRhgq/d2kCnCImR9QBnANpoYQNws
 PqKw==
X-Gm-Message-State: APjAAAWfjXuSfirZlY0YX2flEhDJTC1E0wHvfhTluEvUY3+f18ZYfKrs
 fTL/lBj+b9IPqXqZIk18Li4yo5BAQSMqtO5b2RnknmqVkeai+RmXr9zgWiiz39RYnhzVL8D/pG6
 StU8y9Dld5lbOs7c=
X-Received: by 2002:a05:600c:214f:: with SMTP id
 v15mr28454857wml.110.1580721122394; 
 Mon, 03 Feb 2020 01:12:02 -0800 (PST)
X-Google-Smtp-Source: APXvYqzgOqOVy7A7O7WNtfmzwyFRB+6TbzkmwFZ87/LolTLjzG3RTlNKpl8loOp7t9/KF9eNf3wtSw==
X-Received: by 2002:a05:600c:214f:: with SMTP id
 v15mr28454828wml.110.1580721122125; 
 Mon, 03 Feb 2020 01:12:02 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:a9f0:cbc3:a8a6:fc56?
 ([2001:b07:6468:f312:a9f0:cbc3:a8a6:fc56])
 by smtp.gmail.com with ESMTPSA id e16sm24606227wrs.73.2020.02.03.01.12.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Feb 2020 01:12:01 -0800 (PST)
Subject: Re: VW ELF loader
To: David Gibson <david@gibson.dropbear.id.au>
References: <f881c2e7-be92-9695-6e19-2dd88cbc63c1@ozlabs.ru>
 <e3ee4b4d-1b24-2900-4304-05fa521a9b47@redhat.com>
 <20200203012842.GD52446@umbus.fritz.box>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ec81cca1-d5fb-3f1e-b433-3328d81a117e@redhat.com>
Date: Mon, 3 Feb 2020 10:12:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200203012842.GD52446@umbus.fritz.box>
Content-Language: en-US
X-MC-Unique: 7s1O8UUyNGa0q-JZvudvxg-1
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
Cc: Thomas Huth <thuth@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Cornelia Huck <conny@cornelia-huck.de>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/02/20 02:28, David Gibson wrote:
> But "pseries" is different.  We're implementing the PAPR platform,
> which describes an OS environment that's presented by a combination of
> a hypervisor and firmware.  The features it specifies *require*
> collaboration between the firmware and the hypervisor.

Which features are these?

> So really, the question isn't whether we implement things in firmware
> or in qemu.  It's whether we implement the firmware functionality as
> guest cpu code, which needs to be coded to work with a limited
> environment, built with a special toolchain, then emulated with TCG.
> Or, do we just implement it in normal C code, with a full C library,
> and existing device and backend abstractions inside qemu.

... which is adding almost 2000 lines of new code to the host despite
the following limitations:

> 4. no networking in OF CI at all;
> 5. no vga;
> 6. no disk partitions in CI, i.e. no commas to select a partition -
> this relies on a bootloader accessing the disk as a whole;

and of course:

> 7. "interpret" (executes passed forth expression) does nothing as in this
> environment grub only uses it for switching cursor off and similar tasks.

In other words you're not dropping SLOF, you're really dropping
OpenFirmware completely.  It's little more than what ARM does.

Paolo


