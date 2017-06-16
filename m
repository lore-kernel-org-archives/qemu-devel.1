Received: from eggs.gnu.org ([2001:4830:134:3::10]:33145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dLm7W-0000xx-JA
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 03:56:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dLm7V-0006lA-F8
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 03:56:42 -0400
Date: Fri, 16 Jun 2017 15:56:27 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170616075627.GF21807@lemon.lan>
References: <5b2ec66b3434b98de0ef7d59fd8a1de09f966c1a.1497595807.git.maozy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b2ec66b3434b98de0ef7d59fd8a1de09f966c1a.1497595807.git.maozy.fnst@cn.fujitsu.com>
Subject: Re: [Qemu-devel] [PATCH v2] util: remove the obsolete non-blocking
 connect
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, quintela@redhat.com, mitake.hitoshi@lab.ntt.co.jp, jcody@redhat.com, mreitz@redhat.com, sheepdog@lists.wpkg.org, Cao jin <caoj.fnst@cn.fujitsu.com>, kraxel@redhat.com, pbonzini@redhat.com, namei.unix@gmail.com

On Fri, 06/16 15:31, Mao Zhongyi wrote:
> From: Cao jin <caoj.fnst@cn.fujitsu.com>
> 
> The non-blocking connect mechanism is obsolete, and it doesn't
> work well in inet connection, because it will call getaddrinfo
> first and getaddrinfo will blocks on DNS lookups. Since commit
> e65c67e4 & d984464e, the non-blocking connect of migration goes
> through QIOChannel in a different manner(using a thread), and
> nobody use this old non-blocking connect anymore.
> 
> Any newly written code which needs a non-blocking connect should
> use the QIOChannel code, so we can drop NonBlockingConnectHandler
> as a concept entirely.
> 
> Cc: mitake.hitoshi@lab.ntt.co.jp
> Cc: namei.unix@gmail.com
> Cc: jcody@redhat.com
> Cc: kwolf@redhat.com
> Cc: mreitz@redhat.com
> Cc: berrange@redhat.com
> Cc: kraxel@redhat.com
> Cc: pbonzini@redhat.com
> Cc: qemu-block@nongnu.org
> Cc: sheepdog@lists.wpkg.org
> Cc: famz@redhat.com
> Cc: quintela@redhat.com
> Suggested-by: Daniel P. Berrange <berrange@redhat.com>
> Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
> Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
> ---
> v2:
> 1. block/ssh.c is not compiled in v1 which leads to no error 
>    reported when I run make & make check, although I make a 
> 	mistake in block/ssh.c, because the package libssh2-devel 
> 	missed in my system. Now fixed it.
> 2. Write the prototype in a single line. [Juan Quintela]
> 
> Because it's a minor change, so still add the r-b.
> 
> v1:
> This patch was reviewed by Daniel about a years ago, but it has never
> been merged just since socket_connect() called by net_socket_connect_init()
> where NonBlockingConnectHandler was passed to socket_connect(). it's broken.
> 
> Now this problem was worked around by Daniel's patch(commit 6701e551 'Revert
> "Change net/socket.c to use socket_*() functions" again'). Therefore, resend
> it, of course, part of related code has changed over the years, so changed
> the patch accordingly.
> 
> The reviewed patch listed on:
> https://lists.gnu.org/archive/html/qemu-devel/2016-07/msg06373.html
> 
>  --help                 |   0
>  block/sheepdog.c       |   2 +-
>  block/ssh.c            |   2 +-
>  include/qemu/sockets.h |  12 +--
>  io/channel-socket.c    |   2 +-
>  util/qemu-sockets.c    | 205 ++++++-------------------------------------------
>  6 files changed, 28 insertions(+), 195 deletions(-)
>  create mode 100644 --help
> 
> diff --git a/--help b/--help
> new file mode 100644
> index 0000000..e69de29

NACK, I believe you added a new file '--help' by mistake.

Fam
