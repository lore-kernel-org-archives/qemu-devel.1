Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F32EC2BA83
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 11:32:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66F2F206ED
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 11:32:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xp9vWCC+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66F2F206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2ZCn-0006Vl-JM
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 06:32:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51798)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1j2ZCE-00064M-Me
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 06:31:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1j2ZCC-0008HE-SS
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 06:31:45 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:38953)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1j2ZCC-0008E3-O0
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 06:31:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581679903;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2kKwne0l91n6b++i5o1pYI7JOMkmZR48qyhHt26Mn8g=;
 b=Xp9vWCC+/kpy5qzGyN5iS1ZhQXPF2fXW1JER0UUX9gT/snE9jf5uGc8bfRm6gLfndbEpAn
 PbdXnNSOArCK6M74Fa1RzI6M33c/3QO7Kb2jXjTQWNgTA0AquZnK9EJLnrc1qr6miwb8Uj
 W+Vs8crEGqbQsiu90ziPjiZYEA6nzSY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-escSIMK4PM2_yB1OGZTOXw-1; Fri, 14 Feb 2020 06:31:38 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AF1E713E4;
 Fri, 14 Feb 2020 11:31:37 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.141])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 01A235DA85;
 Fri, 14 Feb 2020 11:31:36 +0000 (UTC)
Date: Fri, 14 Feb 2020 11:31:34 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Muhui Jiang <jiangmuhui@gmail.com>
Subject: Re: Mapping between Host virtual address and guest physical address
Message-ID: <20200214113134.GA3329@work-vm>
References: <CAF_eCeobcey65QJw10J85znetzNWSpmzo2ds=QT+0maNeK9acg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAF_eCeobcey65QJw10J85znetzNWSpmzo2ds=QT+0maNeK9acg@mail.gmail.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: escSIMK4PM2_yB1OGZTOXw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Muhui Jiang (jiangmuhui@gmail.com) wrote:
> Dear All
>=20
> I am recently using qemu-system-arm to boot a linux uImage.
>=20
> I would like to do some dynamic instrumentation on the uncompressed kerne=
l.
> It seems that I need to focus on two key points.
>=20
> Firstly, I need to know when the kernel is uncompressed, which means the
> compression process is finished. By analyzing the vmlinux.elf  and the
> trace I can figure it out.
>=20
> Secondly, I need to know where the uncompressed is, which means where the
> uncompressed linux kernel (Before translated into tcg) stores in the
> virtual address of qemu. Does anyone have ideas? Many Thanks

There's are some existing HMP monitor commands for this type of
debugging:

gpa2hpa addr -- print the host physical address corresponding to a guest ph=
ysical address
gpa2hva addr -- print the host virtual address corresponding to a guest phy=
sical address
gva2gpa addr -- print the guest physical address corresponding to a guest v=
irtual address

so I think you're saying you want gpa2hva

Dave

> Regards
> Muhui
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


