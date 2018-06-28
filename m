Received: from eggs.gnu.org ([2001:4830:134:3::10]:53573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fYWqs-0001Vg-Hj
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 09:20:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fYWqp-0005Mi-BZ
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 09:20:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46202 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fYWqp-0005Ld-5O
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 09:20:43 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AD292CB9F9
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 13:20:42 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180620073223.31964-1-peterx@redhat.com>
	<871sctea4y.fsf@dusky.pond.sub.org>
	<87tvpoadcc.fsf_-_@dusky.pond.sub.org>
	<87wouk8vul.fsf@dusky.pond.sub.org>
	<87h8lo74oa.fsf@dusky.pond.sub.org> <20180627133442.GB2455@xz-mi>
Date: Thu, 28 Jun 2018 15:20:41 +0200
In-Reply-To: <20180627133442.GB2455@xz-mi> (Peter Xu's message of "Wed, 27 Jun
	2018 21:34:42 +0800")
Message-ID: <87woujgi8m.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] monitor: enable OOB by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>

Peter Xu <peterx@redhat.com> writes:

> On Wed, Jun 27, 2018 at 03:13:57PM +0200, Markus Armbruster wrote:
>> Monitor behavior changes even when the client rejects capability "oob".
>> 
>> Traditionally, the monitor reads, executes and responds to one command
>> after the other.  If the client sends in-band commands faster than the
>> server can execute them, the kernel will eventually refuse to buffer
>> more, and sending blocks or fails with EAGAIN.
>> 
>> To make OOB possible, we need to read and queue commands as we receive
>> them.  If the client sends in-band commands faster than the server can
>> execute them, the server will eventually drop commands to limit the
>> queue length.  The sever sends event COMMAND_DROPPED then.
>> 
>> However, we get the new behavior even when the client rejects capability
>> "oob".  We get the traditional behavior only when the server doesn't
>> offer "oob".
>> 
>> Is this what we want?
>
> Not really.  But I thought we kept that old behavior, haven't we?
>
> In handle_qmp_command() we have this:
>
>     /*
>      * If OOB is not enabled on the current monitor, we'll emulate the
>      * old behavior that we won't process the current monitor any more
>      * until it has responded.  This helps make sure that as long as
>      * OOB is not enabled, the server will never drop any command.
>      */
>     if (!qmp_oob_enabled(mon)) {
>         monitor_suspend(mon);
>         req_obj->need_resume = true;
>     } else {
>         /* Drop the request if queue is full. */
>         if (mon->qmp.qmp_requests->length >= QMP_REQ_QUEUE_LEN_MAX) {
>             qemu_mutex_unlock(&mon->qmp.qmp_queue_lock);
>             qapi_event_send_command_dropped(id,
>                                             COMMAND_DROP_REASON_QUEUE_FULL,
>                                             &error_abort);
>             qmp_request_free(req_obj);
>             return;
>         }
>     }
>
> Here assuming that we are not enabling OOB, then since we will suspend
> the monitor when we receive one command, then monitor_can_read() later
> will check with a result that "we should not read the chardev", then
> it'll leave all the data in the input buffer.  Then AFAIU the QMP
> client that didn't enable OOB will have similar behavior as before.
>
> Also, we will never receive a COMMAND_DROPPED event in that legacy
> mode as well since it's in the "else" block.   Am I right?

Hmm.  Did I get confused?  Let me look again.

Some places check qmp_oob_enabled(), which is true when the server
offered capability "oob" and the client accepted.  In terms of my reply
to Daniel, it distinguishes the two run time cases "OOB off" and "OOB
on".

Other places check ->use_io_thr, which is true when

    (flags & MONITOR_USE_CONTROL) && !CHARDEV_IS_MUX(chr)

in monitor_init().

One of these places is get_qmp_greeting().  It makes the server offer
"oob" when ->use_io_thr.  Makes sense.

In terms of my reply to Daniel, ->use_io_thr distinguishes between "OOB
not offered" and ("OOB offered, but rejected by client" or "OOB offered
and accepted").

Uses could to violate 'may use "server offered OOB" only for
configuration purposes', so let's check them:

* monitor_json_emitter()

  If mon->use_io_thr, push to response queue.  Else emit directly.

  I'm afraid run time behavior differs for "OOB not offered" (emit
  directly) and "OOB offered by rejected" (queue).

* qmp_caps_check()

  If !mon->use_io_thr, reject client's acceptance of "oob".  Implicitly
  recomputing the set of offered capabilities here is less than elegant,
  but it's not wrong.

* monitor_resume()

  If mon->use_io_thr(), kick the monitor I/O thread.

  Again, different behavior for the two variations of "OOB off".

* get_qmp_greeting()

  Covered above, looks good to me.

* monitor_qmp_setup_handlers_bh()

  If mon->use_io_thr(), pass the monitor I/O thread's AIOContext to
  qemu_chr_fe_set_handlers(), else pass NULL.

  Again, different behavior for the two variations of "OOB off".

* monitor_init()

  If mon->use_io_thr, set up bottom half
  monitor_qmp_setup_handlers_bh(), else call qemu_chr_fe_set_handlers()
  directly.

  Again, different behavior for the two variations of "OOB off".

Either I am confused now, or the two variations of "OOB off" execute
different code at run time.  Which is it?

If it's different code, are the differences observable for the client?

Observable or not, I suspect the differences should not exist.
