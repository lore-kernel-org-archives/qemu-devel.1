Received: from eggs.gnu.org ([2001:4830:134:3::10]:59575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cQsOt-0005k6-Ga
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 04:07:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cQsOo-00087l-IG
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 04:07:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40968)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1cQsOo-00086U-BO
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 04:07:22 -0500
Date: Tue, 10 Jan 2017 10:07:18 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170110100718.3b49a954@nial.brq.redhat.com>
In-Reply-To: <76f63302-2cb2-199e-317f-7d44212188b9@redhat.com>
References: <1483371890-289981-1-git-send-email-imammedo@redhat.com>
	<1483371890-289981-4-git-send-email-imammedo@redhat.com>
	<bd7470b8-42e1-c681-f5c5-0d3808e0a9b6@redhat.com>
	<20170109151733.34510569@nial.brq.redhat.com>
	<76f63302-2cb2-199e-317f-7d44212188b9@redhat.com>
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
Cc: ehabkost@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com, dgilbert@redhat.com, pbonzini@redhat.com, afaerber@suse.de

On Mon, 9 Jan 2017 14:26:28 -0600
Eric Blake <eblake@redhat.com> wrote:

> On 01/09/2017 08:17 AM, Igor Mammedov wrote:
> 
> >> Wait. Isn't this going to inject an 'id' dict member to every use of
> >> user_creatable_add_type()?  But not all QAPI structs contain an id
> >> member.  Which means that you are now explicitly relying on the visitor
> >> to silently ignore garbage in the dictionary, rather than our desired
> >> goal of only validating if the dictionary exactly matches what the QAPI
> >> says it will match.
> >>
> >> I'm not sure if I like this hack, or if there is a better way to do
> >> things when using a strict (rather than relaxed) input visitor.  
> > a bit less ugly variant but with the same basic idea would look like:
> > --------------
> > Subject: [PATCH] fix qmp/hmp query-memdev not reporting IDs of memory backends   
> >                                                                                  
> > Considering 'id' is mandatory for user_creatable objects/backends                
> > and user_creatable_add_type() always has it as an argument                       
> > regardless of where from it is called CLI/monitor or QMP,                        
> > Fix issue by adding 'id' property to hostmem backends and                        
> > set it in user_creatable_add_type() for every object that                        
> > implements 'id' property. Then later at query-memdev time                        
> > get 'id' from object directly.                       
> 
> Yes, that seems like an improved message.
> 
> >                                                                                  
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com> 
> > 
> > [...]
> > 
> > diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
> > index 9b4155a..03a95c3 100644
> > --- a/qom/object_interfaces.c
> > +++ b/qom/object_interfaces.c
> > @@ -62,6 +62,12 @@ Object *user_creatable_add_type(const char *type, const char *id,
> >  
> >      assert(qdict);
> >      obj = object_new(type);
> > +    if (object_property_find(obj, "id", NULL)) {
> > +        object_property_set_str(obj, id, "id", &local_err);
> > +        if (local_err) {
> > +            goto out;
> > +        }
> > +    }  
> 
> Works for me.
> 

Thanks,
Then, I'll respin v2 with noted fixups in commit messages
this amended patch.
