Received: from eggs.gnu.org ([209.51.188.92]:56997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hH9td-0004o7-LF
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 12:28:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hH9tX-0003q4-If
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 12:28:18 -0400
References: <20190418145355.21100-1-armbru@redhat.com>
	<20190418145355.21100-6-armbru@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <4aa820cd-bb5e-b891-bd77-42afab8de347@redhat.com>
Date: Thu, 18 Apr 2019 18:28:05 +0200
MIME-Version: 1.0
In-Reply-To: <20190418145355.21100-6-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 5/6] pc-bios/s390-ccw: Clean up harmless
 misuse of isdigit()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org

On 18/04/2019 16.53, Markus Armbruster wrote:
> atoui() and get_index() pass char values to isdigit().  With a
> standard isdigit(), we'd get undefined behavior when the value is
> negative.  But we're using isdigit() from pc-bios/s390-ccw/libc.h
> here, which behaves nicely.  Clean up anyway, just to avoid setting a
> bad example.
> 
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: Thomas Huth <thuth@redhat.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: qemu-s390x@nongnu.org
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  pc-bios/s390-ccw/libc.c | 2 +-
>  pc-bios/s390-ccw/menu.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/pc-bios/s390-ccw/libc.c b/pc-bios/s390-ccw/libc.c
> index a786566c4c..3187923950 100644
> --- a/pc-bios/s390-ccw/libc.c
> +++ b/pc-bios/s390-ccw/libc.c
> @@ -38,7 +38,7 @@ uint64_t atoui(const char *str)
>      }
>  
>      while (*str) {
> -        if (!isdigit(*str)) {
> +        if (!isdigit(*(unsigned char *)str)) {
>              break;
>          }
>          val = val * 10 + *str - '0';
> diff --git a/pc-bios/s390-ccw/menu.c b/pc-bios/s390-ccw/menu.c
> index 82a4ae6315..ce3815b201 100644
> --- a/pc-bios/s390-ccw/menu.c
> +++ b/pc-bios/s390-ccw/menu.c
> @@ -134,7 +134,7 @@ static int get_index(void)
>  
>      /* Check for erroneous input */
>      for (i = 0; i < len; i++) {
> -        if (!isdigit(buf[i])) {
> +        if (!isdigit((unsigned char)buf[i])) {
>              return -1;
>          }
>      }

FWIW, "char" is unsigned by default on s390x, so this is doing nothing.

 Thomas
