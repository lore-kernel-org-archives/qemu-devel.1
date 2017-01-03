Received: from eggs.gnu.org ([2001:4830:134:3::10]:59704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cOSkb-0001dp-4X
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 12:19:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cOSkW-0000RV-6h
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 12:19:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33114)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1cOSkV-0000RL-UU
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 12:19:48 -0500
Date: Tue, 3 Jan 2017 18:19:49 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170103181949.37434fb8@Igors-MacBook-Pro.local>
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
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com, armbru@redhat.com, dgilbert@redhat.com, afaerber@suse.de

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
> member.
it would 'inject' 'id' only for objects that have 'id' property.
or more exactly it would restore 'id' that is deleted earlier from
the same qdict. Look for qdict_del() usage in this file.
This way it'd be able to process both kinds of objects that implement
'id' property and ones that don't.
 
> Which means that you are now explicitly relying on the visitor
> to silently ignore garbage in the dictionary, rather than our desired
> goal of only validating if the dictionary exactly matches what the QAPI
> says it will match.
currently 'id' is mandatory, but not enforced by QAPI structs,
for all objects created with -object/object_add as it's used for
naming object in qom tree:
      object_property_add_child(object_get_objects_root(), id, obj, &local_err); 

> 
> I'm not sure if I like this hack, or if there is a better way to do
> things when using a strict (rather than relaxed) input visitor.
I'm not sure about a better way to do this.
Currently we use 2 visitors: opts (for cli/hmp) and qobject_input for qmp path,
which accept anything as target object could take different options.

The only things we currently enforce in code is presence of implicit 'qom-type' property
and 'id' property. The rest of properties are validated by object's property setters.

> 
> >      visit_start_struct(v, NULL, NULL, 0, &local_err);
> >      if (local_err) {
> >          goto out;
> > 
> 
