Received: from eggs.gnu.org ([209.51.188.92]:60953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <catherine.hecx@gmail.com>) id 1hBFe2-000281-4r
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 05:23:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <catherine.hecx@gmail.com>) id 1hBFNE-00042Q-7J
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 05:06:31 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:45047)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <catherine.hecx@gmail.com>)
	id 1hBFND-0003zF-RW
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 05:06:28 -0400
Received: by mail-ot1-x341.google.com with SMTP id d24so11282084otl.11
	for <qemu-devel@nongnu.org>; Tue, 02 Apr 2019 02:06:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAEn6zmEzwQD_Ot8sttJj0KwML3Zkhfg9+QBxbOLn6bUsDpVn7w@mail.gmail.com>
	<20190321061024.GB9149@xz-x1>
	<CAEn6zmGFv+UbhyriwakFKB=UhnC6=thhybDF9D1E9JzoYL-1oA@mail.gmail.com>
	<CAFEAcA8q0c5BFh-11KNRJWCi6+Yer_5peekmQptmaw8Ag3SNhw@mail.gmail.com>
	<20190322101211.GA2703@work-vm> <20190325033948.GG9149@xz-x1>
	<CAEn6zmF0DRqqUxjKpdxWYdb_ofGXV_wACfELA991qLfvo9N6vA@mail.gmail.com>
	<CAEn6zmEzcNJGQWrkbP2_v3aidj5o=S39pQgm8kPHqSn8Os=J+g@mail.gmail.com>
	<CAFEAcA_=7E9nrFLLmhXBwk5k10ufhKQKX+ZCttfWOxOYt=hZog@mail.gmail.com>
	<CAEn6zmGmNLp5dF-1ViQn_HFnim9+FuGSXAptrReouQCQbsa=KQ@mail.gmail.com>
	<20190402075801.GE11008@xz-x1>
In-Reply-To: <20190402075801.GE11008@xz-x1>
From: Catherine Ho <catherine.hecx@gmail.com>
Date: Tue, 2 Apr 2019 17:06:15 +0800
Message-ID: <CAEn6zmEjYh6uK3Y5cyenLKDKe+cCpjC5HOnNNoM6SniDAKPwzQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] migration: avoid copying ignore-shared
 ramblock when in incoming migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Yury Kotov <yury-kotov@yandex-team.ru>

On Tue, 2 Apr 2019 at 15:58, Peter Xu <peterx@redhat.com> wrote:

> On Tue, Apr 02, 2019 at 03:47:16PM +0800, Catherine Ho wrote:
> > Hi Peter Maydell
> >
> > On Tue, 2 Apr 2019 at 11:05, Peter Maydell <peter.maydell@linaro.org>
> wrote:
> >
> > > On Tue, 2 Apr 2019 at 09:57, Catherine Ho <catherine.hecx@gmail.com>
> > > wrote:
> > > > The root cause is the used idx is moved forward after 1st time
> incoming,
> > > and in 2nd time incoming,
> > > > the last_avail_idx will be incorrectly restored from the saved devi=
ce
> > > state file(not in the ram).
> > > >
> > > > I watched this even on x86 for a virtio-scsi disk
> > > >
> > > > Any ideas for supporting 2nd time, 3rd time... incoming restoring?
> > >
> > > Does the destination end go through reset between the 1st and 2nd
> > >
> > seems not, please see my step below
> >
> > > incoming attempts? I'm not a migration expert, but I thought that
> > > devices were allowed to assume that their state is "state of the
> > > device following QEMU reset" before the start of an incoming
> > > migration attempt.
> > >
> >
> > Here  is my step:
> > 1. start guest normal by qemu with shared memory-backend file
> > 2. stop the vm. save the device state to another file via monitor migra=
te
> > "exec: cat>..."
> > 3. quit the vm
> > 4. retore the vm by qemu -incoming "exec:cat ..."
> > 5. continue the vm via monito, the 1st incoming works fine
> > 6. quit the vm
> > 7. retore the vm by qemu -incoming "exec:cat ..." for 2nd time
> > 8. continue   -> error happened
> > Actually, this can be fixed by forcely restore the idx by
> > virtio_queue_restore_last_avail_idx(=EF=BC=89
> > But I am sure whether it is reasonable.
>
> Yeah I really suspect its validity.
>
> IMHO normal migration streams keep the device state and RAM data
> together in the dumped file, so they always match.
>
> In your shared case, the device states are in the dumped file however
> the RAM data is located somewhere else.  After you quit the VM from
> the 1st incoming migration the RAM is new (because that's a shared
> memory file) and the device data is still old.  They do not match
> already, then I'd say you can't migrate with that any more.
>
> If you want to do that, you'd better take snapshot of the RAM backend
> file if your filesystem supports (or even simpler, to back it up
> before hand) before you start any incoming migration.  Then with the
> dumped file (which contains the device states) and that snapshot file
> (which contains the exact RAM data that matches the device states)
> you'll alway be able to migrate for as many times as you want.
>

Understood, thanks Peter Xu
Is there any feasible way to indicate the snapshot of the RAM backend file
is
matched with the device data?
>VQ 2 size 0x400 < last_avail_idx 0x1639 - used_idx 0x2688
>Failed to load virtio-scsi:virtio

Because I thought reporting above error is not so friendly. Could we add a
version id in both RAM backend file and device date file?

B.R.
Catherine
>
>
> Regards,
>
> --
> Peter Xu
>
