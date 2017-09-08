Received: from eggs.gnu.org ([2001:4830:134:3::10]:55089)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dqGVC-0002ib-1b
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 06:27:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dqGV6-0004AO-Sl
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 06:27:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40508)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dqGV6-00049m-Ja
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 06:27:04 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 83A25883AE
	for <qemu-devel@nongnu.org>; Fri,  8 Sep 2017 10:27:03 +0000 (UTC)
Date: Fri, 8 Sep 2017 18:27:01 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170908102701.GL4511@lemon>
References: <20170906124900.17354-1-famz@redhat.com>
	<20170908100537.GI3609@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170908100537.GI3609@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4] buildsys: Move crypto cflags/libs to
 per object variables
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org

On Fri, 09/08 11:05, Daniel P. Berrange wrote:
> On Wed, Sep 06, 2017 at 08:49:00PM +0800, Fam Zheng wrote:
> > This patch groups the crypto objects into a few .mo objects based on
> > functional submodules, and moves inclusion conditions to *-objs
> > variables, then moves the global cflags/libs to the *-cflags and *-libs
> > variables.
> > 
> > For init.o and cipher.o, which may or may not need the library flags
> > depending on config, adding flags and libs unconditionally doesn't hurt,
> > because if the library is not available, the variables are empty.  This
> > makes less code.
> > 
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> > 
> > ---
> > 
> > v4: Merge into one patch which is supposedly easier to manage and
> > review, and use .mo appraoch to avoid $(foreach) and $(eval) magics.
> 
> I don't think using  .mo is suitable here. You've used it as a generic
> mechanism for grouping .o files, but that is not what it does. There
> are special semantics around .mo rules that affect how the final
> binaries are linked.

Using .mo is okay here, but after a hindsight I think grouping by library
(nettle.mo, gcrypt.mo, etc.) is better than grouping by functionality, for
modularization in the future. But that also means assigning the cflags/libs
variable cannot be simplified like this.

> 
> eg looking back at the description of .mo files 
> 
> [quote]
> commit c261d774fb9093d00e0938a19f502fb220f62718
> Author: Fam Zheng <famz@redhat.com>
> Date:   Mon Sep 1 18:35:10 2014 +0800
> 
> [...snip...]
> 
>     3) When linking an executable, those .mo files in its "-y" variables are
>        filtered out, and replaced by one or more -Wl,-u,$symbol flags. This
>        is done in the added macro "process-archive-undefs".
>     
>        These "-Wl,-u,$symbol" flags will force ld to pull in the function
>        definition from the archives when linking.
>     
>        Note that the .mo objects, that are actually meant to be linked in
>        the executables, are already expanded in unnest-vars, before the
>        linking command. So we are safe to simply filter out .mo for the
>        purpose of pulling undefined symbols.
>     
>        process-archive-undefs works as this: For each ".mo", find all the
>        undefined symbols in it, filter ones that are defined in the
>        archives. For each of these symbols, generate a "-Wl,-u,$symbol" in
>        the link command, and put them before archive names in the command
>        line.
> [/quote]
> 
> Based on this, I don't think I can ack this patch, because it can
> have unexpected consequences.

This described the process-archive-undefs semantics of .mo, but not the essence
of it.  Basically .mo is just partial linking with the additional services of
-cflags, -libs and the above -Wl,-u thing. I cannot think of any unexpected
consequences with this change. We've had sdl.mo in ui/Makefile.objs for long,
just for the same purpose of this patch, with no problem.

Fam
