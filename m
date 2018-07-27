Received: from eggs.gnu.org ([2001:4830:134:3::10]:53738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fj5Ar-0000vQ-Ej
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 12:01:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fj5Aq-0000zM-FW
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 12:01:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60698 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fj5Aq-0000z0-8z
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 12:01:00 -0400
References: <20180727151359.29061-1-armbru@redhat.com>
	<20180727151359.29061-16-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <fb83fdef-2a97-4c9f-893d-61df0fa21d90@redhat.com>
Date: Fri, 27 Jul 2018 11:00:57 -0500
MIME-Version: 1.0
In-Reply-To: <20180727151359.29061-16-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 15/23] tests: New helper
 qtest_qmp_receive_success()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, f4bug@amsat.org, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>

On 07/27/2018 10:13 AM, Markus Armbruster wrote:
> Commit b21373d0713 copied wait_command() from tests/migration-test.c
> to tests/tpm-util.c.  Replace both copies by new libqtest helper
> qtest_qmp_receive_success().  Also use it to simplify
> qtest_qmp_device_del().
> 
> Bonus: gets rid of a non-literal format string.  A step towards
> compile-time format string checking without triggering
> -Wformat-nonliteral.

Where? [1]

> 
> Cc: Thomas Huth <thuth@redhat.com>
> Cc: Juan Quintela <quintela@redhat.com>
> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> ---

> +++ b/tests/libqtest.c
> @@ -1029,6 +1029,35 @@ void qtest_cb_for_every_machine(void (*cb)(const char *machine))
>       qobject_unref(response);
>   }
>   
> +QDict *qtest_qmp_receive_success(QTestState *s,
> +                                 void (*event_cb)(void *opaque,
> +                                                  const char *event,
> +                                                  QDict *data),
> +                                 void *opaque)
> +{

I like the new signature!

> +++ b/tests/migration-test.c

>   /*
>    * Events can get in the way of responses we are actually waiting for.
>    */
>   static QDict *wait_command(QTestState *who, const char *command)
>   {

[1] This is still taking a format non-literal command...

> -    const char *event_string;
> -    QDict *response, *ret;
> -
> -    response = qtest_qmp(who, command);
...
> +    qtest_qmp_send(who, command);

and is passing it on through.

> +    return qtest_qmp_receive_success(who, stop_cb, NULL);
>   }
>   

> +++ b/tests/tpm-util.c

> -/*
> - * Events can get in the way of responses we are actually waiting for.
> - */
> -static QDict *tpm_util_wait_command(QTestState *who, const char *command)
> -{

Maybe you were counting this instance,

>   void tpm_util_wait_for_migration_complete(QTestState *who)
>   {
>       while (true) {
> -        QDict *rsp, *rsp_return;
> +        QDict *rsp_return;
>           bool completed;
>           const char *status;
>   
> -        rsp = tpm_util_wait_command(who, "{ 'execute': 'query-migrate' }");
> -        rsp_return = qdict_get_qdict(rsp, "return");
> +        qtest_qmp_send(who, "{ 'execute': 'query-migrate' }");

where you did indeed drop a format non-literal?

But on the assumption that there's more cleanups later in the series, 
this is indeed incrementally better, so

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
