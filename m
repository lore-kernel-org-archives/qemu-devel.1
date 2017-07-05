Received: from eggs.gnu.org ([2001:4830:134:3::10]:49478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dSoGT-0008E8-Am
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 13:39:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dSoGQ-0007oF-4Z
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 13:39:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46690)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dSoGP-0007nq-RY
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 13:38:58 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170621153424.16690-1-vsementsov@virtuozzo.com>
	<20170621153424.16690-3-vsementsov@virtuozzo.com>
	<695de534-7f65-c6cc-00ac-4d35e3eb6e7d@redhat.com>
Date: Wed, 05 Jul 2017 19:38:49 +0200
In-Reply-To: <695de534-7f65-c6cc-00ac-4d35e3eb6e7d@redhat.com> (Eric Blake's
	message of "Thu, 29 Jun 2017 14:27:13 -0500")
Message-ID: <87tw2qiy1i.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 2/6] nbd/server: use errp instead of LOG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, pbonzini@redhat.com, stefanha@redhat.com, den@openvz.org

Eric Blake <eblake@redhat.com> writes:

> On 06/21/2017 10:34 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Move to modern errp scheme from just LOGging errors.
>> 
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>  nbd/server.c | 268 +++++++++++++++++++++++++++++++++++------------------------
>>  1 file changed, 161 insertions(+), 107 deletions(-)
>
> Unfortunately longer, but I'm okay with that (and we already did it
> client-side, so this is just a case of a patch series being spread out
> over time).
>
>
>>  
>>  /* Send an error reply.
>>   * Return -errno on error, 0 on success. */
>> -static int GCC_FMT_ATTR(4, 5)
>> +static int GCC_FMT_ATTR(5, 6)
>>  nbd_negotiate_send_rep_err(QIOChannel *ioc, uint32_t type,
>> -                           uint32_t opt, const char *fmt, ...)
>> +                           uint32_t opt, Error **errp, const char *fmt, ...)
>>  {
>
> Markus, this violates our usual idiom of errp last in code that is not
> directly operating on an Error (the actual Error implementation in
> error.c being the main obvious exception that lists errp first), but I
> don't see any better approach. Do you have any thoughts on it?

The convention to put Error **errp last comes from GLib's GError.
Here's what it has to say about combining GError with variable
arguments:

    The last argument of a function that returns an error should be a
    location where a GError can be placed (i.e. "GError** error"). If
    GError is used with varargs, the GError** should be the last
    argument before the "...".

https://developer.gnome.org/glib/unstable/glib-Error-Reporting.html

Separating the format string from the variable arguments is ugly,
though.  I can't find examples of this ugliness in /usr/include/glib.  I
can find a few for Vladimir's solution:

* g_output_stream_printf() in gio/goutputstream.h: format string
  followed by arguments

* g_initable_new() in gio/ginitable.h: key name followed by key value,
  ..., NULL

* g_subprocess_new() in gio/gsubprocess.h: argv0, ..., NULL

* g_subprocess_launcher_spawn() in gio/gsubprocesslauncher.h: argv0,
  ..., NULL

* g_markup_collect_attributes() in gmarkup.h: attribute name followed by
  attribute value, ..., NULL

Let's follow this precedence.  In short, Vladimir's patch is okay as is.

[...]
