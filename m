Received: from eggs.gnu.org ([2001:4830:134:3::10]:50997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fuddB-0002xP-Hb
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 09:02:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fudQB-0007Fp-JE
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 08:48:36 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20180809213528.14738-8-mreitz@redhat.com>
References: <20180809213528.14738-1-mreitz@redhat.com>
	<20180809213528.14738-8-mreitz@redhat.com>
Date: Tue, 28 Aug 2018 14:48:28 +0200
Message-ID: <w51d0u2sllv.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-3.1 v10 07/31] iotests.py: Add
 node_info()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>

On Thu 09 Aug 2018 11:35:04 PM CEST, Max Reitz wrote:
> This function queries a node; since we cannot do that right now, it
> executes query-named-block-nodes and returns the matching node's object.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/qemu-iotests/iotests.py | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
> index 5c45788dac..6583001ac8 100644
> --- a/tests/qemu-iotests/iotests.py
> +++ b/tests/qemu-iotests/iotests.py
> @@ -465,6 +465,16 @@ class VM(qtest.QEMUQtestMachine):
>                  else:
>                      iotests.log(ev)
>  
> +    def node_info(self, node_name, require_existence=True):
> +        nodes = self.qmp('query-named-block-nodes')
> +        for x in nodes['return']:
> +            if x['node-name'] == node_name:
> +                return x
> +        if require_existence:
> +            assert False
> +        else:
> +            return None
> +

I don't think you need the require_existence parameter here... if you
simply return None you'll get an error as soon as you try to use the
return value.

Berto
