Received: from eggs.gnu.org ([2001:4830:134:3::10]:49621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cqcFy-0000QM-0D
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 05:08:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cqcFt-0005gi-PG
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 05:08:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55930)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cqcFt-0005gQ-JY
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 05:08:33 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 22 Mar 2017 10:08:30 +0100
Message-ID: <87bmstu19t.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] Minimum RAM size for PC machines?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: seabios@seabios.org, =?utf-8?B?TMOhc3psw7Mgw4lyc2Vr?= <lersek@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

Last time I checked[1], SeaBIOS required 1MiB of RAM, and the failure
modes were mean.

Back then, I asked whether we should enforce a suitable minimum RAM
size[2].  Peter Maydell replied that modelling RAM constraints involves
an expedition into the Generality Swamps, and wished me better luck than
he had.

Four and a half years later, the failure modes are as mean as ever.  For
instance,

    $ qemu-system-x86_64 --nodefaults -device VGA -m 640k

simply hangs for me, and

    $ qemu-system-x86_64 --nodefaults -device VGA -m 16k

crashes with "qemu: fatal: Trying to execute code outside RAM or ROM at
0x0000000000004000" and a register dump with TCG, or the even less
helpful "KVM internal error. Suberror: 1" with KVM.

Waiting for "someone" to design and implement the completely general
solution has had the predictable result: nothing.

Are we now ready to accept a simple & stupid patch that actually helps
users, say letting boards that care declare minimum and maximum RAM
size?  And make PC reject RAM size less than 1MiB, even though "someone"
might conceivably have firmware that works with less?



[1] Message-ID: <87fw7xwqkq.fsf@blackfin.pond.sub.org>
https://www.seabios.org/pipermail/seabios/2012-August/004343.html
[2] Message-ID: <87wr1921rd.fsf@blackfin.pond.sub.org>
https://lists.gnu.org/archive/html/qemu-devel/2012-08/msg01319.html
