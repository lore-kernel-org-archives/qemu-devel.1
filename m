Received: from eggs.gnu.org ([2001:4830:134:3::10]:51386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dXRDh-0001ix-Oh
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 08:03:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dXRDb-0000rs-Qq
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 08:03:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54010)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dXRDb-0000rR-L5
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 08:03:11 -0400
Date: Tue, 18 Jul 2017 20:02:50 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170718120250.GD27284@pxdev.xzpeter.org>
References: <1499429683-73361-1-git-send-email-agraf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>

On Fri, Jul 07, 2017 at 02:14:43PM +0200, Alexander Graf wrote:
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
>  
>  
>  class ConfigurationSection(object):
> +    QEMU_VM_SUBSECTION    = 0x05
> +
>      def __init__(self, file):
>          self.file = file
>  
>      def read(self):
>          name_len = self.file.read32()
>          name = self.file.readstr(len = name_len)
> +        oldpos = self.file.tell()
> +        if self.file.read8() == self.QEMU_VM_SUBSECTION:

Here name_len missing?

               name_len = self.file.read8()

(though all of them are going to be threw away...)

> +            name = self.file.readstr()
> +            version_id = self.file.read32()
> +            if name == "configuration/target-page-bits":
> +                target_page_size = self.file.read32()
> +            else:
> +                raise Exception("Unknown config subsection: %s" % name)
> +        else:
> +            # No subsection following, forget that we ever read anything
> +            self.file.seek(oldpos)

I guess we need self.file.file.seek(oldpos) here? Since otherwise on
x86 we'll get:

Traceback (most recent call last):
  File "./analyze-migration.py", line 615, in <module>
    dump.read(dump_memory = args.memory)
  File "./analyze-migration.py", line 542, in read
    section.read()
  File "./analyze-migration.py", line 275, in read
    self.file.seek(oldpos)
AttributeError: 'MigrationFile' object has no attribute 'seek'

Thanks,

-- 
Peter Xu
