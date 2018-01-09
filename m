Received: from eggs.gnu.org ([2001:4830:134:3::10]:35435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1eYtO9-0005Eh-9m
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 07:52:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1eYtO6-0005c3-4y
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 07:52:21 -0500
References: <20180108215007.46471-1-marcel@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <5367c8a4-91bd-7712-525d-0a1ed6e6acab@redhat.com>
Date: Tue, 9 Jan 2018 13:51:59 +0100
MIME-Version: 1.0
In-Reply-To: <20180108215007.46471-1-marcel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] fw_cfg: fix memory corruption when all
 fw_cfg slots are used
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>, qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, mst@redhat.com, qemu-stable@nongnu.org, kraxel@redhat.com

On 01/08/18 22:50, Marcel Apfelbaum wrote:
> When all the fw_cfg slots are used, a write is made outside the
> bounds of the fw_cfg files array as part of the sort algorithm.
> 
> Fix it by avoiding an unnecessary array element move.
> Fix also an assert while at it.
> 
> Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
> ---
>  hw/nvram/fw_cfg.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
> index 753ac0e4ea..4313484b21 100644
> --- a/hw/nvram/fw_cfg.c
> +++ b/hw/nvram/fw_cfg.c
> @@ -784,7 +784,7 @@ void fw_cfg_add_file_callback(FWCfgState *s,  const char *filename,
>       * index and "i - 1" is the one being copied from, thus the
>       * unusual start and end in the for statement.
>       */
> -    for (i = count + 1; i > index; i--) {
> +    for (i = count; i > index; i--) {
>          s->files->f[i] = s->files->f[i - 1];
>          s->files->f[i].select = cpu_to_be16(FW_CFG_FILE_FIRST + i);
>          s->entries[0][FW_CFG_FILE_FIRST + i] =
> @@ -833,7 +833,6 @@ void *fw_cfg_modify_file(FWCfgState *s, const char *filename,
>      assert(s->files);
>  
>      index = be32_to_cpu(s->files->count);
> -    assert(index < fw_cfg_file_slots(s));
>  
>      for (i = 0; i < index; i++) {
>          if (strcmp(filename, s->files->f[i].name) == 0) {
> @@ -843,6 +842,9 @@ void *fw_cfg_modify_file(FWCfgState *s, const char *filename,
>              return ptr;
>          }
>      }
> +
> +    assert(index < fw_cfg_file_slots(s));
> +
>      /* add new one */
>      fw_cfg_add_file_callback(s, filename, NULL, NULL, NULL, data, len, true);
>      return NULL;
> 

Given that I was CC'd... I don't understand the purpose of the sorting.
I've read commit bab47d9a75a3 ("Sort the fw_cfg file list", 2016-04-07),
yes. It does not spell out the goal.

I assume the idea is migration compatibility for the same machine type
between QEMU releases. Is that correct? A new release might assign a
different selector key to the same fw_cfg file, and a guest that is
migrated while reading fw_cfg could end up with half-half of different
blobs.

Wasn't this somehow addressed by keeping fw_cfg blobs in RAM blocks or
some such?

Also, assuming the problem is real (i.e., we need to stick with the same
numeric values regardless of moving around the insertion points in the
source code), then why is it safe for "non-legacy" machine types to do
... er... "something else" than keep the same numeric values? The commit
says,

    This will avoid any future issues of moving the file creation
    around, it doesn't matter what order they are created now,
    the will always be in filename order.

Which is true, but if a new file is introduced (with a pathname in the
middle), then that will shift up everything behind. Or... is the idea
that the same machine type on a new QEMU release may only reorder the
additions of the preexistent fw_cfg files across the source code, but
must not expose *new* fw_cfg files?

If this is the idea, then keeping the list sorted would indeed ensure
the same numeric values too -- however, I don't think the assumption is
safe. Certain devices may expose dedicated, standalone fw_cfg blobs, and
such devices, when they are implemented, are generally enabled for older
machine types too, retroactively. ... Hm, in that case, is the argument
that the device can never be present on the *source* (old version) QEMU,
so for migration to be even considered, it can also not be present on
the target (new version) QEMU?

Wow, complex.

Laszlo
