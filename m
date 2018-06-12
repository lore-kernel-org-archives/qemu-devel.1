Received: from eggs.gnu.org ([2001:4830:134:3::10]:54724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fSezT-00060q-HF
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 04:49:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fSezO-0003zd-M3
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 04:49:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54076 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fSezO-0003zT-GG
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 04:49:18 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E7E1C4023132
	for <qemu-devel@nongnu.org>; Tue, 12 Jun 2018 08:49:17 +0000 (UTC)
Date: Tue, 12 Jun 2018 09:49:14 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180612084914.GA2512@work-vm>
References: <20180608130846.22234-1-dgilbert@redhat.com>
	<20180608130846.22234-6-dgilbert@redhat.com>
	<87y3flilan.fsf@dusky.pond.sub.org> <20180611174958.GP2661@work-vm>
	<877en4y07a.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877en4y07a.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH v3 5/7] hmp: Add info commands for preconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: imammedo@redhat.com, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

* Markus Armbruster (armbru@redhat.com) wrote:
> "Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:
> 
> > * Markus Armbruster (armbru@redhat.com) wrote:
> >> "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> writes:
> >> 
> >> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >> >
> >> > Allow a bunch of the info commands to be used in preconfig.
> >> >
> >> > version, chardev, name, uuid,memdev, iothreads
> >> >   Were enabled in QMP in the previous patch from Igor
> >> 
> >> Yes, these are okay together with PATCH 4.
> >> 
> >> > status, hotpluggable_cpus
> >> >   Was enabled in the original allow-preconfig series
> >> 
> >> query-status looks okay to me.
> >> 
> >> > history
> >> >   is HMP specific
> >> 
> >> Yes.
> >> 
> >> > usbhost, qom-tree, numa
> >> >   Don't have a QMP equivalent
> >> 
> >> HMP commands without a QMP equivalent are okay if their functionality
> >> makes no sense in QMP, or is of use only for human users.
> >> 
> >> Example for "makes no sense in QMP": setting the current CPU, because a
> >> QMP monitor doesn't have a current CPU.
> >> 
> >> Examples for "is of use only for human users": HMP command "help", the
> >> integrated pocket calculator.
> >
> > Right, but they do already exist; it's possible we may want to fix/add
> > QMP versions - but this series isn't about going through and fixing
> > existing stuff up.
> >
> >> Now let's review the three commands:
> >> 
> >> * Gerd, why does "info usbhost" have no QMP equivalent?
> >> 
> >> * Eduardo, why does "info numa" have no QMP equivalent?
> >> 
> >> * "info qom-tree" is a recursive variant of qom-list that skips anything
> >>   but children.  This convenience command exists so you don't have to
> >>   filter and string together output from many qom-list.
> >> 
> >>   I think it stands to reason that if providing "info qom-tree" makes
> >>   sense, then so does qom-list (HMP and QMP).  If qom-list, then
> >>   qom-list-types, qom-list-properties, qom-get, and probably even
> >>   qom-set (I've always been suspicious of qom-set, but that has nothing
> >>   to do with preconfig state).
> >> 
> >>   It might make sense to split off the whole QOM shebang into a separate
> >>   patch.
> >
> > People have been trying to add qom-get etc for quite a while (I tried a
> > couple of years ago); it gets stuck in type display issues.  I've not
> > directly seen a need for those other variants, but qom-get is something
> > I'd love to have, still that's a job for another patch.
> 
> Yes.
> 
> > 'info qom-tree' is very very useful when debugging qemu to see what the
> > basic state we're building is; it's primarily for debugging.
> 
> I'm not at all opposed to enabling qom-tree, but I want its QMP building
> blocks enabled as well then.  I think enabling their HMP buddies as well
> would only make sense.

Hmm; OK, enabling qom-list, qom-get, qom-set, qom-list-types,
qom-list-properties for qmp.
qom-list and qom-set enabled in HMP.

Dave
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
