Received: from eggs.gnu.org ([2001:4830:134:3::10]:56743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fj5LA-0000Fl-2L
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 12:11:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fj5L6-0007X2-Ro
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 12:11:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53506 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fj5L6-0007WS-ME
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 12:11:36 -0400
References: <20180727151359.29061-1-armbru@redhat.com>
	<20180727151359.29061-20-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <aa8f502a-6dbb-c0ac-57fa-f1431a98387b@redhat.com>
Date: Fri, 27 Jul 2018 11:11:35 -0500
MIME-Version: 1.0
In-Reply-To: <20180727151359.29061-20-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 19/23] migration-test: Clean up string
 interpolation into QMP, part 3
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
> migration-test.c interpolates strings into JSON in a few places:
> 
> * migrate_set_parameter() interpolates string parameter @value as a
>    JSON number.  Change it to long long.  This requires changing
>    migrate_check_parameter() similarly.
> 
> * migrate_set_capability() interpolates string parameter @value as a
>    JSON boolean.  Change it to bool.
> 
> * deprecated_set_speed() interpolates string parameter @value as a
>    JSON number.  Change it to long long.
> 
> Bonus: gets rid of non-literal format strings.  A step towards
> compile-time format string checking without triggering
> -Wformat-nonliteral.
> 
> Cc: Juan Quintela <quintela@redhat.com>
> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> ---
>   tests/migration-test.c | 74 +++++++++++++++++-------------------------
>   1 file changed, 29 insertions(+), 45 deletions(-)
> 
> diff --git a/tests/migration-test.c b/tests/migration-test.c
> index 1c1e56b15b..132c30891d 100644
> --- a/tests/migration-test.c
> +++ b/tests/migration-test.c
> @@ -315,31 +315,25 @@ static void cleanup(const char *filename)
>   }
>   
>   static void migrate_check_parameter(QTestState *who, const char *parameter,
> -                                    const char *value)
> +                                    long long value)
>   {
>       QDict *rsp_return;
> -    char *result;
>   
>       rsp_return = wait_command(who,
>                                 "{ 'execute': 'query-migrate-parameters' }");
> -    result = g_strdup_printf("%" PRId64,
> -                             qdict_get_try_int(rsp_return,  parameter, -1));
> -    g_assert_cmpstr(result, ==, value);

The old code allows defaulting to -1 if the value is not present;

> -    g_free(result);
> +    g_assert_cmpint(qdict_get_int(rsp_return,  parameter), ==, value);

the new code requires the value to be found.  Matters if any of the 
callers passed "-1" in the old code, but a search of the file doesn't 
spot any such callers. So I think you're okay.

Also, while touching this line, it would be nice to get rid of the 
double space before parameter.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
