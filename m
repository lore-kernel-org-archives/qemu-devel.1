Received: from eggs.gnu.org ([2001:4830:134:3::10]:51621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fn3J2-00055f-PV
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 10:49:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fn3J2-0002EF-0o
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 10:49:52 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20180628000745.4477-8-mreitz@redhat.com>
References: <20180628000745.4477-1-mreitz@redhat.com>
	<20180628000745.4477-8-mreitz@redhat.com>
Date: Tue, 07 Aug 2018 16:49:42 +0200
Message-ID: <w51wot28c55.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v9 07/31] iotests.py: Add
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

On Thu 28 Jun 2018 02:07:21 AM CEST, Max Reitz wrote:
> This function queries a node; since we cannot do that right now, it
> executes query-named-block-nodes and returns the matching node's object.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/qemu-iotests/iotests.py | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
> index 5c45788dac..3b18907f6a 100644
> --- a/tests/qemu-iotests/iotests.py
> +++ b/tests/qemu-iotests/iotests.py
> @@ -465,6 +465,13 @@ class VM(qtest.QEMUQtestMachine):
>                  else:
>                      iotests.log(ev)
>  
> +    def node_info(self, node_name):
> +        nodes = self.qmp('query-named-block-nodes')
> +        for x in nodes['return']:
> +            if x['node-name'] == node_name:
> +                return x
> +        assert False
> +

There are cases in which you want to verify that a node doesn't exist
anymore (e.g. after you have removed it), so it would be nice to return
None if the node doesn't exist.

I actually have a similar function (minus the "return None" part) in one
of my tests from the blockdev-reopen series, so I could make use of this
one instead.

Berto
