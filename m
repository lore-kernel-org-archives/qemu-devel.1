Received: from eggs.gnu.org ([2001:4830:134:3::10]:50431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ey1XF-0005Rj-3x
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 16:37:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ey1XE-0002Xr-8b
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 16:37:37 -0400
Date: Mon, 19 Mar 2018 17:37:28 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180319203728.GT3417@localhost.localdomain>
References: <1521452376-25099-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521452376-25099-1-git-send-email-thuth@redhat.com>
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
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org

On Mon, Mar 19, 2018 at 10:39:36AM +0100, Thomas Huth wrote:
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
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  In case someone wants to help with creating some bug fix patches
>  during the QEMU hard freeze phase: This test can now be used to
>  trigger lots of introspection bugs that we were not aware of yet.
>  I think most of the bugs are due to wrong handling of instance_init
>  vs. realize functions.
[...]

This looks very useful, thanks!

I wonder if we could have something that would make it simpler
for us to cover more command-line combinations + QMP commands in
simple "validate output and check if QEMU won't crash" test cases
without writing extra C or Python code every time.

device-crash-test could be used for that, but I'd like to make it
simpler to extend.

-- 
Eduardo
