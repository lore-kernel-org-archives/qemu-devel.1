Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7673C35247
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 20:32:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60C16214AF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 20:32:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fdt3px8y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60C16214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iznok-00027V-Bx
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 15:32:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46922)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iznnv-0001hQ-3h
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 15:31:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iznnt-0004Ym-Aq
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 15:31:14 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:28089
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1iznnt-0004XW-6s
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 15:31:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581021072;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RZBrWifjx9YPfRsBr6Cqdf1kQBNYA/xZ2nQySJ0XPSQ=;
 b=fdt3px8yqgh/nDoJBqGM8bNGK3CK1HpB40qCLlZC9/dMaTDzqD0uRk+/cBuSQTiyyKV+me
 DgVhvPfnYfaJlY8RCNOBkpqmnMWBqZK0uPjRQhw0pJI5QdeaV+sM4OyxOM7ZXQ1VKYwEid
 xYsDNEjwNc3JL8utsHyu6wx+9hrz3Zw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-92-3wB4UjryNEmYs8onB9Ll6Q-1; Thu, 06 Feb 2020 15:31:09 -0500
Received: by mail-wr1-f69.google.com with SMTP id l1so4087012wrt.4
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 12:31:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:content-transfer-encoding:from:mime-version
 :subject:date:message-id:references:cc:in-reply-to:to;
 bh=yK9eCK6yjt0cADdDSOw+fYRQRzGXDJUG89irwumnsfY=;
 b=UYt/PGzG0080cHlt1dlsl1nx3dypTpO5Rl6grGMiEIRdlOeE6Ni6qVYkdnOD+7dhol
 U46l7HHh1+9rRF+AQRH4duNBOWIpQM55fEjV22rwvH850ULxGgX6m2pRNTpogTyJAD2y
 ySiXdejsW6Ybnx0jp46fyyyL2vahPVSMtY/zdwb1OBxYfu0gL6IjiOEWUvId3VAWvAzs
 LzLMcRNg4AoKDPHMoajvIpf2b6/IMw/9UKOyQyLguw3q3MmxlwW64baYMy2Pj3NWDR7d
 VxWq/q5mMuOs35/p0sQltKSx7R2NKsmXlJ0jmjYLrYNKU5piDgGxXaP/Hdwj2JSiJg1i
 tcMQ==
X-Gm-Message-State: APjAAAWfFYTEn4YyzTv90LcVOlz0/HxsvlKckctNQ7Bwqim3+wtQlSMz
 rn7/AvKBI91yrnBS5oNXZy9lCdmsP40XO78dYtCdt6ZewJcvhyg9M4MyI8VV8RuhLc9AKbQe7X/
 2AGFIhxBCdKRQX+Q=
X-Received: by 2002:a1c:7c05:: with SMTP id x5mr6407932wmc.15.1581021068627;
 Thu, 06 Feb 2020 12:31:08 -0800 (PST)
X-Google-Smtp-Source: APXvYqyyWpoAywWZgh5p2thwUbUbmz4V9O/PzV50aZSbJfwqTtvPB+DyfBjngSipL37FqCxfRP+aHA==
X-Received: by 2002:a1c:7c05:: with SMTP id x5mr6407907wmc.15.1581021068335;
 Thu, 06 Feb 2020 12:31:08 -0800 (PST)
Received: from [192.168.3.122] (p5B0C655E.dip0.t-ipconnect.de. [91.12.101.94])
 by smtp.gmail.com with ESMTPSA id
 z25sm736172wmf.14.2020.02.06.12.31.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2020 12:31:07 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v1 00/13] Ram blocks with resizable anonymous allocations
 under POSIX
Date: Thu, 6 Feb 2020 21:31:06 +0100
Message-Id: <13585E49-B84C-41D8-8825-F96841F475D0@redhat.com>
References: <20200206201121.GM3655@work-vm>
In-Reply-To: <20200206201121.GM3655@work-vm>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
X-Mailer: iPhone Mail (17C54)
X-MC-Unique: 3wB4UjryNEmYs8onB9Ll6Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org,
 Greg Kurz <groug@kaod.org>, Alex Williamson <alex.williamson@redhat.com>,
 Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> Am 06.02.2020 um 21:11 schrieb Dr. David Alan Gilbert <dgilbert@redhat.co=
m>:
>=20
> =EF=BB=BF* David Hildenbrand (david@redhat.com) wrote:
>> We already allow resizable ram blocks for anonymous memory, however, the=
y
>> are not actually resized. All memory is mmaped() R/W, including the memo=
ry
>> exceeding the used_length, up to the max_length.
>>=20
>> When resizing, effectively only the boundary is moved. Implement actuall=
y
>> resizable anonymous allocations and make use of them in resizable ram
>> blocks when possible. Memory exceeding the used_length will be
>> inaccessible. Especially ram block notifiers require care.
>>=20
>> Having actually resizable anonymous allocations (via mmap-hackery) allow=
s
>> to reserve a big region in virtual address space and grow the
>> accessible/usable part on demand. Even if "/proc/sys/vm/overcommit_memor=
y"
>> is set to "never" under Linux, huge reservations will succeed. If there =
is
>> not enough memory when resizing (to populate parts of the reserved regio=
n),
>> trying to resize will fail. Only the actually used size is reserved in t=
he
>> OS.
>>=20
>> E.g., virtio-mem [1] wants to reserve big resizable memory regions and
>> grow the usable part on demand. I think this change is worth sending out
>> individually. Accompanied by a bunch of minor fixes and cleanups.
>>=20
>> [1] https://lore.kernel.org/kvm/20191212171137.13872-1-david@redhat.com/
>=20
> There's a few bits I've not understood from skimming the patches:
>=20

Thanks for having a look!

>  a) Am I correct in thinking you PROT_NONE the extra space so you can
> gkrow/shrink it?

Yes!

>  b) What does kvm see - does it have a slot for the whole space or for
> only the used space?

Only the used space. Resizing triggers a resize of the memory region. That =
triggers memory notifiers, which remove the old kvm memslot and re-add the =
new kvm memslot. (That=E2=80=98s existing handling, so nothing new).

So KVM will not see PROT_NONE when creating a slot.

>     I ask because we found with virtiofs/DAX experiments that on Power,
> kvm gets upset if you give it a mapping with PROT_NONE.
>     (That maybe less of an issue if you change the mapping after the
> slot is created).

That should work as expected. Resizing *while* kvm is running is tricky, bu=
t that=E2=80=98s not part of this series and a different story :) right now=
, resizing is only valid on reboot/incoming migration.

>=20
>  c) It's interesting this is keyed off the RAMBlock notifiers - do
>     memory_listener's on the address space the block is mapped into get
>    triggered?  I'm wondering how vhost (and vhost-user) in particular
>    see this.

Yes, memory listeners get triggered. Old region is removed, new one is adde=
d. Nothing changed on that front.

The issue with ram block notifiers is that they did not do a =E2=80=9Eremov=
e old, add new=E2=80=9C on resizes. They only added the full ram block. Bad=
. E.g., vfio wants to pin all memory - which would fail on PROT_NONE.

E.g., for HAX, there is no kernel ioctl to remove a ram block ... for SEV t=
here is, but I am not sure about the implications when converting back and =
forth between encrypted/unencrypted. So SEV and HAX require legacy handling=
.

Cheers!


