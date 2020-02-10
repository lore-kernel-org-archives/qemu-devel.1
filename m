Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BCB8C352A5
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 11:27:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AA6C2082F
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 11:27:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ETsKsZDC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AA6C2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j17Dw-0006QJ-FU
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 06:27:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32812)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1j17Cc-000532-H6
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 06:26:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1j17Cb-0007LU-8n
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 06:26:10 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51552
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1j17Cb-0007Ke-4Y
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 06:26:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581333967;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E3mZLwM5CSlwellmhNbORrRxevhseR/PtyhovYXU9ds=;
 b=ETsKsZDCwkdNwJAJydNDQgPhjv9jjOMdQUhnzfZtRKrjR2ycIrBgPVMUiQqZAO8o2nowVz
 al/W5REQlZex9BiLeA59tBUMlfJGugMr4G1JSm2IP8bQbsqnzTWJLqHgDdmF2GeXiEc6Yb
 SrUQ1Oe9hRBsO7p3/64SQkRbUf+yPAI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-101-OSEU7I-SMcKFh7rXIzHbyw-1; Mon, 10 Feb 2020 06:26:06 -0500
Received: by mail-wr1-f72.google.com with SMTP id s13so4833144wrb.21
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2020 03:26:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=E3mZLwM5CSlwellmhNbORrRxevhseR/PtyhovYXU9ds=;
 b=KVI0NjcOq7aztaKTVT9eZTbvMeKlRF/Qo9VCDZotg+aZfKoha/jYrcc1f2MFT7UTl7
 NVCza5B/4qH2y5lyZJRNzeVapLH6LnS2hzHQriUX5FsAVPMetZDxc2uLo02zQQq0LewB
 IflwaF4kYjgIyPoJ2zzgXqfLUAw97+n1jdCqcSDjT5isFgbbk9Z9GSGHyR5NeyAFuURk
 BmT0cCmYONjDntzfmb3x0LoZiTg3d9pBB/vDccbCssXjH9uAfVNGoQ5f9jz+y1/1Xg7K
 +d+FPfpO8ZGI4g9jDLH9cJHFdKWnvPBARX27JQKNBCiCZUeDqjiRVV39pb+BaI5APpJo
 dSrg==
X-Gm-Message-State: APjAAAXCLICgQsq9GR1xmDE1r70RClH0cJx4DWSLRqwgT63ezKlW+F0o
 8XHheBXjKAR+fvgfP7uteqls2dcld6eJDxo3CTDVtHBb3eHG+iJWLQ9jRVKqO0ftBgYF4lSd4bO
 8obs7a7+RNpbEi0g=
X-Received: by 2002:adf:e483:: with SMTP id i3mr1432627wrm.215.1581333965107; 
 Mon, 10 Feb 2020 03:26:05 -0800 (PST)
X-Google-Smtp-Source: APXvYqxPJh6JiANAhtDBXwvUr/WBDBgZIIn6DTFVzrIlQibdMNVFSWJWT5atvqTVelV8B/hF/vq/oA==
X-Received: by 2002:adf:e483:: with SMTP id i3mr1432595wrm.215.1581333964835; 
 Mon, 10 Feb 2020 03:26:04 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:a9f0:cbc3:a8a6:fc56?
 ([2001:b07:6468:f312:a9f0:cbc3:a8a6:fc56])
 by smtp.gmail.com with ESMTPSA id x7sm129639wrq.41.2020.02.10.03.26.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2020 03:26:04 -0800 (PST)
Subject: Re: VW ELF loader
To: David Gibson <david@gibson.dropbear.id.au>
References: <20200203012842.GD52446@umbus.fritz.box>
 <ec81cca1-d5fb-3f1e-b433-3328d81a117e@redhat.com>
 <de7e4d34-eb63-904c-3475-7feee154c72c@ozlabs.ru>
 <8420784f-b4c7-9864-8534-b94dbc5f74ff@redhat.com>
 <d63ba962-ffbb-9f27-34fb-657188e90194@ozlabs.ru>
 <CABgObfYwtrh_uy8zFmg2qDjK6iynniN6=jJ9_MKfNxXUaOkPKw@mail.gmail.com>
 <71d1cc16-f07d-481d-096b-17ee326157bb@ozlabs.ru>
 <CABgObfa4tUVBbpBtoY3JFSF8-0mRVxgGbzQokc+JrJGPagwPaQ@mail.gmail.com>
 <20200205060634.GI60221@umbus.fritz.box>
 <62d62fab-46a4-240b-037b-409ba859b93d@redhat.com>
 <20200210072802.GD22584@umbus.fritz.box>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <29abb8fe-f094-689f-2e3d-5462692048fd@redhat.com>
Date: Mon, 10 Feb 2020 12:26:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200210072802.GD22584@umbus.fritz.box>
Content-Language: en-US
X-MC-Unique: OSEU7I-SMcKFh7rXIzHbyw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
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
Cc: Thomas Huth <thuth@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 qemu-devel <qemu-devel@nongnu.org>, Cornelia Huck <conny@cornelia-huck.de>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/02/20 08:28, David Gibson wrote:
> On Thu, Feb 06, 2020 at 09:27:01AM +0100, Paolo Bonzini wrote:
>> On 05/02/20 07:06, David Gibson wrote:
>>> On Tue, Feb 04, 2020 at 12:26:32AM +0100, Paolo Bonzini wrote:
>> I'm really sorry if what I am saying is stupid; but I was thinking of a
>> firmware entrypoint like
>>
>> 	if (op == "read" || op == "write")
>> 		do_driver_stuff(op);
>> 	else
>> 		hypercall();
> 
> Um... I'm not really clear on where you're imagining this going.  In
> the OF model, device operations are done by "opening" a device tree
> node then executing methods on it, so you can't really even get to
> this point without a bunch of DT stuff.

Could you delegate that part to QEMU, as in the v6 patches?  The
firmware would record the path<->ihandle association on open and close,
and then you can use that when GRUB does "read" and "write" to invoke
the appropriate driver.

>> This is not even close to pseudocode, but hopefully enough to give the
>> idea.  Perhaps what I don't understand is why you can't start the
>> firmware with r3 pointing to the device tree, and stash it for when you
>> leave control to GRUB.
> 
> Again, I'm not even really sure what you mean by this.  We already
> enter SLOF with r3 pointing to a device tree.  I'm not sure what
> stashing it would accomplish.  GRUB as it stands expects an OF style
> entry point though, not a flat tree style entry point.

Again, sorry if what I'm saying makes little sense.  The terminology is
certainly off.  What I mean is:

- read the device tree, instantiate all PCI and virtio drivers

- keep the device tree around for use while GRUB is running

- find and invoke GRUB

- on the OF entry point, wrap open and close + handle the disk and
network entry points, and pass everything else to QEMU.

>> The TTY can use the simple
>> getchar/putchar hypercalls,
> 
> Yes... though if people attach a graphical console they might be
> pretty surprised that they don't get anything on there.

They wouldn't with Alexey's code either, would they?  And it would be
yet another QEMU backend to hook into, while with firmware it would be
lots of code to write but super-boring and something that has been done
countless times.

> We can possibly ignore the spapr virtual devices.  They seemed like
> they'd be important for people transitioning from guests under
> PowerVM, but honestly I'm not sure they've ever been used much.
> 
> We do support emulated (or passthrough) PCI devices.  I don't know if
> they're common enough that we need boot support for them.  Netboot
> from a vfio network adaptor might be something people want.

Can you get that with SLOF?

> USB storage is also a fairly likely candidate, and that would add a
> *lot* of extra complexity, since we'd need both the HCD and storage
> drivers.

Any reason to make it USB and not a virtio-blk device?  (On x86 these
days you only add USB storage disks to a VM in order to get drivers to
Windows).

Paolo


