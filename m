Received: from eggs.gnu.org ([2001:4830:134:3::10]:55462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dAoSk-0004ev-Bd
	for qemu-devel@nongnu.org; Tue, 16 May 2017 22:13:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dAoSj-0000Fu-6N
	for qemu-devel@nongnu.org; Tue, 16 May 2017 22:13:18 -0400
Date: Wed, 17 May 2017 10:13:02 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170517021302.GF27669@lemon.lan>
References: <20170505102153.758-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170505102153.758-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] iotests: 147: Don't test inet6 if not
 available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Fri, 05/05 18:21, Fam Zheng wrote:
> This is the case in our docker tests, as we use --net=none there. Skip
> this method.

Ping. Is this patch okay?

> 
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  tests/qemu-iotests/147 | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/tests/qemu-iotests/147 b/tests/qemu-iotests/147
> index 32afea6..db34838 100755
> --- a/tests/qemu-iotests/147
> +++ b/tests/qemu-iotests/147
> @@ -147,6 +147,13 @@ class BuiltinNBD(NBDBlockdevAddBase):
>          self._server_down()
>  
>      def test_inet6(self):
> +        try:
> +            socket.getaddrinfo("::0", "0", socket.AF_INET6,
> +                               socket.SOCK_STREAM, socket.IPPROTO_TCP,
> +                               socket.AI_ADDRCONFIG | socket.AI_CANONNAME)
> +        except socket.gaierror:
> +            # IPv6 not available, skip
> +            return
>          address = { 'type': 'inet',
>                      'data': {
>                          'host': '::1',
> -- 
> 2.9.3
> 
> 
