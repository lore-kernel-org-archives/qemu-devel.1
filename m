Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2AB8C43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 18:47:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A7C4206F2
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 18:47:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RNfwilxM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A7C4206F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHu0a-0001ZQ-QR
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 14:47:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46321)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jHtzk-00015D-1d
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 14:46:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jHtzh-00015R-T0
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 14:46:15 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:44567)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jHtzh-00014P-Px
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 14:46:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585334773;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zNgJp/0TCcNGo2/Wqzdmm1HrnxglrLazcI0u1oqXC+8=;
 b=RNfwilxMfeTTO0uxL3r3RO8twbkejrfue+Kl4dFZ2Ul4J7VFaT5zG5v1I1jNjPimU1Ckvh
 sxoLwgjYifyh8n8dplR3VdfX13EwUj8ZM7RdfsJ/FdLkPobKEWGqYIPqw1Hk1qXxdU/p0c
 6RBllmni0cE3utQJ3recaVFlOshqMrA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-lhfYLjlBMeexBZu4QncbNg-1; Fri, 27 Mar 2020 14:46:04 -0400
X-MC-Unique: lhfYLjlBMeexBZu4QncbNg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 53AD21005513;
 Fri, 27 Mar 2020 18:46:03 +0000 (UTC)
Received: from [10.3.113.103] (ovpn-113-103.phx2.redhat.com [10.3.113.103])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 07B2F1001B28;
 Fri, 27 Mar 2020 18:46:02 +0000 (UTC)
Subject: Re: [PATCH 2/3] io: Support shutdown of TLS channel
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20200327161936.2225989-1-eblake@redhat.com>
 <20200327161936.2225989-3-eblake@redhat.com>
 <20200327164040.GQ1619@redhat.com>
 <aa9f40ee-450e-20f3-e860-2a56e5fd0b75@redhat.com>
 <20200327174334.GT1619@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <0b3fb119-64c5-0e03-c43d-15e9683fcfd7@redhat.com>
Date: Fri, 27 Mar 2020 13:46:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200327174334.GT1619@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/27/20 12:43 PM, Daniel P. Berrang=C3=A9 wrote:

>>> I don't think it is acceptable to do this loop here. The gnutls_bye()
>>> function triggers several I/O operations which could block. Looping
>>> like this means we busy-wait, blocking this thread for as long as I/O
>>> is blocking on the socket.
>>
>> Hmm, good point.  Should we give qio_channel_tls_shutdown a bool paramet=
er
>> that says whether it should wait (good for use when we are being run in =
a
>> coroutine and can deal with the additional I/O) or just fail with -EAGAI=
N
>> (which the caller can ignore if it is not worried)?
>=20
> A bool would not be sufficient, because the caller would need to know
> which direction to wait for I/O on.
>=20
> Looking at the code it does a flush of outstanding data, then sends
> some bytes, and then receives some bytes. The write will probably
> work most of the time, but the receive is almost always going to
> return -EAGAIN. So I don't think that failing with EGAIN is going
> to be much of a benefit.

Here, I'm guessing you're talking about gnutls lib/record.c.  But note:=20
for GNUTLS_SHUT_WR, it only does _gnutls_io_write_flush and=20
gnutls_alert_send; the use of _gnutls_recv_int is reserved for=20
GNUTLS_SHUT_RDWR.  When informing the other end that you are not going=20
to write any more, you don't have to wait for a reply.

>=20
>>> If we must call gnutls_bye(), then it needs to be done in a way that
>>> can integrate with the main loop so it poll()'s / unblocks the current
>>> coroutine/thread.  This makes the whole thing significantly more
>>> complex to deal with, especially if the shutdown is being done in
>>> cleanup paths which ordinarily are expected to execute without
>>> blocking on I/O.  This is the big reason why i never made any attempt
>>> to use gnutls_bye().
>>
>> We _are_ using gnutls_bye(GNUTLS_SHUT_RDWR) on the close() path (which i=
s
>=20
> Are you sure ?  AFAIK there is no existing usage of gnutls_bye() at all
> in QEMU.

Oh, I'm confusing that with nbdkit, which does use=20
gnutls_bye(GNUTLS_SHUT_RDWR) but does not wait for a response (at least,=20
not yet).

>=20
>> indeed a cleanup path where not blocking is worthwhile) even without thi=
s
>> patch, but the question is whether using gnutls_bye(GNUTLS_SHUT_WR) in t=
he
>> normal data path, where we are already using coroutines to manage callba=
cks,
>> can benefit the remote endpoint, giving them a chance to see clean shutd=
own
>> instead of abrupt termination.
>=20
> I'm not convinced the clean shutdown at the TLS level does anything impor=
tant
> given that we already have done a clean shutdown at the NBD level.

Okay, then for now, I'll still try and see if I can fix the=20
libnbd/nbdkit hang without relying on qemu sending a clean=20
gnutls_bye(GNUTLS_SHUT_WR).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


