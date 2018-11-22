Received: from eggs.gnu.org ([2001:4830:134:3::10]:39549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gPqyF-0004UU-7A
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 10:32:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gPqyA-000370-MA
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 10:32:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50856)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1gPqyA-00033p-8i
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 10:32:42 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 69C887AE99
	for <qemu-devel@nongnu.org>; Thu, 22 Nov 2018 15:32:40 +0000 (UTC)
References: <20181121134151.23993-1-crosa@redhat.com>
	<20181121134151.23993-2-crosa@redhat.com>
	<6a0de6d4-8b53-4f8b-0b69-0841e1421e41@redhat.com>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <59c939c0-9f2d-3aa0-5cd7-75c36c2f2575@redhat.com>
Date: Thu, 22 Nov 2018 10:32:35 -0500
MIME-Version: 1.0
In-Reply-To: <6a0de6d4-8b53-4f8b-0b69-0841e1421e41@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
To: Wainer dos Santos Moschetta <wainersm@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <pmathieu@redhat.com>, Caio Carrara <ccarrara@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>



On 11/22/18 7:19 AM, Wainer dos Santos Moschetta wrote:
>=20
> On 11/21/2018 11:41 AM, Cleber Rosa wrote:
>> Commit a22528b918 fixed an issue that is exposed by means of the
>> "set-numa-node" QMP command (introduced in f3be67812).=C2=A0 This adds=
 a
>> test that pretty much maps the steps documented on the fix.
>>
>> Additionally, given that 'set-numa-node' is only allowed in
>> 'preconfig' state, a specific check for that was added a separate
>> test.
>>
>> Tests: a22528b918c7d29795129b5a64c4cb44bb57a44d
>> Reference: f3be67812c226162f86ce92634bd913714445420
>> CC: Igor Mammedov <imammedo@redhat.com>
>> CC: Markus Armbruster <armbru@redhat.com>
>> Signed-off-by: Cleber Rosa <crosa@redhat.com>
>> ---
>> =C2=A0 tests/acceptance/set_numa_node.py | 41 ++++++++++++++++++++++++=
+++++++
>> =C2=A0 1 file changed, 41 insertions(+)
>> =C2=A0 create mode 100644 tests/acceptance/set_numa_node.py
>>
>> diff --git a/tests/acceptance/set_numa_node.py
>> b/tests/acceptance/set_numa_node.py
>> new file mode 100644
>> index 0000000000..0c55315231
>> --- /dev/null
>> +++ b/tests/acceptance/set_numa_node.py
>> @@ -0,0 +1,41 @@
>> +# Tests for QMP set-numa-node related behavior and regressions
>> +#
>> +# Copyright (c) 2018 Red Hat, Inc.
>> +#
>> +# Author:
>> +#=C2=A0 Cleber Rosa <crosa@redhat.com>
>> +#
>> +# This work is licensed under the terms of the GNU GPL, version 2 or
>> +# later.=C2=A0 See the COPYING file in the top-level directory.
>> +
>> +from avocado_qemu import Test
>> +
>> +
>> +class SetNumaNode(Test):
>> +=C2=A0=C2=A0=C2=A0 """
>> +=C2=A0=C2=A0=C2=A0 :avocado: enable
>> +=C2=A0=C2=A0=C2=A0 :avocado: tags=3Dquick,numa
>> +=C2=A0=C2=A0=C2=A0 """
>> +=C2=A0=C2=A0=C2=A0 def test_numa_not_supported(self):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.vm.add_args('-nodefau=
lts', '-S', '-preconfig')
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.vm.set_machine('none'=
)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.vm.launch()
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 res =3D self.vm.qmp('set-n=
uma-node', type=3D'node')
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assertIsNotNone(res, =
'Unexpected empty QMP response to
>> "set-numa-node"')
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assertEqual(res['erro=
r']['class'], 'GenericError')
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assertEqual(res['erro=
r']['desc'],
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 'NUMA is not supported by this machine-type')
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assertTrue(self.vm.is=
_running())
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.vm.qmp('x-exit-precon=
fig')
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.vm.shutdown()
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assertEqual(self.vm.e=
xitcode(), 0)
>> +
>> +=C2=A0=C2=A0=C2=A0 def test_no_preconfig(self):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.vm.add_args('-nodefau=
lts', '-S')
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.vm.set_machine('none'=
)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.vm.launch()
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 res =3D self.vm.qmp('set-n=
uma-node', type=3D'node')
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assertIsNotNone(res, =
'Unexpected empty QMP response to
>> "set-numa-node"')
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assertEqual(res['erro=
r']['class'], 'GenericError')
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assertEqual(res['erro=
r']['desc'],
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 "The command is permitted only in
>> 'preconfig' state")
>=20
> There is a qtest suite of tests for NUMA configuration on
> tests/numa-test.c, including one simple test for set-numa-node (pulled
> in as https://lists.gnu.org/archive/html/qemu-devel/2018-05/msg06930.ht=
ml).
>=20
> So did you consider to include those cases of test on tests/numa-test.c
> instead?
>=20
> - Wainer
>=20
>=20

Hi Wainer,

Thanks for the pointer.  Answering your question, I had not looked at
tests/numa-test.c while I was writing this.

Given that one of the points of this patch is to give more (real, useful
and practical) examples of how to write tests with this framework, I
think it was a good thing.

But, this type of question, the comparison of this type of test with
other types of tests in QEMU has been recurring, so I think we should
address the question with some kind of comparison/benefits/guidelines
write up in the near future.

- Cleber.
