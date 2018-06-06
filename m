Received: from eggs.gnu.org ([2001:4830:134:3::10]:52817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fQWBT-0008Fb-VB
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 07:00:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fQWBQ-00048p-Sj
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 07:00:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42468 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fQWBQ-00048Q-OL
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 07:00:52 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E29A5401DE69
	for <qemu-devel@nongnu.org>; Wed,  6 Jun 2018 11:00:51 +0000 (UTC)
Date: Wed, 6 Jun 2018 13:00:50 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180606130050.7bc74b34@redhat.com>
In-Reply-To: <19cc576e-5b1c-c45e-034a-95329d1bff62@redhat.com>
References: <d714d8ac-6642-f2f3-ad9c-ac7e3bdf30e0@redhat.com>
	<d453da2c-92fe-5ef8-239c-656c1822b9e0@redhat.com>
	<787c23db-430b-dc20-10f7-00fdf119449c@redhat.com>
	<20180604222433.4d585846@redhat.com>
	<19cc576e-5b1c-c45e-034a-95329d1bff62@redhat.com>
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

On Wed, 6 Jun 2018 12:35:07 +0200
Max Reitz <mreitz@redhat.com> wrote:

> On 2018-06-04 22:24, Igor Mammedov wrote:
> > On Mon, 4 Jun 2018 16:04:33 +0200
> > Max Reitz <mreitz@redhat.com> wrote:
> >   
> >> On 2018-06-02 12:46, Michal Privoznik wrote:  
> >>> On 06/01/2018 03:28 PM, Max Reitz wrote:    
> >>>> Hi,
> >>>>
> >>>> The @preconfig RunState documentation states:
> >>>>    
> >>>>> The state is reachable only if the --preconfig CLI option is used.    
> >>>>
> >>>> However, this is not true:
> >>>>
> >>>> $ echo | x86_64-softmmu/qemu-system-x86_64 -monitor stdio
> >>>> QEMU 2.12.50 monitor - type 'help' for more information
> >>>> (qemu)
> >>>> HMP not available in preconfig state, use QMP instead    
> >>>
> >>> Not sure if this is the same bug, but I've noticed libvirt having
> >>> troubles detecting capabilities of qemu and debugging lead to this patch:
> >>>
> >>> http://lists.nongnu.org/archive/html/qemu-devel/2018-06/msg00367.html
> >>>
> >>> (which by no means I claim is proper solution. It might be viewed as
> >>> workaround by expert qemu devels)    
> >>
> >> I haven't investigated further, but that patch breaks iotest 091 (which
> >> tests migration).  It just stops now after the migration has started, so
> >> it never completes.
> >>
> >> Actually, it seems to break all migration iotests (but 203, which
> >> migrates to /dev/null), so I suspect it breaks migration as a whole.  
> > Manual migration to file and restore from it, was tested manually and
> > worked fine, migration-test  from 'make check' is ok as well.
> > It's probably due broken to "echo foo | $QEMU"  
> 
> I highly doubt that, because four of the failing migration iotests are
> written in Python and thus use QMP.  (169, 194, 196, 199)
> 
> They work on master, but fail after that patch.
Indeed, this patch breaks migration. There is fixed version on list [CCed]

[PATCH v3 1/2] cli: Don't run early event loop if no  --preconfig was specified

that passes all iotests, some of tests I had to run several times
due to transient failures not related to the topic (some timing issues)

> 
> Max
> 
> > There is another issue with -nodefaults option leading to indefinite
> > timeout even if --preconfig wasn't used. I've just posted fix for that
> > so that it won't be masked out by Michal/Daniel's fix.
> > But I've run iotests  and -nodefaults fix doesn't affect outcome of the
> > tests (the same 4 failures).   
> 
