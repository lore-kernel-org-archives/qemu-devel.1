Received: from eggs.gnu.org ([2001:4830:134:3::10]:52528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fppre-0007nI-6F
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 03:05:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fppra-0002Z0-0o
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 03:05:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41618 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1fpprZ-0002Yc-P6
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 03:05:01 -0400
Date: Wed, 15 Aug 2018 15:04:56 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180815070456.GB14092@lemon.usersys.redhat.com>
References: <20180813171132.21939-1-cota@braap.org>
	<20180813171132.21939-2-cota@braap.org>
	<20180815030942.GA14092@lemon.usersys.redhat.com>
	<20180815045323.GA7585@flamenco>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180815045323.GA7585@flamenco>
Subject: Re: [Qemu-devel] [PATCH 1/3] qsp: QEMU's Synchronization Profiler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Stefan Weil <sw@weilnetz.de>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Wed, 08/15 00:53, Emilio G. Cota wrote:
> > > +#define QSP_GEN_VOID(type_, qsp_t_, func_, impl_)                       \
> > > +    void func_(type_ *obj, const char *file, unsigned line)             \
> > > +    {                                                                   \
> > > +        struct qsp_entry *e = qsp_entry_get(obj, file, line, qsp_t_);   \
> > > +        int64_t t;                                                      \
> > > +                                                                        \
> > 
> > No qsp_init()?
> > 
> > > +        t = get_clock();                                                \
> > > +        impl_(obj, file, line);                                         \
> > > +        atomic_set(&e->ns, e->ns + get_clock() - t);                    \
> > > +        atomic_set(&e->n_acqs, e->n_acqs + 1);                          \
> > > +    }
> > > +
> > > +#define QSP_GEN_RET1(type_, qsp_t_, func_, impl_)                       \
> > > +    int func_(type_ *obj, const char *file, unsigned line)              \
> > > +    {                                                                   \
> > > +        struct qsp_entry *e = qsp_entry_get(obj, file, line, qsp_t_);   \
> > > +        int64_t t;                                                      \
> > > +        int err;                                                        \
> > > +                                                                        \
> > 
> > Same here.
> 
> qsp_init is called by qsp_get_entry.

Oh yes, I missed it. Then you can remove the one in qsp_cond_wait() as well for
consistency.  (That's where I noticed this).

Fam
