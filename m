Received: from eggs.gnu.org ([2001:4830:134:3::10]:57010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fO8XT-0000sp-GG
	for qemu-devel@nongnu.org; Wed, 30 May 2018 17:21:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fO8XP-00075p-Ec
	for qemu-devel@nongnu.org; Wed, 30 May 2018 17:21:47 -0400
Received: from mail-ua0-x244.google.com ([2607:f8b0:400c:c08::244]:34185)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fO8XP-00075W-Ag
	for qemu-devel@nongnu.org; Wed, 30 May 2018 17:21:43 -0400
Received: by mail-ua0-x244.google.com with SMTP id 74-v6so3105898uav.1
	for <qemu-devel@nongnu.org>; Wed, 30 May 2018 14:21:43 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180530184156.15634-1-crosa@redhat.com>
	<20180530184156.15634-4-crosa@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <42cfbaf3-c13c-b43f-3ea0-026852c5f1be@amsat.org>
Date: Wed, 30 May 2018 18:21:39 -0300
MIME-Version: 1.0
In-Reply-To: <20180530184156.15634-4-crosa@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 3/5] Acceptance tests: add quick VNC
 tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Amador Pahim <amador@pahim.org>

On 05/30/2018 03:41 PM, Cleber Rosa wrote:
> This patch adds a few simple behavior tests for VNC.
> 
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  tests/acceptance/vnc.py | 60 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
>  create mode 100644 tests/acceptance/vnc.py
> 
> diff --git a/tests/acceptance/vnc.py b/tests/acceptance/vnc.py
> new file mode 100644
> index 0000000000..b1ef9d71b1
> --- /dev/null
> +++ b/tests/acceptance/vnc.py
> @@ -0,0 +1,60 @@
> +# Simple functional tests for VNC functionality
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
> +class Vnc(Test):
> +    """
> +    :avocado: enable
> +    :avocado: tags=vnc,quick
> +    """
> +    def test_no_vnc(self):
> +        self.vm.add_args('-nodefaults', '-S')
> +        self.vm.launch()
> +        self.assertFalse(self.vm.qmp('query-vnc')['return']['enabled'])
> +
> +    def test_no_vnc_change_password(self):
> +        self.vm.add_args('-nodefaults', '-S')
> +        self.vm.launch()
> +        self.assertFalse(self.vm.qmp('query-vnc')['return']['enabled'])
> +        set_password_response = self.vm.qmp('change',
> +                                            device='vnc',
> +                                            target='password',
> +                                            arg='new_password')
> +        self.assertIn('error', set_password_response)
> +        self.assertEqual(set_password_response['error']['class'],
> +                         'GenericError')
> +        self.assertEqual(set_password_response['error']['desc'],
> +                         'Could not set password')
> +
> +    def test_vnc_change_password_requires_a_password(self):
> +        self.vm.add_args('-nodefaults', '-S', '-vnc', ':0')
> +        self.vm.launch()
> +        self.assertTrue(self.vm.qmp('query-vnc')['return']['enabled'])
> +        set_password_response = self.vm.qmp('change',
> +                                            device='vnc',
> +                                            target='password',
> +                                            arg='new_password')
> +        self.assertIn('error', set_password_response)
> +        self.assertEqual(set_password_response['error']['class'],
> +                         'GenericError')
> +        self.assertEqual(set_password_response['error']['desc'],
> +                         'Could not set password')
> +
> +    def test_vnc_change_password(self):
> +        self.vm.add_args('-nodefaults', '-S', '-vnc', ':0,password')
> +        self.vm.launch()
> +        self.assertTrue(self.vm.qmp('query-vnc')['return']['enabled'])
> +        set_password_response = self.vm.qmp('change',
> +                                            device='vnc',
> +                                            target='password',
> +                                            arg='new_password')
> +        self.assertEqual(set_password_response['return'], {})
> 
