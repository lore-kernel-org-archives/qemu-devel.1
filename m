Received: from eggs.gnu.org ([2001:4830:134:3::10]:53094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cUDpn-0006kq-Jh
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:37:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cUDph-0002OC-OO
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:37:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45724)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1cUDph-0002NA-Fj
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:36:57 -0500
Date: Thu, 19 Jan 2017 15:36:52 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170119153652.4ea82c8e@nial.brq.redhat.com>
In-Reply-To: <20170118184637.GJ3491@thinpad.lan.raisama.net>
References: <1484759609-264075-1-git-send-email-imammedo@redhat.com>
	<1484759609-264075-12-git-send-email-imammedo@redhat.com>
	<20170118184637.GJ3491@thinpad.lan.raisama.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 11/13] numa: use new machine.cpu property
 with -numa cpus=... CLI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Dou Liyang <douly.fnst@cn.fujitsu.com>, fanc.fnst@cn.fujitsu.com, caoj.fnst@cn.fujitsu.com, stefanha@redhat.com, izumi.taku@jp.fujitsu.com, vilanova@ac.upc.edu, peter.maydell@linaro.org, Andrew Jones <drjones@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>

On Wed, 18 Jan 2017 16:46:37 -0200
Eduardo Habkost <ehabkost@redhat.com> wrote:

> On Wed, Jan 18, 2017 at 06:13:27PM +0100, Igor Mammedov wrote:
> > add compat layer to legacy cpu_index based '-numa cpus=...'
> > CLI option, which will use new machine.cpu property to set
> > numa mapping if that propety is available.
> > 
> > This way machine that supports machine.cpu property will
> > not break legacy CLI but will be able to move away from
> > using numa_info[node_id].node_cpu bitmaps and use only
> > possible_cpus instead.
> > 
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> >  numa.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++++---------------
> >  1 file changed, 48 insertions(+), 15 deletions(-)
> > 
> > diff --git a/numa.c b/numa.c
> > index 887ee58..0c34130 100644
> > --- a/numa.c
> > +++ b/numa.c
> > @@ -141,10 +141,35 @@ uint32_t numa_get_node(ram_addr_t addr, Error **errp)
> >      return -1;
> >  }
> >  
> > -static void numa_node_parse(NumaNodeOptions *node, QemuOpts *opts, Error **errp)
> > +static void numa_cpu_set_nid(MachineState *ms, CpuInstanceProperties *props,
> > +                             Error **errp)
> > +{
> > +    Visitor *v;
> > +    QObject *qobj;
> > +    Error *local_error = NULL;
> > +
> > +    v = qobject_output_visitor_new(&qobj);
> > +    visit_type_CpuInstanceProperties(v, "cpu", &props, &local_error);
> > +    visit_complete(v, &qobj);
> > +    visit_free(v);
> > +    if (local_error) {
> > +        goto end;
> > +    }
> > +    v = qobject_input_visitor_new(qobj, true);
> > +    object_property_set(OBJECT(ms), v, "cpu", &local_error);
> > +    visit_free(v);
> > +    qobject_decref(qobj);
> > +end:
> > +    error_propagate(errp, local_error);
> > +}
> > +
> > +static void numa_node_parse(MachineState *ms, NumaNodeOptions *node,
> > +                            QemuOpts *opts, Error **errp)
> >  {
> >      uint16_t nodenr;
> >      uint16List *cpus = NULL;
> > +    MachineClass *mc = MACHINE_GET_CLASS(ms);
> > +    bool has_cpu_prop = object_property_find(OBJECT(ms), "cpu", NULL);
> >  
> >      if (node->has_nodeid) {
> >          nodenr = node->nodeid;
> > @@ -172,6 +197,19 @@ static void numa_node_parse(NumaNodeOptions *node, QemuOpts *opts, Error **errp)
> >              return;
> >          }
> >          bitmap_set(numa_info[nodenr].node_cpu, cpus->value, 1);
> > +        if (mc->cpu_index_to_instance_props && has_cpu_prop) {
> > +            CpuInstanceProperties props;
> > +            Error *local_error = NULL;
> > +
> > +            props = mc->cpu_index_to_instance_props(ms, cpus->value);
> > +            props.has_node_id = true;
> > +            props.node_id = nodenr;
> > +            numa_cpu_set_nid(ms, &props, &local_error);
> > +            if (local_error) {
> > +                error_propagate(errp, local_error);
> > +                return;
> > +            }
> > +        }
> >      }  
> 
> With this, now we have two completely different ways to store the
> results of "-numa node,cpus...", and both are likely to stay
> forever if we take too long to update the other machines.
> 
> Do you plan to make ppc/spapr and arm/virt use the new
> machine.cpu system so we could remove numa_info[].node_cpu
> completely in the same series?
this RFC is just to demonstrate an approach.

it would be better to do conversion within the same merge
window (however note ARM is not even close to -device based cpus)
so I would prefer do it incrementally per target
(under promise of not abandoning project midways)
above said doing conversion for x86 and spapr within one merge
windows seems feasible.
