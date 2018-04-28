Received: from eggs.gnu.org ([2001:4830:134:3::10]:50296)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fCGuA-0007eM-Ao
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 23:52:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fCGu5-0004Y7-5q
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 23:52:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33700 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fCGu5-0004Xz-0j
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 23:52:05 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E54B081A6A5A
	for <qemu-devel@nongnu.org>; Sat, 28 Apr 2018 03:52:00 +0000 (UTC)
Date: Sat, 28 Apr 2018 11:51:50 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180428035150.GA25938@xz-mi>
References: <1524841523-95513-1-git-send-email-imammedo@redhat.com>
	<1524841523-95513-6-git-send-email-imammedo@redhat.com>
	<f62a4655-2d55-dfc7-e332-3da3ce379c56@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f62a4655-2d55-dfc7-e332-3da3ce379c56@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 05/11] qapi: introduce new cmd option
 "allowed-in-preconfig"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org, ehabkost@redhat.com, pkrempa@redhat.com, armbru@redhat.com

On Fri, Apr 27, 2018 at 05:05:30PM -0500, Eric Blake wrote:

[...]

> > diff --git a/monitor.c b/monitor.c
> > index 0ffdf1d..e5e60dc 100644
> > --- a/monitor.c
> > +++ b/monitor.c
> > @@ -1183,7 +1183,7 @@ static void monitor_init_qmp_commands(void)
> >  
> >      qmp_register_command(&qmp_commands, "query-qmp-schema",
> >                           qmp_query_qmp_schema,
> > -                         QCO_NO_OPTIONS);
> > +                         QCO_ALLOWED_IN_PRECONFIG);
> 
> I understand why query-qmp-schema is special cased (because it uses
> 'gen':false in QAPI), but...
> 
> >      qmp_register_command(&qmp_commands, "device_add", qmp_device_add,
> >                           QCO_NO_OPTIONS);
> >      qmp_register_command(&qmp_commands, "netdev_add", qmp_netdev_add,
> > @@ -1193,7 +1193,8 @@ static void monitor_init_qmp_commands(void)
> >  
> >      QTAILQ_INIT(&qmp_cap_negotiation_commands);
> >      qmp_register_command(&qmp_cap_negotiation_commands, "qmp_capabilities",
> > -                         qmp_marshal_qmp_capabilities, QCO_NO_OPTIONS);
> > +                         qmp_marshal_qmp_capabilities,
> > +                         QCO_ALLOWED_IN_PRECONFIG);
> 
> ...why are we still special-casing the registration of qmp_capabilities
> here...

[1]

> 
> >  }
> >  
> >  static bool qmp_cap_enabled(Monitor *mon, QMPCapability cap)
> > diff --git a/qapi/introspect.json b/qapi/introspect.json
> > index c7f67b7..8036154 100644
> > --- a/qapi/introspect.json
> > +++ b/qapi/introspect.json
> > @@ -262,13 +262,16 @@
> >  # @allow-oob: whether the command allows out-of-band execution.
> >  #             (Since: 2.12)
> >  #
> > +# @allowed-in-preconfig: command can be executed in preconfig runstate,
> > +#                        default: 'false' (Since 2.13)
> > +#
> 
> If we like the bikeshedding on the QAPI spelling, I think it also
> applies to the introspection spelling.
> 
> 
> > +++ b/qapi/misc.json
> > @@ -35,7 +35,8 @@
> >  #
> >  ##
> >  { 'command': 'qmp_capabilities',
> > -  'data': { '*enable': [ 'QMPCapability' ] } }
> > +  'data': { '*enable': [ 'QMPCapability' ] },
> > +  'allowed-in-preconfig': true }
> 
> ...should't this be good enough to get qmp_capabilities registered?  Hmm
> - maybe that's an independent cleanup (and it might be missed fallout
> from Peter Xu's OOB work).

My understanding is that we have two lists:

    QmpCommandList qmp_commands, qmp_cap_negotiation_commands;

And here it only registers with qmp_commands list via:

    qmp_init_marshal(&qmp_commands);

But not for the other one, which is explicitly registered at [1].  So
it seems that [1] is still needed?

Thanks,

-- 
Peter Xu
