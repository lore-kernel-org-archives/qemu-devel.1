Received: from eggs.gnu.org ([2001:4830:134:3::10]:37577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fe4Yc-0002qk-Pr
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 16:20:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fe4YZ-0006hD-Hq
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 16:20:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56796)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fe4YZ-0006gN-8F
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 16:20:47 -0400
Date: Fri, 13 Jul 2018 17:20:38 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180713202038.GQ31657@localhost.localdomain>
References: <20180712194522.31063-1-ehabkost@redhat.com>
	<20180712194522.31063-2-ehabkost@redhat.com>
	<62728fab-c201-b212-98e9-5a5b1af315a4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62728fab-c201-b212-98e9-5a5b1af315a4@redhat.com>
Subject: Re: [Qemu-devel] [RFC 1/3] qom: Document reference count ownership
 rules
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>

On Fri, Jul 13, 2018 at 11:07:15AM +0200, Thomas Huth wrote:
> On 12.07.2018 21:45, Eduardo Habkost wrote:
> > The documentation for QOM is not clear about who owns references
> > to objects (i.e. who is responsible for calling object_unref()
> > later).
> > 
> > This is important considering there are a few inconsistencies in
> > the API (e.g. callers of object_new() need to call object_unref()
> > later, but callers of object_new_with_props() must not do it).
> > 
> > Update the documentation so that every mention of object
> > references also mention who exactly owns the reference.
> > 
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > ---
> >  include/qom/object.h | 73 +++++++++++++++++++++++++-------------------
> >  1 file changed, 42 insertions(+), 31 deletions(-)
> > 
> > diff --git a/include/qom/object.h b/include/qom/object.h
> > index f3d2308d56..08a1bbba7d 100644
> > --- a/include/qom/object.h
> > +++ b/include/qom/object.h
> > @@ -376,7 +376,7 @@ typedef void (ObjectUnparent)(Object *obj);
> >   * ObjectFree:
> >   * @obj: the object being freed
> >   *
> > - * Called when an object's last reference is removed.
> > + * Called when an object's last reference is dropped using object_unref().
> >   */
> >  typedef void (ObjectFree)(void *obj);
> >  
> > @@ -601,8 +601,8 @@ struct InterfaceClass
> >   * @typename: The name of the type of the object to instantiate.
> >   *
> >   * This function will initialize a new object using heap allocated memory.
> > - * The returned object has a reference count of 1, and will be freed when
> > - * the last reference is dropped.
> > + * The returned object has a reference count of 1, and the reference will be
> > + * owned by the caller.
> >   *
> >   * Returns: The newly allocated and instantiated object.
> >   */
> > @@ -617,8 +617,8 @@ Object *object_new(const char *typename);
> >   * @...: list of property names and values
> >   *
> >   * This function will initialize a new object using heap allocated memory.
> > - * The returned object has a reference count of 1, and will be freed when
> > - * the last reference is dropped.
> > + * The returned object has a reference count of 1, and the reference will
> > + * be owned by the caller.
> 
> That's the description of object_new_with_props here already, isn't it?
> So the reference will be owned by the parent object, not by the caller.

Oops, you're right.  Thanks!

> 
> >   * The @id parameter will be used when registering the object as a
> >   * child of @parent in the composition tree.
> > @@ -652,8 +652,8 @@ Object *object_new(const char *typename);
> >   *   </programlisting>
> >   * </example>
> >   *
> > - * The returned object will have one stable reference maintained
> > - * for as long as it is present in the object hierarchy.
> > + * The returned object will have one reference, <emphasis>owned by the
> > + * parent object</emphasis> (not by the caller).
> 
> ... and then this information here is somewhat redundant. I suggest to
> remove one of the two spots.

Will change this to:

 /**
  * object_new_with_props:
  * @typename:  The name of the type of the object to instantiate.
  * @parent: the parent object
  * @id: The unique ID of the object
  * @errp: pointer to error object
  * @...: list of property names and values
  *
  * This function will initialize a new object using heap allocated memory.
- * The returned object has a reference count of 1, and will be freed when
- * the last reference is dropped.
+ * The returned object will have one reference, <emphasis>owned by the
+ * parent object</emphasis> (not by the caller).
  *
  * The @id parameter will be used when registering the object as a
  * child of @parent in the composition tree.
  *
  * The variadic parameters are a list of pairs of (propname, propvalue)
  * strings. The propname of %NULL indicates the end of the property
  * list. If the object implements the user creatable interface, the
  * object will be marked complete once all the properties have been
  * processed.
  *
  * <example>
  *   <title>Creating an object with properties</title>
  *   <programlisting>
  *   Error *err = NULL;
  *   Object *obj;
  *
  *   obj = object_new_with_props(TYPE_MEMORY_BACKEND_FILE,
  *                               object_get_objects_root(),
  *                               "hostmem0",
  *                               &err,
  *                               "share", "yes",
  *                               "mem-path", "/dev/shm/somefile",
  *                               "prealloc", "yes",
  *                               "size", "1048576",
  *                               NULL);
  *
  *   if (!obj) {
  *     g_printerr("Cannot create memory backend: %s\n",
  *                error_get_pretty(err));
  *   }
  *   </programlisting>
  * </example>
  *
- * The returned object will have one stable reference maintained
- * for as long as it is present in the object hierarchy.
- *
  * Returns: The newly allocated, instantiated & initialized object.
  */
 Object *object_new_with_props(const char *typename,
                               Object *parent,
                               const char *id,
                               Error **errp,
                               ...) QEMU_SENTINEL;

-- 
Eduardo
