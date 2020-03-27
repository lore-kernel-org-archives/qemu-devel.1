Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A35C43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 17:43:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D59B0206F1
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 17:43:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OpS63rHy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D59B0206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHt0n-0001X6-0Z
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 13:43:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34080)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jHt01-00012K-58
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 13:42:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jHszz-0008Ry-Dq
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 13:42:28 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:41779)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jHszz-0008Q7-9z
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 13:42:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585330946;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0vWKhsSddCOtgM8qeGHumtcIG5bNnoqUnnoDsnmwWgI=;
 b=OpS63rHyfkv1hNrLhl7NFlpboWvckXLOX1sBbrakHrKIQgW0tqgCb1HPZvx4L+ksDsOVZ4
 aOXi/Qx/MjUM0c1W3H7k03anBV9XiSkxsTEuuQBhrlYno4ubv7iFDNi5Zj0WNM1hrnKbtL
 a8p1B8jScalkxq+d7gMe/RdeXuZIQis=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-0jLHd2WmMZigbDFfGjrDgA-1; Fri, 27 Mar 2020 13:42:23 -0400
X-MC-Unique: 0jLHd2WmMZigbDFfGjrDgA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E7C23800D5E;
 Fri, 27 Mar 2020 17:42:22 +0000 (UTC)
Received: from [10.3.113.103] (ovpn-113-103.phx2.redhat.com [10.3.113.103])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7A39060C18;
 Fri, 27 Mar 2020 17:42:22 +0000 (UTC)
Subject: Re: [PATCH 3/3] nbd: Use shutdown(SHUT_WR) after last item sent
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20200327161936.2225989-1-eblake@redhat.com>
 <20200327161936.2225989-4-eblake@redhat.com>
 <20200327163548.GP1619@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <4a56f56e-60b8-6b1f-f805-31a192eb6148@redhat.com>
Date: Fri, 27 Mar 2020 12:42:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200327163548.GP1619@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/27/20 11:35 AM, Daniel P. Berrang=C3=A9 wrote:
> On Fri, Mar 27, 2020 at 11:19:36AM -0500, Eric Blake wrote:
>> Although the remote end should always be tolerant of a socket being
>> arbitrarily closed, there are situations where it is a lot easier if
>> the remote end can be guaranteed to read EOF even before the socket
>> has closed.  In particular, when using gnutls, if we fail to inform
>> the remote end about an impending teardown, the remote end cannot
>> distinguish between our closing the socket as intended vs. a malicious
>> intermediary interrupting things, and may result in spurious error
>> messages.
>=20
> Does this actually matter in the NBD case ?
>=20
> It has an explicit NBD command for requesting shutdown, and once
> that's processed, it is fine to just close the socket abruptly - I
> don't see a benefit to a TLS shutdown sequence on top.

You're right that the NBD protocol has ways for the client to advertise=20
it will be shutting down, AND documents that the server must be robust=20
to clients that just abruptly disconnect after that point.  But we don't=20
have control over all such servers, and there may very well be a server=20
that logs an error on abrupt closure, where it would be silent if we did=20
a proper gnutls_bye.  Which is more important: maximum speed in=20
disconnecting after we expressed intent, or maximum attempt at catering=20
to all sorts of remote implementations that might not be as tolerant as=20
qemu is of an abrupt termination?

> AFAIK, the TLS level clean shutdown is only required if the
> application protocol does not have any way to determine an
> unexpected shutdown itself.

'man gnutls_bye' states:

        Note that not all implementations will properly terminate a TLS=20
connec=E2=80=90
        tion.   Some  of  them, usually for performance reasons, will=20
terminate
        only the  underlying  transport  layer,  and  thus  not=20
distinguishing
        between  a  malicious  party prematurely terminating the=20
connection and
        normal termination.

You're right that because the protocol has an explicit message, we can=20
reliably distinguish any early termination prior to=20
NBD_OPT_ABORT/NBD_CMD_DISC as being malicious, so the only case where it=20
matters is if we have a premature termination after we asked for clean=20
shutdown, at which point a malicious termination didn't lose any data.=20
So on that front, I guess you are right that not using gnutls_bye isn't=20
going to have much impact.

>=20
> This is relevant for HTTP where the connection data stream may not
> have a well defined end condition.
>=20
> In the NBD case though, we have an explicit NBD_CMD_DISC to trigger
> the disconnect. After processing that message, an EOF is acceptable
> regardless of whether ,
> before processing that message, any EOF is a unexpected.
>=20
>>            Or, we can end up with a deadlock where both ends are stuck
>> on a read() from the other end but neither gets an EOF.
>=20
> If the socket has been closed abruptly why would it get stuck in
> read() - it should see EOF surely ?

That's what I'm trying to figure out: the nbdkit testsuite definitely=20
hung even though 'qemu-nbd --list' exited, but I haven't yet figured out=20
whether the bug lies in nbdkit proper or in libnbd, nor whether a=20
cleaner tls shutdown would have prevented the hang in a more reliable=20
manner. https://www.redhat.com/archives/libguestfs/2020-March/msg00191.html

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


