Received: from eggs.gnu.org ([2001:4830:134:3::10]:56462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fuGRJ-0005np-06
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 08:16:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fuGPh-0002EX-2m
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 08:14:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59484 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fuGPg-0002Dy-Sh
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 08:14:33 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 90ADD26347
	for <qemu-devel@nongnu.org>; Mon, 27 Aug 2018 12:14:32 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180815133747.25032-1-peterx@redhat.com>
	<20180815133747.25032-4-peterx@redhat.com>
Date: Mon, 27 Aug 2018 14:14:25 +0200
In-Reply-To: <20180815133747.25032-4-peterx@redhat.com> (Peter Xu's message of
	"Wed, 15 Aug 2018 21:37:37 +0800")
Message-ID: <87tvngt3a6.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v6 03/13] qapi: remove error checks for
 event emission
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

Peter Xu <peterx@redhat.com> writes:

> In the whole QAPI event emission code we're passing in an Error* object
> along the whole stack.  That's never useful since it never fails after
> all.  Remove that.

This is the interesting part.  We'll see below why it can't fail.

> Then, remove that parameter from all the callers to send an event.

This is the mechanical part.  The callers pass &error_abort, except for
one that passes NULL.

The patch moves the &error_abort argument from the qapi_event_send_FOO()
calls to the places where the argument is used.  No effect except for
the caller that passes NULL.  That one now asserts "no error".

> Suggested-by: Eric Blake <eblake@redhat.com>
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---

Patch quoted except for the parts that drop &error_abort from
qapi_event_send_FOO() calls:

[...]
> diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
> index c2e11465f0..6d3cffd548 100644
> --- a/docs/devel/qapi-code-gen.txt
> +++ b/docs/devel/qapi-code-gen.txt
> @@ -1356,10 +1356,9 @@ Example:
>      $ cat qapi-generated/example-qapi-events.c
>  [Uninteresting stuff omitted...]
>  
> -    void qapi_event_send_my_event(Error **errp)
> +    void qapi_event_send_my_event(void)
>      {
>          QDict *qmp;
> -        Error *err = NULL;
>          QMPEventFuncEmit emit;
>  
>          emit = qmp_event_get_func_emit();
> @@ -1369,9 +1368,8 @@ Example:
>  
>          qmp = qmp_event_build_dict("MY_EVENT");
>  
> -        emit(EXAMPLE_QAPI_EVENT_MY_EVENT, qmp, &err);
> +        emit(EXAMPLE_QAPI_EVENT_MY_EVENT, qmp);
>  
> -        error_propagate(errp, err);
>          qobject_unref(qmp);
>      }
>  
[...]
> diff --git a/include/qapi/qmp-event.h b/include/qapi/qmp-event.h
> index 0c87ad833e..23e588ccf8 100644
> --- a/include/qapi/qmp-event.h
> +++ b/include/qapi/qmp-event.h
> @@ -14,8 +14,7 @@
>  #ifndef QMP_EVENT_H
>  #define QMP_EVENT_H
>  
> -
> -typedef void (*QMPEventFuncEmit)(unsigned event, QDict *dict, Error **errp);
> +typedef void (*QMPEventFuncEmit)(unsigned event, QDict *dict);
>  
>  void qmp_event_set_func_emit(QMPEventFuncEmit emit);
>  
[...]
> diff --git a/migration/ram.c b/migration/ram.c
> index 79c89425a3..f6fd8e5e09 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -1670,7 +1670,7 @@ static void migration_bitmap_sync(RAMState *rs)
>          rs->bytes_xfer_prev = bytes_xfer_now;
>      }
>      if (migrate_use_events()) {
> -        qapi_event_send_migration_pass(ram_counters.dirty_sync_count, NULL);
> +        qapi_event_send_migration_pass(ram_counters.dirty_sync_count);
>      }
>  }
>  

This is the one caller that ignores errors instead of asserting they
can't happen.

> diff --git a/monitor.c b/monitor.c
> index 5cd9398824..3fb480d94b 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -689,7 +689,7 @@ monitor_qapi_event_queue_no_reenter(QAPIEvent event, QDict *qdict)
>  }
>  
>  static void
> -monitor_qapi_event_queue(QAPIEvent event, QDict *qdict, Error **errp)
> +monitor_qapi_event_queue(QAPIEvent event, QDict *qdict)
>  {
>      /*
>       * monitor_qapi_event_queue_no_reenter() is not reentrant: it

Doesn't use its @errp argument, i.e. it can't fail.

[...]
> diff --git a/scripts/qapi/events.py b/scripts/qapi/events.py
> index 764ef177ab..2ed7902424 100644
> --- a/scripts/qapi/events.py
> +++ b/scripts/qapi/events.py
> @@ -18,7 +18,7 @@ from qapi.common import *
>  def build_event_send_proto(name, arg_type, boxed):
>      return 'void qapi_event_send_%(c_name)s(%(param)s)' % {
>          'c_name': c_name(name.lower()),
> -        'param': build_params(arg_type, boxed, 'Error **errp')}
> +        'param': build_params(arg_type, boxed)}
>  
>  
>  def gen_event_send_decl(name, arg_type, boxed):
> @@ -70,7 +70,6 @@ def gen_event_send(name, arg_type, boxed, event_enum_name):

This is where we change to &error_abort.  We need to show "can't fail".

>  %(proto)s
>  {
>      QDict *qmp;
> -    Error *err = NULL;
>      QMPEventFuncEmit emit;
>  ''',
>                  proto=build_event_send_proto(name, arg_type, boxed))
> @@ -103,45 +102,35 @@ def gen_event_send(name, arg_type, boxed, event_enum_name):
       if arg_type and not arg_type.is_empty():
           ret += mcgen('''
       v = qobject_output_visitor_new(&obj);
>  ''')
>          if not arg_type.is_implicit():
>              ret += mcgen('''
> -    visit_type_%(c_name)s(v, "%(name)s", &arg, &err);
> +    visit_type_%(c_name)s(v, "%(name)s", &arg, &error_abort);


Correct, because the QObject output visitor never fails.

>  ''',
>                           name=name, c_name=arg_type.c_name())
>          else:
>              ret += mcgen('''
>  
> -    visit_start_struct(v, "%(name)s", NULL, 0, &err);
> -    if (err) {
> -        goto out;
> -    }
> -    visit_type_%(c_name)s_members(v, &param, &err);
> -    if (!err) {
> -        visit_check_struct(v, &err);
> -    }
> +    visit_start_struct(v, "%(name)s", NULL, 0, &error_abort);
> +    visit_type_%(c_name)s_members(v, &param, &error_abort);
> +    visit_check_struct(v, &error_abort);


Likewise.

>      visit_end_struct(v, NULL);
>  ''',
>                           name=name, c_name=arg_type.c_name())
>          ret += mcgen('''
> -    if (err) {
> -        goto out;
> -    }
>  
>      visit_complete(v, &obj);
>      qdict_put_obj(qmp, "data", obj);
>  ''')
>  
>      ret += mcgen('''
> -    emit(%(c_enum)s, qmp, &err);
> +    emit(%(c_enum)s, qmp);

@emit is either monitor_qapi_event_queue() or event_test_emit().
Neither can fail.

>  
>  ''',
>                   c_enum=c_enum_const(event_enum_name, name))
>  
>      if arg_type and not arg_type.is_empty():
>          ret += mcgen('''
> -out:
>      visit_free(v);
>  ''')
>      ret += mcgen('''
> -    error_propagate(errp, err);
>      qobject_unref(qmp);
>  }
>  ''')
[...]
> diff --git a/tests/test-qmp-event.c b/tests/test-qmp-event.c
> index 8677094ad1..9cddd72adb 100644
> --- a/tests/test-qmp-event.c
> +++ b/tests/test-qmp-event.c
> @@ -95,7 +95,7 @@ static bool qdict_cmp_simple(QDict *a, QDict *b)
>  
>  /* This function is hooked as final emit function, which can verify the
>     correctness. */
> -static void event_test_emit(test_QAPIEvent event, QDict *d, Error **errp)
> +static void event_test_emit(test_QAPIEvent event, QDict *d)
>  {
>      QDict *t;
>      int64_t s, ms;

Doesn't use its @errp argument, i.e. it can't fail.

[...]

Let's improve the commit message a bit.  Here's my try:

    qapi: Drop qapi_event_send_FOO()'s Error ** argument

    The generated qapi_event_send_FOO() take an Error ** argument.  They
    can't actually fail, because all they do with the argument is passing it
    to functions that can't fail: the QObject output visitor, and the
    @qmp_emit callback, which is either monitor_qapi_event_queue() or
    event_test_emit().

    Drop the argument, and pass &error_abort to the QObject output visitor
    and @qmp_emit instead.

With something like that:
Reviewed-by: Markus Armbruster <armbru@redhat.com>
