Received: from eggs.gnu.org ([2001:4830:134:3::10]:60222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1etxtD-0001I2-CR
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 10:55:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1etxt8-0004Pa-Hn
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 10:55:31 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34192 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1etxt8-0004P6-BB
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 10:55:26 -0500
Date: Thu, 8 Mar 2018 16:55:15 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180308165515.5f6b6c9a@redhat.com>
In-Reply-To: <20180307141648.GC3090@work-vm>
References: <1518784641-43151-1-git-send-email-imammedo@redhat.com>
	<1518784641-43151-6-git-send-email-imammedo@redhat.com>
	<20180307141648.GC3090@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 5/9] QAPI: allow to specify valid
 runstates per command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, pkrempa@redhat.com, ehabkost@redhat.com, cohuck@redhat.com, armbru@redhat.com, pbonzini@redhat.com, david@gibson.dropbear.id.au

On Wed, 7 Mar 2018 14:16:50 +0000
"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:

> * Igor Mammedov (imammedo@redhat.com) wrote:
> > Add optional 'runstates' parameter in QAPI command definition,
> > which will permit to specify RunState variations in which
> > a command could be exectuted via QMP monitor.
> > 
> > For compatibility reasons, commands, that don't use
> > 'runstates' explicitly, are not permited to run in
> > preconfig state but allowed in all other states.
> > 
> > New option will be used to allow commands, which are
> > prepared/need to run this early, to run in preconfig state.
> > It will include query-hotpluggable-cpus and new set-numa-node
> > commands. Other commands that should be able to run in
> > preconfig state, should be ammeded to not expect machine
> > in initialized state.
> > 
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
[...]

> > @@ -224,6 +224,25 @@ static mon_cmd_t mon_cmds[];
> >  static mon_cmd_t info_cmds[];
> >  
> >  QmpCommandList qmp_commands, qmp_cap_negotiation_commands;
> > +const RunState cap_negotiation_valid_runstates[] = {
> > +    RUN_STATE_DEBUG,
> > +    RUN_STATE_INMIGRATE,
> > +    RUN_STATE_INTERNAL_ERROR,
> > +    RUN_STATE_IO_ERROR,
> > +    RUN_STATE_PAUSED,
> > +    RUN_STATE_POSTMIGRATE,
> > +    RUN_STATE_PRELAUNCH,
> > +    RUN_STATE_FINISH_MIGRATE,
> > +    RUN_STATE_RESTORE_VM,
> > +    RUN_STATE_RUNNING,
> > +    RUN_STATE_SAVE_VM,
> > +    RUN_STATE_SHUTDOWN,
> > +    RUN_STATE_SUSPENDED,
> > +    RUN_STATE_WATCHDOG,
> > +    RUN_STATE_GUEST_PANICKED,
> > +    RUN_STATE_COLO,
> > +    RUN_STATE_PRECONFIG,
> > +};  
> 
> It's a shame this is such a manual copy.
> 
> While you're taking a big hammer to HMP in the preconfig case,
> it's worth noting this more specific code is only protecting QMP
> commands.
> 
> 
> It's a shame in all the uses below we can't be working with bitmasks
> of run-state's; it would feel a lot easier to have a default and mask
> out or or in extra states.
> 
> Dave
[...]

> > @@ -219,7 +219,11 @@
> >  # Note: This example has been shortened as the real response is too long.
> >  #
> >  ##
> > -{ 'command': 'query-commands', 'returns': ['CommandInfo'] }
> > +{ 'command': 'query-commands', 'returns': ['CommandInfo'],
> > +  'runstates': [ 'debug', 'inmigrate', 'internal-error', 'io-error', 'paused',
> > +                 'postmigrate', 'prelaunch', 'finish-migrate', 'restore-vm',
> > +                 'running', 'save-vm', 'shutdown', 'suspended', 'watchdog',
> > +                 'guest-panicked', 'colo', 'preconfig' ] }  
> 
> That's going to get to be a pain to update as we add more states.
[...]
Yep it would be a pain so,
In v4 this approach/patch is replaced by a simpler one that Eric's suggested.
It will provide preconfig  specific flag in command, similar to what allow-oob
patches on list do. So it would look like following:

------------------------ docs/devel/qapi-code-gen.txt -------------------------
index 25b7180..170f15f 100644
@@ -556,7 +556,8 @@ following example objects:
 
 Usage: { 'command': STRING, '*data': COMPLEX-TYPE-NAME-OR-DICT,
          '*returns': TYPE-NAME, '*boxed': true,
-         '*gen': false, '*success-response': false }
+         '*gen': false, '*success-response': false,
+         '*allowed-in-preconfig': true }
 
 Commands are defined by using a dictionary containing several members,
 where three members are most common.  The 'command' member is a
@@ -636,6 +637,13 @@ possible, the command expression should include the optional key
 'success-response' with boolean value false.  So far, only QGA makes
 use of this member.
 
+A command may use optional 'allowed-in-preconfig' key to permit
+its execution at early runtime configuration stage (preconfig runstate).
+If not specified then a command defaults to 'allowed-in-preconfig: false'.
+
+An example of declaring preconfig enabled command:
+ { 'command': 'qmp_capabilities',
+   'allowed-in-preconfig': true }
