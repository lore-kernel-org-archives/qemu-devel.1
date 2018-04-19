Received: from eggs.gnu.org ([2001:4830:134:3::10]:42028)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1f8zWU-00076m-QK
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 22:42:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1f8zWR-0001w8-ID
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 22:42:10 -0400
Received: from mail-pl0-x22e.google.com ([2607:f8b0:400e:c01::22e]:36711)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1f8zWR-0001vG-4T
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 22:42:07 -0400
Received: by mail-pl0-x22e.google.com with SMTP id m7-v6so2305401plt.3
	for <qemu-devel@nongnu.org>; Wed, 18 Apr 2018 19:42:06 -0700 (PDT)
References: <20180329032149.44685-1-aik@ozlabs.ru>
	<bc4100f4-0a01-a526-c6ce-c2602a96e28a@redhat.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <d8efb96c-75a0-86fd-3615-57e9099afb5c@ozlabs.ru>
Date: Thu, 19 Apr 2018 12:41:59 +1000
MIME-Version: 1.0
In-Reply-To: <bc4100f4-0a01-a526-c6ce-c2602a96e28a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu] RFC: memory/hmp: Print owners/parents
 in "info mtree"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>

On 12/4/18 7:15 pm, Paolo Bonzini wrote:
> On 29/03/2018 05:21, Alexey Kardashevskiy wrote:
>> +    DeviceState *dev = (DeviceState *) object_dynamic_cast(obj, TYPE_DEVICE);
>> +    const char *id = object_property_print(obj, "id", true, NULL);
> 
> I learnt now about commit e1ff3c67e8544f41f1bea76ba76385faee0d2bb7 and I
> find it a mistake.  The "id" is available through
> object_get_canonical_path_component.  Can you change the "id" assignment
> to use object_get_canonical_path_component instead?

Uff. I did some tests and found that this is needed, at least. I can also
returning NULL from object_get_canonical_path_component(), it just seems to
be a real case and majority of object_get_canonical_path_component() users
do not test the returned pointer.

===================
diff --git a/qom/object.c b/qom/object.c
index 4677951..0c2d5c2 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1645,7 +1645,9 @@ gchar *object_get_canonical_path_component(Object *obj)
     GHashTableIter iter;

     g_assert(obj);
-    g_assert(obj->parent != NULL);
+    if (!obj->parent) {
+        return g_strdup("<no-parent>");
+    }

     g_hash_table_iter_init(&iter, obj->parent->properties);
     while (g_hash_table_iter_next(&iter, NULL, (gpointer *)&prop)) {
@@ -1668,7 +1670,7 @@ gchar *object_get_canonical_path(Object *obj)
     Object *root = object_get_root();
     char *newpath, *path = NULL;

-    while (obj != root) {
+    while (obj && obj != root) {
         char *component = object_get_canonical_path_component(obj);

         if (path) {
@@ -1681,6 +1683,8 @@ gchar *object_get_canonical_path(Object *obj)
         }

         obj = obj->parent;
+        if (!obj)
+            printf("+++Q+++ (%u) %s %u\n", getpid(), __func__, __LINE__);
     }

====================


as QMP crashes QEMU with this:

{"execute": "qom-get", "arguments": {"path":
"/machine/unattached/device[3]/smram[0]", "property": "container"}}

with the patch it returns:

{'return': '/<no-parent>/mem-container-smram[0]'}


Without the patch it crashes as:

(gdb) bt
#0  object_get_canonical_path (obj=0x0) at /home/aik/p/qemu/qom/object.c:1687
#1  0x0000555555829676 in memory_region_get_container (obj=0x555556d5c6e0,
v=0x555557a7c530, name=0x5555569a4fe0 "container", opaque=0x0,
errp=0x7fffffffda58) at /home/aik/p/qemu/memory.c:1172
#2  0x0000555555bf719a in object_property_get (obj=0x555556d5c6e0,
v=0x555557a7c530, name=0x5555569a4fe0 "container", errp=0x7fffffffda58) at
/home/aik/p/qemu/qom/object.c:1107
#3  0x0000555555bfa2de in object_property_get_qobject (obj=0x555556d5c6e0,
name=0x5555569a4fe0 "container", errp=0x7fffffffdae8) at
/home/aik/p/qemu/qom/qom-qobject.c:39
#4  0x00005555559963cf in qmp_qom_get (path=0x5555576e5680
"/machine/unattached/device[3]/smram[0]", property=0x5555569a4fe0
"container", errp=0x7fffffffdae8) at /home/aik/p/qemu/qmp.c:271
#5  0x000055555598de6c in qmp_marshal_qom_get (args=0x5555573b5720,
ret=0x7fffffffdb60, errp=0x7fffffffdb58) at qapi/qapi-commands-misc.c:1249
#6  0x0000555555d155ad in do_qmp_dispatch (cmds=0x55555645a3e0
<qmp_commands>, request=0x5555573aff80, errp=0x7fffffffdbb0) at
/home/aik/p/qemu/qapi/qmp-dispatch.c:111
#7  0x0000555555d1576d in qmp_dispatch (cmds=0x55555645a3e0 <qmp_commands>,
request=0x5555573aff80) at /home/aik/p/qemu/qapi/qmp-dispatch.c:160
#8  0x0000555555819361 in monitor_qmp_dispatch_one (req_obj=0x555556fd7ee0)
at /home/aik/p/qemu/monitor.c:4091
#9  0x0000555555819573 in monitor_qmp_bh_dispatcher (data=0x0) at
/home/aik/p/qemu/monitor.c:4149
#10 0x0000555555d23df9 in aio_bh_call (bh=0x555556a1a650) at
/home/aik/p/qemu/util/async.c:90
#11 0x0000555555d23e91 in aio_bh_poll (ctx=0x5555569f0ce0) at
/home/aik/p/qemu/util/async.c:118
#12 0x0000555555d28a92 in aio_dispatch (ctx=0x5555569f0ce0) at
/home/aik/p/qemu/util/aio-posix.c:436
#13 0x0000555555d2422c in aio_ctx_dispatch (source=0x5555569f0ce0,
callback=0x0, user_data=0x0) at /home/aik/p/qemu/util/async.c:261
#14 0x00007ffff4cc6b77 in ?? ()
#15 0x0000000000000000 in ?? ()


It is fc27/x86_64 both host and guest, QMP issues when guest booted to the
login prompt (so I'd not expect any hotplugs) and I have no idea what smram
is and what its parent should be.


>> +    const char *name = object_property_print(obj, "name", true, NULL);
> 
> Who defines a name property?

Nothing, not sure why I put it here in the first place, will remove.

> 
>> +    mon_printf(f, " %s:{", label);
>> +    if (dev) {
>> +        mon_printf(f, "dev");
>> +        if (dev->id) {
>> +            mon_printf(f, " id=%s", dev->id);
>> +        }
>> +    } else {
>> +        mon_printf(f, "obj");
> 
>> +    }
>> +    if (name) {
>> +        mon_printf(f, " name=%s ", name);
>> +    }
>> +    if (id) {
>> +        mon_printf(f, " id=%s ", id);
>> +    }
>> +    if (dev && (!name && !id && !dev->id)) {
>> +        mon_printf(f, " path=%s", dev->canonical_path);
> 
> Why not print the path for the !dev case?  I think we can just have
> 
>     mon_prinf(f, " %s:{%s", label, dev ? "dev" : "obj");
>     if (dev ? dev->id : id) {
>         mon_printf(f, " id=%s", dev ? dev->id : id);
>     } else {
>         canonical_path = object_get_canonical_path(...)
>         mon_printf(f, " path=%s", canonical_path);
>         g_free(canonical_path);
>     }

Makes sense, assuming the issue above is fixed.


> 
> Thanks,
> 
> Paolo
> 


-- 
Alexey
