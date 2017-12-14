Received: from eggs.gnu.org ([2001:4830:134:3::10]:53638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ePSdJ-0008Gl-5q
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 07:29:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ePSdF-0006Uk-3h
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 07:29:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40148)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ePSdE-0006UF-TS
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 07:28:57 -0500
References: <1512669755-8409-1-git-send-email-thuth@redhat.com>
	<1512669755-8409-3-git-send-email-thuth@redhat.com>
	<CAFEAcA9gz0cNkPvZhkLYfYQ+ST01POwuptfXkKixSu_x=s9C+g@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <3fb76985-d02d-262f-491c-384680a13f3b@redhat.com>
Date: Thu, 14 Dec 2017 13:28:47 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9gz0cNkPvZhkLYfYQ+ST01POwuptfXkKixSu_x=s9C+g@mail.gmail.com>
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

 Hi Peter,

On 11.12.2017 23:04, Peter Maydell wrote:
> On 7 December 2017 at 18:02, Thomas Huth <thuth@redhat.com> wrote:
>> These options likely do not work as expected as soon as the user
>> tries to use more than one network interface at once. The parameters
>> have been marked as deprecated since QEMU v2.6, so users had plenty
>> of time to move their scripts to the new syntax. Time to remove the
>> old parameters now.
>=20
> The deprecation message says:
>                error_report("The -redir option is deprecated. "
>                             "Please use '-netdev user,hostfwd=3D...' in=
stead.");
>=20
> How does this work for systems which have embedded ethernet
> devices and can't use -netdev ?

Of course it should work the same way as you currently can configure all
embedded ethernet devices:

 -net nic -net user,hostfwd=3D...

By the way, I think our documentation is really lacking some proper
description how to deal with on-board devices ...

> This is one reason I haven't bothered to update my scripts yet

-redir is likely not doing what you expect as soon as you are using two
or more (embedded or non-embedded) NICs on a machine, so you really
should not use that option anymore.

> The message also doesn't point out that if you were previously
> using -net + -redir you need to switch to -device + -netdev,
> since -net + -netdev doesn't work AFAIK.

I haven't tried, but I think you can also use:

 -netdev user,id=3Du1,hostfwd=3D... -net nic,netdev=3Du1

Or did you run into problems here?

Anyway, looks like we really have to improve our documentation about
"-net nic" ... yet another item for my TODO list (unless somebody else
wants to have a try)...

 Thomas
