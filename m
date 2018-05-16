Received: from eggs.gnu.org ([2001:4830:134:3::10]:44127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fIxTt-0007Bl-33
	for qemu-devel@nongnu.org; Wed, 16 May 2018 10:32:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fIxTq-0002iV-0W
	for qemu-devel@nongnu.org; Wed, 16 May 2018 10:32:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52052 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fIxTp-0002i5-RU
	for qemu-devel@nongnu.org; Wed, 16 May 2018 10:32:37 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BB0B540201A1
	for <qemu-devel@nongnu.org>; Wed, 16 May 2018 14:32:36 +0000 (UTC)
Date: Wed, 16 May 2018 16:32:34 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180516163234.79a6e692@redhat.com>
In-Reply-To: <87eficu8g1.fsf@dusky.pond.sub.org>
References: <1526395713-60357-1-git-send-email-imammedo@redhat.com>
	<20180515152641.7oaxop77wgzokr7h@kamzik.brq.redhat.com>
	<3543e1cb-85b9-7f50-f97f-e8f2b98b10e0@redhat.com>
	<87eficu8g1.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] numa: clarify error message when node
 index is out of range in -numa dist, ...
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, Andrew Jones <drjones@redhat.com>, qemu-devel@nongnu.org, ehabkost@redhat.com

On Tue, 15 May 2018 19:37:02 +0200
Markus Armbruster <armbru@redhat.com> wrote:

> Eric Blake <eblake@redhat.com> writes:
> 
> > On 05/15/2018 10:26 AM, Andrew Jones wrote:  
> >> On Tue, May 15, 2018 at 04:48:33PM +0200, Igor Mammedov wrote:  
> >>> When using following CLI:
> >>>    -numa dist,src=128,dst=1,val=20
> >>> user gets a rather confusing error message:
> >>>     "Invalid node 128, max possible could be 128"
> >>>
> >>> Where 128 is number of nodes that QEMU supports (MAX_NODES),
> >>> while src/dst is an index up to that limit, so it should be
> >>> MAX_NODES - 1 in error message.
> >>> Make error message to explicitly state valid range for node
> >>> index to be more clear.
> >>>
> >>> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> >>> Reviewed-by: Andrew Jones <drjones@redhat.com>
> >>> ---  
> >  
> >>>       if (src >= MAX_NODES || dst >= MAX_NODES) {
> >>>           error_setg(errp,
> >>> -                   "Invalid node %d, max possible could be %d",
> >>> -                   MAX(src, dst), MAX_NODES);
> >>> +                   "Invalid node %d, The valid node range is [0 - %d]",  
> >>                                        ^ should be a '.'
> >>
> >> And maybe need a '.' at the end of the second sentence too, as it's not
> >> an error phrase, but a real sentence.
> >>  
> >>> +                   MAX(src, dst), MAX_NODES - 1);
> >>>          return;
> >>>      }  
> >
> > Actually, error_setg() is documented as taking a single phrase (no '.'
> > included), and that if you need a second sentence, it's better to use
> > error_append_hint(). 
well, using append_hint makes it less readable, before using it we get following error:

$ qemu-system-x86_64 -numa dist,src=128,dst=1,val=20
qemu-system-x86_64: -numa dist,src=128,dst=1,val=20: Invalid node 128, The valid node range is [0 - 127]
$

after using it we get:
  
$ qemu-system-x86_64 -numa dist,src=128,dst=1,val=20
qemu-system-x86_64: -numa dist,src=128,dst=1,val=20: Invalid node value 128
The valid node range is [0 - 127]$ 

i.e. an extra newline in the middle of error message and looses automatic
newline at the end so the shell prompt continues error message


> Correct.  Providing help on valid values is exactly what
> error_append_hint() is for.
> 
> >                       Maybe Markus has an opinion on the best way to
> > word this error message.  
> 
> Yes: "Parameter 'src' expects an integer between 0 and 127"
> 
> Referring to an erroneous key=value by value is not nice.  What if the
> value occurs in multiple places, and is valid in at least one?  key is
> there, it's unique[*], so use it.
> 
> 
> [*] Except in the few places that use repeated keys to form lists.  Ugh.
