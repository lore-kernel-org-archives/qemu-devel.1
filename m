Received: from eggs.gnu.org ([2001:4830:134:3::10]:49953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <etienne.duble@imag.fr>) id 1gNeaR-00024A-L7
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 08:55:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <etienne.duble@imag.fr>) id 1gNeaO-0007zV-0W
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 08:55:07 -0500
Received: from zm-mta-out-1.u-ga.fr ([152.77.200.56]:53890)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <etienne.duble@imag.fr>)
	id 1gNeaN-0007yZ-MI
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 08:55:03 -0500
From: =?UTF-8?Q?Etienne_Dubl=c3=a9?= <etienne.duble@imag.fr>
Message-ID: <04fcf478-29c3-67be-74bb-fd26975fe441@imag.fr>
Date: Fri, 16 Nov 2018 14:55:01 +0100
MIME-Version: 1.0
Content-Language: fr
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] qemu-user performance
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hello,
Please forgive my little knowledge about qemu internals.
Some time ago I had an idea that might improve usage of qemu user mode=20
(I believe) and I would like to get your thoughts about it.
Context: qemu-user is used by more and more people to run containers=20
(e.g. docker) based on a different CPU architecture (e.g. the OS of a=20
raspberry pi). With linux kernel module "binfmt_misc", the emulation is=20
handled transparently by qemu. Usually, a shell session will be run=20
first, and then many subprocesses. And of course, each of these=20
processes is actually a qemu process running in "user-mode". For=20
example, if one types "make" to compile some code, there will be a "qemu=20
make" process, then probably 10 or more "qemu gcc" processes, etc. Since=20
all of these are different qemu processes, they do not share any=20
knowledge, so each time a new one is spawn, it has to translate the=20
binary code of libc, ld-linux, any other library it uses, its own binary=20
code, etc. When it ends, all this work is lost, and new processes will=20
have to reprocess a big part of the very same code over and over again.
So the idea is: what if we could share the cache of code already=20
translated between all those processes?
There would be sereral ways to achieve this:
* use a shared memory area for the cache, and locking mechanisms.
* have a (maybe optional) daemon that would manage the cache of all=20
processes.
* python-like model: the first time a binary or library is translated,=20
save this translated code in a cache file next to the original file,=20
with different extension.
Please let me know what you think about it, if something similar has=20
already been studied, or if I miss something obvious.
Thanks
Etienne

--=20
Etienne Dubl=C3=A9
CNRS / LIG - B=C3=A2timent IMAG
700 avenue Centrale - 38401 St Martin d'H=C3=A8res
Bureau 426 - Tel 0457421431
