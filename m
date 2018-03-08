Received: from eggs.gnu.org ([2001:4830:134:3::10]:46155)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ettxl-0004z2-Vq
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 06:43:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ettxk-0006Dn-TU
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 06:43:58 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55798 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ettxk-0006Da-LS
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 06:43:56 -0500
Date: Thu, 8 Mar 2018 19:43:49 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180308114349.GF32252@xz-mi>
References: <20180124053957.29145-1-peterx@redhat.com>
	<20180124053957.29145-18-peterx@redhat.com>
	<20180308110413.044b15ed@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180308110413.044b15ed@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 17/23] qapi: introduce new cmd option
 "allow-oob"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, Stefan Hajnoczi <shajnocz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Thu, Mar 08, 2018 at 11:04:13AM +0100, Igor Mammedov wrote:
> On Wed, 24 Jan 2018 13:39:51 +0800
> Peter Xu <peterx@redhat.com> wrote:
> 
> > Here "oob" stands for "Out-Of-Band".  When "allow-oob" is set, it means
> > the command allows out-of-band execution.
> > 
> > The "oob" idea is proposed by Markus Armbruster in following thread:
> > 
> >   https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg02057.html
> > 
> > This new "allow-oob" boolean will be exposed by "query-qmp-schema" as
> > well for command entries, so that QMP clients can know which command can
> > be used as out-of-band calls. For example the command "migrate"
> > originally looks like:
> > 
> >   {"name": "migrate", "ret-type": "17", "meta-type": "command",
> >    "arg-type": "86"}
> > 
> > And it'll be changed into:
> > 
> >   {"name": "migrate", "ret-type": "17", "allow-oob": false,
> >    "meta-type": "command", "arg-type": "86"}
> > 
> > This patch only provides the QMP interface level changes.  It does not
> > contains the real out-of-band execution implementation yet.
> > 
> > Suggested-by: Markus Armbruster <armbru@redhat.com>
> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > Reviewed-by: Fam Zheng <famz@redhat.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  include/qapi/qmp/dispatch.h    |  1 +
> >  qapi/introspect.json           |  6 +++++-
> >  scripts/qapi-commands.py       | 19 ++++++++++++++-----
> >  scripts/qapi-introspect.py     | 10 ++++++++--
> >  scripts/qapi.py                | 15 ++++++++++-----
> >  scripts/qapi2texi.py           |  2 +-
> >  tests/qapi-schema/test-qapi.py |  2 +-
> >  7 files changed, 40 insertions(+), 15 deletions(-)
> > 
> > diff --git a/include/qapi/qmp/dispatch.h b/include/qapi/qmp/dispatch.h
> > index 20578dcd48..b76798800c 100644
> > --- a/include/qapi/qmp/dispatch.h
> > +++ b/include/qapi/qmp/dispatch.h
> > @@ -23,6 +23,7 @@ typedef enum QmpCommandOptions
> >  {
> >      QCO_NO_OPTIONS = 0x0,
> >      QCO_NO_SUCCESS_RESP = 0x1,
> > +    QCO_ALLOW_OOB = 0x2,
> Options are essentially bitmask,
> so using shift for value would be more explicit way to express it.
> 
>   QCO_ALLOW_OOB = (1U << 1)

Yes, shifting would be more clear.  Thanks,

-- 
Peter Xu
