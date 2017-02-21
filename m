Received: from eggs.gnu.org ([2001:4830:134:3::10]:54619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cg6Lg-00086z-Ey
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 04:03:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cg6Lb-0004dH-I1
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 04:03:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45506)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cg6Lb-0004ct-8z
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 04:02:59 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20170220160316.16803-1-danielhb@linux.vnet.ibm.com>
Date: Tue, 21 Feb 2017 10:02:50 +0100
In-Reply-To: <20170220160316.16803-1-danielhb@linux.vnet.ibm.com> (Daniel
	Henrique Barboza's message of "Mon, 20 Feb 2017 13:03:16 -0300")
Message-ID: <87ino3ncg5.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2] Changing error message of QMP
 'migrate_set_downtime' to seconds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, quintela@redhat.com

Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com> writes:

> The previous error message was displaying the values in miliseconds,
> being misleading with the command that accepts the value in seconds:
>
> { "execute": "migrate_set_downtime", "arguments": {"value": 3000}}
> {"error": {"class": "GenericError", "desc": "Parameter 'downtime_limit'
> expects an integer in the range of 0 to 2000000 milliseconds"}}
>
> This patch changes it to '2000 seconds' to keep consistency with
> the expected parameter. The macro 'QERR_INVALID_PARAMETER_VALUE'
> was changed for a regular string that allows the use of the
> MAX_MIGRATE_SET_DOWNTIME as a parameter, instead of hardcoding
> the value in the error message.
>
> Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
> ---
>  migration/migration.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/migration/migration.c b/migration/migration.c
> index c6ae69d..c05e764 100644
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
> -        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
> -                   "downtime_limit",
> -                   "an integer in the range of 0 to 2000000 milliseconds");
> +        (params->downtime_limit < 0 ||
> +         params->downtime_limit > MAX_MIGRATE_SET_DOWNTIME)) {
> +        error_setg(errp, "Parameter 'downtime_limit' expects an integer in "
> +                         "the range of 0 to %d seconds",
> +                         MAX_MIGRATE_SET_DOWNTIME / 1000);
>          return;
>      }
>      if (params->has_x_checkpoint_delay && (params->x_checkpoint_delay < 0)) {

Isn't this wrong for QMP migrate-set-parameters?  There, the unit is
milliseconds, i.e. the new error message is as wrong as the old one is
for migrate_set_downtime.

I'm afraid you need to fix the error message in
qmp_migrate_set_downtime().  If you assume qmp_migrate_set_parameters()
fails only in one way, replace its error object by one with a better
message[*].  If you'd rather not assume, you need to refactor things so
that each place can set the downtime and create an appropriate error on
failure.

We might want to check other command wrappers that translate units.

Time units are a hopeless mess in QMP.  We should've enforced uniform
usage of either seconds or nanoseconds.  The latter to placate
irrational fear of floating-point[**].


[*] If replacing messages turns out to be a common operation, we can add
a function to replace it within the same Error object.

[**] If you think the rounding you can get when converting
floating-point seconds to integer milli-, micro- or nanoseconds matters,
I have time-keeping equipment to sell you.
