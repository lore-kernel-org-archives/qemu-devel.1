Received: from eggs.gnu.org ([2001:4830:134:3::10]:49386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dfT5V-00081z-Cr
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 11:40:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dfT5T-0003pN-Tt
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 11:40:01 -0400
Date: Wed, 9 Aug 2017 17:39:42 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170809153942.GI4213@localhost.localdomain>
References: <20170731095443.28211-6-el13635@mail.ntua.gr>
	<w51valyjj7j.fsf@maestria.local.igalia.com>
	<20170808134544.paekftiounmirhbo@postretch>
	<w51poc6jeln.fsf@maestria.local.igalia.com>
	<20170808145620.wlb5rdutuseutclx@postretch>
	<w51mv7aje27.fsf@maestria.local.igalia.com>
	<20170809093612.oee2u5kdgyojheqm@postretch>
	<w51y3qslxyz.fsf@maestria.local.igalia.com>
	<20170809134205.dbkx5cuvjpbaxftv@postretch>
	<w51valwlrzc.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <w51valwlrzc.fsf@maestria.local.igalia.com>
Subject: Re: [Qemu-devel] [PATCH v3 5/7] block: add throttle block filter
 driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: Manos Pitsidianakis <el13635@mail.ntua.gr>, qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block <qemu-block@nongnu.org>

Am 09.08.2017 um 16:45 hat Alberto Garcia geschrieben:
> On Wed 09 Aug 2017 03:42:07 PM CEST, Manos Pitsidianakis wrote:
> > On Wed, Aug 09, 2017 at 02:36:20PM +0200, Alberto Garcia wrote:
> >>On Wed 09 Aug 2017 11:36:12 AM CEST, Manos Pitsidianakis wrote:
> >>> On Tue, Aug 08, 2017 at 05:04:48PM +0200, Alberto Garcia wrote:
> >>>>On Tue 08 Aug 2017 04:56:20 PM CEST, Manos Pitsidianakis wrote:
> >>>>>>> So basically if we have anonymous groups, we accept limits in the
> >>>>>>> driver options but only without a group-name.
> >>>>>>
> >>>>>>In the commit message you do however have limits and a group name, is
> >>>>>>that a mistake?
> >>>>>>
> >>>>>>    -drive driver=throttle,file.filename=foo.qcow2, \
> >>>>>>           limits.iops-total=...,throttle-group=bar
> >>>>>
> >>>>> Sorry this wasn't clear, I'm actually proposing to remove limits from
> >>>>> the throttle driver options and only create/config throttle groups via
> >>>>> -object/object-add.
> >>>>
> >>>>Sorry I think it was me who misunderstood :-) Anyway in the new
> >>>>command-line API I would be more inclined to have limits defined using
> >>>>"-object throttle-group" and -drive would only reference the group id.
> >>>>
> >>>>I understand that this implies that it wouldn't be possible to create
> >>>>anonymous groups (at least not from the command line), is that a
> >>>>problem?
> >>>
> >>> We can accept anonymous groups if a user specifies limits but not a
> >>> group name in the throttle driver. (The only case where limits would
> >>> be acccepted)
> >>
> >>Yeah but that's only if we have the limits.iops-total=... options in the
> >>throttle driver. If we "remove limits from the throttle driver options
> >>and only create/config throttle groups via -object/object-add" we 
> >>cannot
> >>do that.
> >
> > We can check that groups is not defined at the same time as limits,
> 
> I'm not sure if I'm following the conversation anymore :-) let's try to
> recap:
> 
>   a) Groups are defined like this (with the current patches):
> 
>      -object throttle-group,id=foo,x-iops-total=100,x-..
> 
>   b) Throttle nodes are defined like this:
> 
>      -drive driver=throttle,file.filename=foo.qcow2, \
>             limits.iops-total=...,throttle-group=bar
> 
>   c) Therefore limits can be defined either in (a) or (b)
> 
>   d) If we omit throttle-group=... in (b), we would create an anonymous
>      group.
> 
>   e) The -drive syntax from (b) has the "problem" that it's possible to
>      define several nodes with the same throttling group but different
>      limits. The last one would win (as the legacy syntax does), but
>      that's not something completely straightforward for the end user.
> 
>   f) The syntax from (b) also has the problem that there's one more
>      place that needs code to parse throttling limits.
> 
>   g) We can solve (e) and (f) if we remove the limits.* options
>      altogether from the throttling filter. In that case you would need
>      to define a throttle-group object and use the throttle-group option
>      of the filter node in all cases.
> 
>   h) If we remove the limits.* options we cannot have anonymous groups
>      anymore (at least not using this API). My question is: is it a
>      problem? What would we lose? What benefits do anonymous groups
>      bring us?

As I understand it, basically only the convenience of begin able to
specify a limit directly in -drive rather than having to create an
-object and reference its ID.

>   i) We can of course maintain the limits.* options, but disallow
>      throttle-group when they are present. That way we would allow
>      anonymous groups and we would solve the ambiguity problem described
>      in (e). My question is: is it worth it?

Maybe not. Depends on how important we consider the convenience feature.

> >>> Not creating eponymous throttle groups via the throttle driver means
> >>> we don't need throttle_groups anymore, since even anonymous ones
> >>> don't need to be accounted for in a list.
> >>
> >>I don't follow you here, how else do you get a group by its name?
> >
> > If all eponymous groups are managed by the QOM tree, we should be able
> > to iterate over the object root container for all ThrottleGroups just
> > like qmp_query_iothreads() in iothread.c
> 
> Mmm... can't we actually use the root container now already? (even with
> anonymous groups I mean). Why do we need throttle_groups?

Anonymous groups don't have a parent, so they aren't accessible through
the root container.

Kevin
