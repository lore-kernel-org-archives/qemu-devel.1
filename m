Received: from eggs.gnu.org ([2001:4830:134:3::10]:40936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ddZL6-0004DG-4i
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 05:56:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ddZL5-0007zi-5m
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 05:56:16 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:37249)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1ddZL4-0007xM-V5
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 05:56:15 -0400
Received: by mail-wm0-x242.google.com with SMTP id t138so5092794wmt.4
	for <qemu-devel@nongnu.org>; Fri, 04 Aug 2017 02:56:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1246900984.1258310.1501799811039.JavaMail.zimbra@redhat.com>
References: <20170713190116.21608-1-dgilbert@redhat.com>
	<20170802144229.GA5821@igalia.com> <20170803164516.GG3673@work-vm>
	<1246900984.1258310.1501799811039.JavaMail.zimbra@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Fri, 4 Aug 2017 10:56:11 +0100
Message-ID: <CAJSP0QXyNX69-8cmcPAgv=SSW0z-mtSMy43eOoz8FE2hYsTFtQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] vl.c/exit: pause cpus before closing block
 devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, John Snow <jsnow@redhat.com>, Alberto Garcia <berto@igalia.com>, qemu-devel <qemu-devel@nongnu.org>, Manos Pitsidianakis <el13635@mail.ntua.gr>, Kevin Wolf <kwolf@redhat.com>

On Thu, Aug 3, 2017 at 11:36 PM, Paolo Bonzini <pbonzini@redhat.com> wrote:
> ----- Original Message -----
>> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>> To: "Alberto Garcia" <berto@igalia.com>
>> Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, jsnow@redhat.com
>> Sent: Thursday, August 3, 2017 6:45:17 PM
>> Subject: Re: [Qemu-devel] [PATCH] vl.c/exit: pause cpus before closing block devices
>>
>> * Alberto Garcia (berto@igalia.com) wrote:
>> > On Thu, Jul 13, 2017 at 08:01:16PM +0100, Dr. David Alan Gilbert (git)
>> > wrote:
>> > > --- a/vl.c
>> > > +++ b/vl.c
>> > > @@ -4787,8 +4787,8 @@ int main(int argc, char **argv, char **envp)
>> > >      replay_disable_events();
>> > >      iothread_stop_all();
>> > >
>> > > -    bdrv_close_all();
>> > >      pause_all_vcpus();
>> > > +    bdrv_close_all();
>> > >      res_free();
>> >
>> > I haven't debugged it yet, but in my computer iotest 093 stops working
>> > (it never finishes) after this change.
>>
>> Yes, I can reproduce that here (I've got to explicitly run 093 - it
>> doesn't do it automatically for me):
>
> The culprit so to speak is this:
>
>         if (qtest_enabled()) {
>             /* For testing block IO throttling only */
>             tg->clock_type = QEMU_CLOCK_VIRTUAL;
>         }
>
> So after pause_all_vcpus(), the clock doesn't advance and bdrv_close_all
> hangs.  Should throttling be disabled by the time bdrv_close drains the
> BlockDriverState, and likewise for bdrv_close_all?

bdrv_drain_all() is called before blk_remove_all_bs(), so throttling
is still enabled while draining:

void bdrv_close_all(void)
{
    block_job_cancel_sync_all();
    nbd_export_close_all();

    /* Drop references from requests still in flight, such as canceled block
     * jobs whose AIO context has not been polled yet */
    bdrv_drain_all();

    blk_remove_all_bs();

Perhaps we need a bdrv_throttle_disable_all() function.  Manos is
moving throttling to a block driver so there is no longer a 1:1
relationship between BB and throttling - there might be multiple
throtting nodes in a BDS graph.

Stefan
