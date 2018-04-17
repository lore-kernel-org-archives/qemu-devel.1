Received: from eggs.gnu.org ([2001:4830:134:3::10]:35694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1f8PTS-0000f3-Hs
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 08:12:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1f8PTR-0001sX-B7
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 08:12:38 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1521452376-25099-1-git-send-email-thuth@redhat.com>
Date: Tue, 17 Apr 2018 14:12:12 +0200
In-Reply-To: <1521452376-25099-1-git-send-email-thuth@redhat.com> (Thomas
	Huth's message of "Mon, 19 Mar 2018 10:39:36 +0100")
Message-ID: <87in8qf2w3.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [RFC PATCH] tests/device-introspect: Test devices
 with all machines, not only with "none"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Eduardo Habkost <ehabkost@redhat.com>

Thomas Huth <thuth@redhat.com> writes:

> Many device introspection crashes only happen if you are using a
> certain machine, e.g.:
>
> $ ppc-softmmu/qemu-system-ppc -S -M ref405ep,accel=qtest -qmp stdio
> {"QMP": {"version": {"qemu": {"micro": 50, "minor": 11, "major": 2},
>  "package": "build-all"}, "capabilities": []}}
> { 'execute': 'qmp_capabilities' }
> {"return": {}}
> { 'execute': 'device-list-properties',
>   'arguments': {'typename': 'macio-newworld'}}
> Unexpected error in qemu_chr_fe_init() at chardev/char-fe.c:222:
> Device 'serial0' is in use
> Aborted (core dumped)
>
> To be able to catch these problems, let's extend the device-introspect
> test to check the devices on all machine types. Since this is a rather
> slow operation, the test is only run in "SPEED=slow" mode.

If the device works with one machine type, it has a decent chance to
work with others, too.  Thus, testing each device with every machine
type is overkill.  I appreciate having overkill as an option :)

What I'd like to see for a quick "make check" is testing each device
once.  That should flush out most bugs.  

> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  In case someone wants to help with creating some bug fix patches
>  during the QEMU hard freeze phase: This test can now be used to
>  trigger lots of introspection bugs that we were not aware of yet.
>  I think most of the bugs are due to wrong handling of instance_init
>  vs. realize functions.

Yes, that's a common class of bugs.  There's little guidance on what
kind of work belongs where, and plenty of bad examples.  Some of the bad
examples crash (as you found).  Some work fine, typically because the
device doesn't support unplug.

Bad examples breed more bad code, so we better fix them all.  The ones
that work are harder to find...
