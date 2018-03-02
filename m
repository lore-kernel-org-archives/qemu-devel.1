Received: from eggs.gnu.org ([2001:4830:134:3::10]:45384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eriep-0002RI-V5
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:15:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eriel-0000dX-Lj
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:15:23 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46810 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eriel-0000dM-GI
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:15:19 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2E82E4040858
	for <qemu-devel@nongnu.org>; Fri,  2 Mar 2018 11:15:19 +0000 (UTC)
References: <20180301084438.13594-1-peterx@redhat.com>
	<20180301084438.13594-4-peterx@redhat.com>
	<2c8bac11-9f90-f79b-7b08-77f94a196c3a@redhat.com>
	<20180302035418.GV27381@xz-mi>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <773346dc-0f78-6cbc-0b07-5ece999cef29@redhat.com>
Date: Fri, 2 Mar 2018 12:15:09 +0100
MIME-Version: 1.0
In-Reply-To: <20180302035418.GV27381@xz-mi>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 03/15] qio: introduce
 qio_channel_add_watch_{full|source}
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, "Daniel P . Berrange" <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On 02/03/2018 04:54, Peter Xu wrote:
> On Thu, Mar 01, 2018 at 06:13:06PM +0100, Paolo Bonzini wrote:
>> On 01/03/2018 09:44, Peter Xu wrote:
>>> + * qio_channel_add_watch_source:
>>> + * @ioc: the channel object
>>> + * @condition: the I/O condition to monitor
>>> + * @func: callback to invoke when the source becomes ready
>>> + * @user_data: opaque data to pass to @func
>>> + * @notify: callback to free @user_data
>>> + * @context: gcontext to bind the source to
>>> + *
>>> + * Similar as qio_channel_add_watch(), but allows to specify context
>>> + * to run the watch source, meanwhile return the GSource object
>>> + * instead of tag ID, with the GSource referenced already.
>>> + *
>>> + * Note: callers is responsible to unref the source when not needed.
>>> + *
>>> + * Returns: the source pointer
>>> + */
>>> +GSource *qio_channel_add_watch_source(QIOChannel *ioc,
>>> +                                      GIOCondition condition,
>>> +                                      QIOChannelFunc func,
>>> +                                      gpointer user_data,
>>> +                                      GDestroyNotify notify,
>>> +                                      GMainContext *context);
>>>  
>>
>> Just a small thing, this is a bit inconsistent with the rest of the
>> GSource API, where the g_source_attach is usually left to the caller
>> when a function returns GSource *.
>>
>> You might therefore name it instead qio_channel_create_watch, for
>> consistency with g_io_{add,create}_watch, and remove the "context" argument.
> 
> Looks like there is already a qio_channel_create_watch() (io/channel.c).
> 
> How about qio_channel_create_watch_attached()?  Or... anything better?

I would add the g_source_set_callback call (and arguments) to
qio_channel_create_watch and leave the g_source_attach to the caller.

Paolo
