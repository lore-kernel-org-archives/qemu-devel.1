Received: from eggs.gnu.org ([2001:4830:134:3::10]:42465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1duXAA-0003fw-2u
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 01:03:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1duXA6-0007kZ-Pg
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 01:03:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35268)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1duXA6-0007ey-JJ
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 01:03:02 -0400
Date: Wed, 20 Sep 2017 13:02:52 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170920050252.GT3617@pxdev.xzpeter.org>
References: <1505375436-28439-1-git-send-email-peterx@redhat.com>
	<1505375436-28439-3-git-send-email-peterx@redhat.com>
	<f9ef8d51-0fac-efa0-a358-8c3a3e92e894@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f9ef8d51-0fac-efa0-a358-8c3a3e92e894@redhat.com>
Subject: Re: [Qemu-devel] [RFC 02/15] qobject: allow NULL for
 qstring_get_str()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Stefan Hajnoczi <shajnocz@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Laurent Vivier <lvivier@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Tue, Sep 19, 2017 at 03:48:35PM -0500, Eric Blake wrote:
> On 09/14/2017 02:50 AM, Peter Xu wrote:
> > Then I can get NULL rather than crash when calling things like:
> > 
> >   qstring_get_str(qobject_to_qstring(object));
> > 
> > when key does not exist.
> 
> Right now, qdict_get_str() is documented as:
> 
>  * This function assumes that 'key' exists and it stores a
>  * QString object.
> 
> Your code changes that, by making it now return NULL instead of crashing
> on what used to be usage in violation of the contract; compared to
> qdict_get_try_str() which gracefully returns NULL, but which could use
> your new semantics for doing so in fewer lines of code.
> 
> I'm not necessarily opposed to the change, but I worry that it has
> subtle ramifications that we haven't thought about, as well as
> consistency with the rest of the QObject APIs.  It may be better to just
> introduce qstring_get_try_str(), which gracefully handles NULL input,
> and leave the existing function alone; and if you do introduce a new
> helper, it may be worth converting existing clients (perhaps with help
> from Coccinelle) to take advantage of the helper.

I'll take your suggestion.

Though I didn't see much existing codes that can use the new
qstring_get_try_str().  One I found is object_property_get_str().
I can add one more patch to convert its usage.

Thanks,

> 
> > +++ b/qobject/qstring.c
> > @@ -125,7 +125,7 @@ QString *qobject_to_qstring(const QObject *obj)
> >   */
> >  const char *qstring_get_str(const QString *qstring)
> >  {
> > -    return qstring->string;
> > +    return qstring ? qstring->string : NULL;
> >  }
> >  
> >  /**
> > 
> 
> -- 
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
> 

-- 
Peter Xu
