Received: from eggs.gnu.org ([2001:4830:134:3::10]:56984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ePVar-0002zI-HF
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 10:38:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ePVao-0001of-6k
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 10:38:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50956)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ePVan-0001o1-UK
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 10:38:38 -0500
References: <1512669755-8409-1-git-send-email-thuth@redhat.com>
	<1512669755-8409-3-git-send-email-thuth@redhat.com>
	<CAFEAcA9gz0cNkPvZhkLYfYQ+ST01POwuptfXkKixSu_x=s9C+g@mail.gmail.com>
	<3fb76985-d02d-262f-491c-384680a13f3b@redhat.com>
	<CAFEAcA8D87rdcO6qVqfgS2G3N0fBzuj1uUsCRXcCv3m1KR6eyg@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <e5453a61-58d1-9b34-172b-fa4317d58573@redhat.com>
Date: Thu, 14 Dec 2017 16:38:30 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8D87rdcO6qVqfgS2G3N0fBzuj1uUsCRXcCv3m1KR6eyg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.12 2/2] net: Remove the deprecated
 -tftp, -bootp, -redir and -smb options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Stefan Hajnoczi <stefanha@redhat.com>

On 14.12.2017 14:16, Peter Maydell wrote:
> On 14 December 2017 at 12:28, Thomas Huth <thuth@redhat.com> wrote:
>> On 11.12.2017 23:04, Peter Maydell wrote:
>>> The deprecation message says:
>>>                error_report("The -redir option is deprecated. "
>>>                             "Please use '-netdev user,hostfwd=3D...' =
instead.");
>>>
>>> How does this work for systems which have embedded ethernet
>>> devices and can't use -netdev ?
>>
>> Of course it should work the same way as you currently can configure a=
ll
>> embedded ethernet devices:
>>
>>  -net nic -net user,hostfwd=3D...
>=20
> Mmm, but the deprecation message doesn't say that.
>=20
>> By the way, I think our documentation is really lacking some proper
>> description how to deal with on-board devices ...
>>
>>> This is one reason I haven't bothered to update my scripts yet
>>
>> -redir is likely not doing what you expect as soon as you are using tw=
o
>> or more (embedded or non-embedded) NICs on a machine, so you really
>> should not use that option anymore.
>=20
> Two NICs on a machine is an obscure special case, though.
> Almost all setups will have just the one NIC.
>=20
>>> The message also doesn't point out that if you were previously
>>> using -net + -redir you need to switch to -device + -netdev,
>>> since -net + -netdev doesn't work AFAIK.
>>
>> I haven't tried, but I think you can also use:
>>
>>  -netdev user,id=3Du1,hostfwd=3D... -net nic,netdev=3Du1
>>
>> Or did you run into problems here?
>=20
> Nope. I just ignored the whole thing because the deprecation
> message didn't give me enough help and didn't actually stop
> anything working, and I knew that what the message did
> say was definitely wrong for my command line. I suspect I'm
> not an entirely atypical user here...
>=20
> I think what we need to do to be able to actually remove
> this code is:
>  (1) make sure our documentation is clear and simple about
> how to move from an old command line to a new one
> (with examples, and covering all the conditions, not
> just the "let's assume everything's a PC with a
> pluggable PCI network card" case)
>  (2) make the deprecation warning be specific, and
> cover all the cases, and probably refer to a documentation
> URL
>  (3) make -redir in versions where we've removed the
> functionality print a message that specifically says
> "this option has been removed and is replaced by $FOO;
> see $URL for how to update your command line" (ie not
> just "-redir: unknown option", but retain the deprecation
> warning text for a bit).
>=20
> (Sorry if this feels like unexpectedly raising the bar
> for deprecation&removal -- I should probably have
> raised the issue earlier, but it was only your
> patch doing the removal that reminded me.)

Well, you could have at least complained during the 2.10 development
cycle when we put all the deprecation stuff into place...
But it's ok, this just showed me that there's at least somebody still
around who uses the old parameters, and it also revealed that our
documentation about how to configure on-board NICs is really bad.

I'll try to come up with some patches that improve the documentation and
the deprecation message, and then we can remove these options in QEMU
v2.14 instead. The code for these options is rather simple anyway, so it
also should not hurt that much to carry it on a little bit longer.

@Jason: Could you please ignore this patch here, but queue at least the
"-net channel" patch? I'm pretty sure that nobody is using "-net
channel" anymore these days, so removing "-net channel" right now should
be fine.

 Thomas
