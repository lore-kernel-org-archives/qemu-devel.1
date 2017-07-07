Received: from eggs.gnu.org ([2001:4830:134:3::10]:59256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dTUk4-0000zc-Lj
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 11:00:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dTUk0-0003Id-4z
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 11:00:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42960)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dTUjz-0003IV-Uc
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 11:00:20 -0400
Date: Fri, 7 Jul 2017 16:00:11 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170707150011.GH2451@work-vm>
References: <1499429683-73361-1-git-send-email-agraf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1499429683-73361-1-git-send-email-agraf@suse.de>
Subject: Re: [Qemu-devel] [PATCH] migration: Make analyze-migration script
 target-page-size aware
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexander Graf <agraf@suse.de>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>

* Alexander Graf (agraf@suse.de) wrote:
> The configuration section has a new subsection to transmit the target page
> size along with the migration stream. The analyze migration script needs
> to learn about that to read configuration streams that were triggering
> this subsection to get transmitted.
> 
> With this patch applied, I can successfully analyze migration streams
> on AArch64 again.
> 
> Signed-off-by: Alexander Graf <agraf@suse.de>
> ---
>  scripts/analyze-migration.py | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/scripts/analyze-migration.py b/scripts/analyze-migration.py
> index 1455387..02784f2 100755
> --- a/scripts/analyze-migration.py
> +++ b/scripts/analyze-migration.py
> @@ -254,12 +254,25 @@ class HTABSection(object):

(Note I'm not a particularly python person, so take lightly)

>  class ConfigurationSection(object):
> +    QEMU_VM_SUBSECTION    = 0x05
> +

It's odd, you already have this constant defined twice in this script.

>      def __init__(self, file):
>          self.file = file
>  
>      def read(self):
>          name_len = self.file.read32()
>          name = self.file.readstr(len = name_len)
> +        oldpos = self.file.tell()
> +        if self.file.read8() == self.QEMU_VM_SUBSECTION:
> +            name = self.file.readstr()
> +            version_id = self.file.read32()
> +            if name == "configuration/target-page-bits":
> +                target_page_size = self.file.read32()

All of your other references to target_page_size in the script
are self.TARGET_PAGE_SIZE.

You might want to make the conditional subsection check into a function
somewhere, but that's OK for now.

Dave

> +            else:
> +                raise Exception("Unknown config subsection: %s" % name)
> +        else:
> +            # No subsection following, forget that we ever read anything
> +            self.file.seek(oldpos)
>  
>  class VMSDFieldGeneric(object):
>      def __init__(self, desc, file):
> -- 
> 1.8.5.6
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
