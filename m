Received: from eggs.gnu.org ([2001:4830:134:3::10]:38777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fUssP-0003NY-66
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 08:03:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fUssK-0008M1-Af
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 08:03:17 -0400
Date: Mon, 18 Jun 2018 14:03:08 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180618140308.0fe78716@redhat.com>
In-Reply-To: <20180615140448.32234-12-david@redhat.com>
References: <20180615140448.32234-1-david@redhat.com>
	<20180615140448.32234-12-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 11/13] nvdimm: allow setting the
 label-size to 0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>

On Fri, 15 Jun 2018 16:04:46 +0200
David Hildenbrand <david@redhat.com> wrote:

> It is inititally 0, so setting it to 0 should be allowed, too.
I'm not sure if we need to permit it.
By default labels are disabled (label-size=0) and user are supposed to provide
this option if labels should be enabled with a valid size. 

it could be confusing for user when asking for label and not getting it.

I suggest to drop this patch, it's not really related to this series
nor required for your future work.

> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/mem/nvdimm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
> index db7d8c3050..df7646488b 100644
> --- a/hw/mem/nvdimm.c
> +++ b/hw/mem/nvdimm.c
> @@ -52,9 +52,9 @@ static void nvdimm_set_label_size(Object *obj, Visitor *v, const char *name,
>      if (local_err) {
>          goto out;
>      }
> -    if (value < MIN_NAMESPACE_LABEL_SIZE) {
> +    if (value && value < MIN_NAMESPACE_LABEL_SIZE) {
>          error_setg(&local_err, "Property '%s.%s' (0x%" PRIx64 ") is required"
> -                   " at least 0x%lx", object_get_typename(obj),
> +                   " either 0 or at least 0x%lx", object_get_typename(obj),
>                     name, value, MIN_NAMESPACE_LABEL_SIZE);
>          goto out;
>      }
