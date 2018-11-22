Received: from eggs.gnu.org ([2001:4830:134:3::10]:48510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wainersm@redhat.com>) id 1gPnxC-0004b4-P6
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 07:19:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wainersm@redhat.com>) id 1gPnx8-0006iC-LX
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 07:19:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:62313)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1gPnx8-0006dr-Cf
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 07:19:26 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id ACEE25F787
	for <qemu-devel@nongnu.org>; Thu, 22 Nov 2018 12:19:24 +0000 (UTC)
References: <20181121134151.23993-1-crosa@redhat.com>
	<20181121134151.23993-2-crosa@redhat.com>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <6a0de6d4-8b53-4f8b-0b69-0841e1421e41@redhat.com>
Date: Thu, 22 Nov 2018 10:19:21 -0200
MIME-Version: 1.0
In-Reply-To: <20181121134151.23993-2-crosa@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
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
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <pmathieu@redhat.com>, Caio Carrara <ccarrara@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>


On 11/21/2018 11:41 AM, Cleber Rosa wrote:
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
>   tests/acceptance/set_numa_node.py | 41 +++++++++++++++++++++++++++++++
>   1 file changed, 41 insertions(+)
>   create mode 100644 tests/acceptance/set_numa_node.py
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

There is a qtest suite of tests for NUMA configuration on 
tests/numa-test.c, including one simple test for set-numa-node (pulled 
in as https://lists.gnu.org/archive/html/qemu-devel/2018-05/msg06930.html).

So did you consider to include those cases of test on tests/numa-test.c 
instead?

- Wainer
