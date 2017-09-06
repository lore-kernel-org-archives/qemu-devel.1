Received: from eggs.gnu.org ([2001:4830:134:3::10]:35732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dphkr-0003In-O1
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 17:21:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dphko-0004HY-JH
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 17:21:01 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:50295)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dphko-0004GC-D2
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 17:20:58 -0400
Date: Wed, 6 Sep 2017 17:20:56 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170906212056.GC25558@flamenco>
References: <150471856141.24907.274176769201097378.stgit@frigg.lan>
	<150471928780.24907.14047559834166839201.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <150471928780.24907.14047559834166839201.stgit@frigg.lan>
Subject: Re: [Qemu-devel] [PATCH v4 03/20] instrument: Add generic library
 loader
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On Wed, Sep 06, 2017 at 20:34:48 +0300, Lluís Vilanova wrote:
> Signed-off-by: Lluís Vilanova <vilanova@ac.upc.edu>
> ---
(snip)
> diff --git a/configure b/configure
> index 80dcc91c98..05bd7b1950 100755
> --- a/configure
> +++ b/configure
> @@ -6034,6 +6034,8 @@ fi
>  echo "CONFIG_TRACE_FILE=$trace_file" >> $config_host_mak
>  
>  if test "$instrument" = "yes"; then
> +  LDFLAGS="-rdynamic $LDFLAGS"          # limit symbols available to clients

-rdynamic exports all objects to the instrumenters, not the other way around.
You can see it with nm(1).

BTW I'm using ebf447b5b from your qemu-dbi repo. Is that the same as this
patchset? It doesn't compile with --enable-instrument:
$ make
  CC      x86_64-linux-user/instrument/trace.o
/data/src/qemu2/instrument/trace.c:12:30: fatal error: qemu-instr/trace.h: No such file or directory
compilation terminated.
/data/src/qemu2/rules.mak:66: recipe for target 'instrument/trace.o' failed
make[1]: *** [instrument/trace.o] Error 1
Makefile:326: recipe for target 'subdir-x86_64-linux-user' failed
make: *** [subdir-x86_64-linux-user] Error 2

		Emilio
