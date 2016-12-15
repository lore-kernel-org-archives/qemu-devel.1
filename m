Received: from eggs.gnu.org ([2001:4830:134:3::10]:44757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cHaCG-000548-KI
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 12:52:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cHaCD-00006q-GB
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 12:52:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52008)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1cHaCD-00006I-A7
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 12:51:57 -0500
References: <1481742422-15969-1-git-send-email-ashijeetacharya@gmail.com>
	<1481742422-15969-4-git-send-email-ashijeetacharya@gmail.com>
	<20161215171118.GQ2509@work-vm>
From: John Snow <jsnow@redhat.com>
Message-ID: <760d279a-0219-9c0f-a3b6-4f177c5b0167@redhat.com>
Date: Thu, 15 Dec 2016 12:51:53 -0500
MIME-Version: 1.0
In-Reply-To: <20161215171118.GQ2509@work-vm>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
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
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Ashijeet Acharya <ashijeetacharya@gmail.com>
Cc: amit.shah@redhat.com, pbonzini@redhat.com, kwolf@redhat.com, armbru@redhat.com, quintela@redhat.com, mst@redhat.com, marcandre.lureau@redhat.com, groug@kaod.org, aneesh.kumar@linux.vnet.ibm.com, peter.maydell@linaro.org, qemu-devel@nongnu.org



On 12/15/2016 12:11 PM, Dr. David Alan Gilbert wrote:
>      if (virtio_gpu_virgl_enabled(g->conf)) {
> +        error_setg(&g->migration_blocker, "virgl is not yet migratable");
> +        ret = migrate_add_blocker(g->migration_blocker, errp);
> +        if (ret) {
> +            if (ret > 0) {
> +                error_setg(errp, "Cannot use virgl as it does not support live"
> +                           " migration yet and --only-migratable was "
> +                           "specified");
> +            }
> +            return;
> +        }
> +    }

It may be best to leave this patch as a generic "Failed to add a
migration blocker" type of patch.

Then, in a fourth patch, you add the --only-migratable specific stuff as
an enhancement. (Basically, add your changes on top of my patch in your
own, separate patch.)

I'd also add the "--only-migratable" stuff only inside
migrate_add_blocker, and whatever the reason happens to be, you can
append a hint to the error message in the caller above.

e.g.

migrate_add_blocker(..) {
..
  error_setg("Failed to add migration blocker: --only-migratable was
specified")
..
}

And in the caller:

r = migrate_add_blocker(.., errp)
if (r) {
  error_append_hint(errp, "Failed to initialize virgl, couldn't add
migration blocker")
}

Or something along those lines. Maybe even error_prepend in this case
makes sense.

I'd try to keep all of the --only-migratable logic localized and in a
separate patch, leaving this patch strictly to deal with the case where
a migration is already in progress. Of course, you'll be right to notice
that in many of these initialization cases the error path could never
trigger, but that's OK. It adds the generic handling necessary to cope
with an error from a lower layer.

I'd also certainly advise to never return a custom error code from
migrate_add_blocker if we also wish to return a 'real' error code. Stick
with POSIX entirely or avoid it entirely.

--js
