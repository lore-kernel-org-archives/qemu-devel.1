Received: from eggs.gnu.org ([2001:4830:134:3::10]:37242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fazrG-00009O-Nt
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 04:43:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fazrD-0002Nw-Ke
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 04:43:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57108 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fazrD-0002MQ-ER
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 04:43:19 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C2099401EF26
	for <qemu-devel@nongnu.org>; Thu,  5 Jul 2018 08:43:18 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180704084507.14560-1-peterx@redhat.com>
	<20180704084507.14560-4-peterx@redhat.com>
Date: Thu, 05 Jul 2018 10:43:13 +0200
In-Reply-To: <20180704084507.14560-4-peterx@redhat.com> (Peter Xu's message of
	"Wed, 4 Jul 2018 16:45:01 +0800")
Message-ID: <871sciax9a.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 3/9] qapi: remove error checks for event
 emission
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

Peter Xu <peterx@redhat.com> writes:

> In the whole QAPI event emission code we're passing in an Error* object
> along the whole stack.  That's never useful since it never fails after
> all.  Remove that.
>
> Then, remove that parameter from all the callers to send an event.
>
> Suggested-by: Eric Blake <eblake@redhat.com>
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
[...]
> diff --git a/scripts/qapi/events.py b/scripts/qapi/events.py
> index 5657524688..3953dc9837 100644
> --- a/scripts/qapi/events.py
> +++ b/scripts/qapi/events.py
> @@ -18,7 +18,7 @@ from qapi.common import *
>  def build_event_send_proto(name, arg_type, boxed):
>      return 'void qapi_event_send_%(c_name)s(%(param)s)' % {
>          'c_name': c_name(name.lower()),
> -        'param': build_params(arg_type, boxed, 'Error **errp')}
> +        'param': build_params(arg_type, boxed, "")}

Use ' instead of " for consistency.

But let's make @extra optional in the previous patch (default it to
None), so this spot becomes simpler.

>  
>  
>  def gen_event_send_decl(name, arg_type, boxed):
> @@ -70,7 +70,6 @@ def gen_event_send(name, arg_type, boxed, event_enum_name):
>  %(proto)s
>  {
>      QDict *qmp;
> -    Error *err = NULL;
>      QMPEventFuncEmit emit;
>  ''',
>                  proto=build_event_send_proto(name, arg_type, boxed))
> @@ -103,45 +102,35 @@ def gen_event_send(name, arg_type, boxed, event_enum_name):
>  ''')
>          if not arg_type.is_implicit():
>              ret += mcgen('''
> -    visit_type_%(c_name)s(v, "%(name)s", &arg, &err);
> +    visit_type_%(c_name)s(v, "%(name)s", &arg, NULL);

&error_abort, please.  This should never fail, and when it does,
something's seriously wrong.

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
> +    visit_start_struct(v, "%(name)s", NULL, 0, NULL);
> +    visit_type_%(c_name)s_members(v, &param, NULL);
> +    visit_check_struct(v, NULL);

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
