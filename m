Received: from eggs.gnu.org ([2001:4830:134:3::10]:47144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cWpvP-0006yZ-Tn
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 14:41:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cWpvL-0001Er-1A
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 14:41:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:64931)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cWpvK-0001Ed-RB
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 14:41:34 -0500
Date: Thu, 26 Jan 2017 19:41:29 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170126194128.GB2796@work-vm>
References: <1485422212-31546-1-git-send-email-ashijeetacharya@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1485422212-31546-1-git-send-email-ashijeetacharya@gmail.com>
Subject: Re: [Qemu-devel] [PATCH] migrate: Migration aborts abruptly for
 machine "none"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ashijeet Acharya <ashijeetacharya@gmail.com>
Cc: thuth@redhat.com, quintela@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org

* Ashijeet Acharya (ashijeetacharya@gmail.com) wrote:
> Migration of a "none" machine with no RAM crashes abruptly as
> bitmap_new() fails and thus aborts. Instead, place a check for
> last_ram_offset() being '0' at the start of ram_save_setup() and
> error out with a meaningful error message.
> 
> Signed-off-by: Ashijeet Acharya <ashijeetacharya@gmail.com>
> ---
>  migration/ram.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index ef8fadf..bf05d69 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -1947,6 +1947,11 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
>  {
>      RAMBlock *block;
>  
> +    if (last_ram_offset() == 0) {
> +        error_report("Failed to migrate: No RAM available!");
> +        return -1;
> +    }
> +

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Dave

>      /* migration has already setup the bitmap, reuse it. */
>      if (!migration_in_colo_state()) {
>          if (ram_save_init_globals() < 0) {
> -- 
> 2.6.2
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
