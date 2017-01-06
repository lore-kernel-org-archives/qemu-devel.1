Received: from eggs.gnu.org ([2001:4830:134:3::10]:50309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPQdI-00072J-Kw
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 04:16:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPQdB-00088z-E2
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 04:16:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38252)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cPQdB-00088t-5y
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 04:16:13 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6B997C04B93C
	for <qemu-devel@nongnu.org>; Fri,  6 Jan 2017 09:16:13 +0000 (UTC)
Date: Fri, 6 Jan 2017 09:16:07 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170106091607.GD31112@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170105160321.21786-1-berrange@redhat.com>
	<20170105160321.21786-6-berrange@redhat.com>
	<73e36ee2-081e-4298-bf5b-411cc8d247b7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <73e36ee2-081e-4298-bf5b-411cc8d247b7@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 5/8] io: add ability to associate an error
 with a task
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org

On Thu, Jan 05, 2017 at 03:03:08PM -0600, Eric Blake wrote:
> On 01/05/2017 10:03 AM, Daniel P. Berrange wrote:
> > Currently when a task fails, the error is never explicitly
> > associated with the task object, it is just passed along
> > through the completion callback. This adds ability to
> 
> s/adds/adds the/
> 
> > explicitly associate an error with the task.
> > 
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > ---
> >  include/io/task.h | 29 +++++++++++++++++++++++++++++
> >  io/task.c         | 23 +++++++++++++++++++++++
> >  2 files changed, 52 insertions(+)
> > 
> > diff --git a/include/io/task.h b/include/io/task.h
> > index ece1372..244c1a1 100644
> > --- a/include/io/task.h
> > +++ b/include/io/task.h
> > @@ -240,6 +240,35 @@ void qio_task_abort(QIOTask *task,
> >  
> >  
> >  /**
> > + * qio_task_set_error:
> > + * @task: the task struct
> > + * @err: pointer to the error
> > + *
> > + * Associate an error with the task, which can later
> > + * be retrieved with the qio_task_propagate_error()
> > + * method. This method takes ownership of @err, so
> > + * it is not valid to access it after this call
> > + * completes.
> > + */
> > +void qio_task_set_error(QIOTask *task,
> > +                        Error *err);
> 
> Is it valid for @err to be NULL (or put another way, may callers blindly
> call this function whether or not an error has occurred)?...
> 
> > +
> > +
> > +/**
> > + * qio_task_propagate_error:
> > + * @task: the task struct
> > + * @errp: pointer to a NULL-initialized error object
> > + *
> > + * Propagate the error associated with @task
> > + * into @errp.
> > + *
> > + * Returns: true if an error was propagated, false otherwise
> > + */
> > +gboolean qio_task_propagate_error(QIOTask *task,
> 
> Must this return 'gboolean' (in which case the docs should mention
> TRUE/FALSE rather than true/false)? Or can we make it return the nicer
> 'bool'?

bool is fine - gboolean is just from my habit of using glib

> > @@ -159,6 +163,25 @@ void qio_task_abort(QIOTask *task,
> >  }
> >  
> >  
> > +void qio_task_set_error(QIOTask *task,
> > +                        Error *err)
> > +{
> > +    error_propagate(&task->err, err);
> 
> ...As written, qio_task_set_error(task, NULL) is thus valid as a no-op;
> and in turn, qio_task_set_error(task, err) is unconditionally valid a
> cleanup path regardless of whether the cleanup was reached on success
> (err is still NULL) or failure (err is set).  But it's worth documenting.
> 
> In fact, error_propagate() can be called more than once (first call
> wins, all later calls silently drop the subsequent error in favor of a
> first one already present), and therefore qio_task_set_error() gains
> that same property.  Worth documenting?

Ok, will expand docs.


Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
