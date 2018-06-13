Received: from eggs.gnu.org ([2001:4830:134:3::10]:38937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fT2Il-0004rd-WB
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 05:42:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fT2Ii-0000vQ-4f
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 05:42:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40094 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fT2Ih-0000uj-VN
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 05:42:48 -0400
Date: Wed, 13 Jun 2018 10:42:43 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180613094243.GH27901@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180613061657.13632-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180613061657.13632-1-ppandit@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qga: check bytes count read by
 guest-file-read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, Stefan Weil <sw@weilnetz.de>, Michael Roth <mdroth@linux.vnet.ibm.com>, Prasad J Pandit <pjp@fedoraproject.org>

On Wed, Jun 13, 2018 at 11:46:57AM +0530, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
> 
> While reading file content via 'guest-file-read' command,
> 'qmp_guest_file_read' routine allocates buffer of count+1
> bytes. It could overflow for large values of 'count'.
> Add check to avoid it.

No objection to this patch, but I would point out that even
trying to read  'UINT32_MAX - 1' bytes is going to end in
disaster. 

We'll allocate UINT32_MAX bytes of RAM to read the data.

Then we'll allocate

   (UINT32_MAX / 3 + 1) * 4 + 1)

bytes of RAM in g_base64_encode.... which incidentally
is not checking for integer overflow either when calling
g_malloc.

Then our JSON formatting code will allocate at least that
much RAM again, probably also not checking for overflow.

I wouldn't be surprised if we allocate that much RAM yet
again in some other part of the stack too.

> 
> Reported-by: Fakhri Zulkifli <mohdfakhrizulkifli@gmail.com>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  qga/commands-posix.c | 2 +-
>  qga/commands-win32.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> index eae817191b..068c0f0bd9 100644
> --- a/qga/commands-posix.c
> +++ b/qga/commands-posix.c
> @@ -458,7 +458,7 @@ struct GuestFileRead *qmp_guest_file_read(int64_t handle, bool has_count,
>  
>      if (!has_count) {
>          count = QGA_READ_COUNT_DEFAULT;
> -    } else if (count < 0) {
> +    } else if (count < 0 || count >= UINT32_MAX) {
>          error_setg(errp, "value '%" PRId64 "' is invalid for argument count",
>                     count);
>          return NULL;
> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> index 70ee5379f6..73f31fa8c2 100644
> --- a/qga/commands-win32.c
> +++ b/qga/commands-win32.c
> @@ -318,7 +318,7 @@ GuestFileRead *qmp_guest_file_read(int64_t handle, bool has_count,
>      }
>      if (!has_count) {
>          count = QGA_READ_COUNT_DEFAULT;
> -    } else if (count < 0) {
> +    } else if (count < 0 || count >= UINT32_MAX) {
>          error_setg(errp, "value '%" PRId64
>                     "' is invalid for argument count", count);
>          return NULL;
> -- 
> 2.17.1
> 
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
