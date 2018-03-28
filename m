Received: from eggs.gnu.org ([2001:4830:134:3::10]:59347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f1BYZ-0007W1-CX
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 09:56:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f1BYV-0004Vt-4U
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 09:56:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53768 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f1BYU-0004VK-W2
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 09:55:59 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 04F948182D1E
	for <qemu-devel@nongnu.org>; Wed, 28 Mar 2018 13:55:55 +0000 (UTC)
References: <20180328130723.20831-1-marcandre.lureau@redhat.com>
	<20180328130723.20831-3-marcandre.lureau@redhat.com>
	<a74de730-cf65-056c-dfa1-2fcc9361b9a1@redhat.com>
	<CAMxuvayFZiYwf99mbMVFVwFZR2Bnqfv4rYS1O2SpDT1mhFtAEg@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ac132600-ac94-c9b7-b280-f2ff2ebebf74@redhat.com>
Date: Wed, 28 Mar 2018 08:55:51 -0500
MIME-Version: 1.0
In-Reply-To: <CAMxuvayFZiYwf99mbMVFVwFZR2Bnqfv4rYS1O2SpDT1mhFtAEg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/3] qobject: introduce QObjectCommon
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, "P. Berrange, Daniel" <berrange@redhat.com>, "Armbruster, Markus" <armbru@redhat.com>, "Bonzini, Paolo" <pbonzini@redhat.com>

On 03/28/2018 08:48 AM, Marc-Andr=C3=A9 Lureau wrote:

>>> +#define QOBJECT(x) \
>>> +   container_of(&(x)->base, QObject, base)
>>
>>
>> If I understand correctly, this still causes clang complaints when cal=
led as
>> QOBJECT(NULL).  As long as we are touching this, should we improve thi=
s
>> macro to be friendly to NULL conversion?
>=20
> I don't see much need for allowing NULL (literally) to be passed to
> QOBJECT(). If it's a null pointer, as long as it has the right type,
> it should be fine, shouldn't it?

Not with clang ubsan (okay, the failure is at runtime, not compile time):

https://lists.gnu.org/archive/html/qemu-devel/2018-03/msg05143.html
https://lists.gnu.org/archive/html/qemu-devel/2018-03/msg05148.html

Even when the offset is 0, the mere fact that you are computing an=20
offset relative to a NULL pointer is undefined behavior.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
