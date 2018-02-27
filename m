Received: from eggs.gnu.org ([2001:4830:134:3::10]:43109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eqnSX-0002Tu-Fh
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 17:10:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eqnST-0002T8-F9
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 17:10:53 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57274 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eqnST-0002St-8o
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 17:10:49 -0500
References: <1518784641-43151-1-git-send-email-imammedo@redhat.com>
	<1518784641-43151-6-git-send-email-imammedo@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <25f9342d-2eea-9b87-d371-b66c4285a78d@redhat.com>
Date: Tue, 27 Feb 2018 16:10:31 -0600
MIME-Version: 1.0
In-Reply-To: <1518784641-43151-6-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
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
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, ehabkost@redhat.com, pkrempa@redhat.com, david@gibson.dropbear.id.au, peter.maydell@linaro.org, pbonzini@redhat.com, cohuck@redhat.com

On 02/16/2018 06:37 AM, Igor Mammedov wrote:
> Add optional 'runstates' parameter in QAPI command definition,
> which will permit to specify RunState variations in which
> a command could be exectuted via QMP monitor.

s/exectuted/executed/

> 
> For compatibility reasons, commands, that don't use

s/commands,/commands/

> 'runstates' explicitly, are not permited to run in

s/explicitly,/explicitly/
s/permited/permitted/

> preconfig state but allowed in all other states.
> 
> New option will be used to allow commands, which are
> prepared/need to run this early, to run in preconfig state.
> It will include query-hotpluggable-cpus and new set-numa-node
> commands. Other commands that should be able to run in
> preconfig state, should be ammeded to not expect machine

s/ammeded/amended/

> in initialized state.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>   include/qapi/qmp/dispatch.h             |  5 +++-
>   monitor.c                               | 28 +++++++++++++++++---
>   qapi-schema.json                        | 12 +++++++--
>   qapi/qmp-dispatch.c                     | 39 ++++++++++++++++++++++++++++
>   qapi/qmp-registry.c                     |  4 ++-
>   qapi/run-state.json                     |  6 ++++-
>   scripts/qapi-commands.py                | 46 ++++++++++++++++++++++++++-------
>   scripts/qapi-introspect.py              |  2 +-
>   scripts/qapi.py                         | 15 +++++++----
>   scripts/qapi2texi.py                    |  2 +-
>   tests/qapi-schema/doc-good.out          |  4 +--
>   tests/qapi-schema/ident-with-escape.out |  2 +-
>   tests/qapi-schema/indented-expr.out     |  4 +--
>   tests/qapi-schema/qapi-schema-test.out  | 18 ++++++-------
>   tests/qapi-schema/test-qapi.py          |  6 ++---
>   15 files changed, 151 insertions(+), 42 deletions(-)

Missing mention in docs/; among other things, see how the OOB series 
adds a similar per-command witness during QMP on whether the command can 
be used in certain contexts:
https://lists.gnu.org/archive/html/qemu-devel/2018-01/msg05789.html
including edits to docs/devel/qapi-code-gen.txt (definitely needed here) 
and docs/interop/qmp-spec.txt (may or may not be needed here).

> 
> diff --git a/include/qapi/qmp/dispatch.h b/include/qapi/qmp/dispatch.h
> index 1e694b5..f821781 100644
> --- a/include/qapi/qmp/dispatch.h
> +++ b/include/qapi/qmp/dispatch.h
> @@ -15,6 +15,7 @@
>   #define QAPI_QMP_DISPATCH_H
>   
>   #include "qemu/queue.h"
> +#include "qapi-types.h"

Probably conflict with the pending work from Markus to reorganize the 
QAPI header files to be more modular.

> +++ b/qapi-schema.json
> @@ -219,7 +219,11 @@
>   # Note: This example has been shortened as the real response is too long.
>   #
>   ##
> -{ 'command': 'query-commands', 'returns': ['CommandInfo'] }
> +{ 'command': 'query-commands', 'returns': ['CommandInfo'],
> +  'runstates': [ 'debug', 'inmigrate', 'internal-error', 'io-error', 'paused',
> +                 'postmigrate', 'prelaunch', 'finish-migrate', 'restore-vm',
> +                 'running', 'save-vm', 'shutdown', 'suspended', 'watchdog',
> +                 'guest-panicked', 'colo', 'preconfig' ] }

Wow, that's going to be a lot of states to list for every command that 
is interested in the non-default state.  Would a simple bool flag be any 
easier than a list of states, since it looks like preconfig is the only 
special state?

>   
>   ##
>   # @LostTickPolicy:
> @@ -1146,7 +1150,11 @@
>   # <- { "return": {} }
>   #
>   ##
> -{ 'command': 'cont' }
> +{ 'command': 'cont',
> +  'runstates': [ 'debug', 'inmigrate', 'internal-error', 'io-error', 'paused',
> +                 'postmigrate', 'prelaunch', 'finish-migrate', 'restore-vm',
> +                 'running', 'save-vm', 'shutdown', 'suspended', 'watchdog',
> +                 'guest-panicked', 'colo', 'preconfig' ] }

Should 'stop' also be permitted in the preconfig state, to get to the 
state that used to be provided by 'qemu -S'?


> @@ -65,6 +66,40 @@ static QDict *qmp_dispatch_check_obj(const QObject *request, Error **errp)
>       return dict;
>   }
>   
> +static bool is_cmd_permited(const QmpCommand *cmd, Error **errp)

s/permited/permitted/g

> +{
> +    int i;
> +    char *list = NULL;
> +
> +    /* Old commands that don't have explicit runstate in schema
> +     * are permited to run except of at PRECONFIG stage

including in the comments

> +     */
> +    if (!cmd->valid_runstates) {
> +        if (runstate_check(RUN_STATE_PRECONFIG)) {
> +            const char *state = RunState_str(RUN_STATE_PRECONFIG);
> +            error_setg(errp, "The command '%s' isn't valid in '%s'",
> +                       cmd->name, state);
> +            return false;
> +        }
> +        return true;
> +    }
> +
> +    for (i = 0; cmd->valid_runstates[i] != RUN_STATE__MAX; i++) {
> +        if (runstate_check(cmd->valid_runstates[i])) {
> +            return true;
> +        }
> +    }
> +
> +    for (i = 0; cmd->valid_runstates[i] != RUN_STATE__MAX; i++) {
> +        const char *state = RunState_str(cmd->valid_runstates[i]);
> +        list = g_strjoin(", ", state, list, NULL);

This is rather complex compared to a simple bool of whether a command 
can be run in preconfig; do we anticipate ever making any other commands 
fine-grained by state where the length of this message is worthwhile?

> +++ b/scripts/qapi-commands.py
> @@ -192,17 +192,45 @@ out:
>       return ret
>   
>   
> -def gen_register_command(name, success_response):
> +def gen_register_command(name, success_response, runstates):
>       options = 'QCO_NO_OPTIONS'
>       if not success_response:
>           options = 'QCO_NO_SUCCESS_RESP'
>   
> -    ret = mcgen('''
> -    qmp_register_command(cmds, "%(name)s",
> -                         qmp_marshal_%(c_name)s, %(opts)s);
> -''',
> -                name=name, c_name=c_name(name),
> -                opts=options)
> +    if runstates is None:
> +        ret = mcgen('''
> +        qmp_register_command(cmds, "%(name)s",

This is changing the indentation of generated output; everything within 
the mcgen() should be indented according to the output level, not the 
current Python nesting of the source file.

> +                             qmp_marshal_%(c_name)s, %(opts)s,
> +                             NULL);
> +        ''',
> +                     name=name, c_name=c_name(name),
> +                     opts=options)
> +    else:
> +        ret = mcgen('''
> +        static const RunState qmp_valid_states_%(c_name)s[] = {
> +'''
> +                   , c_name=c_name(name))

Unusual placement of the , between args to mcgen().

> +
> +        for value in runstates:
> +            ret += mcgen('''
> +                    %(c_enum)s,
> +'''
> +                         , c_enum=c_enum_const('RunState', value))
> +
> +        ret += mcgen('''
> +                    %(c_enum)s,
> +                };
> +'''
> +                     , c_enum=c_enum_const('RunState', "_MAX"))
> +
> +        ret += mcgen('''
> +                qmp_register_command(cmds, "%(name)s",
> +                                     qmp_marshal_%(c_name)s, %(opts)s,
> +                                     qmp_valid_states_%(c_name)s);
> +        ''',
> +                     name=name, c_name=c_name(name),
> +                     opts=options)
> +
>       return ret
>   
>   
> @@ -241,7 +269,7 @@ class QAPISchemaGenCommandVisitor(QAPISchemaVisitor):
>           self._visited_ret_types = None
>   
>       def visit_command(self, name, info, arg_type, ret_type,
> -                      gen, success_response, boxed):
> +                      gen, success_response, boxed, runstates):
>           if not gen:
>               return
>           self.decl += gen_command_decl(name, arg_type, boxed, ret_type)
> @@ -250,7 +278,7 @@ class QAPISchemaGenCommandVisitor(QAPISchemaVisitor):
>               self.defn += gen_marshal_output(ret_type)
>           self.decl += gen_marshal_decl(name)
>           self.defn += gen_marshal(name, arg_type, boxed, ret_type)
> -        self._regy += gen_register_command(name, success_response)
> +        self._regy += gen_register_command(name, success_response, runstates)

Yeah, we'll definitely need to rebase this on top of Markus' work to 
modularize QAPI output files.

> +++ b/scripts/qapi.py
> @@ -919,7 +919,8 @@ def check_exprs(exprs):
>           elif 'command' in expr:
>               meta = 'command'
>               check_keys(expr_elem, 'command', [],
> -                       ['data', 'returns', 'gen', 'success-response', 'boxed'])
> +                       ['data', 'returns', 'gen', 'success-response', 'boxed',
> +                        'runstates'])

'runstates' is specific to QMP, and doesn't really apply to QGA, right? 
That makes me wonder if it is really the best interface to be exposing 
to the QAPI generator.  Certainly, a single bool that states whether a 
command is allowed in preconfig is a bit more extensible to both QGA and 
QMP, when compared to a list of QMP-specific states.

> @@ -1639,6 +1642,7 @@ class QAPISchema(object):
>           gen = expr.get('gen', True)
>           success_response = expr.get('success-response', True)
>           boxed = expr.get('boxed', False)
> +        runstates = expr.get('runstates')
>           if isinstance(data, OrderedDict):
>               data = self._make_implicit_object_type(
>                   name, info, doc, 'arg', self._make_members(data, info))
> @@ -1646,7 +1650,8 @@ class QAPISchema(object):
>               assert len(rets) == 1
>               rets = self._make_array_type(rets[0], info)
>           self._def_entity(QAPISchemaCommand(name, info, doc, data, rets,
> -                                           gen, success_response, boxed))
> +                                           gen, success_response, boxed,
> +                                           runstates))

Where do we validate that the list of states passed in the QAPI file 
actually makes sense (and that the user didn't typo anything)?  That's 
another argument for a bool flag rather than an array of states, as it 
is easier to validate that a bool was set correctly rather than that a 
list doesn't introduce bogus states.

> +++ b/tests/qapi-schema/doc-good.out
> @@ -18,9 +18,9 @@ object Variant1
>       member var1: str optional=False
>   object Variant2
>   command cmd q_obj_cmd-arg -> Object
> -   gen=True success_response=True boxed=False
> +   gen=True success_response=True boxed=False, runstates=None

Inconsistent on whether output arguments are separated by comma...

> +++ b/tests/qapi-schema/test-qapi.py
> @@ -37,11 +37,11 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
>           self._print_variants(variants)
>   
>       def visit_command(self, name, info, arg_type, ret_type,
> -                      gen, success_response, boxed):
> +                      gen, success_response, boxed, runstates):
>           print('command %s %s -> %s' % \
>                 (name, arg_type and arg_type.name, ret_type and ret_type.name))
> -        print('   gen=%s success_response=%s boxed=%s' % \
> -              (gen, success_response, boxed))
> +        print('   gen=%s success_response=%s boxed=%s, runstates=%s' % \

...here

Also, while you did add coverage of the new information in the 
successful tests, you didn't add any negative tests to check diagnosis 
messages emitted when the field is present in the QAPI schema but 
doesn't make sense, and you didn't modify any of the test-only QAPI 
commands to use non-default states (which means only the live QMP 
commands test the new feature).  I would have expected at least a change 
in tests/qapi-schema/qapi-schema-test.json.

Overall, this is adding a lot of complexity to QMP; are we sure this is 
the interface libvirt wants to use for early NUMA configuration?  Can we 
simplify it to just a new bool, similar to 'allow-oob'?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
