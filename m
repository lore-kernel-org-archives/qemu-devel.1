Received: from eggs.gnu.org ([2001:4830:134:3::10]:33004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fQdNk-00014c-1J
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 14:42:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fQdNj-0003hd-7A
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 14:42:04 -0400
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:37292)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fQdNj-0003hE-0q
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 14:42:03 -0400
Received: by mail-ot0-x241.google.com with SMTP id 101-v6so8470727oth.4
	for <qemu-devel@nongnu.org>; Wed, 06 Jun 2018 11:42:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180606183738.31688-1-mreitz@redhat.com>
References: <20180606183738.31688-1-mreitz@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 6 Jun 2018 19:41:41 +0100
Message-ID: <CAFEAcA-GnSTh7aOEYm8g0DiFKP_o3LgPs_OHO8x0nPKuGU2-bw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] iotests: Fix 219's timing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 6 June 2018 at 19:37, Max Reitz <mreitz@redhat.com> wrote:
> 219 has two issues that may lead to sporadic failure, both of which are
> the result of issuing query-jobs too early after a job has been
> modified.  This can then lead to different results based on whether the
> modification has taken effect already or not.
>
> First, query-jobs is issued right after the job has been created.
> Besides its current progress possibly being in any random state (which
> has already been taken care of), its total progress too is basically
> arbitrary, because the job may not yet have been able to determine it.
> This patch addresses this by just filtering the total progress, like
> what has been done for the current progress already.  However, for more
> clarity, the filtering is changed to replace the values by a string
> 'FILTERED' instead of deleting them.
>
> Secondly, query-jobs is issued right after a job has been resumed.  The
> job may or may not yet have had the time to actually perform any I/O,
> and thus its current progress may or may not have advanced.  To make
> sure it has indeed advanced (which is what the reference output already
> assumes), insert a sleep of 100 ms before query-jobs is invoked.  With a
> slice time of 100 ms, a buffer size of 64 kB and a speed of 256 kB/s,
> this should be the right amount of time to let the job advance by
> exactly 64 kB.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
> v2: Changed the query-jobs progress filtering [Eric]
> ---

I know nothing about the iotests, so this might be off-base,
but this looks rather like "try to fix a race condition by
adding a sleep", which generally doesn't work very well ?

thanks
-- PMM
