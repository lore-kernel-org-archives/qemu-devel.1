Received: from eggs.gnu.org ([2001:4830:134:3::10]:54982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fj5E1-0003FV-Rj
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 12:04:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fj5Dx-0002yc-TU
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 12:04:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60922 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fj5Dx-0002yW-OL
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 12:04:13 -0400
References: <20180727151359.29061-1-armbru@redhat.com>
	<20180727151359.29061-18-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2a73fc45-3ca1-d50f-06e6-c21850cdbd5c@redhat.com>
Date: Fri, 27 Jul 2018 11:04:11 -0500
MIME-Version: 1.0
In-Reply-To: <20180727151359.29061-18-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 17/23] migration-test: Clean up string
 interpolation into QMP, part 1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, f4bug@amsat.org, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On 07/27/2018 10:13 AM, Markus Armbruster wrote:
> Leaving interpolation into JSON to qmp() is more robust than building
> QMP input manually, as explained in the recent commit "tests: Clean up
> string interpolation into QMP input (simple cases)".
> 
> migrate_recover() builds QMP input manually because wait_command()
> can't interpolate.  Well, it can since the previous commit.  Simplify
> accordingly.
> 
> Bonus: gets rid of a non-literal format string.  A step towards
> compile-time format string checking without triggering
> -Wformat-nonliteral.
> 
> Cc: Juan Quintela <quintela@redhat.com>
> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> ---
>   tests/migration-test.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/tests/migration-test.c b/tests/migration-test.c
> index 0c92f2b1cd..323bb60535 100644
> --- a/tests/migration-test.c
> +++ b/tests/migration-test.c
> @@ -156,6 +156,7 @@ static void stop_cb(void *opaque, const char *name, QDict *data)
>   /*
>    * Events can get in the way of responses we are actually waiting for.
>    */
> +GCC_FMT_ATTR(2, 3)
>   static QDict *wait_command(QTestState *who, const char *command, ...)

Placement of function-level attributes is so weird (before the return 
type on implementations, but after the () in declarations) - not your fault.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
