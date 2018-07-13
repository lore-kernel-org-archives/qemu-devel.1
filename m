Received: from eggs.gnu.org ([2001:4830:134:3::10]:47315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fe5Qk-00053N-0W
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 17:16:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fe5Qj-0003oW-2M
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 17:16:46 -0400
Date: Fri, 13 Jul 2018 18:16:36 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180713211636.GS31657@localhost.localdomain>
References: <1531470464-21522-1-git-send-email-thuth@redhat.com>
	<1531470464-21522-2-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531470464-21522-2-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 01/16] qom/object: Add a new function
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

On Fri, Jul 13, 2018 at 10:27:29AM +0200, Thomas Huth wrote:
> A lot of code is using the object_initialize() function followed by a call
> to object_property_add_child() to add the newly initialized object as a child
> of the current object. Both functions increase the reference counter of the
> new object, but many spots that call these two functions then forget to drop
> one of the superfluous references. So the newly created object is often not
> cleaned up correctly when the parent is destroyed. In the worst case, this
> can cause crashes, e.g. because device objects are not correctly removed from
> their parent_bus.
> 
> Since this is a common pattern between many code spots, let's introdcue a
> new function that takes care of calling all three required initialization
> functions, first object_initialize(), then object_property_add_child() and
> finally object_unref().
> 
> And while we're at object.h, also fix some copy-n-paste errors in the
> comments there ("to store the area" --> "to store the error").
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  include/qom/object.h | 23 +++++++++++++++++++++--
>  qom/object.c         | 15 +++++++++++++++
>  2 files changed, 36 insertions(+), 2 deletions(-)
> 
> diff --git a/include/qom/object.h b/include/qom/object.h
> index f3d2308..3362db0 100644
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -749,6 +749,25 @@ int object_set_propv(Object *obj,
>  void object_initialize(void *obj, size_t size, const char *typename);
>  
>  /**
> + * object_initialize_child:
> + * @parentobj: The parent object to add a property to
> + * @propname: The name of the property
> + * @childobj: A pointer to the memory to be used for the object.
> + * @size: The maximum size available at @obj for the object.
> + * @type: The name of the type of the object to instantiate.
> + * @errp: If an error occurs, a pointer to an area to store the error
> + *
> + * This function will initialize an object. The memory for the object should
> + * have already been allocated. The object will then be added as child property
> + * to a parent with object_property_add_child() function. The returned object
> + * has a reference count of 1 (for the "child<...>" property from the parent),
> + * so the object will get finalized automatically when the parent gets removed.
> + */
> +void object_initialize_child(Object *parentobj, const char *propname,
> +                             void *childobj, size_t size, const char *type,
> +                             Error **errp);

I wonder if we should deprecate object_initialize() and support
only object_initialize_child() later.  Initializing an object
contained inside another one without making it a child of the
parent object is a recipe for trouble.

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

-- 
Eduardo
