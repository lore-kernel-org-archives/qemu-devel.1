Received: from eggs.gnu.org ([2001:4830:134:3::10]:48067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ffAhi-0002RJ-Kl
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 17:06:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ffAhh-00052q-4K
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 17:06:46 -0400
Date: Mon, 16 Jul 2018 18:06:36 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180716210636.GS31657@localhost.localdomain>
References: <1531745974-17187-1-git-send-email-thuth@redhat.com>
	<1531745974-17187-2-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531745974-17187-2-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 01/17] qom/object: Add a new function
 object_initialize_child()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, Markus Armbruster <armbru@redhat.com>, Beniamino Galvani <b.galvani@gmail.com>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Alistair Francis <alistair@alistair23.me>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>

On Mon, Jul 16, 2018 at 02:59:18PM +0200, Thomas Huth wrote:
> A lot of code is using the object_initialize() function followed by a call
> to object_property_add_child() to add the newly initialized object as a child
> of the current object. Both functions increase the reference counter of the
> new object, but many spots that call these two functions then forget to drop
> one of the superfluous references. So the newly created object is often not
> cleaned up correctly when the parent is destroyed. In the worst case, this
> can cause crashes, e.g. because device objects are not correctly removed from
> their parent_bus.
> 
> Since this is a common pattern between many code spots, let's introduce a
> new function that takes care of calling all three required initialization
> functions, first object_initialize(), then object_property_add_child() and
> finally object_unref(). And since the function does a similar job like
> object_new_with_props(), also allow to set additional properties via
> varargs, and use user_creatable_complete() to make sure that the functions
> can be used similarly.
> 
> And while we're at object.h, also fix some copy-n-paste errors in the
> comments there ("to store the area" --> "to store the error").
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  include/qom/object.h | 45 +++++++++++++++++++++++++++++++++++++++++--
>  qom/object.c         | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 97 insertions(+), 2 deletions(-)
> 
> diff --git a/include/qom/object.h b/include/qom/object.h
> index f3d2308..f0b0bf3 100644
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -749,6 +749,47 @@ int object_set_propv(Object *obj,
>  void object_initialize(void *obj, size_t size, const char *typename);
>  
>  /**
> + * object_initialize_child:
> + * @parentobj: The parent object to add a property to
> + * @propname: The name of the property
> + * @childobj: A pointer to the memory to be used for the object.
> + * @size: The maximum size available at @childobj for the object.
> + * @type: The name of the type of the object to instantiate.
> + * @errp: If an error occurs, a pointer to an area to store the error
> + * @...: list of property names and values
> + *
> + * This function will initialize an object. The memory for the object should
> + * have already been allocated. The object will then be added as child property
> + * to a parent with object_property_add_child() function. The returned object
> + * has a reference count of 1 (for the "child<...>" property from the parent),
> + * so the object will be finalized automatically when the parent gets removed.
> + *
> + * The variadic parameters are a list of pairs of (propname, propvalue)
> + * strings. The propname of %NULL indicates the end of the property list.
> + * If the object implements the user creatable interface, the object will
> + * be marked complete once all the properties have been processed.
> + */
> +void object_initialize_child(Object *parentobj, const char *propname,
> +                             void *childobj, size_t size, const char *type,
> +                             Error **errp, ...) QEMU_SENTINEL;
> +
> +/**
> + * object_initialize_childv:
> + * @parentobj: The parent object to add a property to
> + * @propname: The name of the property
> + * @childobj: A pointer to the memory to be used for the object.
> + * @size: The maximum size available at @childobj for the object.
> + * @type: The name of the type of the object to instantiate.
> + * @errp: If an error occurs, a pointer to an area to store the error
> + * @vargs: list of property names and values
> + *
> + * See object_initialize_child() for documentation.
> + */
> +void object_initialize_childv(Object *parentobj, const char *propname,
> +                              void *childobj, size_t size, const char *type,
> +                              Error **errp, va_list vargs);
> +
> +/**
>   * object_dynamic_cast:
>   * @obj: The object to cast.
>   * @typename: The @typename to cast to.
> @@ -1382,7 +1423,7 @@ Object *object_resolve_path_component(Object *parent, const gchar *part);
>   * @obj: the object to add a property to
>   * @name: the name of the property
>   * @child: the child object
> - * @errp: if an error occurs, a pointer to an area to store the area
> + * @errp: if an error occurs, a pointer to an area to store the error
>   *
>   * Child properties form the composition tree.  All objects need to be a child
>   * of another object.  Objects can only be a child of one object.
> @@ -1420,7 +1461,7 @@ void object_property_allow_set_link(const Object *, const char *,
>   * @child: a pointer to where the link object reference is stored
>   * @check: callback to veto setting or NULL if the property is read-only
>   * @flags: additional options for the link
> - * @errp: if an error occurs, a pointer to an area to store the area
> + * @errp: if an error occurs, a pointer to an area to store the error
>   *
>   * Links establish relationships between objects.  Links are unidirectional
>   * although two links can be combined to form a bidirectional relationship
> diff --git a/qom/object.c b/qom/object.c
> index 4609e34..75d1d48 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -392,6 +392,60 @@ void object_initialize(void *data, size_t size, const char *typename)
>      object_initialize_with_type(data, size, type);
>  }
>  
> +void object_initialize_child(Object *parentobj, const char *propname,
> +                             void *childobj, size_t size, const char *type,
> +                             Error **errp, ...)
> +{
> +    va_list vargs;
> +
> +    va_start(vargs, errp);
> +    object_initialize_childv(parentobj, propname, childobj, size, type, errp,
> +                             vargs);
> +    va_end(vargs);
> +}
> +
> +void object_initialize_childv(Object *parentobj, const char *propname,
> +                              void *childobj, size_t size, const char *type,
> +                              Error **errp, va_list vargs)
> +{
> +    Error *local_err = NULL;
> +    Object *obj;
> +
> +    object_initialize(childobj, size, type);
> +    obj = OBJECT(childobj);
> +
> +    object_set_propv(obj, &local_err, vargs);
> +    if (local_err) {
> +        goto out;
> +    }
> +
> +    object_property_add_child(parentobj, propname, obj, &local_err);
> +    if (local_err) {
> +        goto out;
> +    }
> +
> +    if (object_dynamic_cast(obj, TYPE_USER_CREATABLE)) {
> +        user_creatable_complete(obj, &local_err);
> +        if (local_err) {
> +            object_unparent(obj);
> +            goto out;
> +        }
> +    }

I don't like adding TYPE_USER_CREATABLE-specific hacks to QOM
core, but well, at least this is consistent with
object_new_with_propv().

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

> +
> +    /*
> +     * Since object_property_add_child added a reference to the child object,
> +     * we can drop the reference added by object_initialize(), so the child
> +     * property will own the only reference to the object.
> +     */
> +    object_unref(obj);
> +
> +out:
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        object_unref(obj);
> +    }
> +}
> +
>  static inline bool object_property_is_child(ObjectProperty *prop)
>  {
>      return strstart(prop->type, "child<", NULL);
> -- 
> 1.8.3.1
> 

-- 
Eduardo
