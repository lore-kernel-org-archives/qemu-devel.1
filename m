Received: from eggs.gnu.org ([2001:4830:134:3::10]:58002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fDWj6-0003NF-Lm
	for qemu-devel@nongnu.org; Tue, 01 May 2018 10:57:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fDWj2-0002V4-Mc
	for qemu-devel@nongnu.org; Tue, 01 May 2018 10:57:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47964 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fDWj2-0002Uy-HB
	for qemu-devel@nongnu.org; Tue, 01 May 2018 10:57:52 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 294A78DC3F
	for <qemu-devel@nongnu.org>; Tue,  1 May 2018 14:57:47 +0000 (UTC)
Date: Tue, 1 May 2018 16:57:39 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180501165739.4a680341@redhat.com>
In-Reply-To: <f62a4655-2d55-dfc7-e332-3da3ce379c56@redhat.com>
References: <1524841523-95513-1-git-send-email-imammedo@redhat.com>
	<1524841523-95513-6-git-send-email-imammedo@redhat.com>
	<f62a4655-2d55-dfc7-e332-3da3ce379c56@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Cc: qemu-devel@nongnu.org, pkrempa@redhat.com, ehabkost@redhat.com, Peter Xu <peterx@redhat.com>, armbru@redhat.com

On Fri, 27 Apr 2018 17:05:30 -0500
Eric Blake <eblake@redhat.com> wrote:

> On 04/27/2018 10:05 AM, Igor Mammedov wrote:
> > New option will be used to allow commands, which are prepared/need
> > to run, during preconfig state. Other commands that should be able
> > to run in preconfig state, should be ameded to not expect machine  
> 
> s/ameded/amended/
> 
> > in initialized state or deal with it.
> > 
> > For compatibility reasons, commands that don't use new flag
> > 'allowed-in-preconfig' explicitly are not permitted to run in
> > preconfig state but allowed in all other states like they used
> > to be.
> > 
> > Within this patch allow following commands in preconfig state:
> >    qmp_capabilities
> >    query-qmp-schema
> >    query-commands
> >    query-command-line-options
> >    query-status
> >    exit-preconfig
> > to allow qmp connection, basic introspection and moving to the next
> > state.
> > 
> > PS:
> > set-numa-node and query-hotpluggable-cpus will be enabled later in
> > a separate patches.
> > 
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> > v6:
> >   * exclude 'cont' command from preconfig enabled, in favor of
> >     exit-preconfig command
> >   * makr exit-preconfig with allowed-in-preconfig=true  
> 
> s/makr/mark/ (not that the changelog matters to git...)
> 
> 
> > +++ b/docs/devel/qapi-code-gen.txt
> > @@ -559,7 +559,7 @@ following example objects:
> >  Usage: { 'command': STRING, '*data': COMPLEX-TYPE-NAME-OR-DICT,
> >           '*returns': TYPE-NAME, '*boxed': true,
> >           '*gen': false, '*success-response': false,
> > -         '*allow-oob': true }
> > +         '*allow-oob': true, '*allowed-in-preconfig': true }  
> 
> Bikeshedding - is it worth naming this just 'allow-preconfig', for a bit
> more similarity to 'allow-oob'?  It's less typing, and still conveys the
> same amount of information (allow preconfig to use this command).
Since I'll need to respin anyways, lets got with shorter name

> 
> >  
> >  Commands are defined by using a dictionary containing several members,
> >  where three members are most common.  The 'command' member is a
> > @@ -683,6 +683,14 @@ OOB command handlers must satisfy the following conditions:
> >  
> >  If in doubt, do not implement OOB execution support.
> >  
> > +A command may use optional 'allowed-in-preconfig' key to permit
> > +its execution at early runtime configuration stage (preconfig runstate).
> > +If not specified then a command defaults to 'allowed-in-preconfig: false'.  
> 
> Unusual spelling for JSON:
>  s/'allowed-in-preconfig: false'/'allowed-in-preconfig':false/
> 
> and of course, additional tweaks here and in other patches if you like
> my bikeshedding for a shorter name.
> 
> > +
> > +An example of declaring preconfig enabled command:  
> 
> Might read better as:
> An example of declaring a command that is enabled during preconfig:
> 
> > + { 'command': 'qmp_capabilities',
> > +   'allowed-in-preconfig': true }
> > +
> >  === Events ===
> >  
> >  Usage: { 'event': STRING, '*data': COMPLEX-TYPE-NAME-OR-DICT,
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
> 
> 
> > +++ b/scripts/qapi/common.py  
> 
> > @@ -1422,7 +1423,7 @@ class QAPISchemaAlternateType(QAPISchemaType):
> >  
> >  class QAPISchemaCommand(QAPISchemaEntity):
> >      def __init__(self, name, info, doc, arg_type, ret_type,
> > -                 gen, success_response, boxed, allow_oob):
> > +                 gen, success_response, boxed, allow_oob, allowed_in_preconfig):  
> 
> Borderline long line; I'd wrap it (except that if you use the shorter
> name allow_preconfig, then there's not a long line issue).
> 
> > +++ b/scripts/qapi/doc.py
> > @@ -226,8 +226,8 @@ class QAPISchemaGenDocVisitor(qapi.common.QAPISchemaVisitor):
> >                                 name=doc.symbol,
> >                                 body=texi_entity(doc, 'Members')))
> >  
> > -    def visit_command(self, name, info, arg_type, ret_type,
> > -                      gen, success_response, boxed, allow_oob):
> > +    def visit_command(self, name, info, arg_type, ret_type, gen,
> > +                      success_response, boxed, allow_oob, allowed_in_preconfig):
> >          doc = self.cur_doc
> >          if boxed:
> >              body = texi_body(doc)  
> 
> It's nice that introspection covers whether a command is allowed during
> preconfig; but wouldn't it also be nice if the documentation also
> mentioned this attribute?  (Hmm, partly my fault for missing during
> review of OOB that the same can be said about documentation of allow_oob
> - so you were just copying existing practice)
yep, it's pretty much copypast.
Could you point to a place/example commit that adds documentation?

> Overall looks reasonable to me, but see my notes elsewhere in the series
> about hoisting this earlier in the series while still keeping things
> compiling (perhaps by splitting the introduction of
> QCO_ALLOWED_IN_PRECONFIG from the introduction of --preconfig on the
> command line).
I'll fix the rest of comments and reshuffle series as you suggest here
and in previous review comments.

Thanks!
