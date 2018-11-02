Received: from eggs.gnu.org ([2001:4830:134:3::10]:37776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gIUAQ-0007ky-6Y
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 03:46:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gITwc-0004Fg-0D
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 03:32:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51838)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1gITwb-0004FD-Ob
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 03:32:37 -0400
Date: Fri, 2 Nov 2018 15:32:26 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20181102073226.GG7804@xz-x1>
References: <20181101101715.9443-1-fli@suse.com>
	<20181101101715.9443-6-fli@suse.com> <20181102023738.GD7804@xz-x1>
	<39af00cd-fb54-de7d-154e-d9047156ab43@suse.com>
	<20181102033241.GF7804@xz-x1>
	<6d613886-1b35-53b4-86f8-443679e535be@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6d613886-1b35-53b4-86f8-443679e535be@suse.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC v7 5/9] migration: fix the multifd code
 when sending less channels
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fei Li <fli@suse.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, dgilbert@redhat.com, famz@redhat.com, quintela@redhat.com

On Fri, Nov 02, 2018 at 03:13:05PM +0800, Fei Li wrote:
>=20
>=20
> On 11/02/2018 11:32 AM, Peter Xu wrote:
> > On Fri, Nov 02, 2018 at 11:00:24AM +0800, Fei Li wrote:
> > >=20
> > > On 11/02/2018 10:37 AM, Peter Xu wrote:
> > > > On Thu, Nov 01, 2018 at 06:17:11PM +0800, Fei Li wrote:
> > > > > Set the migration state to "failed" instead of "setup" when fai=
ling
> > > > > to send packet via some channel.
> > > > Could you please provide more information in the commit message?
> > > > E.g., what will happen if without this patch?  Will it crash the
> > > > source or stall the source migration or others?  Otherwise it's a=
 bit
> > > > hard for me to understand what's this patch for.
> > > Sorry for the inadequate description , I was intended to say that w=
hen
> > > failing
> > > to do the live migration using multifd, e.g. sending less channels,=
 the src
> > > status displays "setup" when running `info migrate`. I assume we sh=
ould tell
> > > users that the "Migration status" is "failed" now (and along with t=
he
> > > failure reason).
> > >=20
> > > The current src status when failed inmultifd_new_send_channel_async=
()=EF=BC=9A
> > >=20
> > >=20
> > > (qemu) migrate_set_capability x-multifd on
> > > (qemu) migrate_set_parameter x-multifd-channels 4
> > > (qemu) migrate -d tcp:192.168.190.98:4444
> > > (qemu) qemu-system-x86_64: failed in multifd_new_send_channel_async=
 due to
> > > ...
> > > (qemu) info migrate
> > > globals:
> > > store-global-state: on
> > > only-migratable: off
> > > send-configuration: on
> > > send-section-footer: on
> > > decompress-error-check: on
> > > capabilities: xbzrle: off rdma-pin-all: off auto-converge: off zero=
-blocks:
> > > off compress: off events: off postcopy-ram: off x-colo: off release=
-ram: off
> > > block: off return-path: off pause-before-switchover: off x-multifd:=
 on
> > > dirty-bitmaps: off postcopy-blocktime: off late-block-activate: off
> > > Migration status: setup
> > > total time: 0 milliseconds
> > Thanks for the information.
> >=20
> > I had a quick look.  For now we do this:
> >=20
> >          multifd_save_setup (without waiting for channels to be ready=
)
> >          create thread migration_thread
> >                  (in thread)
> >                  ram_save_setup
> >                          multifd_send_sync_main (wait for the channel=
s)

[1]

> >=20
> > The thing is that we didn't get the notification when one of the
> > multifd channel is failed.  IMHO instead of setting the global
> > migration state in a per-channel function, we should just report the
> > error upwards, then the main thread should decide how to change the
> > state machine of the migration.
> Thanks for the detail explanation, do agree with reporting and letting
> the main thread handle this. :)
> But one thing to note is that during my previous debugging, I remember
> sometimes the main thread: migration_thread() is called earlier than
> the first channel is ready in multifd_new_send_channel_async(). Thus
> we should be careful about where/when to check the state of the channel=
.

Yeah, I guess that's exactly the stack I described at [1] above.

So my preference here would be that: in multifd_save_setup() we don't
continue until we know that the sockets are ready.  After all AFAIU
currently we'll depend on all the channels when migrate, so we can't
really do anything if without all the channels ready.  That'll
simplify the error handling of the case you've encountered during
SETUP.

> > And we have set it in migrate_set_error() after all so the main threa=
d
> > should be able to know somehow
> But in our current code, the main thread has not utilized the s->error
> to know whether the migration state, right? As I checked the code,
> the s->error is only used
> - in qmp query: copy s->error to info->error_desc when detecting the mi=
grate
> status is failed;
> - in migrate_fd_cleanup() when migrate_fd_connect() fails: print the er=
ror
> Or the s->error is just used in this way?

Hmm, _maybe_ we can introduce MultiFDSendParams.err then we can put
per-thread error there.

> >   (though IMHO I'll even prefer to have a
> > per-channel variable to keep the state of the channel, then the
> > per-channel functions won't touch any globals which offers better
> > isolation).
> >=20
> > I'm not sure how Juan thinks about it, but I'd prefer some work to
> > provide such isolation and also some mechanism to allow the main
> > thread to detect the per-channel errors not only during setup phase
> > but also during the migration (e.g., when network is suddenly down).
> > Then we don't touch any globals (e.g., we shouldn't call
> > migrate_get_current in any per-channel function like
> > multifd_new_send_channel_async).
> Ok, wait for Juan's comment. :)

Yes.

Regards,

--=20
Peter Xu
