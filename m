Received: from eggs.gnu.org ([2001:4830:134:3::10]:55509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fpZKq-0007pw-1Z
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 09:26:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fpZKm-00016l-IS
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 09:26:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39652 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fpZKm-00016U-BK
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 09:26:04 -0400
References: <20180808120334.10970-1-armbru@redhat.com>
	<20180808120334.10970-44-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f8adc9b0-15f8-50ea-ab60-2e7a2cc1440e@redhat.com>
Date: Tue, 14 Aug 2018 08:26:00 -0500
MIME-Version: 1.0
In-Reply-To: <20180808120334.10970-44-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 43/56] qjson: Fix qobject_from_json() &
 friends for multiple values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

On 08/08/2018 07:03 AM, Markus Armbruster wrote:
> qobject_from_json() & friends use the consume_json() callback to
> receive either a value or an error from the parser.
> 
> When they are fed a string that contains more than either one JSON
> value or one JSON syntax error, consume_json() gets called multiple
> times.
> 
> When the last call receives a value, qobject_from_json() returns that
> value.  Any other values are leaked.
> 
> When any call receives an error, qobject_from_json() sets the first
> error received.  Any other errors are thrown away.
> 
> When values follow errors, qobject_from_json() returns both a value
> and sets an error.  That's bad.  Impact:
> 
> * block.c's parse_json_protocol() ignores and leaks the value.  It's
>    used to to parse pseudo-filenames starting with "json:".  The
>    pseudo-filenames can come from the user or from image meta-data such
>    as a QCOW2 image's backing file name.

Fortunately, I don't think this falls in the category of a 
denial-of-service attack worthy of a CVE (memory leaks in long-running 
processes are bad, but to be an escalation attack, you'd have to 
convince someone with more rights to repeatedly reload your malicious 
image to cause them to suffer from the leak - but why would they load 
your image more than once? You can reload it yourself, but then you are 
only killing your own qemu so there is no escalation of privilege).


> 
> * vl.c's parse_display_qapi() ignores and leaks the error.  It's used
>    to parse the argument of command line option -display.
> 
> * vl.c's main() case QEMU_OPTION_blockdev ignores the error and leaves
>    it in @err.  main() will then pass a pointer to a non-null Error *
>    to net_init_clients(), which is forbidden.  It can lead to assertion
>    failure or other misbehavior.
> 
> * check-qjson.c's multiple_values() demonstrates the badness.
> 
> * The other callers are not affected since they only pass strings with
>    exactly one JSON value or, in the case of negative tests, one
>    error.
> 
> The impact on the _nofail() functions is relatively harmless.  They
> abort when any call receives an error.  Else they return the last
> value, and leak the others, if any.
> 
> Fix consume_json() as follows.  On the first call, save value and
> error as before.  On subsequent calls, if any, don't save them.  If
> the first call saved a value, the next call, if any, replaces the
> value by an "Expecting at most one JSON value" error.  Take care not
> to leak values or errors that aren't saved.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   qobject/qjson.c     | 15 ++++++++++++++-
>   tests/check-qjson.c | 10 +++-------
>   2 files changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/qobject/qjson.c b/qobject/qjson.c
> index 7395556069..7f69036487 100644
> --- a/qobject/qjson.c
> +++ b/qobject/qjson.c
> @@ -33,8 +33,21 @@ static void consume_json(void *opaque, QObject *json, Error *err)
>   {
>       JSONParsingState *s = opaque;
>   
> +    assert(!json != !err);
> +    assert(!s->result || !s->err);
> +
> +    if (s->result) {

Reached whether the second item encountered was also an object (json != 
NULL) or an error (err != NULL), but seems reasonable.

> +        qobject_unref(s->result);
> +        s->result = NULL;
> +        error_setg(&s->err, "Expecting at most one JSON value");
> +    }
> +    if (s->err) {
> +        qobject_unref(json);
> +        error_free(err);
> +        return;
> +    }

Worth spelling this clause as error_propagate(&s->err, err)?  Oh, I see 
why you can't - you have to do the early return in the case that (json 
!= NULL) so that you don't assign s->result again if this was a parse of 
a second object.

>       s->result = json;
> -    error_propagate(&s->err, err);
> +    s->err = err;
>   }
>   

Took me a couple of reads to verify the logic makes sense, but it looks 
right.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
