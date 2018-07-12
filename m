Received: from eggs.gnu.org ([2001:4830:134:3::10]:47787)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fdhX2-00089H-MW
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 15:45:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fdhX1-0001My-4L
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 15:45:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48252)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fdhX0-0001MM-N9
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 15:45:39 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 12 Jul 2018 16:45:20 -0300
Message-Id: <20180712194522.31063-2-ehabkost@redhat.com>
In-Reply-To: <20180712194522.31063-1-ehabkost@redhat.com>
References: <20180712194522.31063-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC 1/3] qom: Document reference count ownership rules
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>

The documentation for QOM is not clear about who owns references
to objects (i.e. who is responsible for calling object_unref()
later).

This is important considering there are a few inconsistencies in
the API (e.g. callers of object_new() need to call object_unref()
later, but callers of object_new_with_props() must not do it).

Update the documentation so that every mention of object
references also mention who exactly owns the reference.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/qom/object.h | 73 +++++++++++++++++++++++++-------------------
 1 file changed, 42 insertions(+), 31 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index f3d2308d56..08a1bbba7d 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -376,7 +376,7 @@ typedef void (ObjectUnparent)(Object *obj);
  * ObjectFree:
  * @obj: the object being freed
  *
- * Called when an object's last reference is removed.
+ * Called when an object's last reference is dropped using object_unref().
  */
 typedef void (ObjectFree)(void *obj);
 
@@ -601,8 +601,8 @@ struct InterfaceClass
  * @typename: The name of the type of the object to instantiate.
  *
  * This function will initialize a new object using heap allocated memory.
- * The returned object has a reference count of 1, and will be freed when
- * the last reference is dropped.
+ * The returned object has a reference count of 1, and the reference will be
+ * owned by the caller.
  *
  * Returns: The newly allocated and instantiated object.
  */
@@ -617,8 +617,8 @@ Object *object_new(const char *typename);
  * @...: list of property names and values
  *
  * This function will initialize a new object using heap allocated memory.
- * The returned object has a reference count of 1, and will be freed when
- * the last reference is dropped.
+ * The returned object has a reference count of 1, and the reference will
+ * be owned by the caller.
  *
  * The @id parameter will be used when registering the object as a
  * child of @parent in the composition tree.
@@ -652,8 +652,8 @@ Object *object_new(const char *typename);
  *   </programlisting>
  * </example>
  *
- * The returned object will have one stable reference maintained
- * for as long as it is present in the object hierarchy.
+ * The returned object will have one reference, <emphasis>owned by the
+ * parent object</emphasis> (not by the caller).
  *
  * Returns: The newly allocated, instantiated & initialized object.
  */
@@ -713,9 +713,6 @@ Object *object_new_with_propv(const char *typename,
  *   </programlisting>
  * </example>
  *
- * The returned object will have one stable reference maintained
- * for as long as it is present in the object hierarchy.
- *
  * Returns: -1 on error, 0 on success
  */
 int object_set_props(Object *obj,
@@ -744,7 +741,7 @@ int object_set_propv(Object *obj,
  *
  * This function will initialize an object.  The memory for the object should
  * have already been allocated.  The returned object has a reference count of 1,
- * and will be finalized when the last reference is dropped.
+ * and the reference will be owned by the caller.
  */
 void object_initialize(void *obj, size_t size, const char *typename);
 
@@ -928,8 +925,12 @@ GSList *object_class_get_list_sorted(const char *implements_type,
  * object_ref:
  * @obj: the object
  *
- * Increase the reference count of a object.  A object cannot be freed as long
- * as its reference count is greater than zero.
+ * Increase the reference count of a object.  A object won't be freed as
+ * long as its reference count is greater than zero.
+ *
+ * The new reference will be owned by the caller, meaning the caller is
+ * responsible for ensuring object_unref() will be called once the
+ * reference is not needed anymore.
  */
 void object_ref(Object *obj);
 
@@ -937,8 +938,10 @@ void object_ref(Object *obj);
  * object_unref:
  * @obj: the object
  *
- * Decrease the reference count of a object.  A object cannot be freed as long
- * as its reference count is greater than zero.
+ * Drop a reference to a object, decreasing its reference count.  This
+ * function should be called only if the caller owns a reference taken using
+ * object_ref() or returned by functions like object_initialize() and
+ * object_new().
  */
 void object_unref(Object *obj);
 
@@ -1104,10 +1107,13 @@ char *object_property_get_str(Object *obj, const char *name,
  *
  * Writes an object's canonical path to a property.
  *
- * If the link property was created with
- * <code>OBJ_PROP_LINK_STRONG</code> bit, the old target object is
- * unreferenced, and a reference is added to the new target object.
+ * If the link property was created with <code>OBJ_PROP_LINK_STRONG</code>
+ * bit, the property will take a reference to the object, and drop
+ * a reference to the old object.
  *
+ * If <code>OBJ_PROP_LINK_STRONG</code> was not set for the property, the
+ * caller is responsible for ensuring the object will stay alive until the
+ * property is modified or deleted.
  */
 void object_property_set_link(Object *obj, Object *value,
                               const char *name, Error **errp);
@@ -1398,7 +1404,10 @@ void object_property_add_child(Object *obj, const char *name,
                                Object *child, Error **errp);
 
 typedef enum {
-    /* Unref the link pointer when the property is deleted */
+    /*
+     * Property owns a reference to the target object.  Unref the link
+     * pointer when the property is modified or deleted.
+     */
     OBJ_PROP_LINK_STRONG = 0x1,
 } ObjectPropertyLinkFlags;
 
@@ -1433,13 +1442,14 @@ void object_property_allow_set_link(const Object *, const char *,
  * link being set.  If <code>@check</code> is NULL, the property is read-only
  * and cannot be set.
  *
- * Ownership of the pointer that @child points to is transferred to the
- * link property.  The reference count for <code>*@child</code> is
- * managed by the property from after the function returns till the
- * property is deleted with object_property_del().  If the
- * <code>@flags</code> <code>OBJ_PROP_LINK_STRONG</code> bit is set,
- * the reference count is decremented when the property is deleted or
- * modified.
+ * If the <code>OBJ_PROP_LINK_STRONG</code> bit is set in @flags,
+ * ownership of the pointer that @child points to is transferred to the
+ * link property, and the reference will be dropped when the property is
+ * modified or deleted with object_property_del().
+ *
+ * If <code>OBJ_PROP_LINK_STRONG</code> is not set in @flags, the caller
+ * is responsible for ensuring the object pointed by @child will stay alive
+ * until the property is modified or deleted.
  */
 void object_property_add_link(Object *obj, const char *name,
                               const char *type, Object **child,
@@ -1607,7 +1617,8 @@ void object_class_property_add_uint64_ptr(ObjectClass *klass, const char *name,
  * Add an alias for a property on an object.  This function will add a property
  * of the same type as the forwarded property.
  *
- * The caller must ensure that <code>@target_obj</code> stays alive as long as
+ * The property won't take a reference to <code>@target_obj</code>, so the
+ * caller must ensure that <code>@target_obj</code> stays alive as long as
  * this property exists.  In the case of a child object or an alias on the same
  * object this will be the case.  For aliases to other objects the caller is
  * responsible for taking a reference.
@@ -1626,10 +1637,10 @@ void object_property_add_alias(Object *obj, const char *name,
  * Add an unmodifiable link for a property on an object.  This function will
  * add a property of type link<TYPE> where TYPE is the type of @target.
  *
- * The caller must ensure that @target stays alive as long as
- * this property exists.  In the case @target is a child of @obj,
- * this will be the case.  Otherwise, the caller is responsible for
- * taking a reference.
+ * The property won't take a reference to <code>@target_obj</code>, so the
+ * caller must ensure that @target stays alive as long as this property
+ * exists.  In the case @target is a child of @obj, this will be the case.
+ * Otherwise, the caller is responsible for taking a reference.
  */
 void object_property_add_const_link(Object *obj, const char *name,
                                     Object *target, Error **errp);
-- 
2.18.0.rc1.1.g3f1ff2140
