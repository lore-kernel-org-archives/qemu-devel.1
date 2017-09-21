Received: from eggs.gnu.org ([2001:4830:134:3::10]:51428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dv154-00080S-3o
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 08:59:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dv14z-0000Ry-9u
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 08:59:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33210)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dv14z-0000RB-1j
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 08:59:45 -0400
Date: Thu, 21 Sep 2017 14:59:39 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170921145939.653d4d5f@nial.brq.redhat.com>
In-Reply-To: <bf0ffdb7-d164-5947-cbaf-5a8aef58c1ef@redhat.com>
References: <1505991234-246759-1-git-send-email-imammedo@redhat.com>
	<bf0ffdb7-d164-5947-cbaf-5a8aef58c1ef@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] s390x: use generic cpu_model parsing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>

On Thu, 21 Sep 2017 14:34:40 +0200
David Hildenbrand <david@redhat.com> wrote:

> On 21.09.2017 12:53, Igor Mammedov wrote:
> > define default CPU type in generic way in machine class_init
> > and let common machine code to handle cpu_model parsing.
> > 
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> > tested under TCG booting debian kernel,
> > and compile tested on s390 host  
> 
> Hotplugging checks (mixed CPU models) still seem to work fine.
> 
> Also parameters get applied and the model name is properly parsed.
> 
> >                       "supported by TCG (1) on s390x", max_cpus);
> > @@ -73,25 +66,8 @@ static void s390_init_cpus(MachineState *machine)
> >      /* initialize possible_cpus */
> >      mc->possible_cpu_arch_ids(machine);
> >  
> > -    model_pieces = g_strsplit(machine->cpu_model, ",", 2);
> > -    if (!model_pieces[0]) {
> > -        error_report("Invalid/empty CPU model name");
> > -        exit(1);
> > -    }
> > -
> > -    oc = cpu_class_by_name(TYPE_S390_CPU, model_pieces[0]);
> > -    if (!oc) {
> > -        error_report("Unable to find CPU definition: %s", model_pieces[0]);
> > -        exit(1);
> > -    }
> > -    typename = object_class_get_name(oc);
> > -    cc = CPU_CLASS(oc);
> > -    /* after parsing, properties will be applied to all *typename* instances */
> > -    cc->parse_features(typename, model_pieces[1], &error_fatal);
> > -    g_strfreev(model_pieces);
> > -
> >      for (i = 0; i < smp_cpus; i++) {
> > -        s390x_new_cpu(typename, i, &error_fatal);
> > +        s390x_new_cpu(machine->cpu_type, i, &error_fatal);
> >      }
> >  }
> >  
> > @@ -446,6 +422,9 @@ static void ccw_machine_class_init(ObjectClass *oc, void *data)
> >      mc->get_hotplug_handler = s390_get_hotplug_handler;
> >      mc->cpu_index_to_instance_props = s390_cpu_index_to_props;
> >      mc->possible_cpu_arch_ids = s390_possible_cpu_arch_ids;
> > +    /* it is overrriden with 'host' cpu type when accel=kvm  
> 
> s/overrriden/overridden/
> 
> ... with 'host' cpu *in kvm_arch_init*. ?
thanks, fixed in v2

> 
> > +     * i.e. when kvm_arch_init() is executed */
> > +    mc->default_cpu_type = S390_CPU_TYPE_NAME("qemu");
> >      hc->plug = s390_machine_device_plug;
> >      hc->unplug_request = s390_machine_device_unplug_request;
> >      nc->nmi_monitor_handler = s390_nmi;
> > diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
> > index 5169379..0bf7e14 100644
> > --- a/target/s390x/cpu_models.c
> > +++ b/target/s390x/cpu_models.c
> > @@ -1207,9 +1207,6 @@ static void s390_qemu_cpu_model_class_init(ObjectClass *oc, void *data)
> >                                  qemu_hw_version());
> >  }  
> 
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>
> 
