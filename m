Received: from eggs.gnu.org ([2001:4830:134:3::10]:48075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f1WYz-00013P-8V
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 08:21:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f1WYv-00062Z-Um
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 08:21:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39864)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1f1WYv-00062J-Eu
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 08:21:49 -0400
Date: Thu, 29 Mar 2018 09:21:46 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180329122146.GV5046@localhost.localdomain>
References: <1520860275-101576-1-git-send-email-imammedo@redhat.com>
	<1520860275-101576-6-git-send-email-imammedo@redhat.com>
	<20180323212837.GH28161@localhost.localdomain>
	<20180328142957.6b63c0a8@redhat.com>
	<20180328193016.GS5046@localhost.localdomain>
	<20180329115355.2166bde1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180329115355.2166bde1@redhat.com>
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
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, pkrempa@redhat.com, cohuck@redhat.com, armbru@redhat.com, pbonzini@redhat.com, david@gibson.dropbear.id.au

On Thu, Mar 29, 2018 at 11:53:55AM +0200, Igor Mammedov wrote:
> On Wed, 28 Mar 2018 16:30:16 -0300
> Eduardo Habkost <ehabkost@redhat.com> wrote:
> 
> > On Wed, Mar 28, 2018 at 02:29:57PM +0200, Igor Mammedov wrote:
> > > On Fri, 23 Mar 2018 18:28:37 -0300
> > > Eduardo Habkost <ehabkost@redhat.com> wrote:
> > >   
> > > > On Mon, Mar 12, 2018 at 02:11:11PM +0100, Igor Mammedov wrote:  
> > > > > New option will be used to allow commands, which are prepared/need
> > > > > to run run in preconfig state. Other commands that should be able
> > > > > to run in preconfig state, should be ammeded to not expect machine
> > > > > in initialized state or deal with it.
> > > > > 
> > > > > For compatibility reasons, commands, that don't use new flag
> > > > > 'allowed-in-preconfig' explicitly, are not permited to run in
> > > > > preconfig state but allowed in all other states like they used
> > > > > to be.
> > > > > 
> > > > > Within this patch allow following commands in preconfig state:
> > > > >    qmp_capabilities
> > > > >    query-qmp-schema
> > > > >    query-commands
> > > > >    query-status
> > > > >    cont
> > > > > to allow qmp connection, basic introspection and moving to the next
> > > > > state.
> > > > > 
> > > > > PS:
> > > > > set-numa-node and query-hotpluggable-cpus will be enabled later in
> > > > > a separate patch.
> > > > > 
> > > > > Signed-off-by: Igor Mammedov <imammedo@redhat.com>    
> > > > 
> > > > I didn't review the code yet, but:
> > > > 
> > > > Shouldn't this be applied before patch 3/9, for bisectability?
> > > > Otherwise it will be very easy to crash QEMU after applying patch
> > > > 3/9.  
> > > no, it isn't going to work.
> > > This patch depends on RUN_STATE_PRECONFIG that is introduced in 3/9.
> > > 
> > > It could be fine to merge into 3/9 during merge, but then history
> > > wise it would be difficult to read it later with 2 big and mostly
> > > separate changes within one patch.  
> > 
> > Yeah, I don't think squashing would be the right answer.
> > 
> > > 
> > > Considering -preconfig if off by default it shouldn't affect
> > > bisectability in general so I'd keep current patch order.  
> > 
> > Well, it would affect bisectability if debugging a crash that
> > happens using -preconfig.
> > 
> > The only hunk in this patch that really depends on patch 3/9
> > seems to be:
> > 
> >   @@ -92,6 +93,13 @@ static QObject *do_qmp_dispatch(QmpCommandList *cmds, QObject *request,
> >            return NULL;
> >        }
> >   
> >   +    if (runstate_check(RUN_STATE_PRECONFIG) &&
> >   +        !(cmd->options & QCO_ALLOWED_IN_PRECONFIG)) {
> >   +        error_setg(errp, "The command '%s' isn't permitted in '%s' state",
> >   +                   cmd->name, RunState_str(RUN_STATE_PRECONFIG));
> >   +        return NULL;
> >   +    }
> >   +
> >        if (!qdict_haskey(dict, "arguments")) {
> >            args = qdict_new();
> >        } else {
> >   
> > 
> > What about moving it to patch 3/9?
> By itself it won't work but with moving following hunk with it
> 
> @@ -21,7 +21,8 @@ typedef void (QmpCommandFunc)(QDict *, QObject **, Error **);
>  typedef enum QmpCommandOptions
>  {
>      QCO_NO_OPTIONS = 0x0,
> -    QCO_NO_SUCCESS_RESP = 0x1,
> +    QCO_NO_SUCCESS_RESP = 1U << 0,
> +    QCO_ALLOWED_IN_PRECONFIG =  1U << 1,
>  } QmpCommandOptions;
> 
> it should compile and do proper check in above hunk.
> 
> I'll try to do it and see if it works.

Sounds OK to me.

> 
> > Or, an alternative is to move the following hunk from patch 3/9 to this patch:
> > 
> >   diff --git a/qapi/run-state.json b/qapi/run-state.json
> >   index 1c9fff3aef..ce846a570e 100644
> >   --- a/qapi/run-state.json
> >   +++ b/qapi/run-state.json
> >   @@ -49,12 +49,15 @@
> >    # @colo: guest is paused to save/restore VM state under colo checkpoint,
> >    #        VM can not get into this state unless colo capability is enabled
> >    #        for migration. (since 2.8)
> >   +# @preconfig: QEMU is paused before board specific init callback is executed.
> >   +#             The state is reachable only if -preconfig CLI option is used.
> >   +#             (Since 2.12)
> >    ##
> >    { 'enum': 'RunState',
> >      'data': [ 'debug', 'inmigrate', 'internal-error', 'io-error', 'paused',
> >                'postmigrate', 'prelaunch', 'finish-migrate', 'restore-vm',
> >                'running', 'save-vm', 'shutdown', 'suspended', 'watchdog',
> >   -            'guest-panicked', 'colo' ] }
> >   +            'guest-panicked', 'colo', 'preconfig' ] }
> >   
> >    ##
> >    # @StatusInfo:
> > 
> > Which could be an interesting idea, because the QAPI schema
> > changes would be all grouped inside a single patch, and then
> > followed by the actual implementation of the -preconfig option.
> it won't really work as this enum generates RUN_STATE_PRECONFIG,
> which is used by 3/9

My suggestion in this case would be applying this patch
(including the above run-state.json change) before 3/9.

-- 
Eduardo
