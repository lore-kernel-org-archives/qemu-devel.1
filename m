Received: from eggs.gnu.org ([2001:4830:134:3::10]:40091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1f1ADV-0002zm-Vi
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 08:30:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1f1ADQ-0002VB-Bk
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 08:30:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46936 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1f1ADQ-0002V1-7i
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 08:30:08 -0400
Date: Wed, 28 Mar 2018 14:29:57 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180328142957.6b63c0a8@redhat.com>
In-Reply-To: <20180323212837.GH28161@localhost.localdomain>
References: <1520860275-101576-1-git-send-email-imammedo@redhat.com>
	<1520860275-101576-6-git-send-email-imammedo@redhat.com>
	<20180323212837.GH28161@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 5/9] qapi: introduce new cmd option
 "allowed-in-preconfig"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, pkrempa@redhat.com, cohuck@redhat.com, armbru@redhat.com, pbonzini@redhat.com, david@gibson.dropbear.id.au

On Fri, 23 Mar 2018 18:28:37 -0300
Eduardo Habkost <ehabkost@redhat.com> wrote:

> On Mon, Mar 12, 2018 at 02:11:11PM +0100, Igor Mammedov wrote:
> > New option will be used to allow commands, which are prepared/need
> > to run run in preconfig state. Other commands that should be able
> > to run in preconfig state, should be ammeded to not expect machine
> > in initialized state or deal with it.
> > 
> > For compatibility reasons, commands, that don't use new flag
> > 'allowed-in-preconfig' explicitly, are not permited to run in
> > preconfig state but allowed in all other states like they used
> > to be.
> > 
> > Within this patch allow following commands in preconfig state:
> >    qmp_capabilities
> >    query-qmp-schema
> >    query-commands
> >    query-status
> >    cont
> > to allow qmp connection, basic introspection and moving to the next
> > state.
> > 
> > PS:
> > set-numa-node and query-hotpluggable-cpus will be enabled later in
> > a separate patch.
> > 
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>  
> 
> I didn't review the code yet, but:
> 
> Shouldn't this be applied before patch 3/9, for bisectability?
> Otherwise it will be very easy to crash QEMU after applying patch
> 3/9.
no, it isn't going to work.
This patch depends on RUN_STATE_PRECONFIG that is introduced in 3/9.

It could be fine to merge into 3/9 during merge, but then history
wise it would be difficult to read it later with 2 big and mostly
separate changes within one patch.

Considering -preconfig if off by default it shouldn't affect
bisectability in general so I'd keep current patch order.
