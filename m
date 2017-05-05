Received: from eggs.gnu.org ([2001:4830:134:3::10]:34387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1d6bPa-0005H8-JP
	for qemu-devel@nongnu.org; Fri, 05 May 2017 07:28:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1d6bPZ-0000eB-NO
	for qemu-devel@nongnu.org; Fri, 05 May 2017 07:28:38 -0400
Date: Fri, 5 May 2017 13:28:26 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170505132826.29aa8377@nial.brq.redhat.com>
In-Reply-To: <20170504114018.zpqvohjxu23bhar7@kamzik.brq.redhat.com>
References: <1493816238-33120-1-git-send-email-imammedo@redhat.com>
	<1493816238-33120-11-git-send-email-imammedo@redhat.com>
	<20170504114018.zpqvohjxu23bhar7@kamzik.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 10/24] numa: mirror cpu to node mapping
 in MachineState::possible_cpus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, David Gibson <david@gibson.dropbear.id.au>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Shannon Zhao <zhaoshenglong@huawei.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org

On Thu, 4 May 2017 13:40:18 +0200
Andrew Jones <drjones@redhat.com> wrote:

[...]
> > +void machine_set_cpu_numa_node(MachineState *machine,
> > +                               CpuInstanceProperties *props, Error **errp)
> > +{
[...]

> > +        }
> > +
> > +        /* skip slots with explicit mismatch */
> > +        if (props->has_thread_id && props->thread_id != slot->props.thread_id) {
> > +                continue;
> > +        }
> > +
> > +        if (props->has_core_id && props->core_id != slot->props.core_id) {
> > +                continue;
> > +        }
> > +
> > +        if (props->has_socket_id && props->socket_id != slot->props.socket_id) {
> > +                continue;
> > +        }  
> 
> nit: above 3 if-conditions could be condensed into 1 compound condition
this reduces number of lines but result is a bit ugly due to 80chr/line limit:

        /* skip slots with explicit mismatch */                                  
        if ((props->has_thread_id &&                                             
             props->thread_id != slot->props.thread_id) ||                       
            (props->has_core_id && props->core_id != slot->props.core_id) ||     
            (props->has_socket_id && props->socket_id != slot->props.socket_id)  
        ) {                                                                      
                continue;                                                        
        }

do you still want the change?
