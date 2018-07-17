Received: from eggs.gnu.org ([2001:4830:134:3::10]:44775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1ffROQ-0006eC-2g
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 10:55:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1ffROO-00081e-Vn
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 10:55:58 -0400
Received: from mail-it0-x244.google.com ([2607:f8b0:4001:c0b::244]:50561)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jemmy858585@gmail.com>)
	id 1ffROO-000811-Qp
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 10:55:56 -0400
Received: by mail-it0-x244.google.com with SMTP id w16-v6so2214261ita.0
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 07:55:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAOGPPbdxP=7C5m45LXFd3Yw8UEbKzdShjoXXFwORu8xruVOCiA@mail.gmail.com>
References: <1528106113-32692-1-git-send-email-lidongchen@tencent.com>
	<20180706095318.GB9761@work-vm> <20180706104152.GA2661@work-vm>
	<CAOGPPbdxP=7C5m45LXFd3Yw8UEbKzdShjoXXFwORu8xruVOCiA@mail.gmail.com>
From: 858585 jemmy <jemmy858585@gmail.com>
Date: Tue, 17 Jul 2018 22:55:55 +0800
Message-ID: <CAOGPPbcQ2FkaT0xOS8JQaoHxzQYQdk0m2S2sVGYYWdmSqQagnQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] migration: release MigrationIncomingState
 in migration_object_finalize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Lidong Chen <lidongchen@tencent.com>

On Thu, Jul 12, 2018 at 12:08 PM, 858585 jemmy <jemmy858585@gmail.com> wrote:
> On Fri, Jul 6, 2018 at 6:41 PM, Dr. David Alan Gilbert
> <dgilbert@redhat.com> wrote:
>> * Dr. David Alan Gilbert (dgilbert@redhat.com) wrote:
>>> * Lidong Chen (jemmy858585@gmail.com) wrote:
>>> > Qemu initialize the MigrationIncomingState structure in migration_object_init,
>>> > but not release it. this patch release it in migration_object_finalize.
>>> >
>>> > Signed-off-by: Lidong Chen <lidongchen@tencent.com>
>>>
>>> Queued
>>
>> I've had to unqueue this, see below:
>>
>>>
>>> > ---
>>> >  migration/migration.c | 7 +++++++
>>> >  1 file changed, 7 insertions(+)
>>> >
>>> > diff --git a/migration/migration.c b/migration/migration.c
>>> > index 05aec2c..e009a05 100644
>>> > --- a/migration/migration.c
>>> > +++ b/migration/migration.c
>>> > @@ -156,6 +156,13 @@ void migration_object_init(void)
>>> >  void migration_object_finalize(void)
>>> >  {
>>> >      object_unref(OBJECT(current_migration));
>>> > +
>>> > +    qemu_sem_destroy(&current_incoming->postcopy_pause_sem_fault);
>>> > +    qemu_sem_destroy(&current_incoming->postcopy_pause_sem_dst);
>>> > +    qemu_event_destroy(&current_incoming->main_thread_load_event);
>>> > +    qemu_mutex_destroy(&current_incoming->rp_mutex);
>>> > +    g_array_free(current_incoming->postcopy_remote_fds, true);
>>
>> That array is already free'd in migration_incoming_state_destroy,
>> so I see reliable glib assert's from this array free.
>
> The migration_incoming_state_destroy only invoked in destination qemu.
> The source qemu will not free this memory.
> So I think free current_incoming->postcopy_remote_fds is not good way.
>
> and migration_object_init and migration_object_finalize should not be
> invoked in main
> function. It's better to  alloc memory when start migration and
> release it when migration finished.
>
> I will submit a new version patch to fix it.

I find many function use current_incoming and current_migration,
if we alloc these when migration start, and release these when
migration finished, it need change many function.
so I will just remove
g_array_free(current_incoming->postcopy_remote_fds, true) from the
patch.

Thanks

>
>>
>> Dave
>>
>>> > +    g_free(current_incoming);
>>> >  }
>>> >
>>> >  /* For outgoing */
>>> > --
>>> > 1.8.3.1
>>> >
>>> --
>>> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>> --
>> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
