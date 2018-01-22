Received: from eggs.gnu.org ([2001:4830:134:3::10]:37738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1edWYV-0008DK-2e
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 02:30:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1edWYR-0007Pc-T8
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 02:30:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60860)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1edWYR-0007Oq-Ki
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 02:30:07 -0500
Date: Mon, 22 Jan 2018 15:29:53 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180122072953.GB29532@xz-mi>
References: <20171219084557.9801-1-peterx@redhat.com>
	<20171219084557.9801-13-peterx@redhat.com>
	<c417f619-aad5-a379-bad5-985b44ab1ebb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c417f619-aad5-a379-bad5-985b44ab1ebb@redhat.com>
Subject: Re: [Qemu-devel] [RFC v6 12/27] qmp: negotiate QMP capabilities
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Fri, Jan 12, 2018 at 02:57:23PM -0600, Eric Blake wrote:
> On 12/19/2017 02:45 AM, Peter Xu wrote:
> > After this patch, we will allow QMP clients to enable QMP capabilities
> > when sending the first "qmp_capabilities" command.  Originally we are
> > starting QMP session with no arguments like:
> > 
> >   { "execute": "qmp_capabilities" }
> > 
> > Now we can enable some QMP capabilities using (take OOB as example,
> > which is the only one capability that we support):
> > 
> >   { "execute": "qmp_capabilities",
> >     "argument": { "enable": [ "oob" ] } }
> > 
> > When the "argument" key is not provided, no capability is enabled.
> > 
> > For capability "oob", the monitor needs to be run on dedicated IO
> > thread, otherwise the command will fail.  For example, trying to enable
> > OOB on a MUXed typed QMP monitor will fail.
> 
> 
> > 
> > One thing to mention is that, QMP capabilities are per-monitor, and also
> > when the connection is closed due to some reason, the capabilities will
> > be reset.
> > 
> > Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  monitor.c        | 65 +++++++++++++++++++++++++++++++++++++++++++++++++++++---
> >  qapi-schema.json | 15 ++++++++++---
> >  2 files changed, 74 insertions(+), 6 deletions(-)
> > 
> 
> > @@ -1044,6 +1079,20 @@ void qmp_qmp_capabilities(Error **errp)
> >          return;
> >      }
> >  
> > +    /* Enable QMP capabilities provided by the guest if applicable. */
> > +    if (has_enable) {
> > +        qmp_caps_check(cur_mon, enable, &local_err);
> > +        if (local_err) {
> > +            /*
> > +             * Failed check on either of the capabilities will fail
> 
> s/either/any/

Fixed.

> 
> > +             * the apply of all.
> 
> s/apply/application/
> 
> or even a more verbose
> 
> will fail the entire command (and thus not apply any of the other
> capabilities that were also requested).

Sure.

> 
> > @@ -3950,6 +3999,10 @@ static QObject *get_qmp_greeting(void)
> >      qmp_marshal_query_version(NULL, &ver, NULL);
> >  
> >      for (cap = 0; cap < QMP_CAPABILITY__MAX; cap++) {
> > +        if (!mon->use_io_thr && cap == QMP_CAPABILITY_OOB) {
> > +            /* Monitors that are not using IOThread won't support OOB */
> > +            continue;
> > +        }
> >          qlist_append(cap_list, qstring_from_str(QMPCapability_str(cap)));
> 
> I think this hunk belongs in the previous patch - the server should not
> advertise 'oob' in the greeting if it will not be able to honor it.

Yes, Fam asked the same question.  How about I squash these two
patches?  After all chunk moving between commits are even more
error-prone to me...  and even moving the chunk will need me to drop
all r-bs for the patches.

Let me squash them.

> 
> 
> > +++ b/qapi-schema.json
> > @@ -102,21 +102,30 @@
> >  #
> >  # Enable QMP capabilities.
> >  #
> > -# Arguments: None.
> > +# Arguments:
> > +#
> > +# @enable:    List of QMPCapabilities to enable, which is optional.
> 
> Maybe document that this list must not include any capabilities that
> were not mentioned in the server's initial greeting.

Ok.  Thanks,

-- 
Peter Xu
