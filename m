Received: from eggs.gnu.org ([2001:4830:134:3::10]:54728)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dmcux-0002np-1H
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 05:34:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dmcut-0008MA-Sj
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 05:34:43 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:37039)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dmcut-0008M4-MN
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 05:34:39 -0400
Received: by mail-wm0-x241.google.com with SMTP id x189so3090610wmg.4
	for <qemu-devel@nongnu.org>; Tue, 29 Aug 2017 02:34:39 -0700 (PDT)
Date: Tue, 29 Aug 2017 10:34:36 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170829093436.GF25960@stefanha-x1.localdomain>
References: <20170828015654.2530-1-Sergio.G.DelReal@gmail.com>
	<20170828015654.2530-7-Sergio.G.DelReal@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170828015654.2530-7-Sergio.G.DelReal@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 06/14] hvf: add compilation rules to
 Makefile.objs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sergio Andres Gomez Del Real <sergio.g.delreal@gmail.com>
Cc: qemu-devel@nongnu.org

On Sun, Aug 27, 2017 at 08:56:46PM -0500, Sergio Andres Gomez Del Real wrote:
> This commit adds to target/i386/Makefile.objs the necessary rules so
> that the new files for hvf are compiled by the build system.
> It also adds handling of the -enable-hvf argument in the main function
> in vl.c.
> 
> Signed-off-by: Sergio Andres Gomez Del Real <Sergio.G.DelReal@gmail.com>
> ---
>  target/i386/Makefile.objs | 1 +
>  vl.c                      | 7 +++++++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/target/i386/Makefile.objs b/target/i386/Makefile.objs
> index 6a26e9d9f0..0bef89c099 100644
> --- a/target/i386/Makefile.objs
> +++ b/target/i386/Makefile.objs
> @@ -12,4 +12,5 @@ obj-$(CONFIG_HAX) += hax-all.o hax-mem.o hax-windows.o
>  endif
>  ifdef CONFIG_DARWIN
>  obj-$(CONFIG_HAX) += hax-all.o hax-mem.o hax-darwin.o
> +obj-$(CONFIG_HVF) += hvf-utils/ hvf-all.o
>  endif

This should be in the commit that imported the .c files.  They should be
compiled right away.

> diff --git a/vl.c b/vl.c
> index 8e247cc2a2..de7d2a3858 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -3751,6 +3751,13 @@ int main(int argc, char **argv, char **envp)
>                  olist = qemu_find_opts("machine");
>                  qemu_opts_parse_noisily(olist, "accel=hax", false);
>                  break;
> +#if defined(__APPLE__)
> +            case QEMU_OPTION_enable_hvf:
> +                olist = qemu_find_opts("machine");
> +                qemu_opts_parse_noisily(olist, "accel=hvf", false);
> +                hvf_disable(0);
> +                break;
> +#endif

This code change is independent of the Makefile.objs change.  It should
be a spearate commit.

As mentioned in another email, -enable-hvf should be dropped.
