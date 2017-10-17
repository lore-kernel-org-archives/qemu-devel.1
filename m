Received: from eggs.gnu.org ([2001:4830:134:3::10]:58879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e4U7Y-0004pC-FF
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 11:49:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e4U7V-0004LQ-T9
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 11:49:32 -0400
Date: Tue, 17 Oct 2017 17:49:23 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171017174923.6c8c5cf2.cohuck@redhat.com>
In-Reply-To: <1508247680-98800-2-git-send-email-imammedo@redhat.com>
References: <1508247680-98800-1-git-send-email-imammedo@redhat.com>
	<1508247680-98800-2-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] s390x: fix cpu object referrence leak
 in s390x_new_cpu()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org

On Tue, 17 Oct 2017 15:41:19 +0200
Igor Mammedov <imammedo@redhat.com> wrote:

> object_new() returns cpu with refcnt == 1 and after realize
> refcnt == 2*. s390x_new_cpu() as an owner of the first refcnt
> should have released it on exit in both cases (on error and
> success) to avoid it leaking. Do so for both cases.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  target/s390x/helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/s390x/helper.c b/target/s390x/helper.c
> index 97adbcc..64d4c48 100644
> --- a/target/s390x/helper.c
> +++ b/target/s390x/helper.c
> @@ -80,9 +80,9 @@ S390CPU *s390x_new_cpu(const char *typename, uint32_t core_id, Error **errp)
>      object_property_set_bool(OBJECT(cpu), true, "realized", &err);
>  
>  out:
> +    object_unref(OBJECT(cpu));
>      if (err) {
>          error_propagate(errp, err);
> -        object_unref(OBJECT(cpu));
>          cpu = NULL;
>      }
>      return cpu;

Thanks, applied.
