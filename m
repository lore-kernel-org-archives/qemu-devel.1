Received: from eggs.gnu.org ([209.51.188.92]:38230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <catherine.hecx@gmail.com>) id 1hBEJ1-00029k-Pa
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 03:58:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <catherine.hecx@gmail.com>) id 1hBE8m-0004Il-QM
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 03:47:29 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:40250)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <catherine.hecx@gmail.com>)
	id 1hBE8m-0004IU-Ga
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 03:47:28 -0400
Received: by mail-ot1-x342.google.com with SMTP id t8so11135650otp.7
	for <qemu-devel@nongnu.org>; Tue, 02 Apr 2019 00:47:28 -0700 (PDT)
MIME-Version: 1.0
References: <1553010562-13561-1-git-send-email-catherine.hecx@gmail.com>
	<20190320050735.GB8956@xz-x1>
	<CAEn6zmEzwQD_Ot8sttJj0KwML3Zkhfg9+QBxbOLn6bUsDpVn7w@mail.gmail.com>
	<20190321061024.GB9149@xz-x1>
	<CAEn6zmGFv+UbhyriwakFKB=UhnC6=thhybDF9D1E9JzoYL-1oA@mail.gmail.com>
	<CAFEAcA8q0c5BFh-11KNRJWCi6+Yer_5peekmQptmaw8Ag3SNhw@mail.gmail.com>
	<20190322101211.GA2703@work-vm> <20190325033948.GG9149@xz-x1>
	<CAEn6zmF0DRqqUxjKpdxWYdb_ofGXV_wACfELA991qLfvo9N6vA@mail.gmail.com>
	<CAEn6zmEzcNJGQWrkbP2_v3aidj5o=S39pQgm8kPHqSn8Os=J+g@mail.gmail.com>
	<CAFEAcA_=7E9nrFLLmhXBwk5k10ufhKQKX+ZCttfWOxOYt=hZog@mail.gmail.com>
In-Reply-To: <CAFEAcA_=7E9nrFLLmhXBwk5k10ufhKQKX+ZCttfWOxOYt=hZog@mail.gmail.com>
From: Catherine Ho <catherine.hecx@gmail.com>
Date: Tue, 2 Apr 2019 15:47:16 +0800
Message-ID: <CAEn6zmGmNLp5dF-1ViQn_HFnim9+FuGSXAptrReouQCQbsa=KQ@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Peter Xu <peterx@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Yury Kotov <yury-kotov@yandex-team.ru>

Hi Peter Maydell

On Tue, 2 Apr 2019 at 11:05, Peter Maydell <peter.maydell@linaro.org> wrote=
:

> On Tue, 2 Apr 2019 at 09:57, Catherine Ho <catherine.hecx@gmail.com>
> wrote:
> > The root cause is the used idx is moved forward after 1st time incoming=
,
> and in 2nd time incoming,
> > the last_avail_idx will be incorrectly restored from the saved device
> state file(not in the ram).
> >
> > I watched this even on x86 for a virtio-scsi disk
> >
> > Any ideas for supporting 2nd time, 3rd time... incoming restoring?
>
> Does the destination end go through reset between the 1st and 2nd
>
seems not, please see my step below

> incoming attempts? I'm not a migration expert, but I thought that
> devices were allowed to assume that their state is "state of the
> device following QEMU reset" before the start of an incoming
> migration attempt.
>

Here  is my step:
1. start guest normal by qemu with shared memory-backend file
2. stop the vm. save the device state to another file via monitor migrate
"exec: cat>..."
3. quit the vm
4. retore the vm by qemu -incoming "exec:cat ..."
5. continue the vm via monito, the 1st incoming works fine
6. quit the vm
7. retore the vm by qemu -incoming "exec:cat ..." for 2nd time
8. continue   -> error happened
Actually, this can be fixed by forcely restore the idx by
virtio_queue_restore_last_avail_idx(=EF=BC=89
But I am sure whether it is reasonable.

B.R.

>
> thanks
> -- PMM
>
