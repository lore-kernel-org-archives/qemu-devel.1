Received: from eggs.gnu.org ([2001:4830:134:3::10]:52513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e2gMp-0007Aq-1N
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 12:29:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e2gMl-0001qZ-3L
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 12:29:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59826)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1e2gMk-0001q7-TW
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 12:29:47 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 05AE8641EF
	for <qemu-devel@nongnu.org>; Thu, 12 Oct 2017 16:29:46 +0000 (UTC)
Date: Thu, 12 Oct 2017 18:29:43 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20171012182943.10d1bfc3@nial.brq.redhat.com>
In-Reply-To: <78ea3fd4-56e6-2b03-5a65-0fb9026ffdb7@redhat.com>
References: <20171012142153.125b5bd8@nial.brq.redhat.com>
	<20171012122826.GK16125@redhat.com>
	<20171012143815.746b0d14@nial.brq.redhat.com>
	<78ea3fd4-56e6-2b03-5a65-0fb9026ffdb7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] QAPI magician wanted ...
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>

On Thu, 12 Oct 2017 08:17:16 -0500
Eric Blake <eblake@redhat.com> wrote:

> On 10/12/2017 07:38 AM, Igor Mammedov wrote:
> > On Thu, 12 Oct 2017 13:28:26 +0100
> > "Daniel P. Berrange" <berrange@redhat.com> wrote:
> >   
> >> On Thu, Oct 12, 2017 at 02:21:53PM +0200, Igor Mammedov wrote:  
> >>>
> >>> I'm working on introducing QMP command to set numa mappings
> >>> via QMP interface at runtime instead of CLI.
> >>>
> >>> I'd prefer to reuse NumaOptions for parsing input,
> >>> but I can't wrap my head around QAPI magic.
> >>>
> >>> So far I've added new command in qapi-schema.json:
> >>>
> >>>   {
> >>>     'command': 'set-numa-node',                                                    
> >>>     'data': {'cmd': 'NumaOptions'}                                                 
> >>>   }    
> >>
> >> I don't see any point in the extra level of nesting you have here, vs
> >> using NumaOptions as the data directly eg
> >>
> >>    {
> >>      'command': 'set-numa-node',
> >>      'data': 'NumaOptions'              
> >>    }  
> > I've tried that, it doesn't compile
> >    'data' for command 'set-numa-node' cannot use union type 'NumaOptions'  
> 
> { 'command': 'set-numa-node', 'boxed': true,
>   'data': 'NumaOptions' }
> 
> To use a union directly as the command (which is a GOOD idea), you have
> to tell the generator to pass it as a boxed item to the
> qmp_set_numa_node function, rather than as exploded parameters, since
> the generator can't explode parameters from a union..
Thanks for suggestion,
it works and I don't need extra nesting anymore.


> >> I think the union gets flattenned - ie you probably want
> >>
> >>    { "execute": "set-numa-node", "arguments": { "cmd": { "type": "node", "nodeid": 1 } } }  
> > thanks, that works for me 
> >   
> >>
> >> Though with my suggestion above you could get it to just
> >>
> >>    { "execute": "set-numa-node", "arguments": { "type": "node", "nodeid": 1 } }  
> 
> Yes, I'd prefer this form without the extra nesting.
> 
> 
