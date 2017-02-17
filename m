Received: from eggs.gnu.org ([2001:4830:134:3::10]:43094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cemT8-00057q-C4
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 12:37:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cemT3-0008VT-Ep
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 12:37:18 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:32865)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cemT3-0008Uh-6b
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 12:37:13 -0500
Received: by mail-wm0-x242.google.com with SMTP id v77so3734508wmv.0
	for <qemu-devel@nongnu.org>; Fri, 17 Feb 2017 09:37:12 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20170217172607.25575-1-danielhb@linux.vnet.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3c2ce558-db56-79b5-14ed-4431f6529c82@redhat.com>
Date: Fri, 17 Feb 2017 18:37:14 +0100
MIME-Version: 1.0
In-Reply-To: <20170217172607.25575-1-danielhb@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] Changing error message of QMP
 'migrate_set_downtime' to seconds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, quintela@redhat.com



On 17/02/2017 18:26, Daniel Henrique Barboza wrote:
> The previous error message was displaying the values in miliseconds,
> being misleading with the command that accepts the value in seconds:
> 
> { "execute": "migrate_set_downtime", "arguments": {"value": 3000}}
> {"error": {"class": "GenericError", "desc": "Parameter 'downtime_limit'
> expects an integer in the range of 0 to 2000000 milliseconds"}}
> 
> This patch changes it to '2000 seconds' to keep consistency with
> the expected parameter.
> 
> Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
> ---
>  migration/migration.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index c6ae69d..2dc63b1 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -49,6 +49,9 @@
>   * for sending the last part */
>  #define DEFAULT_MIGRATE_SET_DOWNTIME 300
>  
> +/* Maximum migrate downtime set to 2000*1000 miliseconds */
> +#define MAX_MIGRATE_SET_DOWNTIME (2000 * 1000)
> +
>  /* Default compression thread count */
>  #define DEFAULT_MIGRATE_COMPRESS_THREAD_COUNT 8
>  /* Default decompression thread count, usually decompression is at
> @@ -843,10 +846,11 @@ void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
>          return;
>      }
>      if (params->has_downtime_limit &&
> -        (params->downtime_limit < 0 || params->downtime_limit > 2000000)) {
> +        (params->downtime_limit < 0 ||
> +         params->downtime_limit > MAX_MIGRATE_SET_DOWNTIME)) {
>          error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
>                     "downtime_limit",
> -                   "an integer in the range of 0 to 2000000 milliseconds");
> +                   "an integer in the range of 0 to 2000 seconds");

Perhaps you could use %d and set  MAX_MIGRATE_SET_DOWNTIME to 2000?
Though perhaps the migration maintainers are okay with the patch as is.

Paolo

>          return;
>      }
>      if (params->has_x_checkpoint_delay && (params->x_checkpoint_delay < 0)) {
> 
