Received: from eggs.gnu.org ([2001:4830:134:3::10]:60277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e2cbJ-0005YS-Ku
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 08:28:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e2cbG-0007Jd-Gv
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 08:28:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34560)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1e2cbG-0007JO-9T
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 08:28:30 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5D8BE2D0FA0
	for <qemu-devel@nongnu.org>; Thu, 12 Oct 2017 12:28:29 +0000 (UTC)
Date: Thu, 12 Oct 2017 13:28:26 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171012122826.GK16125@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171012142153.125b5bd8@nial.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171012142153.125b5bd8@nial.brq.redhat.com>
Subject: Re: [Qemu-devel] QAPI magician wanted ...
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>

On Thu, Oct 12, 2017 at 02:21:53PM +0200, Igor Mammedov wrote:
> 
> I'm working on introducing QMP command to set numa mappings
> via QMP interface at runtime instead of CLI.
> 
> I'd prefer to reuse NumaOptions for parsing input,
> but I can't wrap my head around QAPI magic.
> 
> So far I've added new command in qapi-schema.json:
> 
>   {
>     'command': 'set-numa-node',                                                    
>     'data': {'cmd': 'NumaOptions'}                                                 
>   }

I don't see any point in the extra level of nesting you have here, vs
using NumaOptions as the data directly eg

   {
     'command': 'set-numa-node',
     'data': 'NumaOptions'              
   }


> it at least compiles and manages to handle input without union part
> 
>   { "execute": "set-numa-node", "arguments": { "cmd": { "type": "node" } } }
> 
> however I can't figure out syntax that adds union part to it,
> I have tried something like this
> 
>   { "execute": "set-numa-node", "arguments": { "cmd": { "type": "node", "node" : { "nodeid": 1 } } } }
> 
> but it errors out with
> 
>   {"error": {"class": "GenericError", "desc": "Parameter 'cmd.node' is unexpected"}}
> 
> Any advice on how to make it work if possible at all or
> alternative ways how to achieve the end goal.

I think the union gets flattenned - ie you probably want

   { "execute": "set-numa-node", "arguments": { "cmd": { "type": "node", "nodeid": 1 } } }

Though with my suggestion above you could get it to just

   { "execute": "set-numa-node", "arguments": { "type": "node", "nodeid": 1 } }

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
