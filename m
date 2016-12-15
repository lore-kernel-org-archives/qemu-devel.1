Received: from eggs.gnu.org ([2001:4830:134:3::10]:55058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1cHaWu-00041C-LR
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 13:13:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1cHaWr-0005xC-Hl
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 13:13:20 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:36695)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ashijeetacharya@gmail.com>)
	id 1cHaWr-0005wq-Cf
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 13:13:17 -0500
Received: by mail-io0-f194.google.com with SMTP id b194so9267324ioa.3
	for <qemu-devel@nongnu.org>; Thu, 15 Dec 2016 10:13:17 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <760d279a-0219-9c0f-a3b6-4f177c5b0167@redhat.com>
References: <1481742422-15969-1-git-send-email-ashijeetacharya@gmail.com>
	<1481742422-15969-4-git-send-email-ashijeetacharya@gmail.com>
	<20161215171118.GQ2509@work-vm>
	<760d279a-0219-9c0f-a3b6-4f177c5b0167@redhat.com>
From: Ashijeet Acharya <ashijeetacharya@gmail.com>
Date: Thu, 15 Dec 2016 23:42:16 +0530
Message-ID: <CAC2QTZbnGbQzRFmqfV9o4PZ4SJByyZ0B=FcjHf9cGbSTtjcOkA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH 3/3] migration: disallow
 migrate_add_blocker during migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, amit.shah@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, quintela@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>, marcandre.lureau@redhat.com, groug@kaod.org, aneesh.kumar@linux.vnet.ibm.com, Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On Thu, Dec 15, 2016 at 11:21 PM, John Snow <jsnow@redhat.com> wrote:
>
>
> On 12/15/2016 12:11 PM, Dr. David Alan Gilbert wrote:
>>      if (virtio_gpu_virgl_enabled(g->conf)) {
>> +        error_setg(&g->migration_blocker, "virgl is not yet migratable");
>> +        ret = migrate_add_blocker(g->migration_blocker, errp);
>> +        if (ret) {
>> +            if (ret > 0) {
>> +                error_setg(errp, "Cannot use virgl as it does not support live"
>> +                           " migration yet and --only-migratable was "
>> +                           "specified");
>> +            }
>> +            return;
>> +        }
>> +    }
>
> It may be best to leave this patch as a generic "Failed to add a
> migration blocker" type of patch.
>
> Then, in a fourth patch, you add the --only-migratable specific stuff as
> an enhancement. (Basically, add your changes on top of my patch in your
> own, separate patch.)

No problem, I will separate them. Although I will add changes for the
ARM drivers you first missed out on.

>
> I'd also add the "--only-migratable" stuff only inside
> migrate_add_blocker, and whatever the reason happens to be, you can
> append a hint to the error message in the caller above.
>
> e.g.
>
> migrate_add_blocker(..) {
> ..
>   error_setg("Failed to add migration blocker: --only-migratable was
> specified")
> ..
> }
>
> And in the caller:
>
> r = migrate_add_blocker(.., errp)
> if (r) {
>   error_append_hint(errp, "Failed to initialize virgl, couldn't add
> migration blocker")
> }
>
> Or something along those lines. Maybe even error_prepend in this case
> makes sense.

Yes, I will make this change and make the error message more like:
error_append_hint(errp, "Failed to initialize virgl as it does not
support live migration, couldn't add migration blocker");

>
> I'd try to keep all of the --only-migratable logic localized and in a
> separate patch, leaving this patch strictly to deal with the case where
> a migration is already in progress. Of course, you'll be right to notice
> that in many of these initialization cases the error path could never
> trigger, but that's OK. It adds the generic handling necessary to cope
> with an error from a lower layer.
>
> I'd also certainly advise to never return a custom error code from
> migrate_add_blocker if we also wish to return a 'real' error code. Stick
> with POSIX entirely or avoid it entirely.

Right, as discussed with Dave on the IRC, I will make use of EACCES.

Ashijeet
>
> --js
