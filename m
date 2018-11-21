Received: from eggs.gnu.org ([2001:4830:134:3::10]:60863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gPUmg-0007r3-Gw
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 10:51:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gPUmc-0000nM-EQ
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 10:51:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59338)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gPUma-0000aq-Iq
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 10:51:16 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AB18A58A5A
	for <qemu-devel@nongnu.org>; Wed, 21 Nov 2018 15:51:14 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20181121134151.23993-1-crosa@redhat.com>
	<20181121134151.23993-2-crosa@redhat.com>
Date: Wed, 21 Nov 2018 16:50:49 +0100
In-Reply-To: <20181121134151.23993-2-crosa@redhat.com> (Cleber Rosa's message
	of "Wed, 21 Nov 2018 08:41:51 -0500")
Message-ID: <87pnuy1lba.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 1/1] Acceptance tests: add test for
 set-numa-node error handler fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Philippe =?utf-8?Q?Mathieu-D?= =?utf-8?Q?aud=C3=A9?= <pmathieu@redhat.com>, Caio Carrara <ccarrara@redhat.com>, Igor Mammedov <imammedo@redhat.com>

Cleber Rosa <crosa@redhat.com> writes:

> Commit a22528b918 fixed an issue that is exposed by means of the
> "set-numa-node" QMP command (introduced in f3be67812).  This adds a
> test that pretty much maps the steps documented on the fix.
>
> Additionally, given that 'set-numa-node' is only allowed in
> 'preconfig' state, a specific check for that was added a separate
> test.
>
> Tests: a22528b918c7d29795129b5a64c4cb44bb57a44d
> Reference: f3be67812c226162f86ce92634bd913714445420
> CC: Igor Mammedov <imammedo@redhat.com>
> CC: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>  tests/acceptance/set_numa_node.py | 41 +++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>  create mode 100644 tests/acceptance/set_numa_node.py
>
> diff --git a/tests/acceptance/set_numa_node.py b/tests/acceptance/set_numa_node.py
> new file mode 100644
> index 0000000000..0c55315231
> --- /dev/null
> +++ b/tests/acceptance/set_numa_node.py
> @@ -0,0 +1,41 @@
> +# Tests for QMP set-numa-node related behavior and regressions
> +#
> +# Copyright (c) 2018 Red Hat, Inc.
> +#
> +# Author:
> +#  Cleber Rosa <crosa@redhat.com>
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2 or
> +# later.  See the COPYING file in the top-level directory.
> +
> +from avocado_qemu import Test
> +
> +
> +class SetNumaNode(Test):
> +    """
> +    :avocado: enable
> +    :avocado: tags=quick,numa
> +    """
> +    def test_numa_not_supported(self):
> +        self.vm.add_args('-nodefaults', '-S', '-preconfig')
> +        self.vm.set_machine('none')
> +        self.vm.launch()
> +        res = self.vm.qmp('set-numa-node', type='node')
> +        self.assertIsNotNone(res, 'Unexpected empty QMP response to "set-numa-node"')
> +        self.assertEqual(res['error']['class'], 'GenericError')
> +        self.assertEqual(res['error']['desc'],
> +                         'NUMA is not supported by this machine-type')

Checking the QMP command fails a certain way takes you four lines[*].
Such checks are pretty common in tests using QMP.  Consider creating a
convenience method.

> +        self.assertTrue(self.vm.is_running())
> +        self.vm.qmp('x-exit-preconfig')
> +        self.vm.shutdown()
> +        self.assertEqual(self.vm.exitcode(), 0)
> +
> +    def test_no_preconfig(self):
> +        self.vm.add_args('-nodefaults', '-S')
> +        self.vm.set_machine('none')
> +        self.vm.launch()
> +        res = self.vm.qmp('set-numa-node', type='node')
> +        self.assertIsNotNone(res, 'Unexpected empty QMP response to "set-numa-node"')
> +        self.assertEqual(res['error']['class'], 'GenericError')
> +        self.assertEqual(res['error']['desc'],
> +                         "The command is permitted only in 'preconfig' state")

The test looks good to me.

It could also be done as a qtest in C.  Do we have guidance on when to
use C / qtest and when to use Python / Avocado?

One possible argument for using Python more could be "tests are cheaper
to create and easier to debug that way".  Do we have evidence for that,
or at least gut feelings?

A possible argument against using Python could be much slower "make
check".  I have no idea whether that's actually the case.

Non-argument: requiring Avocado as a build dependency for testing.  I
think that's totally fine as long as it's readily available on all our
supported host platforms.  Same as for any other build dependency,
really.


[*] Would be more if you additionally checked res['error'] exists and is
a dictionary.  I'm not saying you should, just that checking @res isn't
None feels odd to me unless you do.
