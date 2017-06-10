Received: from eggs.gnu.org ([2001:4830:134:3::10]:45502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vyasevic@redhat.com>) id 1dJiuP-0004Wd-7o
	for qemu-devel@nongnu.org; Sat, 10 Jun 2017 12:06:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vyasevic@redhat.com>) id 1dJiuK-0007Ay-9n
	for qemu-devel@nongnu.org; Sat, 10 Jun 2017 12:06:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34242)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vyasevic@redhat.com>) id 1dJiuK-0007Aa-3t
	for qemu-devel@nongnu.org; Sat, 10 Jun 2017 12:06:36 -0400
Reply-To: vyasevic@redhat.com
References: <20170601082935.19993-1-berrange@redhat.com>
From: Vlad Yasevich <vyasevic@redhat.com>
Message-ID: <ffa90716-d0be-67d4-be4e-52824db7e9ba@redhat.com>
Date: Sat, 10 Jun 2017 12:06:30 -0400
MIME-Version: 1.0
In-Reply-To: <20170601082935.19993-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 0/5] Fix handling of IPv4/IPv6 dual stack
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 06/01/2017 04:29 AM, Daniel P. Berrange wrote:
> This is a followup to:
> 
>   v1: https://lists.nongnu.org/archive/html/qemu-devel/2017-04/msg05659.html
>   v2: https://lists.nongnu.org/archive/html/qemu-devel/2017-05/msg04706.html
> 
> This series aims to fix a lot of bugs related to handling of IPv4 / IPv6
> dual stack.
> 
>  - The VNC server mistakenly listened on two separate ports 5900+5901
>    when the to= parameter was given
>  - IPv6 sockets are accepting IPv4 clients even when IPv4 is set to
>    be disabled
>  - IPv6 sockets are failing to accept IPv4 clients when IPv4 is not set
>    to be disabled
>  - The VNC server was loosing the ipv4=/ipv6= settings due to a bug
>    in the DNS resolver
> 
> The behaviour of all this is really subtle and hard to get working correctly
> across all the different network backends. Thus, the most important part of
> this patch series is the last patch which adds a test case covering the
> backends for -vnc, -chardev tcp, -net socket, and -incoming socket, with
> a 120 entry matrix.
> 
> IOW, if you think any of the first 4 patches are applying the wrong logic,
> then take a look at the last patch and indicate which test matrix entries
> are believed to be defining wrong behaviour :-)
> 
> Changed in v2:
> 
>  - Clarified error message in commit message
>  - Replace assert with exit (Eric)
>  - Fix typo in test comment (Eric)
>  - Fix wierd copyright line (Eric)
> 
> Daniel P. Berrange (5):
>   sockets: ensure we can bind to both ipv4 & ipv6 separately
>   sockets: don't block IPv4 clients when listening on "::"
>   sockets: ensure we don't accept IPv4 clients when IPv4 is disabled
>   io: preserve ipv4/ipv6 flags when resolving InetSocketAddress
>   tests: add functional test validating ipv4/ipv6 address flag handling
> 
>  io/dns-resolver.c          |   6 +-
>  tests/.gitignore           |   1 +
>  tests/Makefile.include     |   4 +
>  tests/test-sockets-proto.c | 855 +++++++++++++++++++++++++++++++++++++++++++++
>  util/qemu-sockets.c        |  71 +++-
>  5 files changed, 916 insertions(+), 21 deletions(-)
>  create mode 100644 tests/test-sockets-proto.c
> 

Series Reviewed-by: Vlad Yasevich <vyasevic@redhat.com>

-vlad
