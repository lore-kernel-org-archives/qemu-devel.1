Received: from eggs.gnu.org ([2001:4830:134:3::10]:55341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eQ3cq-0006js-Jq
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 22:59:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eQ3cn-0004KX-IO
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 22:59:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55208)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eQ3cn-0004IG-9e
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 22:58:57 -0500
Date: Sat, 16 Dec 2017 11:58:40 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20171216035840.GU7780@xz-mi>
References: <20171205055200.16305-1-peterx@redhat.com>
	<20171205055200.16305-12-peterx@redhat.com>
	<20171213165651.GB8317@stefanha-x1.localdomain>
	<20171215091403.GQ7780@xz-mi> <20171215093803.GA15187@lemon>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171215093803.GA15187@lemon>
Subject: Re: [Qemu-devel] [RFC v5 11/26] qmp: introduce QMPCapability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com, marcandre.lureau@redhat.com, Stefan Hajnoczi <shajnocz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Fri, Dec 15, 2017 at 05:38:03PM +0800, Fam Zheng wrote:
> On Fri, 12/15 17:14, Peter Xu wrote:
> > On Wed, Dec 13, 2017 at 04:56:51PM +0000, Stefan Hajnoczi wrote:
> > > On Tue, Dec 05, 2017 at 01:51:45PM +0800, Peter Xu wrote:
> > > > There was no QMP capabilities defined.  Define the first "oob" as
> > > > capability to allow out-of-band messages.
> > > > 
> > > > Also, touch up qmp-test.c to test the new bits.
> > > > 
> > > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > > ---
> > > >  monitor.c        | 15 +++++++++++++--
> > > >  qapi-schema.json | 13 +++++++++++++
> > > >  tests/qmp-test.c | 10 +++++++++-
> > > >  3 files changed, 35 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/monitor.c b/monitor.c
> > > > index e8f5a586e4..bad6ee8dd1 100644
> > > > --- a/monitor.c
> > > > +++ b/monitor.c
> > > > @@ -3944,12 +3944,23 @@ void monitor_resume(Monitor *mon)
> > > >  
> > > >  static QObject *get_qmp_greeting(void)
> > > >  {
> > > > +    QDict *result = qdict_new(), *qmp = qdict_new();
> > > > +    QList *cap_list = qlist_new();
> > > >      QObject *ver = NULL;
> > > > +    QMPCapability cap;
> > > > +
> > > > +    qdict_put(result, "QMP", qmp);
> > > >  
> > > >      qmp_marshal_query_version(NULL, &ver, NULL);
> > > > +    qdict_put_obj(qmp, "version", ver);
> > > > +
> > > > +    for (cap = 0; cap < QMP_CAPABILITY__MAX; cap++) {
> > > > +        qlist_append(cap_list, qstring_from_str(
> > > > +                         QMPCapability_str(cap)));
> > > > +    }
> > > > +    qdict_put(qmp, "capabilities", cap_list);
> > > >  
> > > > -    return qobject_from_jsonf("{'QMP': {'version': %p, 'capabilities': []}}",
> > > > -                              ver);
> > > > +    return QOBJECT(result);
> > > >  }
> > > 
> > > Why did you replace qobject_from_jsonf() with manual qdict_*() calls?
> > > 
> > > I was expecting this (it's shorter and easier to read):
> > > 
> > >   static QObject *get_qmp_greeting(void)
> > >   {
> > >       QList *cap_list = qlist_new();
> > >       QObject *ver = NULL;
> > >       QMPCapability cap;
> > > 
> > >       qmp_marshal_query_version(NULL, &ver, NULL);
> > > 
> > >       for (cap = 0; cap < QMP_CAPABILITY__MAX; cap++) {
> > >           qlist_append(cap_list, qstring_from_str(
> > >                            QMPCapability_str(cap)));
> 
> And aligning the parameters would be even nicer.
> 
> > >       }
> > > 
> > >       return qobject_from_jsonf("{'QMP': {'version': %p, 'capabilities': %p}}",
> > >                                 ver, cap);
> > 
> > (I believe you mean s/cap/cap_list/ here?)
> > 
> > >   }
> > 
> > Oh I just didn't notice that "%p" magic at all... :(
> > 
> > I think for me it's fine in either way.  Frankly speaking creating the
> > objects explicitly would be even easier to understand for me instead
> > of using a mixture of two ways... But just let me know if you want me
> > to do it your way.  I can switch.  Thanks,
> 
> I agree with Stefan here. (Readability is not judged based on how low level the
> code goes when there is a higher level interface available, it's exactly the
> opposite, and this doesn't change even when you happen to not know it.)

I was talking mostly about using two ways or using only one way to do
this (especially that's quite simple even using raw objects...),
rather than which one I know. :)

Again, since I'm happy with either way actually, I'm giving in.  Thanks,

-- 
Peter Xu
