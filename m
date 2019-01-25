Received: from eggs.gnu.org ([209.51.188.92]:53689)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gmvU6-0007Lk-SN
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 02:01:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gmvQm-00087n-6i
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 01:57:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34460)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gmvQm-00087N-0z
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 01:57:36 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BF7FDA429A
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 06:57:34 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20190121170434.13592-1-cfergeau@redhat.com>
	<87munqc9zf.fsf@dusky.pond.sub.org> <20190124183257.GF2101@work-vm>
Date: Fri, 25 Jan 2019 07:57:29 +0100
In-Reply-To: <20190124183257.GF2101@work-vm> (David Alan Gilbert's message of
	"Thu, 24 Jan 2019 18:32:58 +0000")
Message-ID: <87h8dxteau.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v5] log: Make glib logging go through QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, Christophe Fergeau <cfergeau@redhat.com>

"Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:

> * Markus Armbruster (armbru@redhat.com) wrote:
>> Christophe Fergeau <cfergeau@redhat.com> writes:
>> 
>> > This commit adds a qemu_init_logging() helper which calls
>> > g_log_set_default_handler() so that glib logs (g_log, g_warning, ...)
>> > are handled similarly to other QEMU logs. This means they will get a
>> > timestamp if timestamps are enabled, and they will go through the
>> > monitor if one is configured.
>> 
>> s/monitor/HMP monitor/
>> 
>> I see why one would like to extend the timestamp feature to GLib log
>> messages.  Routing them through the HMP monitor is perhaps debatable.
>> Cc: Dave in case he has an opinion.
>
> Yes, it's a little odd; what's wrong with stderr for this type of thing?
> My experience has been that things like spice errors are fairly
> asynchronous rather than directly triggered by commands, so maybe less
> suitable for interleaving in the monitor.

Fortunately, error_printf() & friends print to an HMP monitor only when
the current thread is running in HMP monitor context.

> While stderr and hmp output are normally the same, if someone has
> HMP wired to a script, I'd assume this is more likely to break it.

Programs consuming HMP output are brittle.  While we don't break them
just because we can, we do change HMP output without worrying about them
whenever we feel the change is an improvement for *human* readers.

Another possible concern is messages vanishing from stderr.
