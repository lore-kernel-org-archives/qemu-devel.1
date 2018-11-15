Received: from eggs.gnu.org ([2001:4830:134:3::10]:44440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gscrivan@redhat.com>) id 1gNKpL-0007fI-VV
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 11:49:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gscrivan@redhat.com>) id 1gNKpL-0003br-2m
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 11:49:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55552)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <gscrivan@redhat.com>) id 1gNKpK-0003b2-Tc
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 11:49:11 -0500
From: Giuseppe Scrivano <gscrivan@redhat.com>
References: <20181114123643.24091-1-marcandre.lureau@redhat.com>
	<20181114134503.GO19298@redhat.com>
Date: Thu, 15 Nov 2018 17:49:07 +0100
In-Reply-To: <20181114134503.GO19298@redhat.com> ("Daniel P. =?utf-8?Q?Ber?=
	=?utf-8?Q?rang=C3=A9=22's?=
	message of "Wed, 14 Nov 2018 13:45:03 +0000")
Message-ID: <875zwycmm4.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.2 00/41] RFC: slirp: make it again a
 standalone project
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>, qemu-devel@nongnu.org, samuel.thibault@ens-lyon.org, rjones@redhat.com, stefanha@redhat.com, renzo@cs.unibo.it, Akihiro Suda <suda.kyoto@gmail.com>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Wed, Nov 14, 2018 at 04:36:02PM +0400, Marc-Andr=C3=A9 Lureau wrote:
>> Hi,
>>=20
>> Based-on: https://people.debian.org/~sthibault/qemu.git/ slirp branch
>>=20
>> This series goal is to allow building libslirp as an independent library.

Marc-Andr=C3=A9, thanks for working on this!


> At least half of the patches in this series are deleting unused or
> unreachable code. I'd suggest you send all of those as a non-RFC
> series, as they are things we could merge straight away regardless
> of whether/when slirp becomes a separate library.
>
>> While looking at making SLIRP a seperate running process, I thought
>> that having an independent library from QEMU would be a first step.
>>=20
>> There has been some attempts to make slirp a seperate project in the pas=
t.
>> (https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg01092.html)
>> Unfortunately, they forked from QEMU and didn't provide enough
>> compatibility for QEMU to make use of it (in particular, vmstate
>> handling was removed, they lost git history etc). Furthermore, they
>> are not maintained as far as I can see.
>
> More recently there is this fun project which just pulled in the
> QEMU code and chopped out everything todo with slirp:
>
>   https://github.com/rootless-containers/slirp4netns

to give a little bit of background on slirp4netns:

slirp4netns is used for setting up the network in a network namespace
without requiring root privileges.

It is already used by Podman and Buildah to set up the network for
rootless containers, so they won't be limited to run in the host network
namespace or require a suid helper.

Coincidentally just today I was working on a slirp4netns change for
spawning a QEMU process instead of using the forked version.
I'd prefer to not rely on the slirp forked version, but this costs the
access to the underlying knobs.  With a separate libslirp project, this
is not needed anymore.

One change I am aware of in the forked version is the possibility to
tweak the MTU and AFAIK this is the only blocker from adopting libslirp
immediately.
Akihiro, is there anything more that could block slirp4netns from just
using libslirp once it is available?

Regards,
Giuseppe
