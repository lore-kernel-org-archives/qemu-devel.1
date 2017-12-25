Received: from eggs.gnu.org ([2001:4830:134:3::10]:53169)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eTJHg-0000WT-Le
	for qemu-devel@nongnu.org; Sun, 24 Dec 2017 22:18:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eTJHd-000737-Eu
	for qemu-devel@nongnu.org; Sun, 24 Dec 2017 22:18:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34818)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eTJHd-00072l-8v
	for qemu-devel@nongnu.org; Sun, 24 Dec 2017 22:18:33 -0500
Date: Mon, 25 Dec 2017 11:18:22 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20171225031822.GC2443@xz-mi>
References: <20171219084557.9801-1-peterx@redhat.com>
	<20171219084557.9801-13-peterx@redhat.com>
	<20171221100100.GK10812@lemon>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171221100100.GK10812@lemon>
Subject: Re: [Qemu-devel] [RFC v6 12/27] qmp: negotiate QMP capabilities
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Thu, Dec 21, 2017 at 06:01:00PM +0800, Fam Zheng wrote:

[...]

> > +void qmp_qmp_capabilities(bool has_enable, QMPCapabilityList *enable,
> > +                          Error **errp)
> >  {
> > +    Error *local_err = NULL;
> > +
> >      if (cur_mon->qmp.commands == &qmp_commands) {
> >          error_set(errp, ERROR_CLASS_COMMAND_NOT_FOUND,
> >                    "Capabilities negotiation is already complete, command "
> > @@ -1044,6 +1079,20 @@ void qmp_qmp_capabilities(Error **errp)
> >          return;
> >      }
> >  
> > +    /* Enable QMP capabilities provided by the guest if applicable. */
> 
> s/guest/client/ ?

Fixed.

[...]

> > -static QObject *get_qmp_greeting(void)
> > +static QObject *get_qmp_greeting(Monitor *mon)
> >  {
> >      QList *cap_list = qlist_new();
> >      QObject *ver = NULL;
> > @@ -3950,6 +3999,10 @@ static QObject *get_qmp_greeting(void)
> >      qmp_marshal_query_version(NULL, &ver, NULL);
> >  
> >      for (cap = 0; cap < QMP_CAPABILITY__MAX; cap++) {
> > +        if (!mon->use_io_thr && cap == QMP_CAPABILITY_OOB) {
> > +            /* Monitors that are not using IOThread won't support OOB */
> > +            continue;
> > +        }
> 
> OK, I thought this could better go to the previous patch, but it may be fine
> here, together with monitor_qmp_caps_reset().

Yes.  I kept all OOB things in this patch, and for previous patch it
only starts to offer all the capabilities to clients.  Thanks,

-- 
Peter Xu
