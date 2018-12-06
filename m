Received: from eggs.gnu.org ([2001:4830:134:3::10]:42415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gUwYn-0007or-Jm
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 11:31:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gUwYg-0002e3-0N
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 11:31:33 -0500
References: <20181130220344.3350618-1-eblake@redhat.com>
	<20181130220344.3350618-9-eblake@redhat.com>
	<a523fabb-f532-1230-9d61-92d487bb551c@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <44ca18c7-02b1-7176-7ef6-0ae477b1bf96@redhat.com>
Date: Thu, 6 Dec 2018 10:31:06 -0600
MIME-Version: 1.0
In-Reply-To: <a523fabb-f532-1230-9d61-92d487bb551c@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 08/14] nbd/client: Refactor
 nbd_receive_list()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "jsnow@redhat.com" <jsnow@redhat.com>, "nsoffer@redhat.com" <nsoffer@redhat.com>, "rjones@redhat.com" <rjones@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>

On 12/6/18 8:18 AM, Vladimir Sementsov-Ogievskiy wrote:
> 01.12.2018 1:03, Eric Blake wrote:
>> Add some parameters to make this function reusable in upcoming
>> export listing, where we will want to capture the name and
>> description rather than compare against a user-supplied name.
>> No change in semantics to the existing caller.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---
>>    nbd/client.c | 66 +++++++++++++++++++++++++++++++++++++---------------
>>    1 file changed, 47 insertions(+), 19 deletions(-)

>> @@ -290,30 +298,49 @@ static int nbd_receive_list(QIOChannel *ioc, const char *want, bool *match,
>>            nbd_send_opt_abort(ioc);
>>            return -1;
>>        }
>> -    if (namelen != strlen(want)) {
>> -        if (nbd_drop(ioc, len, errp) < 0) {
>> -            error_prepend(errp,
>> -                          "failed to skip export name with wrong length: ");
>> -            nbd_send_opt_abort(ioc);
>> -            return -1;
>> +    if (want) {
>> +        if (namelen != strlen(want)) {
>> +            if (nbd_drop(ioc, len, errp) < 0) {
>> +                error_prepend(errp,
>> +                              "failed to skip export name with wrong length: ");
>> +                nbd_send_opt_abort(ioc);
>> +                return -1;
>> +            }
>> +            return 1;
>>            }
>> -        return 1;
>> +        assert(namelen < sizeof(array));
>> +    } else {
>> +        assert(nameout);
> 
> this assert looks a bit redundant, if nameout is 0, next line will abort not less clearly
> 
>> +        *nameout = name = g_new(char, namelen + 1);
> 
> We should check namelen <= NBD_MAX_NAME_SIZE before it, I think.

Why? We already validated that the overall option is not too large, and 
even if the resulting name from the server is larger than 
NBD_MAX_NAME_SIZE, it's still nice to report that name to the client for 
'qemu-nbd --list'.  And these days, we only call nbd_receive_list if a 
server lacked NBD_OPT_GO, which is getting rarer and rarer, so 
micro-optimizing a rare case to avoid a large malloc isn't going to make 
a noticeable difference.

> 
>>        }
>>
>> -    assert(namelen < sizeof(name));
>>        if (nbd_read(ioc, name, namelen, errp) < 0) {
>>            error_prepend(errp, "failed to read export name: ");
>>            nbd_send_opt_abort(ioc);
>> +        if (!want) {
>> +            free(name);
> 
> g_free
> 
>> +        }
>>            return -1;
>>        }
>>        name[namelen] = '\0';
>>        len -= namelen;
>> -    if (nbd_drop(ioc, len, errp) < 0) {
>> +    if (!want) {
>> +        assert(description);
> 
> NBD_MAX_NAME_SIZE

The description is not bound by NBD_MAX_NAME_SIZE.  The NBD protocol 
DOES document a maximum string size (4k), but we are (so far) not 
actually honoring that limit (our choice for NBD_MAX_NAME_SIZE is 256, 
which is smaller than the NBD protocol limit).

> 
>> +        *description = g_new(char, len + 1);
>> +        if (nbd_read(ioc, *description, len, errp) < 0) {
>> +            error_prepend(errp, "failed to read export description: ");
>> +            nbd_send_opt_abort(ioc);
>> +            free(name);
>> +            free(*description);
> 
> g_free
> 
>> +            return -1;
>> +        }
>> +        (*description)[len] = '\0';
>> +    } else if (nbd_drop(ioc, len, errp) < 0) {
>>            error_prepend(errp, "failed to read export description: ");
>>            nbd_send_opt_abort(ioc);
>>            return -1;
>>        }
>> -    if (!strcmp(name, want)) {
>> +    if (want && !strcmp(name, want)) {
>>            *match = true;
>>        }
>>        return 1;
> 
> one more thing: on fail path, you finally fill output name and description
> with freed pointers. I'd prefer to keep them unchanged in this case, however,
> it's a matter of taste.

Okay, I'll try and be more careful in v2 about not altering the callers 
pointers on failure.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
