Received: from eggs.gnu.org ([2001:4830:134:3::10]:37500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d8IMS-0000xG-NP
	for qemu-devel@nongnu.org; Tue, 09 May 2017 23:32:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d8IMO-0005lO-PH
	for qemu-devel@nongnu.org; Tue, 09 May 2017 23:32:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52988)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1d8IMO-0005lJ-Gg
	for qemu-devel@nongnu.org; Tue, 09 May 2017 23:32:20 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 41F9E83F3E
	for <qemu-devel@nongnu.org>; Wed, 10 May 2017 03:32:19 +0000 (UTC)
Date: Wed, 10 May 2017 11:32:12 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170510033212.GP2820@pxdev.xzpeter.org>
References: <1494329105-4411-1-git-send-email-peterx@redhat.com>
	<1494329105-4411-3-git-send-email-peterx@redhat.com>
	<87a86mhyod.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87a86mhyod.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH v5 2/3] utils: provide size_to_str()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On Tue, May 09, 2017 at 04:50:26PM +0200, Markus Armbruster wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > I stole the algorithm from print_type_size(). I didn't generalize it
> > since that's using [KM...]iB while here we need [KM...]B to finally
> > be able to stands for page sizes (and even more general).
> 
> Can you explain why we need units without the 'i' here?

Oops. I misunderstood XiB... My fault. Page sizes needs exactly "i".

> 
> >
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  include/qemu-common.h |  1 +
> >  util/cutils.c         | 26 ++++++++++++++++++++++++++
> >  2 files changed, 27 insertions(+)
> >
> > diff --git a/include/qemu-common.h b/include/qemu-common.h
> > index d218821..d7d0448 100644
> > --- a/include/qemu-common.h
> > +++ b/include/qemu-common.h
> > @@ -145,6 +145,7 @@ void qemu_hexdump(const char *buf, FILE *fp, const char *prefix, size_t size);
> >  int parse_debug_env(const char *name, int max, int initial);
> >  
> >  const char *qemu_ether_ntoa(const MACAddr *mac);
> > +char *size_to_str(double val);
> >  void page_size_init(void);
> >  
> >  /* returns non-zero if dump is in progress, otherwise zero is
> > diff --git a/util/cutils.c b/util/cutils.c
> > index 50ad179..5aaf370 100644
> > --- a/util/cutils.c
> > +++ b/util/cutils.c
> > @@ -619,3 +619,29 @@ const char *qemu_ether_ntoa(const MACAddr *mac)
> >  
> >      return ret;
> >  }
> > +
> > +/*
> > + * Sample output:
> > + *
> > + * 1          -> "1 B"
> > + * 528        -> "0.516 KB"
> > + * 4096       -> "4 KB"
> > + * 2402958    -> "2.29 MB"
> > + * 1073741824 -> "1 GB"
> > + *
> > + * Please free the buffer after use.
> > + */
> > +char *size_to_str(double val)
> > +{
> > +    static const char suffixes[] = { 'B', 'K', 'M', 'G', 'T', 'P', 'E' };
> > +    unsigned long div;
> > +    int i;
> > +
> > +    frexp(val, &i);
> 
> The ignored return value is in [0.5,1), and multiplying it by 2^i yields
> val.  i is close to the binary logarithm.
> 
> > +    i /= 10;
> 
> Now it's close to base-1024 logarithm.
> 
> Figuring this out requires too much thought for comfort.  Recommend
> steal the comment from print_type_size(), too.

Let me do it even simpler - I'll just move the whole logic in
print_type_size() into size_to_str(), then I'll refactor
print_type_size().

> 
> > +    assert(i < sizeof(suffixes));
> > +    div = 1ULL << (i * 10);
> > +
> > +    return g_strdup_printf("%0.3g %c%s", val / div,
> > +                           suffixes[i], i ? "B" : "");
> 
> The conditional is a bit confusing.  To avoid it, we could make
> suffixes[] an array of strings, with suffixes[0] = "".

I can fix this. Thanks reviewing!

-- 
Peter Xu
