Received: from eggs.gnu.org ([2001:4830:134:3::10]:38986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imhy.yang@gmail.com>) id 1cjnhp-0004Ik-V6
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 08:57:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imhy.yang@gmail.com>) id 1cjnho-0000IJ-Ut
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 08:57:14 -0500
Received: from mail-it0-x244.google.com ([2607:f8b0:4001:c0b::244]:35646)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <imhy.yang@gmail.com>) id 1cjnho-0000Fy-OT
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 08:57:12 -0500
Received: by mail-it0-x244.google.com with SMTP id 203so2359722ith.2
	for <qemu-devel@nongnu.org>; Fri, 03 Mar 2017 05:57:11 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170303132653.GD2439@work-vm>
References: <33183CC9F5247A488A2544077AF19020DA1D01C2@DGGEMA505-MBX.china.huawei.com>
	<20170303120054.GB2439@work-vm>
	<10d66d73-a269-acb4-bc3d-2250793cba8e@redhat.com>
	<20170303131150.GC2439@work-vm>
	<bcaabb9b-44a6-ee7d-14b9-eade207e1538@redhat.com>
	<20170303132653.GD2439@work-vm>
From: Yang Hongyang <imhy.yang@gmail.com>
Date: Fri, 3 Mar 2017 21:57:10 +0800
Message-ID: <CAN+wFu+0XpGH-mbgW7BQ-S6cjvKnZsD_Ay94SV3qiMBc9dYX4A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [Bug?] BQL about live migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, yanghongyang <yanghongyang@huawei.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>, Huangzhichao <huangzhichao@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "quintela@redhat.com" <quintela@redhat.com>

Hi Dave,

On Fri, Mar 3, 2017 at 9:26 PM, Dr. David Alan Gilbert <dgilbert@redhat.com>
wrote:

> * Paolo Bonzini (pbonzini@redhat.com) wrote:
> >
> >
> > On 03/03/2017 14:11, Dr. David Alan Gilbert wrote:
> > > * Paolo Bonzini (pbonzini@redhat.com) wrote:
> > >>
> > >>
> > >> On 03/03/2017 13:00, Dr. David Alan Gilbert wrote:
> ...
> > > That event feature went in sometime after 2.3.0.
> > >
> > >> One possibility is to suspend the monitor in qmp_migrate_cancel and
> > >> resume it (with add_migration_state_change_notifier) when we hit the
> > >> CANCELLED state.  I'm not sure what the latency would be between the
> end
> > >> of migrate_fd_cancel and finally reaching CANCELLED.
> > >
> > > I don't like suspending monitors; it can potentially take quite a
> significant
> > > time to do a cancel.
> > > How about making 'cont' fail if we're in CANCELLING?
> >
> > Actually I thought that would be the case already (in fact CANCELLING is
> > internal only; the outside world sees it as "active" in query-migrate).
> >
> > Lei, what is the runstate?  (That is, why did cont succeed at all)?
>
> I suspect it's RUN_STATE_FINISH_MIGRATE - we set that before we do the
> device
>

It is RUN_STATE_FINISH_MIGRATE.


> save, and that's what we get at the end of a migrate and it's legal to
> restart
> from there.
>
> > Paolo
> >
> > > I'd really love to see the 'run_on_cpu' being more careful about the
> BQL;
> > > we really need all of the rest of the devices to stay quiesced at
> times.
> >
> > That's not really possible, because of how condition variables work. :(
>
> *Really* we need to find a solution to that - there's probably lots of
> other things that can spring up in that small window other than the
> 'cont'.
>

This is what I was worry about. Not only sync_cpu_state() will call
run_on_cpu()
but also vm_stop_force_state() will, both of them did hit the small windows
in our
test.


>
> Dave
>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>
>
