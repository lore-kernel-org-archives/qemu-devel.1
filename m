Received: from eggs.gnu.org ([2001:4830:134:3::10]:54130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1euqi6-0001M7-8Z
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 21:27:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1euqi3-0007xz-4i
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 21:27:42 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60584 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1euqi2-0007xC-VK
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 21:27:39 -0500
References: <20180309090006.10018-1-peterx@redhat.com>
	<20180309090006.10018-18-peterx@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <97cdc93e-1962-3279-13e7-7faac27862f2@redhat.com>
Date: Sat, 10 Mar 2018 20:27:22 -0600
MIME-Version: 1.0
In-Reply-To: <20180309090006.10018-18-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v8 17/23] qapi: introduce new cmd option
 "allow-oob"
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
> Here "oob" stands for "Out-Of-Band".  When "allow-oob" is set, it means
> the command allows out-of-band execution.
> 
> The "oob" idea is proposed by Markus Armbruster in following thread:
> 
>    https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg02057.html
> 
> This new "allow-oob" boolean will be exposed by "query-qmp-schema" as
> well for command entries, so that QMP clients can know which command can

s/command can/commands/can/

> be used as out-of-band calls. For example the command "migrate"
> originally looks like:
> 
>    {"name": "migrate", "ret-type": "17", "meta-type": "command",
>     "arg-type": "86"}
> 
> And it'll be changed into:
> 
>    {"name": "migrate", "ret-type": "17", "allow-oob": false,
>     "meta-type": "command", "arg-type": "86"}
> 
> This patch only provides the QMP interface level changes.  It does not
> contains the real out-of-band execution implementation yet.

s/contains/contain/

> 
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: Fam Zheng <famz@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/qapi/qmp/dispatch.h    |  5 +++--
>  qapi/introspect.json           |  6 +++++-
>  scripts/qapi/commands.py       | 18 +++++++++++++-----
>  scripts/qapi/common.py         | 15 ++++++++++-----
>  scripts/qapi/doc.py            |  2 +-
>  scripts/qapi/introspect.py     | 10 ++++++++--
>  tests/qapi-schema/test-qapi.py |  2 +-
>  7 files changed, 41 insertions(+), 17 deletions(-)

I'm a bit disappointed that tests/qapi-schema/qapi-schema-test.json 
doesn't have any "allow-oob":true commands at any point in the series. 
I consider that to be a bug, so it can be fixed by followup patch even 
after soft freeze; but won't make the lack of good testing hold up this 
series from making the release.

> +++ b/scripts/qapi/introspect.py
> @@ -29,6 +29,11 @@ def to_json(obj, level=0):
>                                 to_json(obj[key], level + 1))
>                   for key in sorted(obj.keys())]
>           ret = '{' + ', '.join(elts) + '}'
> +    elif isinstance(obj, bool):
> +        if obj:
> +            ret = 'true'
> +        else:
> +            ret = 'false'

Conflicts with Marc-Andre's work to perform introspection by QLIT_*; but 
it's easy enough to adjust:

+    elif isinstance(obj, bool):
+        ret += 'QLIT_QBOOL(%s)' % ('true' if obj else 'false')

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
