Received: from eggs.gnu.org ([2001:4830:134:3::10]:55521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1euqsE-0004T7-99
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 21:38:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1euqsB-0003Us-65
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 21:38:10 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59060 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1euqsB-0003Ug-0a
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 21:38:07 -0500
References: <20180309090006.10018-1-peterx@redhat.com>
	<20180309090006.10018-19-peterx@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b1059389-2b03-ee1f-0b56-93699aa67d35@redhat.com>
Date: Sat, 10 Mar 2018 20:37:42 -0600
MIME-Version: 1.0
In-Reply-To: <20180309090006.10018-19-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v8 18/23] qmp: support out-of-band (oob)
 execution
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On 03/09/2018 03:00 AM, Peter Xu wrote:
> Having "allow-oob" to true for a command does not mean that this command

s/to/:/

> will always be run in out-of-band mode.  The out-of-band quick path will
> only be executed if we specify the extra "run-oob" flag when sending the
> QMP request:
> 
>      { "execute":   "command-that-allows-oob",
>        "arguments": { ... },
>        "control":   { "run-oob": true } }
> 
> The "control" key is introduced to store this extra flag.  "control"
> field is used to store arguments that are shared by all the commands,
> rather than command specific arguments.  Let "run-oob" be the first.
> 
> Note that in the patch I exported qmp_dispatch_check_obj() to be used to
> check the request earlier, and at the same time allowed "id" field to be
> there since actually we always allow that.
> 
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   include/qapi/qmp/dispatch.h |  2 ++
>   monitor.c                   | 84 ++++++++++++++++++++++++++++++++++++++++-----
>   qapi/qmp-dispatch.c         | 33 +++++++++++++++++-
>   trace-events                |  2 ++
>   4 files changed, 111 insertions(+), 10 deletions(-)
> 

> +
> +    if (qmp_is_oob(req)) {
> +        if (!qmp_oob_enabled(mon)) {
> +            error_setg(errp, "Please enable Out-Of-Band first "
> +                       "for the session during capabilities negociation");

s/negociation/negotiation/

> +++ b/qapi/qmp-dispatch.c
> @@ -17,8 +17,9 @@

> +/*
> + * Detect whether a request should be run out-of-band, by quickly
> + * peeking at whether we have: { "control": { "run-oob": True } }. By

s/True/true/

> + * default commands are run in-band.
> + */
> +bool qmp_is_oob(QDict *dict)
> +{
> +    QBool *bool_obj;
> +
> +    dict = qdict_get_qdict(dict, "control");
> +    if (!dict) {
> +        return false;
> +    }
> +
> +    bool_obj = qobject_to_qbool(qdict_get(dict, "run-oob"));

Another qobject_to() rebase victim.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
