Received: from eggs.gnu.org ([2001:4830:134:3::10]:37994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dFJ2Q-0001AG-Ts
	for qemu-devel@nongnu.org; Mon, 29 May 2017 07:40:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dFJ2M-0008Um-9A
	for qemu-devel@nongnu.org; Mon, 29 May 2017 07:40:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51786)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dFJ2M-0008Ue-2u
	for qemu-devel@nongnu.org; Mon, 29 May 2017 07:40:38 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0E5DFC04B321
	for <qemu-devel@nongnu.org>; Mon, 29 May 2017 11:40:37 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170513033316.22395-1-ehabkost@redhat.com>
	<20170513033316.22395-2-ehabkost@redhat.com>
	<87d1az64ab.fsf@dusky.pond.sub.org>
	<20170525180426.GR32274@thinpad.lan.raisama.net>
Date: Mon, 29 May 2017 13:40:33 +0200
In-Reply-To: <20170525180426.GR32274@thinpad.lan.raisama.net> (Eduardo
	Habkost's message of "Thu, 25 May 2017 15:04:26 -0300")
Message-ID: <874lw37uxa.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 1/3] qemu.py: Don't set _popen=None on
 error/shutdown
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Marcel Apfelbaum <marcel@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org

Eduardo Habkost <ehabkost@redhat.com> writes:

> On Tue, May 23, 2017 at 04:23:08PM +0200, Markus Armbruster wrote:
>> Eduardo Habkost <ehabkost@redhat.com> writes:
>> 
>> > Keep the Popen object around to we can query its exit code later.
>> >
>> > To keep the existing 'self._popen is None' checks working, add a
>> > is_running() method, that will check if the process is still running.
>> >
>> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
>> 
>> Looks harmless enough.  Have you tested the scripts using this module
>> still work?
>
> Now I did. :)
>
> I see only two users of qemu.py and qtest.py:
>
>   tests/migration/guestperf/engine.py:import qemu
>   tests/qemu-iotests/iotests.py:import qtest
>
> I just tested both using:
>
>   $ make check-tests/qemu-iotests-quick.sh
>   $ make tests/migration/initrd-stress.img PTHREAD_LIB=-pthread
>   $ ./tests/migration/guestperf.py > /tmp/guestperf.json
>
> and they seem to be working.

Thanks!

> (It looks like there's no Makefile rule to run guestperf.py)
>
> BTW, it seems to be impossible to build initrd-stress.img on a out-of-tree
> build.  I had to run ./configure inside the source tree to be able to run
> guestperf.py.

I consider that a bug.  But it's clearly not one you need to fix to get
your series accepted.
