Received: from eggs.gnu.org ([2001:4830:134:3::10]:52845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fsVfQ-0007A5-Q1
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 12:07:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fsVfN-0000S7-IJ
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 12:07:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53816 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fsVfN-0000Rr-Ck
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 12:07:29 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F3B988573E
	for <qemu-devel@nongnu.org>; Wed, 22 Aug 2018 16:07:28 +0000 (UTC)
References: <20180822142956.6859-1-marcandre.lureau@redhat.com>
	<20180822142956.6859-4-marcandre.lureau@redhat.com>
	<20180822154611.GN12750@redhat.com>
	<CAMxuvawr-ooy91ZHTHx+aLYhgpH5gBoAKQz_pvF=kcHzadjLog@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4a0122ad-52eb-d241-709b-76038e65a858@redhat.com>
Date: Wed, 22 Aug 2018 11:07:24 -0500
MIME-Version: 1.0
In-Reply-To: <CAMxuvawr-ooy91ZHTHx+aLYhgpH5gBoAKQz_pvF=kcHzadjLog@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 3/3] seccomp: set the seccomp filter to
 all threads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Cc: Paul Moore <pmoore@redhat.com>, Eduardo Otubo <otubo@redhat.com>, qemu-devel <qemu-devel@nongnu.org>

On 08/22/2018 10:58 AM, Marc-Andr=C3=A9 Lureau wrote:

>> At this point you might as well not bother using seccomp at all. The
>> thread that is confined merely needs to scribble something into the
>> stack of the unconfined thread and now it can do whatever it wants.
>=20
> Actually, that message is incorrect, it should rather be "not all
> threads will be filtered" (as described in commit message).
>=20
>> IMHO we need to find a way to get the policy to apply to those other
>> threads.
>=20
> That's what the patch is about ;)

In other words, this patch is patching the gaping security hole that=20
already exists, but...

>>> +++ b/qemu-options.hx
>>> @@ -3864,6 +3864,8 @@ Disable set*uid|gid system calls
>>>   Disable *fork and execve
>>>   @item resourcecontrol=3D@var{string}
>>>   Disable process affinity and schedular priority
>>> +@item tsync=3D@var{bool}
>>> +Apply seccomp filter to all threads (default is auto, and will warn =
if fail)
>>
>> IMHO this should never exist, as setting "tsync" to anything other
>> than "yes", is akin to just running without any sandbox.
>=20
> Then we should just fail -sandbox on those systems.

...leaving the backdoor open.  Yes, we should instead fix things to hard=20
fail when -sandbox cannot fully protect the process, rather than adding=20
a tsync=3Doff backdoor to permit execution in spite of the insecurity.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
