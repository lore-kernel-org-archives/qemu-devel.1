Received: from eggs.gnu.org ([209.51.188.92]:47598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wainersm@redhat.com>) id 1goYPK-00036E-OX
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 13:46:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wainersm@redhat.com>) id 1goYPJ-0007tb-SK
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 13:46:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41614)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1goYPH-0007kX-UJ
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 13:46:48 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E242D1B8A
	for <qemu-devel@nongnu.org>; Tue, 29 Jan 2019 18:46:33 +0000 (UTC)
References: <20190128174725.8809-1-ccarrara@redhat.com>
	<20190128174725.8809-3-ccarrara@redhat.com>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <b7accb3f-db58-66e5-4874-4244cab4092a@redhat.com>
Date: Tue, 29 Jan 2019 16:46:27 -0200
MIME-Version: 1.0
In-Reply-To: <20190128174725.8809-3-ccarrara@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/2] Acceptance tests: add simple
 migration test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Caio Carrara <ccarrara@redhat.com>, qemu-devel@nongnu.org
Cc: philmd@redhat.com, ehabkost@redhat.com, crosa@redhat.com


On 01/28/2019 03:47 PM, Caio Carrara wrote:
> From: Cleber Rosa <crosa@redhat.com>
>
> This is the simplest possible migration test, exercising the multi
> VM capabilities of the test class.
>
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>   tests/acceptance/migration.py | 45 ++++++++++++++++++++++++++++++++++=
+
>   1 file changed, 45 insertions(+)
>   create mode 100644 tests/acceptance/migration.py
>
> diff --git a/tests/acceptance/migration.py b/tests/acceptance/migration=
.py
> new file mode 100644
> index 0000000000..973ae0ab4b
> --- /dev/null
> +++ b/tests/acceptance/migration.py
> @@ -0,0 +1,45 @@
> +# Migration test
> +#
> +# Copyright (c) 2019 Red Hat, Inc.
> +#
> +# Author:
> +#  Cleber Rosa <crosa@redhat.com>
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2 or
> +# later.  See the COPYING file in the top-level directory.
> +
> +
> +from avocado_qemu import Test
> +
> +from avocado.utils import network
> +from avocado.utils import wait
> +
> +
> +class Migration(Test):
> +    """
> +    :avocado: enable
> +    """
> +
> +    timeout =3D 10
> +
> +    @staticmethod
> +    def migration_completed(vm):
> +        cmd_result =3D vm.qmp('query-migrate')
> +        if cmd_result is not None:
> +            result =3D cmd_result.get('return')
> +            if result is not None:
> +                return result.get('status') =3D=3D 'completed'

You could verify other status that indicate failure on the migration to=20
nicely fail the test, because the printed messaged on timeout does not=20
help much to identify what went wrong.

It could be something like:

-=C2=A0=C2=A0=C2=A0 @staticmethod
-=C2=A0=C2=A0=C2=A0 def migration_completed(vm):
+=C2=A0=C2=A0=C2=A0 def migration_completed(self, vm):
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cmd_result =3D vm.qmp('=
query-migrate')
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if cmd_result is not No=
ne:
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 result =3D cmd_result.get('return')
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 if result is not None:
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 self.assertNotEqual(result.get('status'), 'failed')
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 return result.get('status') =3D=3D 'completed'
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return False


> +        return False
> +
> +    def test_tcp(self):

What if you rename it to something like "test_with_tcp_on_localhost" to=20
better represent the test scenario?

- Wainer

> +        source =3D self.get_vm()
> +        port =3D network.find_free_port()
> +        if port is None:
> +            self.cancel('Failed to find a free port')
> +        dest_uri =3D 'tcp:localhost:%u' % port
> +        dest =3D self.get_vm('-incoming', dest_uri)
> +        dest.launch()
> +        source.launch()
> +        source.qmp('migrate', uri=3Ddest_uri)
> +        wait.wait_for(self.migration_completed, timeout=3Dself.timeout=
,
> +                      step=3D0.1, args=3D(source,))
