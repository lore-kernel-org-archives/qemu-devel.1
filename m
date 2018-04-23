Received: from eggs.gnu.org ([2001:4830:134:3::10]:46165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=644ea31d5=Ian.Jackson@citrix.com>)
	id 1fAeUp-00042P-6z
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 12:39:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=644ea31d5=Ian.Jackson@citrix.com>)
	id 1fAeUm-0008Du-KD
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 12:39:19 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:33928)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=644ea31d5=Ian.Jackson@citrix.com>)
	id 1fAeUm-0008Cl-8A
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 12:39:16 -0400
From: Ian Jackson <ian.jackson@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-ID: <23262.3101.567189.675156@mariner.uk.xensource.com>
Date: Mon, 23 Apr 2018 17:38:53 +0100
In-Reply-To: <20180423162142.GG1980@perard>
References: <1524156319-11465-1-git-send-email-ian.jackson@eu.citrix.com>
	<1524156319-11465-17-git-send-email-ian.jackson@eu.citrix.com>
	<20180423162142.GG1980@perard>
Subject: Re: [Qemu-devel] [PATCH 16/16] configure: do_compiler: Dump some
 extra info under bash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anthony PERARD <anthony.perard@citrix.com>
Cc: qemu-devel@nongnu.org, Ross Lagerwall <ross.lagerwall@citrix.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org, "Kent R. Spillner" <kspillner@acm.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

Anthony PERARD writes ("Re: [PATCH 16/16] configure: do_compiler: Dump some extra info under bash"):
> On Thu, Apr 19, 2018 at 05:45:19PM +0100, Ian Jackson wrote:
> > +funcs: ${FUNCNAME}
> > +lines: ${BASH_LINENO}
> > +files: ${BASH_SOURCE}"
> >      echo $compiler "$@" >> config.log
> >      $compiler "$@" >> config.log 2>&1 || return $?
> >      # Test passed. If this is an --enable-werror build, rerun
> 
> How is this usefull? All I have in my config.log is a lot of:
>   funcs: do_compiler
>   lines: 91
>   files: ./configure
> 
> And one:
>   funcs: do_compiler
>   lines: 95
>   files: ./configure
> 
> It still don't tell me which test had runned.

You are right.  Perhaps my testing was inadequate.  I wrote this a
long while ago, and if there was a syntax along these lines that DTRT
in both bash and dash in my tests it is long gone.  Starting de novo,
the following code works for me:

    (echo >>config.log "
 funcs: ${FUNCNAME[*]}
 lines: ${BASH_LINENO[*]}
 files: ${BASH_SOURCE[*]}") 2>/dev/null ||:

With bash I get the expected information in config.log, which looks
like this:

 funcs: do_compiler do_cc compile_prog cc_has_warning_flag main
 lines: 91 124 1720 1724 0
 files: ./configure ./configure ./configure ./configure ./configure

With dash the script runs but there is nothing from this segment in
the log.  Without the 2>/dev/null, it prints
  ./configure: 63: ./configure: Bad substitution
so the syntax error is indeed being suprresed and ignored.

The ( ) is necessary because syntax errors are not like set -e errors:
they cause the shell process to exit.

I will update the patch and put some of this info in the commit
message.

Ian.
