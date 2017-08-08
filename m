Received: from eggs.gnu.org ([2001:4830:134:3::10]:37184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1deyXd-0002bK-GV
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 03:03:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1deyXY-00088Y-Q4
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 03:03:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57466)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1deyXY-00087w-Jn
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 03:02:56 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8651980E6A
	for <qemu-devel@nongnu.org>; Tue,  8 Aug 2017 07:02:55 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170804175011.21944-1-dgilbert@redhat.com> (David Alan
	Gilbert's message of "Fri, 4 Aug 2017 18:50:11 +0100")
References: <20170804175011.21944-1-dgilbert@redhat.com>
Reply-To: quintela@redhat.com
Date: Tue, 08 Aug 2017 09:02:54 +0200
Message-ID: <874ltiee3l.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH f0r 2.11] runstate/migrate: Two more
 transitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, lvivier@redhat.com, pbonzini@redhat.com

"Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> There's a race if someone does a 'stop' near the end of migrate;
> the migration process goes through two runstates:
>     'finish migrate'
>     'postmigrate'
>
> If the user issues a 'stop' between the two we end up with invalid
> state transitions.
> Add the transitions as valid.
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

To answer Peter question:

int vm_stop(RunState state)
{
    .... we don't care about this case ....

    return do_vm_stop(state);
}

static int do_vm_stop(RunState state)
{
    int ret = 0;

    if (runstate_is_running()) {
        cpu_disable_ticks();
        pause_all_vcpus();
        runstate_set(state);
        vm_state_notify(0, state);
        qapi_event_send_stop(&error_abort);
    }

    bdrv_drain_all();
    replay_disable_events();
    ret = bdrv_flush_all();

    return ret;
}


int runstate_is_running(void)
{
    return runstate_check(RUN_STATE_RUNNING);
}


So, "stop" only changes states when we are in RUNNING state.
The idea was that after migration, the only valid command (as in the
film "it should do something")is "run".

Later, Juan.
