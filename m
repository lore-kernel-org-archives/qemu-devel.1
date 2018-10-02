Received: from eggs.gnu.org ([2001:4830:134:3::10]:39144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g7Rv8-0003mT-9q
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 17:09:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g7Rv7-0000wV-Hx
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 17:09:30 -0400
References: <20180925153949.1577-1-programmingkidx@gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4d079c68-8789-7956-67e5-e88de5b025bc@redhat.com>
Date: Tue, 2 Oct 2018 16:09:17 -0500
MIME-Version: 1.0
In-Reply-To: <20180925153949.1577-1-programmingkidx@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] qemu-img.c: add help for each command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Arbuckle <programmingkidx@gmail.com>, mreitz@redhat.com, kwolf@redhat.com, qemu-block@nongnu.org, muriloo@linux.ibm.com, qemu-devel@nongnu.org

On 9/25/18 10:39 AM, John Arbuckle wrote:
> Add the ability for the user to display help for a certain command.
> Example: qemu-img create --help
> 
> What is printed is all the options available to this command and an example.
> 
> Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
> ---
> v3 changes:
> Fixed a bug that caused qemu-img to crash when running a command without
> options.

Hmm, I just reviewed v2 without noticing that you had posted v3.

> 
> v2 changes:
> Removed block of string comparison code for each command.
> Added a help_func field to the img_cmd_t struct.
> Made strings longer than 80 characters wide.
> 
>   qemu-img.c | 660 +++++++++++++++++++++++++++++++++++++++++++++++++++----------
>   1 file changed, 559 insertions(+), 101 deletions(-)

My v2 comment about splitting this into more reviewable portions still 
applies.

> +++ b/qemu-img.c
> @@ -52,6 +52,7 @@
>   typedef struct img_cmd_t {
>       const char *name;
>       int (*handler)(int argc, char **argv);
> +    void (*help_func)(void);
>   } img_cmd_t;

As does my complaint that you want to track the command synopses here in 
this struct for reuse in multiple contexts later, rather than...

> +static void help_amend(void)
> +{
> +    const char *msg =
> +    "\n"
> +    "usage: qemu-img amend [--object objectdef] [--image-opts] [-p] [-q] [-f fmt]\n"
> +    "[-t cache] -o options filename\n"

repeating things that are in qemu-img-cmds.h and risking them getting 
out of sync.

>   
> -static const img_cmd_t img_cmds[] = {
> +static img_cmd_t img_cmds[] = {
>   #define DEF(option, callback, arg_string)        \
>       { option, callback },
>   #include "qemu-img-cmds.h"
> @@ -4894,6 +5334,12 @@ static const img_cmd_t img_cmds[] = {
>       { NULL, NULL, },
>   };
>   
> +/* These functions will be added to the img_cmds array */
> +void (*help_functions[])(void) = {help_amend, help_bench, help_check,\
> +    help_commit, help_compare, help_convert, help_create, help_dd, help_info,\
> +    help_map, help_measure, help_snapshot, help_rebase, help_resize};

And my biggest gripe, that this approach to initialization is dead 
wrong, is still applicable.

Overall, I like the end result that you are trying to reach. (I'm not 
always a fan of having to run 'command --help' followed by 'command 
subcommand --help' to learn everything, but it sure beats a wall of 
text, and we have at least 'git' and 'cvs' as examples of programs that 
have used that approach, so we are not inventing something new).  But 
you'll need a v4, and preferably broken up into something easier to 
review (one patch per command, rather than a wholesale rewrite in go), 
if you want to get it in.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
