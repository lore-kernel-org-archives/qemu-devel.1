Received: from eggs.gnu.org ([2001:4830:134:3::10]:60421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cXXx1-0002cM-RF
	for qemu-devel@nongnu.org; Sat, 28 Jan 2017 13:42:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cXXwy-0001tV-Pj
	for qemu-devel@nongnu.org; Sat, 28 Jan 2017 13:42:15 -0500
Received: from 5.mo69.mail-out.ovh.net ([46.105.43.105]:45250)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cXXwy-0001qB-JX
	for qemu-devel@nongnu.org; Sat, 28 Jan 2017 13:42:12 -0500
Received: from player798.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id A1280143E3
	for <qemu-devel@nongnu.org>; Sat, 28 Jan 2017 19:42:03 +0100 (CET)
Date: Sat, 28 Jan 2017 19:41:57 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170128194157.0c82cc8a@bahia.lan>
In-Reply-To: <1485422212-31546-1-git-send-email-ashijeetacharya@gmail.com>
References: <1485422212-31546-1-git-send-email-ashijeetacharya@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Cc: thuth@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com, quintela@redhat.com

On Thu, 26 Jan 2017 14:46:52 +0530
Ashijeet Acharya <ashijeetacharya@gmail.com> wrote:

> Migration of a "none" machine with no RAM crashes abruptly as
> bitmap_new() fails and thus aborts. Instead, place a check for
> last_ram_offset() being '0' at the start of ram_save_setup() and
> error out with a meaningful error message.
> 
> Signed-off-by: Ashijeet Acharya <ashijeetacharya@gmail.com>
> ---

Maybe a naive question: why a "none" machine with zero RAM should fail to
migrate ?

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
>      /* migration has already setup the bitmap, reuse it. */
>      if (!migration_in_colo_state()) {
>          if (ram_save_init_globals() < 0) {
