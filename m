Received: from eggs.gnu.org ([2001:4830:134:3::10]:35698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fdepW-0008Kg-Ic
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 12:52:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fdepV-00031X-N9
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 12:52:34 -0400
Date: Thu, 12 Jul 2018 13:52:24 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180712165224.GD31657@localhost.localdomain>
References: <1531409463-3843-1-git-send-email-thuth@redhat.com>
	<1531409463-3843-2-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531409463-3843-2-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/5] qom/object: Add a new function
 object_initialize_as_child()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, Markus Armbruster <armbru@redhat.com>

On Thu, Jul 12, 2018 at 05:30:59PM +0200, Thomas Huth wrote:
> A lot of code is using the object_initialize() function followed by a call to
> object_property_add_child() to add the newly initialized object as a child of
> the current object. Both functions increase the reference counter of the new
> object, but many spots that call these two functions then forget to drop one
> of the superfluous references. So the newly created object is often not cleaned
> up correctly when the parent is destroyed. In the worst case, this can cause
> crashes, e.g. because device objects are not correctly removed from their
> parent_bus.
> Since this is a common pattern between many code spots, let's introdcue a
> new function that takes care of calling all three required initialization
> functions, first object_initialize(), then object_property_add_child() and
> finally object_unref().
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  include/qom/object.h | 19 +++++++++++++++++++
>  qom/object.c         | 14 ++++++++++++++
>  2 files changed, 33 insertions(+)
> 
> diff --git a/include/qom/object.h b/include/qom/object.h
> index f3d2308..c1b254c 100644
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -749,6 +749,25 @@ int object_set_propv(Object *obj,
>  void object_initialize(void *obj, size_t size, const char *typename);
>  
>  /**
> + * object_initialize_as_child:
> + * @parentobj: The parent object to add a property to
> + * @propname: The name of the property
> + * @childobj: A pointer to the memory to be used for the object.
> + * @size: The maximum size available at @obj for the object.
> + * @type: The name of the type of the object to instantiate.
> + * @errp: If an error occurs, a pointer to an area to store the area
> + *
> + * This function will initialize an object. The memory for the object should
> + * have already been allocated. The object will then be added as child property
> + * to a parent with object_property_add_child() function. The returned object
> + * has a reference count of 1, and will be finalized when the last reference is
> + * dropped.
> + */
> +void object_initialize_as_child(Object *parentobj, const char *propname,
> +                                void *childobj, size_t size, const char *type,
> +                                Error **errp);

Why did you use void* instead of Object*?

-- 
Eduardo
