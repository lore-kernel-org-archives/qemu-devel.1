Received: from eggs.gnu.org ([2001:4830:134:3::10]:40069)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dwQ6u-0002br-P4
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 05:55:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dwQ6p-0007a3-64
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 05:55:32 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:33832)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dwQ6o-0007Za-W2
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 05:55:27 -0400
Received: by mail-wm0-x242.google.com with SMTP id i131so6701491wma.1
	for <qemu-devel@nongnu.org>; Mon, 25 Sep 2017 02:55:26 -0700 (PDT)
Date: Mon, 25 Sep 2017 10:55:23 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170925095523.GF14140@stefanha-x1.localdomain>
References: <1506321449-24013-1-git-send-email-peterx@redhat.com>
	<1506321449-24013-2-git-send-email-peterx@redhat.com>
	<4540074c-f523-41f4-3ce7-8b6514060fa4@suse.de>
	<20170925081426.GE19505@pxdev.xzpeter.org>
	<20170925083458.luy7kjv6x56lptvi@postretch>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170925083458.luy7kjv6x56lptvi@postretch>
Subject: Re: [Qemu-devel] [PATCH v2 1/4] qom: provide root container for
 internal objs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>, Peter Xu <peterx@redhat.com>, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>, Fam Zheng <famz@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <shajnocz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Mon, Sep 25, 2017 at 11:34:58AM +0300, Manos Pitsidianakis wrote:
> On Mon, Sep 25, 2017 at 04:14:26PM +0800, Peter Xu wrote:
> > On Mon, Sep 25, 2017 at 09:14:21AM +0200, Andreas Färber wrote:
> > > Am 25.09.2017 um 08:37 schrieb Peter Xu:
> > > > We have object_get_objects_root() to keep user created objects, however
> > > > no place for objects that will be used internally.  Create such a
> > > > container for internal objects.
> > > >
> > > > CC: Andreas Färber <afaerber@suse.de>
> > > > CC: Markus Armbruster <armbru@redhat.com>
> > > > CC: Paolo Bonzini <pbonzini@redhat.com>
> > > > Suggested-by: Daniel P. Berrange <berrange@redhat.com>
> > > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > > ---
> > > >  include/qom/object.h | 10 ++++++++++
> > > >  qom/object.c         |  5 +++++
> > > >  2 files changed, 15 insertions(+)
> > > >
> > > > diff --git a/include/qom/object.h b/include/qom/object.h
> > > > index f3e5cff..f567052 100644
> > > > --- a/include/qom/object.h
> > > > +++ b/include/qom/object.h
> > > > @@ -1214,6 +1214,16 @@ Object *object_get_root(void);
> > > >  Object *object_get_objects_root(void);
> > > >
> > > >  /**
> > > > + * object_get_internal_root:
> > > > + *
> > > > + * Get the container object that holds internally used object
> > > > + * instances. This is the object at path "/internal-objects"
> > > > + *
> > > > + * Returns: the internal object container
> > > > + */
> > > > +Object *object_get_internal_root(void);
> > > > +
> > > > +/**
> > > >   * object_get_canonical_path_component:
> > > >   *
> > > >   * Returns: The final component in the object's canonical path.  The canonical
> > > > diff --git a/qom/object.c b/qom/object.c
> > > > index 3e18537..857cee7 100644
> > > > --- a/qom/object.c
> > > > +++ b/qom/object.c
> > > > @@ -1370,6 +1370,11 @@ Object *object_get_objects_root(void)
> > > >      return container_get(object_get_root(), "/objects");
> > > >  }
> > > >
> > > > +Object *object_get_internal_root(void)
> > > > +{
> > > > +    return container_get(object_get_root(), "/internal-objects");
> > > 
> > > Whatever you expose in the QOM tree is no longer internal. Other name?
> > 
> > Hi, Andreas,
> > 
> > If you mean "info qom-tree" here, can we still treat it as internal?
> > Since after all it's not exposed in QMP (while IMHO QMP is the
> > official protocol for QEMU clients).  And IIUC some HMP commands do
> > dump some internal structs for debugging purpose (like: "info
> > ramblock").
> > 
> > Or, do you have any suggestion?
> > 
> > (I did think about something like "hidden-objects", but I believe they
> > are not hidden as well if we think they are not internal...)
> > 
> > Thanks,
> > 
> > > 
> > > Regards,
> > > Andreas
> 
> If there's no need for internal IOThreads to be together with user created
> ones, a simple queue will be enough (include/qemu/queue.h).

Two solutions:

1. Manos' suggestion is Object->parent == NULL.  Simply don't add the
   Object to a parent.

2. Create an internal root that isn't accessible via QMP.
   Object *internal_root = object_new("container).

Stefan
