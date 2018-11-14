Received: from eggs.gnu.org ([2001:4830:134:3::10]:48935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gMvIl-0004Lt-Q9
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 08:33:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gMvIj-0002zu-V4
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 08:33:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52412)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gMvIj-0002v6-Lv
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 08:33:49 -0500
References: <20181114123643.24091-1-marcandre.lureau@redhat.com>
	<871s7nstle.fsf@dusky.pond.sub.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <e935a267-a5ae-4dd4-a1a7-064c084671ab@redhat.com>
Date: Wed, 14 Nov 2018 14:33:32 +0100
MIME-Version: 1.0
In-Reply-To: <871s7nstle.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: samuel.thibault@ens-lyon.org, renzo@cs.unibo.it, qemu-devel@nongnu.org, stefanha@redhat.com, rjones@redhat.com, Jan Kiszka <jan.kiszka@siemens.com>

On 2018-11-14 13:59, Markus Armbruster wrote:
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>=20
>> Hi,
>>
>> Based-on: https://people.debian.org/~sthibault/qemu.git/ slirp branch
>>
>> This series goal is to allow building libslirp as an independent libra=
ry.
>>
>> While looking at making SLIRP a seperate running process, I thought
>> that having an independent library from QEMU would be a first step.
>>
>> There has been some attempts to make slirp a seperate project in the p=
ast.
>> (https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg01092.html)
>> Unfortunately, they forked from QEMU and didn't provide enough
>> compatibility for QEMU to make use of it (in particular, vmstate
>> handling was removed, they lost git history etc). Furthermore, they
>> are not maintained as far as I can see.
>>
>> I would propose to make slirp a seperate project, that can initially
>> be used by QEMU as a submodule, keeping Makefile.objs until a proper
>> shared library with stability guarantees etc is ready..
>>
>> The subproject could created by preserving git tags, and cleaning up t=
he code style, this way:
>>
>> git filter-branch --tree-filter "if ls * 1> /dev/null 2>&1; then clang=
-format -i * /dev/null; fi " -f --subdirectory-filter "slirp" --prune-emp=
ty --tag-name-filter cat -- --all
>> (my clang-format https://gist.github.com/elmarco/cb20c8d92007df0e2fb8a=
2404678ac73)
>>
>> What do you think?
>=20
> Has the slirp code been improved to be generally useful?  I still got i=
t
> filed under "friends don't let friends use that, except for testing"...

The slirp code is already used in a lot of other projects:

- WinUAE
  (https://github.com/tonioni/WinUAE/tree/master/slirp)

- Previous
  (https://sourceforge.net/p/previous/code/HEAD/tree/trunk/src/slirp/)

- BasiliskII
  (https://github.com/cebix/macemu/tree/master/BasiliskII/src/slirp)

- Bochs

(https://sourceforge.net/p/bochs/code/HEAD/tree/trunk/bochs/iodev/network=
/slirp/)

... and likely many more. AFAIK they all (or at least most) have been
forked from the QEMU code at one point in time and diverged, i.e. they
likely missed the bug fixes and new features that have been added in
QEMU (like IPv6). So yes, IMHO it makes a lot of sense to try to make a
separate library out of the slirp code again, especially if we could
convince the other projects to use it, too, and to collaborate on that
version.

 Thomas
