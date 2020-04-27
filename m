Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A340C54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 13:48:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEA8220656
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 13:48:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="POiy0xqn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEA8220656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT47o-0008BS-TW
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 09:48:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48510)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jT46r-0007Ew-17
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 09:47:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jT46p-0008IJ-Rf
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 09:47:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55000
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jT46p-00088X-D5
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 09:47:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587995261;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ldd8JNEL9gp4iqR8O043ZL5032uGsfyGPaCnuiRnig8=;
 b=POiy0xqnH02t77Jt6zIrCfB0arU7URwP6e94t+6OLEh9SrCVbeMwiFuclrNPteT0o1XQj/
 FkvUXTRKyYnUqoIA8X+EPVwCVGwSz8UnxPmPxuKo7AXfJ/j0u85b+At0ER5LxpkK9mDZjL
 AayCYxgYeryXYUpgThWdO+AOYev6whY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-vfWMoiZKPOChoPC4y-NVmw-1; Mon, 27 Apr 2020 09:47:35 -0400
X-MC-Unique: vfWMoiZKPOChoPC4y-NVmw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E74BA46B;
 Mon, 27 Apr 2020 13:47:34 +0000 (UTC)
Received: from [10.10.116.80] (ovpn-116-80.rdu2.redhat.com [10.10.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 336F45D9DA;
 Mon, 27 Apr 2020 13:47:31 +0000 (UTC)
Subject: Re: [PATCH v2] qemu-sockets: add abstract UNIX domain socket support
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 xiaoqiang zhao <zxq_yx_007@163.com>
References: <20200423035640.29202-1-zxq_yx_007@163.com>
 <20200423090006.GA1077680@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <c11a26d1-9565-a8df-ed98-65a172fb7227@redhat.com>
Date: Mon, 27 Apr 2020 08:47:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200423090006.GA1077680@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/27 01:12:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: armbru@redhat.com, qemu-devel@nongnu.org, kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/23/20 4:00 AM, Daniel P. Berrang=C3=A9 wrote:
> Adding Eric & Markus for QAPI modelling questions
>=20
> On Thu, Apr 23, 2020 at 11:56:40AM +0800, xiaoqiang zhao wrote:
>> unix_connect_saddr now support abstract address type
>>
>> By default qemu does not support abstract UNIX domain
>> socket address. Add this ability to make qemu handy
>> when abstract address is needed.
>=20
> Was that a specific app you're using with QEMU that needs this ?
>=20
>> Abstract address is marked by prefixing the address name with a '@'.
>=20
> For full support of the abstract namespace we would ned to allow
> the "sun_path" to contain an arbitrary mix of NULs and non-NULs
> characters, and allow connect() @addrlen to be an arbitrary size.
>=20
> This patch only allows a single initial NUL, and reqiures @addrlen
> to be the full size of sun_path, padding with trailing NULs. This
> limitation is impossible to lift with QEMU's current approach to
> UNIX sockets, as it relies on passing around a NULL terminated
> string, so there's no way to have embedded NULs. Since there's
> no explicit length, we have to chooose between forcing the full
> sun_path size as @addrlen, or forcing the string length as the
> @addrlen value.
>=20
> IIUC, socat makes the latter decision by default, but has a
> flag to switch to the former.
>=20
>    [man socat]
>    unix-tightsocklen=3D[0|1]
>    On  socket  operations,  pass  a  socket  address  length that does no=
t
>    include the whole struct sockaddr_un record but (besides  other  compo=
=E2=80=90
>    nents)  only  the  relevant  part  of  the filename or abstract string=
.
>    Default is 1.
>    [/man]
>=20
> This actually is supported for both abstract and non-abstract
> sockets, though IIUC this doesn't make a semantic difference
> for non-abstract sockets.

Yes, that matches my experience as well.  '^@a' length 2 is a different=20
socket than '^@a^@' length three, but 'a' length 1 and 'a^@' length 2=20
are the same socket because only non-abstract sockets end at the earlier=20
of the first NUL or the length.

>=20
> The point is we have four possible combinations
>=20
>   NON-ABSTRACT + FULL SIZE
>   NON-ABSTRACT + MINIMAL SIZE  (default)

Two combinations, but only one behavior.

>   ABSTRACT + FULL SIZE
>   ABSTRACT + MINIMAL SIZE  (default)

And two more behaviors.

>=20
> With your patch doing the latter, it means QEMU supports
> only two combinations
>=20
>    NON+ABSTRACT + FULL SIZE
>    ABSTRACT + MINIMAL SIZE
>=20
> and also can't use "@somerealpath" for a non-abstract
> socket, though admittedly this is unlikely.
>=20
> Socat uses a special option to request use of abstract
> sockets. eg ABSTRACT:somepath, and automatically adds
> the leading NUL, so there's no need for a special "@"
> character. This means that UNIX:@somepath still resolves
> to a filesystem path and not a abstract socket path.

Yes, having an additional knob to express abstract sockets seems better=20
than overloading a specific character (although @sockname is a relative=20
name, and relative socket names already come with their own set of=20
problems).

>=20
> Finally, the patch as only added support for connect()
> not listen(). I think if QEMU wants to support abstract
> sockets we must do both, and also have unit tests added
> to tests/test-util-sockets.c

Indeed.

>=20
>=20
> The question is whether we're ok with this simple
> approach in QEMU, or should do a full approach with
> more explicit modelling.
>=20
> ie should we change QAPI thus:
>=20
> { 'struct': 'UnixSocketAddress',
>    'data': {
>      'path': 'str',
>      'tight': 'bool',
>      'abstract': 'bool' } }

You'd want to make 'tight' and 'abstract' optional, with defaults to the=20
existing practice, but otherwise this looks sane to me.


>=20
> where 'tight' is a flag indicating whether to set @addrlen
> to the minimal string length, or the maximum sun_path length.
> And 'abstract' indicates that we automagically add a leading
> NUL.
>=20
> This would *not* allow for NULs in the middle of path,
> but I'm not so bothered about that, since I can't see that
> being widely used. If we really did need that it could be
> added via a 'base64': 'bool' flag, to indicate that @path
> is base64 encoded and thus may contain NULs

Agreed that this is less likely to be needed.

>=20
>>From a CLI POV, this could be mapped to QAPI thus
>=20
>   *  -chardev unix:somepath
>=20
>        @path=3D=3Dsomepath
>        @tight=3D=3Dfalse
>        @abstract=3D=3Dfalse
>=20
>   *  -chardev unix:somepath,tight
>=20
>        @path=3D=3Dsomepath
>        @tight=3D=3Dtrue
>        @abstract=3D=3Dfalse
>=20
>   *  -chardev unix-abstract:somepath
>=20
>        @path=3D=3Dsomepath
>        @tight=3D=3Dfalse
>        @abstract=3D=3Dtrue
>=20
>   *  -chardev unix-abstract:somepath,tight
>=20
>        @path=3D=3Dsomepath
>        @tight=3D=3Dtrue
>        @abstract=3D=3Dtrue
>=20

Also sounds reasonable to me.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


