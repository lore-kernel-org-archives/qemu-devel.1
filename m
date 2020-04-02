Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6261C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 05:38:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B69120784
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 05:38:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I2Bzou7j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B69120784
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJsYV-00050O-LZ
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 01:38:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39666)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jJsXw-0004bs-Bc
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 01:37:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jJsXu-0007qC-RP
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 01:37:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51386
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jJsXu-0007pc-KM
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 01:37:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585805861;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aIVKMX+cBcZO+oZH1qmZBHD9EGWvjaiIRtjCQ2eUF4E=;
 b=I2Bzou7j5kBJdZysh1kdczAxN7KFFCSke2rcKS5xMN5M9t+5G6XE/vJP35xtaFBWqkJBQy
 7qlwUlwQQnha/WignwFJchoVcq0Qz0woFotY06rtjltlADr/z1vQEuVUTvuGrmuhMk2C2b
 UlxO6+5Apj7zqxC6k208xuAptmL2hVA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-422-L1eYCO74Pt2S6eIn3TFJWQ-1; Thu, 02 Apr 2020 01:37:38 -0400
X-MC-Unique: L1eYCO74Pt2S6eIn3TFJWQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A010B18AB2C0;
 Thu,  2 Apr 2020 05:37:37 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-69.ams2.redhat.com
 [10.36.112.69])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6F66198A28;
 Thu,  2 Apr 2020 05:37:37 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id ED5BF11385E2; Thu,  2 Apr 2020 07:37:35 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: Question about scsi device hotplug (e.g scsi-hd)
References: <7302c0b9f2327b9b61b4adb465f166e339e46ac1.camel@redhat.com>
 <20200401150944.GA4500@stefanha-x1.localdomain>
 <4bc42bf2-939f-f6c4-ea45-0d08eb42fc2b@redhat.com>
Date: Thu, 02 Apr 2020 07:37:35 +0200
In-Reply-To: <4bc42bf2-939f-f6c4-ea45-0d08eb42fc2b@redhat.com> (Paolo
 Bonzini's message of "Wed, 1 Apr 2020 18:36:46 +0200")
Message-ID: <87zhbubg80.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 01/04/20 17:09, Stefan Hajnoczi wrote:
>>> What do you think about it?
>>
>> Maybe aio_disable_external() is needed to postpone device emulation
>> until after realize has finished?
>>=20
>> Virtqueue kick ioeventfds are marked "external" and won't be processed
>> while external events are disabled.  See also
>> virtio_queue_aio_set_host_notifier_handler() ->
>> aio_set_event_notifier().
>
> Yes, I think Stefan is right.

Is this issue limited to SCSI devices?


