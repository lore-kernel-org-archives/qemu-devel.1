Received: from eggs.gnu.org ([209.51.188.92]:44246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hH94h-0008Q5-5o
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 11:35:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hH8pM-0006YH-PG
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 11:19:53 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40943)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hH8pM-0006Hb-ID
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 11:19:52 -0400
Received: by mail-wr1-f65.google.com with SMTP id h4so3424640wre.7
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 08:19:47 -0700 (PDT)
References: <20190418145355.21100-1-armbru@redhat.com>
	<20190418145355.21100-2-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2679829b-cc1d-83ce-9949-2b80d970ddec@redhat.com>
Date: Thu, 18 Apr 2019 17:19:45 +0200
MIME-Version: 1.0
In-Reply-To: <20190418145355.21100-2-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/6] qemu-bridge-helper: Fix misuse of
 isspace()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

On 4/18/19 4:53 PM, Markus Armbruster wrote:
> parse_acl_file() passes char values to isspace().  Undefined behavior
> when the value is negative.  Not a security issue, because the
> characters come from trusted $prefix/etc/qemu/bridge.conf and the
> files it includes.
> 
> Fix by using qemu_isspace() instead.

Can we use g_ascii_isspace() and remove qemu_isspace()?

> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  qemu-bridge-helper.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/qemu-bridge-helper.c b/qemu-bridge-helper.c
> index 5396fbfbb6..0d60c07655 100644
> --- a/qemu-bridge-helper.c
> +++ b/qemu-bridge-helper.c
> @@ -29,6 +29,7 @@
>  #include <linux/if_bridge.h>
>  #endif
>  
> +#include "qemu-common.h"
>  #include "qemu/queue.h"
>  
>  #include "net/tap-linux.h"
> @@ -75,7 +76,7 @@ static int parse_acl_file(const char *filename, ACLList *acl_list)
>          char *ptr = line;
>          char *cmd, *arg, *argend;
>  
> -        while (isspace(*ptr)) {
> +        while (qemu_isspace(*ptr)) {
>              ptr++;
>          }
>  
> @@ -99,12 +100,12 @@ static int parse_acl_file(const char *filename, ACLList *acl_list)
>  
>          *arg = 0;
>          arg++;
> -        while (isspace(*arg)) {
> +        while (qemu_isspace(*arg)) {
>              arg++;
>          }
>  
>          argend = arg + strlen(arg);
> -        while (arg != argend && isspace(*(argend - 1))) {
> +        while (arg != argend && qemu_isspace(*(argend - 1))) {
>              argend--;
>          }
>          *argend = 0;
> 
