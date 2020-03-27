Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C41BC43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 17:30:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22CC82072F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 17:30:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B1vLqAA5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22CC82072F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHsoP-0004Rp-7r
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 13:30:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58742)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jHsnk-0003yQ-S1
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 13:29:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jHsnj-0004iC-8E
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 13:29:48 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:34190)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jHsnj-0004gk-4U
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 13:29:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585330186;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cRQT7/ISMJbzRGTl6BpNPgN7scFf1EMA7FiETLedPEs=;
 b=B1vLqAA5I9jaUFywak1tkoeHRhfps7l10XLZS2PIiwok3FoKA9xdTljrTx/UQJIh+ed7lO
 cT5FXNuYP15zujsGqVANJlAVnAXQxVaRzsxYVpuBRZdqgqbm+FqGHzdXneCg2d2/PQlspX
 LPdVa4cvtxgv/MBPTwPoeeLAKKnxAr4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-56-12iKew66OmKMrGcE1yLOTA-1; Fri, 27 Mar 2020 13:29:41 -0400
X-MC-Unique: 12iKew66OmKMrGcE1yLOTA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B989D8017CC;
 Fri, 27 Mar 2020 17:29:40 +0000 (UTC)
Received: from [10.3.113.103] (ovpn-113-103.phx2.redhat.com [10.3.113.103])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5BC8819925;
 Fri, 27 Mar 2020 17:29:40 +0000 (UTC)
Subject: Re: [PATCH 2/3] io: Support shutdown of TLS channel
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20200327161936.2225989-1-eblake@redhat.com>
 <20200327161936.2225989-3-eblake@redhat.com>
 <20200327164040.GQ1619@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <aa9f40ee-450e-20f3-e860-2a56e5fd0b75@redhat.com>
Date: Fri, 27 Mar 2020 12:29:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200327164040.GQ1619@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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

On 3/27/20 11:40 AM, Daniel P. Berrang=C3=A9 wrote:
> On Fri, Mar 27, 2020 at 11:19:35AM -0500, Eric Blake wrote:
>> Gnutls documents that while many apps simply yank out the underlying
>> transport at the end of communication in the name of efficiency, this
>> is indistinguishable from a malicious actor terminating the connection
>> prematurely.  Since our channel I/O code already supports the notion of
>> a graceful shutdown request, it is time to plumb that through to the
>> TLS layer, and wait for TLS to give the all clear before then
>> terminating traffic on the underlying channel.
>>
>> Note that channel-tls now always advertises shutdown support,
>> regardless of whether the underlying channel also has that support.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---
>>   io/channel-tls.c | 27 ++++++++++++++++++++++++++-
>>   1 file changed, 26 insertions(+), 1 deletion(-)
>>
>> diff --git a/io/channel-tls.c b/io/channel-tls.c
>> index 7ec8ceff2f01..f90905823e1d 100644
>> --- a/io/channel-tls.c
>> +++ b/io/channel-tls.c
>> @@ -360,10 +360,35 @@ static int qio_channel_tls_shutdown(QIOChannel *io=
c,
>>                                       Error **errp)
>>   {
>>       QIOChannelTLS *tioc =3D QIO_CHANNEL_TLS(ioc);
>> +    int ret =3D 0;
>>
>>       tioc->shutdown |=3D how;
>>
>> -    return qio_channel_shutdown(tioc->master, how, errp);
>> +    do {
>> +        switch (how) {
>> +        case QIO_CHANNEL_SHUTDOWN_READ:
>> +            /* No TLS counterpart */
>> +            break;
>> +        case QIO_CHANNEL_SHUTDOWN_WRITE:
>> +            ret =3D qcrypto_tls_session_shutdown(tioc->session, QCRYPTO=
_SHUT_WR);
>> +            break;
>> +        case QIO_CHANNEL_SHUTDOWN_BOTH:
>> +            ret =3D qcrypto_tls_session_shutdown(tioc->session,
>> +                                               QCRYPTO_SHUT_RDWR);
>> +            break;
>> +        default:
>> +            abort();
>> +        }
>> +    } while (ret =3D=3D -EAGAIN);
>=20
> I don't think it is acceptable to do this loop here. The gnutls_bye()
> function triggers several I/O operations which could block. Looping
> like this means we busy-wait, blocking this thread for as long as I/O
> is blocking on the socket.

Hmm, good point.  Should we give qio_channel_tls_shutdown a bool=20
parameter that says whether it should wait (good for use when we are=20
being run in a coroutine and can deal with the additional I/O) or just=20
fail with -EAGAIN (which the caller can ignore if it is not worried)?

>=20
> If we must call gnutls_bye(), then it needs to be done in a way that
> can integrate with the main loop so it poll()'s / unblocks the current
> coroutine/thread.  This makes the whole thing significantly more
> complex to deal with, especially if the shutdown is being done in
> cleanup paths which ordinarily are expected to execute without
> blocking on I/O.  This is the big reason why i never made any attempt
> to use gnutls_bye().

We _are_ using gnutls_bye(GNUTLS_SHUT_RDWR) on the close() path (which=20
is indeed a cleanup path where not blocking is worthwhile) even without=20
this patch, but the question is whether using gnutls_bye(GNUTLS_SHUT_WR)=20
in the normal data path, where we are already using coroutines to manage=20
callbacks, can benefit the remote endpoint, giving them a chance to see=20
clean shutdown instead of abrupt termination.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


