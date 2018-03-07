Received: from eggs.gnu.org ([2001:4830:134:3::10]:45993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1etZsS-0008Mm-Eg
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 09:17:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1etZsO-0000jn-DI
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 09:17:08 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49976 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1etZsO-0000i6-55
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 09:17:04 -0500
Date: Wed, 7 Mar 2018 14:16:50 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180307141648.GC3090@work-vm>
References: <1518784641-43151-1-git-send-email-imammedo@redhat.com>
	<1518784641-43151-6-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518784641-43151-6-git-send-email-imammedo@redhat.com>
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
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, pkrempa@redhat.com, ehabkost@redhat.com, cohuck@redhat.com, armbru@redhat.com, pbonzini@redhat.com, david@gibson.dropbear.id.au

* Igor Mammedov (imammedo@redhat.com) wrote:
> Add optional 'runstates' parameter in QAPI command definition,
> which will permit to specify RunState variations in which
> a command could be exectuted via QMP monitor.
> 
> For compatibility reasons, commands, that don't use
> 'runstates' explicitly, are not permited to run in
> preconfig state but allowed in all other states.
> 
> New option will be used to allow commands, which are
> prepared/need to run this early, to run in preconfig state.
> It will include query-hotpluggable-cpus and new set-numa-node
> commands. Other commands that should be able to run in
> preconfig state, should be ammeded to not expect machine
> in initialized state.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  include/qapi/qmp/dispatch.h             |  5 +++-
>  monitor.c                               | 28 +++++++++++++++++---
>  qapi-schema.json                        | 12 +++++++--
>  qapi/qmp-dispatch.c                     | 39 ++++++++++++++++++++++++++++
>  qapi/qmp-registry.c                     |  4 ++-
>  qapi/run-state.json                     |  6 ++++-
>  scripts/qapi-commands.py                | 46 ++++++++++++++++++++++++++-------
>  scripts/qapi-introspect.py              |  2 +-
>  scripts/qapi.py                         | 15 +++++++----
>  scripts/qapi2texi.py                    |  2 +-
>  tests/qapi-schema/doc-good.out          |  4 +--
>  tests/qapi-schema/ident-with-escape.out |  2 +-
>  tests/qapi-schema/indented-expr.out     |  4 +--
>  tests/qapi-schema/qapi-schema-test.out  | 18 ++++++-------
>  tests/qapi-schema/test-qapi.py          |  6 ++---
>  15 files changed, 151 insertions(+), 42 deletions(-)
> 
> diff --git a/include/qapi/qmp/dispatch.h b/include/qapi/qmp/dispatch.h
> index 1e694b5..f821781 100644
> --- a/include/qapi/qmp/dispatch.h
> +++ b/include/qapi/qmp/dispatch.h
> @@ -15,6 +15,7 @@
>  #define QAPI_QMP_DISPATCH_H
>  
>  #include "qemu/queue.h"
> +#include "qapi-types.h"
>  
>  typedef void (QmpCommandFunc)(QDict *, QObject **, Error **);
>  
> @@ -31,12 +32,14 @@ typedef struct QmpCommand
>      QmpCommandOptions options;
>      QTAILQ_ENTRY(QmpCommand) node;
>      bool enabled;
> +    const RunState *valid_runstates;
>  } QmpCommand;
>  
>  typedef QTAILQ_HEAD(QmpCommandList, QmpCommand) QmpCommandList;
>  
>  void qmp_register_command(QmpCommandList *cmds, const char *name,
> -                          QmpCommandFunc *fn, QmpCommandOptions options);
> +                          QmpCommandFunc *fn, QmpCommandOptions options,
> +                          const RunState valid_runstates[]);
>  void qmp_unregister_command(QmpCommandList *cmds, const char *name);
>  QmpCommand *qmp_find_command(QmpCommandList *cmds, const char *name);
>  QObject *qmp_dispatch(QmpCommandList *cmds, QObject *request);
> diff --git a/monitor.c b/monitor.c
> index fcb5386..2edc96c 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -224,6 +224,25 @@ static mon_cmd_t mon_cmds[];
>  static mon_cmd_t info_cmds[];
>  
>  QmpCommandList qmp_commands, qmp_cap_negotiation_commands;
> +const RunState cap_negotiation_valid_runstates[] = {
> +    RUN_STATE_DEBUG,
> +    RUN_STATE_INMIGRATE,
> +    RUN_STATE_INTERNAL_ERROR,
> +    RUN_STATE_IO_ERROR,
> +    RUN_STATE_PAUSED,
> +    RUN_STATE_POSTMIGRATE,
> +    RUN_STATE_PRELAUNCH,
> +    RUN_STATE_FINISH_MIGRATE,
> +    RUN_STATE_RESTORE_VM,
> +    RUN_STATE_RUNNING,
> +    RUN_STATE_SAVE_VM,
> +    RUN_STATE_SHUTDOWN,
> +    RUN_STATE_SUSPENDED,
> +    RUN_STATE_WATCHDOG,
> +    RUN_STATE_GUEST_PANICKED,
> +    RUN_STATE_COLO,
> +    RUN_STATE_PRECONFIG,
> +};

It's a shame this is such a manual copy.

While you're taking a big hammer to HMP in the preconfig case,
it's worth noting this more specific code is only protecting QMP
commands.


It's a shame in all the uses below we can't be working with bitmasks
of run-state's; it would feel a lot easier to have a default and mask
out or or in extra states.

Dave

>  Monitor *cur_mon;
>  
> @@ -1016,17 +1035,18 @@ void monitor_init_qmp_commands(void)
>  
>      qmp_register_command(&qmp_commands, "query-qmp-schema",
>                           qmp_query_qmp_schema,
> -                         QCO_NO_OPTIONS);
> +                         QCO_NO_OPTIONS, NULL);
>      qmp_register_command(&qmp_commands, "device_add", qmp_device_add,
> -                         QCO_NO_OPTIONS);
> +                         QCO_NO_OPTIONS, NULL);
>      qmp_register_command(&qmp_commands, "netdev_add", qmp_netdev_add,
> -                         QCO_NO_OPTIONS);
> +                         QCO_NO_OPTIONS, NULL);
>  
>      qmp_unregister_commands_hack();
>  
>      QTAILQ_INIT(&qmp_cap_negotiation_commands);
>      qmp_register_command(&qmp_cap_negotiation_commands, "qmp_capabilities",
> -                         qmp_marshal_qmp_capabilities, QCO_NO_OPTIONS);
> +                         qmp_marshal_qmp_capabilities, QCO_NO_OPTIONS,
> +                         cap_negotiation_valid_runstates);
>  }
>  
>  void qmp_qmp_capabilities(Error **errp)
> diff --git a/qapi-schema.json b/qapi-schema.json
> index 0262b9f..ee1053d 100644
> --- a/qapi-schema.json
> +++ b/qapi-schema.json
> @@ -219,7 +219,11 @@
>  # Note: This example has been shortened as the real response is too long.
>  #
>  ##
> -{ 'command': 'query-commands', 'returns': ['CommandInfo'] }
> +{ 'command': 'query-commands', 'returns': ['CommandInfo'],
> +  'runstates': [ 'debug', 'inmigrate', 'internal-error', 'io-error', 'paused',
> +                 'postmigrate', 'prelaunch', 'finish-migrate', 'restore-vm',
> +                 'running', 'save-vm', 'shutdown', 'suspended', 'watchdog',
> +                 'guest-panicked', 'colo', 'preconfig' ] }

That's going to get to be a pain to update as we add more states.

>  ##
>  # @LostTickPolicy:
> @@ -1146,7 +1150,11 @@
>  # <- { "return": {} }
>  #
>  ##
> -{ 'command': 'cont' }
> +{ 'command': 'cont',
> +  'runstates': [ 'debug', 'inmigrate', 'internal-error', 'io-error', 'paused',
> +                 'postmigrate', 'prelaunch', 'finish-migrate', 'restore-vm',
> +                 'running', 'save-vm', 'shutdown', 'suspended', 'watchdog',
> +                 'guest-panicked', 'colo', 'preconfig' ] }
>  
>  ##
>  # @system_wakeup:
> diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
> index e31ac4b..26cba19 100644
> --- a/qapi/qmp-dispatch.c
> +++ b/qapi/qmp-dispatch.c
> @@ -17,6 +17,7 @@
>  #include "qapi/qmp/json-parser.h"
>  #include "qapi/qmp/qdict.h"
>  #include "qapi/qmp/qjson.h"
> +#include "sysemu/sysemu.h"
>  
>  static QDict *qmp_dispatch_check_obj(const QObject *request, Error **errp)
>  {
> @@ -65,6 +66,40 @@ static QDict *qmp_dispatch_check_obj(const QObject *request, Error **errp)
>      return dict;
>  }
>  
> +static bool is_cmd_permited(const QmpCommand *cmd, Error **errp)
> +{
> +    int i;
> +    char *list = NULL;
> +
> +    /* Old commands that don't have explicit runstate in schema
> +     * are permited to run except of at PRECONFIG stage
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
> +    }
> +    error_setg(errp, "The command '%s' is valid only in '%s'", cmd->name, list);
> +    g_free(list);
> +
> +    return false;
> +}
> +
>  static QObject *do_qmp_dispatch(QmpCommandList *cmds, QObject *request,
>                                  Error **errp)
>  {
> @@ -92,6 +127,10 @@ static QObject *do_qmp_dispatch(QmpCommandList *cmds, QObject *request,
>          return NULL;
>      }
>  
> +    if (!is_cmd_permited(cmd, errp)) {
> +        return NULL;
> +    }
> +
>      if (!qdict_haskey(dict, "arguments")) {
>          args = qdict_new();
>      } else {
> diff --git a/qapi/qmp-registry.c b/qapi/qmp-registry.c
> index 5af484c..59a5b85 100644
> --- a/qapi/qmp-registry.c
> +++ b/qapi/qmp-registry.c
> @@ -16,7 +16,8 @@
>  #include "qapi/qmp/dispatch.h"
>  
>  void qmp_register_command(QmpCommandList *cmds, const char *name,
> -                          QmpCommandFunc *fn, QmpCommandOptions options)
> +                          QmpCommandFunc *fn, QmpCommandOptions options,
> +                          const RunState valid_runstates[])
>  {
>      QmpCommand *cmd = g_malloc0(sizeof(*cmd));
>  
> @@ -24,6 +25,7 @@ void qmp_register_command(QmpCommandList *cmds, const char *name,
>      cmd->fn = fn;
>      cmd->enabled = true;
>      cmd->options = options;
> +    cmd->valid_runstates = valid_runstates;
>      QTAILQ_INSERT_TAIL(cmds, cmd, node);
>  }
>  
> diff --git a/qapi/run-state.json b/qapi/run-state.json
> index d24a4e8..1c1c9b8 100644
> --- a/qapi/run-state.json
> +++ b/qapi/run-state.json
> @@ -92,7 +92,11 @@
>  #                  "status": "running" } }
>  #
>  ##
> -{ 'command': 'query-status', 'returns': 'StatusInfo' }
> +{ 'command': 'query-status', 'returns': 'StatusInfo',
> +  'runstates': [ 'debug', 'inmigrate', 'internal-error', 'io-error', 'paused',
> +                 'postmigrate', 'prelaunch', 'finish-migrate', 'restore-vm',
> +                 'running', 'save-vm', 'shutdown', 'suspended', 'watchdog',
> +                 'guest-panicked', 'colo', 'preconfig' ] }
>  
>  ##
>  # @SHUTDOWN:
> diff --git a/scripts/qapi-commands.py b/scripts/qapi-commands.py
> index f89d748..659e167 100644
> --- a/scripts/qapi-commands.py
> +++ b/scripts/qapi-commands.py
> @@ -192,17 +192,45 @@ out:
>      return ret
>  
>  
> -def gen_register_command(name, success_response):
> +def gen_register_command(name, success_response, runstates):
>      options = 'QCO_NO_OPTIONS'
>      if not success_response:
>          options = 'QCO_NO_SUCCESS_RESP'
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
>      return ret
>  
>  
> @@ -241,7 +269,7 @@ class QAPISchemaGenCommandVisitor(QAPISchemaVisitor):
>          self._visited_ret_types = None
>  
>      def visit_command(self, name, info, arg_type, ret_type,
> -                      gen, success_response, boxed):
> +                      gen, success_response, boxed, runstates):
>          if not gen:
>              return
>          self.decl += gen_command_decl(name, arg_type, boxed, ret_type)
> @@ -250,7 +278,7 @@ class QAPISchemaGenCommandVisitor(QAPISchemaVisitor):
>              self.defn += gen_marshal_output(ret_type)
>          self.decl += gen_marshal_decl(name)
>          self.defn += gen_marshal(name, arg_type, boxed, ret_type)
> -        self._regy += gen_register_command(name, success_response)
> +        self._regy += gen_register_command(name, success_response, runstates)
>  
>  
>  (input_file, output_dir, do_c, do_h, prefix, opts) = parse_command_line()
> diff --git a/scripts/qapi-introspect.py b/scripts/qapi-introspect.py
> index 032bcea..ede86ac 100644
> --- a/scripts/qapi-introspect.py
> +++ b/scripts/qapi-introspect.py
> @@ -154,7 +154,7 @@ const char %(c_name)s[] = %(c_string)s;
>                                      for m in variants.variants]})
>  
>      def visit_command(self, name, info, arg_type, ret_type,
> -                      gen, success_response, boxed):
> +                      gen, success_response, boxed, runstates):
>          arg_type = arg_type or self._schema.the_empty_object_type
>          ret_type = ret_type or self._schema.the_empty_object_type
>          self._gen_json(name, 'command',
> diff --git a/scripts/qapi.py b/scripts/qapi.py
> index 58f995b..5c5037e 100644
> --- a/scripts/qapi.py
> +++ b/scripts/qapi.py
> @@ -919,7 +919,8 @@ def check_exprs(exprs):
>          elif 'command' in expr:
>              meta = 'command'
>              check_keys(expr_elem, 'command', [],
> -                       ['data', 'returns', 'gen', 'success-response', 'boxed'])
> +                       ['data', 'returns', 'gen', 'success-response', 'boxed',
> +                        'runstates'])
>          elif 'event' in expr:
>              meta = 'event'
>              check_keys(expr_elem, 'event', [], ['data', 'boxed'])
> @@ -1030,7 +1031,7 @@ class QAPISchemaVisitor(object):
>          pass
>  
>      def visit_command(self, name, info, arg_type, ret_type,
> -                      gen, success_response, boxed):
> +                      gen, success_response, boxed, runstates):
>          pass
>  
>      def visit_event(self, name, info, arg_type, boxed):
> @@ -1397,7 +1398,7 @@ class QAPISchemaAlternateType(QAPISchemaType):
>  
>  class QAPISchemaCommand(QAPISchemaEntity):
>      def __init__(self, name, info, doc, arg_type, ret_type,
> -                 gen, success_response, boxed):
> +                 gen, success_response, boxed, runstates):
>          QAPISchemaEntity.__init__(self, name, info, doc)
>          assert not arg_type or isinstance(arg_type, str)
>          assert not ret_type or isinstance(ret_type, str)
> @@ -1408,6 +1409,7 @@ class QAPISchemaCommand(QAPISchemaEntity):
>          self.gen = gen
>          self.success_response = success_response
>          self.boxed = boxed
> +        self.runstates = runstates
>  
>      def check(self, schema):
>          if self._arg_type_name:
> @@ -1431,7 +1433,8 @@ class QAPISchemaCommand(QAPISchemaEntity):
>      def visit(self, visitor):
>          visitor.visit_command(self.name, self.info,
>                                self.arg_type, self.ret_type,
> -                              self.gen, self.success_response, self.boxed)
> +                              self.gen, self.success_response, self.boxed,
> +                              self.runstates)
>  
>  
>  class QAPISchemaEvent(QAPISchemaEntity):
> @@ -1639,6 +1642,7 @@ class QAPISchema(object):
>          gen = expr.get('gen', True)
>          success_response = expr.get('success-response', True)
>          boxed = expr.get('boxed', False)
> +        runstates = expr.get('runstates')
>          if isinstance(data, OrderedDict):
>              data = self._make_implicit_object_type(
>                  name, info, doc, 'arg', self._make_members(data, info))
> @@ -1646,7 +1650,8 @@ class QAPISchema(object):
>              assert len(rets) == 1
>              rets = self._make_array_type(rets[0], info)
>          self._def_entity(QAPISchemaCommand(name, info, doc, data, rets,
> -                                           gen, success_response, boxed))
> +                                           gen, success_response, boxed,
> +                                           runstates))
>  
>      def _def_event(self, expr, info, doc):
>          name = expr['event']
> diff --git a/scripts/qapi2texi.py b/scripts/qapi2texi.py
> index bf1c57b..d28594c 100755
> --- a/scripts/qapi2texi.py
> +++ b/scripts/qapi2texi.py
> @@ -227,7 +227,7 @@ class QAPISchemaGenDocVisitor(qapi.QAPISchemaVisitor):
>                               body=texi_entity(doc, 'Members'))
>  
>      def visit_command(self, name, info, arg_type, ret_type,
> -                      gen, success_response, boxed):
> +                      gen, success_response, boxed, runstates):
>          doc = self.cur_doc
>          if boxed:
>              body = texi_body(doc)
> diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.out
> index 1d2c250..a47d6f6 100644
> --- a/tests/qapi-schema/doc-good.out
> +++ b/tests/qapi-schema/doc-good.out
> @@ -18,9 +18,9 @@ object Variant1
>      member var1: str optional=False
>  object Variant2
>  command cmd q_obj_cmd-arg -> Object
> -   gen=True success_response=True boxed=False
> +   gen=True success_response=True boxed=False, runstates=None
>  command cmd-boxed Object -> None
> -   gen=True success_response=True boxed=True
> +   gen=True success_response=True boxed=True, runstates=None
>  object q_empty
>  object q_obj_Variant1-wrapper
>      member data: Variant1 optional=False
> diff --git a/tests/qapi-schema/ident-with-escape.out b/tests/qapi-schema/ident-with-escape.out
> index b5637cb..d9a272b 100644
> --- a/tests/qapi-schema/ident-with-escape.out
> +++ b/tests/qapi-schema/ident-with-escape.out
> @@ -1,7 +1,7 @@
>  enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool']
>      prefix QTYPE
>  command fooA q_obj_fooA-arg -> None
> -   gen=True success_response=True boxed=False
> +   gen=True success_response=True boxed=False, runstates=None
>  object q_empty
>  object q_obj_fooA-arg
>      member bar1: str optional=False
> diff --git a/tests/qapi-schema/indented-expr.out b/tests/qapi-schema/indented-expr.out
> index 586795f..4b128d5 100644
> --- a/tests/qapi-schema/indented-expr.out
> +++ b/tests/qapi-schema/indented-expr.out
> @@ -1,7 +1,7 @@
>  enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool']
>      prefix QTYPE
>  command eins None -> None
> -   gen=True success_response=True boxed=False
> +   gen=True success_response=True boxed=False, runstates=None
>  object q_empty
>  command zwei None -> None
> -   gen=True success_response=True boxed=False
> +   gen=True success_response=True boxed=False, runstates=None
> diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/qapi-schema-test.out
> index 3b1e908..787c228 100644
> --- a/tests/qapi-schema/qapi-schema-test.out
> +++ b/tests/qapi-schema/qapi-schema-test.out
> @@ -153,15 +153,15 @@ object __org.qemu_x-Union2
>      tag __org.qemu_x-member1
>      case __org.qemu_x-value: __org.qemu_x-Struct2
>  command __org.qemu_x-command q_obj___org.qemu_x-command-arg -> __org.qemu_x-Union1
> -   gen=True success_response=True boxed=False
> +   gen=True success_response=True boxed=False, runstates=None
>  command boxed-struct UserDefZero -> None
> -   gen=True success_response=True boxed=True
> +   gen=True success_response=True boxed=True, runstates=None
>  command boxed-union UserDefNativeListUnion -> None
> -   gen=True success_response=True boxed=True
> +   gen=True success_response=True boxed=True, runstates=None
>  command guest-get-time q_obj_guest-get-time-arg -> int
> -   gen=True success_response=True boxed=False
> +   gen=True success_response=True boxed=False, runstates=None
>  command guest-sync q_obj_guest-sync-arg -> any
> -   gen=True success_response=True boxed=False
> +   gen=True success_response=True boxed=False, runstates=None
>  object q_empty
>  object q_obj_EVENT_C-arg
>      member a: int optional=True
> @@ -222,10 +222,10 @@ object q_obj_user_def_cmd2-arg
>      member ud1a: UserDefOne optional=False
>      member ud1b: UserDefOne optional=True
>  command user_def_cmd None -> None
> -   gen=True success_response=True boxed=False
> +   gen=True success_response=True boxed=False, runstates=None
>  command user_def_cmd0 Empty2 -> Empty2
> -   gen=True success_response=True boxed=False
> +   gen=True success_response=True boxed=False, runstates=None
>  command user_def_cmd1 q_obj_user_def_cmd1-arg -> None
> -   gen=True success_response=True boxed=False
> +   gen=True success_response=True boxed=False, runstates=None
>  command user_def_cmd2 q_obj_user_def_cmd2-arg -> UserDefTwo
> -   gen=True success_response=True boxed=False
> +   gen=True success_response=True boxed=False, runstates=None
> diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi.py
> index ac43d34..958576d 100644
> --- a/tests/qapi-schema/test-qapi.py
> +++ b/tests/qapi-schema/test-qapi.py
> @@ -37,11 +37,11 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
>          self._print_variants(variants)
>  
>      def visit_command(self, name, info, arg_type, ret_type,
> -                      gen, success_response, boxed):
> +                      gen, success_response, boxed, runstates):
>          print('command %s %s -> %s' % \
>                (name, arg_type and arg_type.name, ret_type and ret_type.name))
> -        print('   gen=%s success_response=%s boxed=%s' % \
> -              (gen, success_response, boxed))
> +        print('   gen=%s success_response=%s boxed=%s, runstates=%s' % \
> +              (gen, success_response, boxed, runstates))
>  
>      def visit_event(self, name, info, arg_type, boxed):
>          print('event %s %s' % (name, arg_type and arg_type.name))
> -- 
> 2.7.4
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
