Received: from eggs.gnu.org ([2001:4830:134:3::10]:40575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cr7Su-00027A-Rv
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 14:28:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cr7Sq-0004JK-QH
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 14:28:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49532)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cr7Sq-0004J0-I9
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 14:28:00 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6EF114E339
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 18:28:00 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <1490266548-22500-1-git-send-email-armbru@redhat.com>
	<1490266548-22500-4-git-send-email-armbru@redhat.com>
	<011d21ee-aa96-2541-2e54-16c423f07cce@redhat.com>
Date: Thu, 23 Mar 2017 19:27:57 +0100
In-Reply-To: <011d21ee-aa96-2541-2e54-16c423f07cce@redhat.com> (Eric Blake's
	message of "Thu, 23 Mar 2017 12:39:35 -0500")
Message-ID: <878tnv6e6q.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-2.9 3/5] rbd: Rewrite the code to
 extract list-valued options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, jdurgin@redhat.com, jcody@redhat.com, mreitz@redhat.com

Eric Blake <eblake@redhat.com> writes:

> On 03/23/2017 05:55 AM, Markus Armbruster wrote:
>> We have two list-values options:
>> 
>> * "server" is a list of InetSocketAddress.  We use members "host" and
>>   "port", and silently ignore the rest.
>> 
>> * "auth-supported" is a list of RbdAuthMethod.  We use its only member
>>   "auth".
>> 
>> Since qemu_rbd_open() takes options as a flattened QDict, options has
>> keys of the form server.%d.host, server.%d.port and
>> auth-supported.%d.auth, where %d counts up from zero.
>> 
>> qemu_rbd_array_opts() extracts these values as follows.  First, it
>> calls qdict_array_entries() to find the list's length.  For each list
>> element, it first formats the list's key prefix (e.g. "server.0."),
>> then creates a new QDict holding the options with that key prefix,
>> then converts that to a QemuOpts, so it can finally get the member
>> values from there.
>> 
>> If there's one surefire way to make code using QDict more awkward,
>> it's creating more of them and mixing in QemuOpts for good measure.
>
> No kidding!
>
>> 
>> The conversion to QemuOpts abuses runtime_opts, as described in the
>> commit before previous.
>> 
>> Rewrite to simply get the values straight from the options QDict.
>> This removes the abuse of runtime_opts, so clean it up.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  block/rbd.c | 151 +++++++++++++++++-------------------------------------------
>>  1 file changed, 42 insertions(+), 109 deletions(-)
>> 
>> diff --git a/block/rbd.c b/block/rbd.c
>> index 59c822a..8ba0f79 100644
>> --- a/block/rbd.c
>> +++ b/block/rbd.c
>> @@ -13,6 +13,7 @@
>>  
>>  #include "qemu/osdep.h"
>>  
>> +#include <rbd/librbd.h>
>>  #include "qapi/error.h"
>>  #include "qemu/error-report.h"
>>  #include "block/block_int.h"
>> @@ -20,8 +21,6 @@
>>  #include "qemu/cutils.h"
>>  #include "qapi/qmp/qstring.h"
>>  
>> -#include <rbd/librbd.h>
>> -
>
> Not mentioned in the commit message, but also a useful cleanup for
> hoisting <includes> prior to "includes".
>
>> +static char *rbd_auth(QDict *options)
>>  {
>> -    int num_entries;
>> -    QemuOpts *opts = NULL;
>> -    QDict *sub_options;
>> -    const char *host;
>> -    const char *port;
>> -    char *str;
>> -    char *rados_str = NULL;
>> -    Error *local_err = NULL;
>> +    const char **vals = g_new(const char *, qdict_size(options));
>> +    char keybuf[32];
>> +    QObject *val;
>> +    char *rados_str;
>>      int i;
>>  
>> -    assert(type == RBD_MON_HOST || type == RBD_AUTH_SUPPORTED);
>> -
>> -    num_entries = qdict_array_entries(options, prefix);
>> +    for (i = 0;; i++) {
>> +        sprintf(keybuf, "auth-supported.%d.auth", i);
>
> By my count, and including a trailing NUL, this is 21 bytes + the
> maximum size of a formatted int to fit in keybuf[32]; 32-bit INT_MIN is
> indeed 11 bytes.  Cutting it close there, but I don't see an overflow
> (if gcc 7's new -Wformat-truncation spots something, then gcc is too
> strict.)

11 decimal digits take a hell of a list :)

Could double the buffer if it makes anyone sleep better.

>> +static char *rbd_mon_host(QDict *options)
>> +{
>> +    const char **vals = g_new(const char *, qdict_size(options));
>> +    char keybuf[32];
>> +    QObject *val;
>> +    const char *host, *port;
>> +    char *rados_str;
>> +    int i;
>>  
>> -            value = host;
>> -            if (port) {
>> -                /* check for ipv6 */
>> -                if (strchr(host, ':')) {
>> -                    strbuf = g_strdup_printf("[%s]:%s", host, port);
>> -                } else {
>> -                    strbuf = g_strdup_printf("%s:%s", host, port);
>
> The old code only prints port information if it is present...
>
>> -                }
>> -                value = strbuf;
>> -            } else if (strchr(host, ':')) {
>> -                strbuf = g_strdup_printf("[%s]", host);
>> -                value = strbuf;
>> -            }
>> -        } else {
>> -            value = qemu_opt_get(opts, "auth");
>> +    for (i = 0;; i++) {
>> +        sprintf(keybuf, "server.%d.host", i);
>
> Here, you've got more breathing room.
>
>> +        val = qdict_get(options, keybuf);
>> +        if (!val) {
>> +            break;
>>          }
>> +        host = qstring_get_str(qobject_to_qstring(val));
>> +        sprintf(keybuf, "server.%d.port", i);
>> +        port = qdict_get_str(options, keybuf);
>>  
>> -
>> -        /* each iteration in the for loop will build upon the string, and if
>> -         * rados_str is NULL then it is our first pass */
>> -        if (rados_str) {
>> -            /* separate options with ';', as that  is what rados_conf_set()
>> -             * requires */
>> -            rados_str_tmp = rados_str;
>> -            rados_str = g_strdup_printf("%s;%s", rados_str_tmp, value);
>> -            g_free(rados_str_tmp);
>> +        if (strchr(host, ':')) {
>> +            vals[i] = g_strdup_printf("[%s]:%s", host, port);
>>          } else {
>> -            rados_str = g_strdup(value);
>> +            vals[i] = g_strdup_printf("%s:%s", host, port);
>
> ...but the new code unconditionally prints port information, even when
> port == NULL.  Oops.

How can port be null?  SocketAddress member port is mandatory...
