Received: from eggs.gnu.org ([2001:4830:134:3::10]:41691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d5wqC-0007bq-BK
	for qemu-devel@nongnu.org; Wed, 03 May 2017 12:09:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d5wq9-0006MY-62
	for qemu-devel@nongnu.org; Wed, 03 May 2017 12:09:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48144)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1d5wq8-0006Kz-W9
	for qemu-devel@nongnu.org; Wed, 03 May 2017 12:09:21 -0400
Date: Wed, 3 May 2017 17:09:16 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170503160916.GD2077@work-vm>
References: <20170426212303.27961-1-danielhb@linux.vnet.ibm.com>
	<20170426212303.27961-3-danielhb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170426212303.27961-3-danielhb@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 2/4] hw/ppc: migrating the DRC state of
 hotplugged devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org

* Daniel Henrique Barboza (danielhb@linux.vnet.ibm.com) wrote:

<snip>

>  static void realize(DeviceState *d, Error **errp)
>  {
>      sPAPRDRConnector *drc = SPAPR_DR_CONNECTOR(d);
> @@ -540,6 +598,8 @@ static void realize(DeviceState *d, Error **errp)
>          object_unref(OBJECT(drc));
>      }
>      g_free(child_name);
> +    vmstate_register(DEVICE(drc), drck->get_index(drc), &vmstate_spapr_drc,
> +                     drc);
>      trace_spapr_drc_realize_complete(drck->get_index(drc));
>  }
>  
> @@ -658,6 +718,7 @@ static void spapr_dr_connector_class_init(ObjectClass *k, void *data)
>      dk->reset = reset;
>      dk->realize = realize;
>      dk->unrealize = unrealize;
> +    dk->vmsd = &vmstate_spapr_drc;

Are you sure this is right - isn't it unusual to have both
a ->vmsd entry AND a vmstate_register?

a ->vmsd =   is the preferable way I think, but I see you're
doing something with the 2nd parameter of vmstate_register;
if you *need* to do that then I think it's the only way.

Dave

>      drck->set_isolation_state = set_isolation_state;
>      drck->set_indicator_state = set_indicator_state;
>      drck->set_allocation_state = set_allocation_state;
> -- 
> 2.9.3
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
