Received: from eggs.gnu.org ([209.51.188.92]:33294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <catherine.hecx@gmail.com>) id 1hBKU2-0007Jf-CT
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 10:33:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <catherine.hecx@gmail.com>) id 1hBKTz-0003KV-5r
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 10:33:50 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:34270)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <catherine.hecx@gmail.com>)
	id 1hBKTv-0003IN-SG
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 10:33:44 -0400
Received: by mail-ot1-x341.google.com with SMTP id k21so12307727otf.1
	for <qemu-devel@nongnu.org>; Tue, 02 Apr 2019 07:33:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAEn6zmGFv+UbhyriwakFKB=UhnC6=thhybDF9D1E9JzoYL-1oA@mail.gmail.com>
	<CAFEAcA8q0c5BFh-11KNRJWCi6+Yer_5peekmQptmaw8Ag3SNhw@mail.gmail.com>
	<20190322101211.GA2703@work-vm> <20190325033948.GG9149@xz-x1>
	<CAEn6zmF0DRqqUxjKpdxWYdb_ofGXV_wACfELA991qLfvo9N6vA@mail.gmail.com>
	<CAEn6zmEzcNJGQWrkbP2_v3aidj5o=S39pQgm8kPHqSn8Os=J+g@mail.gmail.com>
	<CAFEAcA_=7E9nrFLLmhXBwk5k10ufhKQKX+ZCttfWOxOYt=hZog@mail.gmail.com>
	<CAEn6zmGmNLp5dF-1ViQn_HFnim9+FuGSXAptrReouQCQbsa=KQ@mail.gmail.com>
	<20190402075801.GE11008@xz-x1>
	<CAEn6zmEjYh6uK3Y5cyenLKDKe+cCpjC5HOnNNoM6SniDAKPwzQ@mail.gmail.com>
	<20190402123659.GG11008@xz-x1>
	<CAEn6zmG6GMgYkDNwYFtBPx0XYWNoixDAgiasso+BL_Vyrs74yQ@mail.gmail.com>
In-Reply-To: <CAEn6zmG6GMgYkDNwYFtBPx0XYWNoixDAgiasso+BL_Vyrs74yQ@mail.gmail.com>
From: Catherine Ho <catherine.hecx@gmail.com>
Date: Tue, 2 Apr 2019 22:33:30 +0800
Message-ID: <CAEn6zmG1o-VRM6ttBaFT1zwDEwDYWt3FpoUY4TsDaWmwmC+ivg@mail.gmail.com>
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
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Tue, 2 Apr 2019 at 22:17, Catherine Ho <catherine.hecx@gmail.com> wrote:

>
>
> On Tue, 2 Apr 2019 at 20:37, Peter Xu <peterx@redhat.com> wrote:
>
>> On Tue, Apr 02, 2019 at 05:06:15PM +0800, Catherine Ho wrote:
>> > On Tue, 2 Apr 2019 at 15:58, Peter Xu <peterx@redhat.com> wrote:
>> >
>> > > On Tue, Apr 02, 2019 at 03:47:16PM +0800, Catherine Ho wrote:
>> > > > Hi Peter Maydell
>> > > >
>> > > > On Tue, 2 Apr 2019 at 11:05, Peter Maydell <
>> peter.maydell@linaro.org>
>> > > wrote:
>> > > >
>> > > > > On Tue, 2 Apr 2019 at 09:57, Catherine Ho <
>> catherine.hecx@gmail.com>
>> > > > > wrote:
>> > > > > > The root cause is the used idx is moved forward after 1st time
>> > > incoming,
>> > > > > and in 2nd time incoming,
>> > > > > > the last_avail_idx will be incorrectly restored from the saved
>> device
>> > > > > state file(not in the ram).
>> > > > > >
>> > > > > > I watched this even on x86 for a virtio-scsi disk
>> > > > > >
>> > > > > > Any ideas for supporting 2nd time, 3rd time... incoming
>> restoring?
>> > > > >
>> > > > > Does the destination end go through reset between the 1st and 2n=
d
>> > > > >
>> > > > seems not, please see my step below
>> > > >
>> > > > > incoming attempts? I'm not a migration expert, but I thought tha=
t
>> > > > > devices were allowed to assume that their state is "state of the
>> > > > > device following QEMU reset" before the start of an incoming
>> > > > > migration attempt.
>> > > > >
>> > > >
>> > > > Here  is my step:
>> > > > 1. start guest normal by qemu with shared memory-backend file
>> > > > 2. stop the vm. save the device state to another file via monitor
>> migrate
>> > > > "exec: cat>..."
>> > > > 3. quit the vm
>> > > > 4. retore the vm by qemu -incoming "exec:cat ..."
>> > > > 5. continue the vm via monito, the 1st incoming works fine
>> > > > 6. quit the vm
>> > > > 7. retore the vm by qemu -incoming "exec:cat ..." for 2nd time
>> > > > 8. continue   -> error happened
>> > > > Actually, this can be fixed by forcely restore the idx by
>> > > > virtio_queue_restore_last_avail_idx(=EF=BC=89
>> > > > But I am sure whether it is reasonable.
>> > >
>> > > Yeah I really suspect its validity.
>> > >
>> > > IMHO normal migration streams keep the device state and RAM data
>> > > together in the dumped file, so they always match.
>> > >
>> > > In your shared case, the device states are in the dumped file howeve=
r
>> > > the RAM data is located somewhere else.  After you quit the VM from
>> > > the 1st incoming migration the RAM is new (because that's a shared
>> > > memory file) and the device data is still old.  They do not match
>> > > already, then I'd say you can't migrate with that any more.
>> > >
>> > > If you want to do that, you'd better take snapshot of the RAM backen=
d
>> > > file if your filesystem supports (or even simpler, to back it up
>> > > before hand) before you start any incoming migration.  Then with the
>> > > dumped file (which contains the device states) and that snapshot fil=
e
>> > > (which contains the exact RAM data that matches the device states)
>> > > you'll alway be able to migrate for as many times as you want.
>> > >
>> >
>> > Understood, thanks Peter Xu
>> > Is there any feasible way to indicate the snapshot of the RAM backend
>> file
>> > is
>> > matched with the device data?
>> > >VQ 2 size 0x400 < last_avail_idx 0x1639 - used_idx 0x2688
>> > >Failed to load virtio-scsi:virtio
>> >
>> > Because I thought reporting above error is not so friendly. Could we
>> add a
>> > version id in both RAM backend file and device date file?
>>
>> It would be non-trivial I'd say - AFAIK we don't have an existing way
>> to tag the memory-backend-file content (IIUC that's what you use).
>>
>> And since you mentioned about versioning of these states, I just
>> remembered that even with this you may not be able to get a complete
>> matched state of the VM, because AFAICT actually besides RAM state &
>> device state, you probably also need to consider the disk state as
>> well.  After you started the VM of the 1st incoming, there could be
>> data flushed to the VM backend disk and then that state is changed as
>> well.  So here even if you snapshot the RAM file you'll still lose the
>> disk state IIUC so it could still be broken.  In other words, to make
>> a migration/snapshot to work you'll need to make all these three
>> states to match.
>>
>
> Yes, thanks
>
>>
>> Before we discuss further on the topic... could you share me with your
>> requirement first?  I started to get a bit confused now since when I
>> thought about shared mem I was thinking about migrating within the
>> same host to e.g. upgrade the hypervisor but that obviously does not
>> need you to do incoming migration for multiple times.  Then what do
>> you finally want to achieve?
>>
> Actually, I am investigating the ignore-shared capability case support on
> arm64. This feature is used in Kata containers project as "vm template"
>  The rom reset failure is the first bug.
> Ok, now I can confirm that doing incoming migration for multiple times is
>
s/is /isn't, sorry ~

> supported. Thanks for the detailed explanation :)
>
B.R.
> Catherine
>
