Received: from eggs.gnu.org ([2001:4830:134:3::10]:42300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cQala-0000cL-Iy
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 09:17:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cQalX-0006es-FF
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 09:17:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43790)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1cQalX-0006eK-6i
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 09:17:39 -0500
Date: Mon, 9 Jan 2017 15:17:33 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170109151733.34510569@nial.brq.redhat.com>
In-Reply-To: <bd7470b8-42e1-c681-f5c5-0d3808e0a9b6@redhat.com>
References: <1483371890-289981-1-git-send-email-imammedo@redhat.com>
	<1483371890-289981-4-git-send-email-imammedo@redhat.com>
	<bd7470b8-42e1-c681-f5c5-0d3808e0a9b6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/3] fix qmp/hmp query-memdev not
 repporting IDs of memory backends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, afaerber@suse.de, ehabkost@redhat.com, dgilbert@redhat.com, armbru@redhat.com, pbonzini@redhat.com

On Tue, 3 Jan 2017 09:34:40 -0600
Eric Blake <eblake@redhat.com> wrote:

> On 01/02/2017 09:44 AM, Igor Mammedov wrote:
> 
> s/repporting/reporting/ in the subject
> 
> > Do it by adding 'id' property to hostmem backends and fetch it
> > in query-memdev from object directly.
> > 
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---  
> 
> > +++ b/qom/object_interfaces.c
> > @@ -4,6 +4,7 @@
> >  #include "qemu/module.h"
> >  #include "qapi-visit.h"
> >  #include "qapi/opts-visitor.h"
> > +#include "qapi/qmp/qstring.h"
> >  
> >  void user_creatable_complete(Object *obj, Error **errp)
> >  {
> > @@ -35,7 +36,7 @@ bool user_creatable_can_be_deleted(UserCreatable *uc, Error **errp)
> >  }
> >  
> >  Object *user_creatable_add_type(const char *type, const char *id,
> > -                                const QDict *qdict,
> > +                                QDict *qdict,
> >                                  Visitor *v, Error **errp)
> >  {
> >      Object *obj;
> > @@ -62,6 +63,9 @@ Object *user_creatable_add_type(const char *type, const char *id,
> >  
> >      assert(qdict);
> >      obj = object_new(type);
> > +    if (object_property_find(obj, "id", NULL)) {
> > +        qdict_put(qdict, "id", qstring_from_str(id));
> > +    }  
> 
> Wait. Isn't this going to inject an 'id' dict member to every use of
> user_creatable_add_type()?  But not all QAPI structs contain an id
> member.  Which means that you are now explicitly relying on the visitor
> to silently ignore garbage in the dictionary, rather than our desired
> goal of only validating if the dictionary exactly matches what the QAPI
> says it will match.
> 
> I'm not sure if I like this hack, or if there is a better way to do
> things when using a strict (rather than relaxed) input visitor.
a bit less ugly variant but with the same basic idea would look like:
--------------
Subject: [PATCH] fix qmp/hmp query-memdev not reporting IDs of memory backends   
                                                                                 
Considering 'id' is mandatory for user_creatable objects/backends                
and user_creatable_add_type() always has it as an argument                       
regardless of where from it is called CLI/monitor or QMP,                        
Fix issue by adding 'id' property to hostmem backends and                        
set it in user_creatable_add_type() for every object that                        
implements 'id' property. Then later at query-memdev time                        
get 'id' from object directly.                                                   
                                                                                 
Signed-off-by: Igor Mammedov <imammedo@redhat.com> 

[...]

diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
index 9b4155a..03a95c3 100644
--- a/qom/object_interfaces.c
+++ b/qom/object_interfaces.c
@@ -62,6 +62,12 @@ Object *user_creatable_add_type(const char *type, const char *id,
 
     assert(qdict);
     obj = object_new(type);
+    if (object_property_find(obj, "id", NULL)) {
+        object_property_set_str(obj, id, "id", &local_err);
+        if (local_err) {
+            goto out;
+        }
+    }
     visit_start_struct(v, NULL, NULL, 0, &local_err);
     if (local_err) {
         goto out;
