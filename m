Received: from eggs.gnu.org ([2001:4830:134:3::10]:37320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1gRj5E-0001fE-Pn
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 14:31:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1gRj5B-00083N-07
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 14:31:44 -0500
Received: from mail-eopbgr00093.outbound.protection.outlook.com
	([40.107.0.93]:59808
	helo=EUR02-AM5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1gRj59-000815-8C
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 14:31:39 -0500
From: Roman Kagan <rkagan@virtuozzo.com>
Date: Tue, 27 Nov 2018 19:31:32 +0000
Message-ID: <20181127193128.GC5147@rkaganip.lan>
References: <20181123090058.6931-1-rkagan@virtuozzo.com>
	<43c4a5d5-9437-57b1-e557-e82dfa6c3af1@redhat.com>
In-Reply-To: <43c4a5d5-9437-57b1-e557-e82dfa6c3af1@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C068C01C7557634E90D1998BA7777859@eurprd08.prod.outlook.com>
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] configure: fix elf2dmp check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Viktor Prutyanov <viktor.prutyanov@phystech.edu>

On Tue, Nov 27, 2018 at 07:50:54PM +0100, Paolo Bonzini wrote:
> On 23/11/18 10:01, Roman Kagan wrote:
> > elf2dmp is keyed on "$posix" = "yes", but "$posix" doesn't seem to be
> > set anywhere.
> > 
> > The original intent was presumably to skip building it on Windows, so
> > check for "$mingw32" = "no" instead.
> > 
> > Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
> > ---
> >  configure | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/configure b/configure
> > index 0a3c6a72c3..fc6ce0065d 100755
> > --- a/configure
> > +++ b/configure
> > @@ -5722,7 +5722,7 @@ if test "$want_tools" = "yes" ; then
> >    if [ "$ivshmem" = "yes" ]; then
> >      tools="ivshmem-client\$(EXESUF) ivshmem-server\$(EXESUF) $tools"
> >    fi
> > -  if [ "$posix" = "yes" ] && [ "$curl" = "yes" ]; then
> > +  if [ "$mingw32" = "no" ] && [ "$curl" = "yes" ]; then
> >      tools="elf2dmp $tools"
> >    fi
> >  fi
> > 
> 
> Unfortunately this shows that elf2dmp is not portable to 32-bit systems,
> nor to non-Linux.  Can this be fixed?

I'm sure it can, but not in time for 3.2.  I'd rather drop this patch
for now and leave the tool disabled in 3.2.

[ FWIW the format specifier mismatches were addressed by Viktor's
patchset of some three weeks ago, "[PATCH 0/2] contrib/elf2dmp: elf2dmp
for Windows hosts", but it hasn't made it yet. ]

/me is wondering why patchew didn't scream at me for breaking 32-bit
builds.  In the meantime I'll be setting up docker for testing 32-bit
builds locally.

Roman.
