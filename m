Received: from eggs.gnu.org ([2001:4830:134:3::10]:52938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f1aSR-0000Et-8b
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 12:31:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f1aSL-00032N-60
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 12:31:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54716)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1f1aSK-00031d-UB
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 12:31:17 -0400
Date: Thu, 29 Mar 2018 13:31:13 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180329163113.GY5046@localhost.localdomain>
References: <1520860275-101576-1-git-send-email-imammedo@redhat.com>
	<1520860275-101576-3-git-send-email-imammedo@redhat.com>
	<20180323204218.GC28161@localhost.localdomain>
	<20180327150827.532e8486@redhat.com>
	<20180328185428.GO5046@localhost.localdomain>
	<20180329150509.7e39a81c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180329150509.7e39a81c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 2/9] numa: split out NumaOptions parsing
 into parse_NumaOptions()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: peter.maydell@linaro.org, pkrempa@redhat.com, cohuck@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com, pbonzini@redhat.com, david@gibson.dropbear.id.au

On Thu, Mar 29, 2018 at 03:05:09PM +0200, Igor Mammedov wrote:
> On Wed, 28 Mar 2018 15:54:28 -0300
> Eduardo Habkost <ehabkost@redhat.com> wrote:
> 
> > On Tue, Mar 27, 2018 at 03:08:27PM +0200, Igor Mammedov wrote:
> > > On Fri, 23 Mar 2018 17:42:18 -0300
> > > Eduardo Habkost <ehabkost@redhat.com> wrote:
> > >   
> > > > On Mon, Mar 12, 2018 at 02:11:08PM +0100, Igor Mammedov wrote:  
> > > > > it will allow to reuse parse_NumaOptions() for parsing
> > > > > configuration commands received via QMP interface
> > > > > 
> > > > > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > > > > ---
> > > > >  include/sysemu/numa.h |  1 +
> > > > >  numa.c                | 48 +++++++++++++++++++++++++++++-------------------
> > > > >  2 files changed, 30 insertions(+), 19 deletions(-)
> > > > > 
> > > > > diff --git a/include/sysemu/numa.h b/include/sysemu/numa.h
> > > > > index 21713b7..7a0ae75 100644
> > > > > --- a/include/sysemu/numa.h
> > > > > +++ b/include/sysemu/numa.h
> > > > > @@ -22,6 +22,7 @@ struct NumaNodeMem {
> > > > >  };
> > > > >  
> > > > >  extern NodeInfo numa_info[MAX_NODES];
> > > > > +int parse_numa(void *opaque, QemuOpts *opts, Error **errp);
> > > > >  void parse_numa_opts(MachineState *ms);
> > > > >  void numa_complete_configuration(MachineState *ms);
> > > > >  void query_numa_node_mem(NumaNodeMem node_mem[]);
> > > > > diff --git a/numa.c b/numa.c
> > > > > index 126c649..2b1d292 100644
> > > > > --- a/numa.c
> > > > > +++ b/numa.c
> > > > > @@ -169,28 +169,11 @@ static void parse_numa_distance(NumaDistOptions *dist, Error **errp)
> > > > >      have_numa_distance = true;
> > > > >  }
> > > > >  
> > > > > -static int parse_numa(void *opaque, QemuOpts *opts, Error **errp)
> > > > > +static
> > > > > +void parse_NumaOptions(MachineState *ms, NumaOptions *object, Error **errp)    
> > > > 
> > > > I wonder if we should rename the parse_numa_{node,distance}()
> > > > functions to configure_numa_{node,distance}(), and this one
> > > > configure_numa().  These functions don't parse anything, anymore.  
> > > I'd preffer to do it in another patch on top of this series
> > > (added it my TODO list)  
> > 
> > I agree with renaming parse_numa*() later, but the new function
> > you are creating can have a more reasonable name as it doesn't
> > parse anything.
> 
> 
> how about: s/parse_NumaOptions/set_NumaOptions/

No strong preference.  "register", "configure", "set" would all
be good enough to me.  I would avoid the weird
underline_and_CamelCase naming style, though (this style seems to
be used only by generated QAPI code).

-- 
Eduardo
