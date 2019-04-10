Received: from eggs.gnu.org ([209.51.188.92]:39435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hEHwF-0001yj-LA
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 14:27:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hEHwE-0005xQ-ME
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 14:27:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35974)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1hEHwE-0005xB-91
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 14:27:10 -0400
References: <f61645d0b3720a039423532d49dd65588d9bccd8.1554919328.git.crobinso@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4aee66fd-1cfa-a935-daa6-6f221af42095@redhat.com>
Date: Wed, 10 Apr 2019 13:27:02 -0500
MIME-Version: 1.0
In-Reply-To: <f61645d0b3720a039423532d49dd65588d9bccd8.1554919328.git.crobinso@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-4.0?] hmp: delvm: use hmp_handle_error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cole Robinson <crobinso@redhat.com>, qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, Peter Maydell <peter.maydell@linaro.org>

On 4/10/19 1:03 PM, Cole Robinson wrote:
> This gives us the consistent 'Error:' prefix added in 66363e9a43f,
> which helps users like libvirt who still need to scrape hmp error
> messages to detect failure.
> 
> Signed-off-by: Cole Robinson <crobinso@redhat.com>
> ---
>  hmp.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Not enough to drive -rc4 on its own, but worth adding to our wishlist of
potential easy patches if we do have a release blocker surface.

Reviewed-by: Eric Blake <eblake@redhat.com>

> 
> diff --git a/hmp.c b/hmp.c
> index 8eec768088..74a4bfc1f9 100644
> --- a/hmp.c
> +++ b/hmp.c
> @@ -1481,10 +1481,11 @@ void hmp_delvm(Monitor *mon, const QDict *qdict)
>      const char *name = qdict_get_str(qdict, "name");
>  
>      if (bdrv_all_delete_snapshot(name, &bs, &err) < 0) {
> -        error_reportf_err(err,
> -                          "Error while deleting snapshot on device '%s': ",
> -                          bdrv_get_device_name(bs));
> +        error_prepend(&err,
> +                      "Error while deleting snapshot on device '%s': ",

Do we want to reword the message (maybe s/Error while //) to avoid the
word "Error" twice in the same line?

> +                      bdrv_get_device_name(bs));
>      }
> +    hmp_handle_error(mon, &err);
>  }
>  
>  void hmp_info_snapshots(Monitor *mon, const QDict *qdict)
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
