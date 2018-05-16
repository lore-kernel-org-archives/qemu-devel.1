Received: from eggs.gnu.org ([2001:4830:134:3::10]:37609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fImnH-0005yg-9d
	for qemu-devel@nongnu.org; Tue, 15 May 2018 23:08:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fImnE-0007WK-3w
	for qemu-devel@nongnu.org; Tue, 15 May 2018 23:07:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49080 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fImnD-0007Vy-Vi
	for qemu-devel@nongnu.org; Tue, 15 May 2018 23:07:56 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 67D097C6B1
	for <qemu-devel@nongnu.org>; Wed, 16 May 2018 03:07:55 +0000 (UTC)
Date: Wed, 16 May 2018 11:07:50 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180516030750.GC9089@xz-mi>
References: <20180515091356.24106-1-peterx@redhat.com>
	<584bbd99-11dd-8da9-a5b4-de285cebc84d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <584bbd99-11dd-8da9-a5b4-de285cebc84d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RFC] qemu-error: introduce error_report_once
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>

On Tue, May 15, 2018 at 10:29:39AM -0500, Eric Blake wrote:
> On 05/15/2018 04:13 AM, Peter Xu wrote:
> > I stole the printk_once() macro.
> > 
> > I always wanted to be able to print some error directly if there is a
> > buffer to dump, however we can't use error_report() really quite often
> > when there can be any DDOS attack.  To avoid that, we can introduce a
> > print-once function for it.
> > 
> > CC: Markus Armbruster <armbru@redhat.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> > We can for sure introduce similar functions for the rest of the
> > error_*() functions, it's just an idea to see whether we'd like it
> > in general.
> > ---
> >   include/qemu/error-report.h | 12 ++++++++++++
> >   1 file changed, 12 insertions(+)
> > 
> > diff --git a/include/qemu/error-report.h b/include/qemu/error-report.h
> > index e1c8ae1a52..efebb80e2c 100644
> > --- a/include/qemu/error-report.h
> > +++ b/include/qemu/error-report.h
> > @@ -44,6 +44,18 @@ void error_report(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
> >   void warn_report(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
> >   void info_report(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
> > +#define error_report_once(fmt, ...)             \
> > +    ({                                          \
> > +        static bool __print_once;               \
> 
> Double-underscore names are reserved for the compiler's use, not ours.
> Better would be naming this:
> 
> static bool print_once_;
> 
> with a trailing underscore, or at most a single leading underscore.
> 
> > +        bool __ret_print_once = !__print_once;  \
> 
> Same comment for this variable.

Sure!

(I am wondering why Linux is always using that way to name lots of
 variables, and I'm surprised that I got 385350 after I run this under
 the Linux repo: 'git grep "__[a-z][a-z]" | wc -l', even considering
 some false positives)

Thanks,

-- 
Peter Xu
