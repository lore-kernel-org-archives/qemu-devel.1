Received: from eggs.gnu.org ([2001:4830:134:3::10]:46616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fPoEf-0005SC-Mf
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 08:05:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fPoEc-0002Lt-F1
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 08:05:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55310 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fPoEc-0002L9-9a
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 08:05:14 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E0F7240BC05B
	for <qemu-devel@nongnu.org>; Mon,  4 Jun 2018 12:05:13 +0000 (UTC)
Date: Mon, 4 Jun 2018 14:05:12 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180604140512.1c43b186@redhat.com>
In-Reply-To: <24719f30-25c9-a80e-0db9-ae2f7f318c68@redhat.com>
References: <d714d8ac-6642-f2f3-ad9c-ac7e3bdf30e0@redhat.com>
	<d453da2c-92fe-5ef8-239c-656c1822b9e0@redhat.com>
	<24719f30-25c9-a80e-0db9-ae2f7f318c68@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Preconfig state reachable without --preconfig given
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Michal Privoznik <mprivozn@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On Mon, 4 Jun 2018 11:46:06 +0200
Max Reitz <mreitz@redhat.com> wrote:

> On 2018-06-02 12:46, Michal Privoznik wrote:
> > On 06/01/2018 03:28 PM, Max Reitz wrote:  
> >> Hi,
> >>
> >> The @preconfig RunState documentation states:
> >>  
> >>> The state is reachable only if the --preconfig CLI option is used.  
> >>
> >> However, this is not true:
> >>
> >> $ echo | x86_64-softmmu/qemu-system-x86_64 -monitor stdio
> >> QEMU 2.12.50 monitor - type 'help' for more information
> >> (qemu)
> >> HMP not available in preconfig state, use QMP instead  
> > 
> > Not sure if this is the same bug, but I've noticed libvirt having
> > troubles detecting capabilities of qemu and debugging lead to this patch:
> > 
> > http://lists.nongnu.org/archive/html/qemu-devel/2018-06/msg00367.html
> > 
> > (which by no means I claim is proper solution. It might be viewed as
> > workaround by expert qemu devels)  
> 
> Well, it'd fix both of my issues, so it has that going for it. :-)
Acked patch.

Markus also suggested to drop HMP monitor altogether at this first loop,
I'll look into it some more taking in account demonize() issue.

> 
> >> On IRC, Daniel proposed doing the runstate transition immediately after
> >> the command line has been read and no --preconfig option has been found.
> >>  Doing that indeed fixes the issue for me (but I don't know whether
> >> that's the best solution).  
> > 
> > Oh has he? I can't find it anywhere.  
> 
> That was in #qemu on OFTC:
> 
> [Friday, June 1 2018] [15:21:26 CEST] <danpb> if we've not passed
> --preconfig though, we should not be in PRECONFIG state in the first
> place IMHO
> [Friday, June 1 2018] [15:22:27 CEST] <danpb> eg  vl.c should set the
> state to RUN_STATE_PRELAUNCH  immediately after parsing CLI args if
> --preconfig wasn't given
That's not how it should be, PRECONFIG is there to replace PRELAUNCH
at early stages (which commit 8a36283e12 message states)
/me is to blame for miss-leading doc comment/

> Max
> 
