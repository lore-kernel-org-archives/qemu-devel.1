Received: from eggs.gnu.org ([2001:4830:134:3::10]:37900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g7RrB-0000Uz-Jn
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 17:05:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g7RoL-0004i9-Vj
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 17:02:31 -0400
References: <20180915161035.7859-1-programmingkidx@gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d0dd8140-ec3f-2b8d-2339-b82ec4b59bd0@redhat.com>
Date: Tue, 2 Oct 2018 16:02:11 -0500
MIME-Version: 1.0
In-Reply-To: <20180915161035.7859-1-programmingkidx@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] qemu-img.c: add help for each command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Arbuckle <programmingkidx@gmail.com>, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org

On 9/15/18 11:10 AM, John Arbuckle wrote:
> Add the ability for the user to display help for a certain command.
> Example: qemu-img create --help
> 
> What is printed is all the options available to this command and an example.
> 
> Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
> ---
> v2 changes:
> Removed block of string comparison code for each command.
> Added a help_func field to the img_cmd_t struct.
> Made strings longer than 80 characters wide.
> 
>   qemu-img.c | 659 +++++++++++++++++++++++++++++++++++++++++++++++++++----------
>   1 file changed, 558 insertions(+), 101 deletions(-)

This is a pretty big patch to review in one sitting. Is it possible for 
you to divide it into smaller portions?

> 
> diff --git a/qemu-img.c b/qemu-img.c
> index 1acddf693c..7b9f6101b3 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -52,6 +52,7 @@
>   typedef struct img_cmd_t {
>       const char *name;
>       int (*handler)(int argc, char **argv);
> +    void (*help_func)(void);
>   } img_cmd_t;

Perhaps by an initial patch that adds .help_func but permits it be NULL 
(falling back to full normal help for commands not yet converted); then 
converts one command per patch, and finally requires .help_func to be 
non-NULL.


>   
> -/* Please keep in synch with qemu-img.texi */

Why did this comment disappear?

> -static void QEMU_NORETURN help(void)
> +/* Prints an overview of available help options */
> +static void help(void)
>   {
>       const char *help_msg =
> -           QEMU_IMG_VERSION
> -           "usage: qemu-img [standard options] command [command options]\n"
> -           "QEMU disk image utility\n"
> -           "\n"
> -           "    '-h', '--help'       display this help and exit\n"
> -           "    '-V', '--version'    output version information and exit\n"
...
> -    printf("%s\nSupported formats:", help_msg);
> -    bdrv_iterate_format(format_print, NULL);
> -    printf("\n\n" QEMU_HELP_BOTTOM "\n");
> -    exit(EXIT_SUCCESS);
> +    QEMU_IMG_VERSION
> +    "usage: qemu-img [standard options] command [command options]\n"
> +    "QEMU disk image utility\n"
> +    "\n"
> +    "    '-h', '--help'       display this help and exit\n"
> +    "    '-V', '--version'    output version information and exit\n"
> +    "    '-T', '--trace'      [[enable=]<pattern>][,events=<file>][,file=<file>]\n"

Why the re-indentation? That also makes it slightly harder to review.

> +    "                         specify tracing options\n"
> +    "\n"
> +    "Command:\n"
> +    "\tamend              Change options of an existing disk image\n"
> +    "\tbench              Run benchmarks on a given disk image\n"
> +    "\tcheck              Check the disk image for consistency or repair it\n"
> +    "\tcommit             Merge the disk image into its backing file\n"
> +    "\tcompare            Check if two images have the same content\n"
> +    "\tconvert            Convert an image file or snapshot into another file\n"
> +    "\tcreate             Create a new disk image\n"
> +    "\tdd                 Copies and converts an input file into another file\n"
> +    "\tinfo               Gives information about the specified image file\n"
> +    "\tmap                Dump the metadata of image filename\n"
> +    "\tmeasure            Calculate the file size required for a new image\n"
> +    "\tsnapshot           List, apply, create or delete snapshots in a file\n"
> +    "\trebase             Changes the backing file of an image file\n"
> +    "\tresize             Resize an image file\n"
> +    "\n\nRun 'qemu-img <command> --help' for details.\n"

I'd spell this:

"\n"
"\n"
"Run ...\n"

(that is, exactly one \n per line, always as the last thing in a string, 
so that it is easier to see in the source how line-breaks will be added 
in the output)

> +    "See <https://qemu.org/contribute/report-a-bug> for how to report bugs.\n"
> +    "More information on the QEMU project at <https://qemu.org>.\n";
> +    printf("%s\n", help_msg);
> +}
> +
> +static void help_amend(void)
> +{
> +    const char *msg =
> +    "\n"
> +    "usage: qemu-img amend [--object objectdef] [--image-opts] [-p] [-q] [-f fmt]\n"
> +    "[-t cache] -o options filename\n"

Why no indentation on the continued option line?

At this point, I'm skipping the various individual commands (as I didn't 
have time to check each one for accuracy - again, an argument that 
splitting into a series that converts one command per patch may be 
easier to review than doing wholesale conversion in a single patch), and 
moving on to the real thing that stood out to me.

> @@ -4886,7 +5326,7 @@ out:
>       return ret;
>   }
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

No. That is too hideous.  You are adding way too much maintainer burden 
to remember to keep multiple distinct lists in sync.

PLEASE instead fix things so that "qemu-img-cmds.h" redefines DEF() to 
add a new parameter (namely, the function callback to install in the 
.help_func slot), then fix all callers that include qemu-img-cmds.h to 
update their DEF macros in context.  And, if you take my advice at 
splitting the series, then you will start by having things like:

DEF("map", img_map, NULL,
"map [--object objectdef] [--image-opts] [-f fmt] [--output=ofmt] [-U] 
filename")

at the beginning (when 'qemu-img map --help' still defers to global 
help, because it hasn't been converted yet), then shift over to:

DEF("map", img_map, help_map,
"map [--object objectdef] [--image-opts] [-f fmt] [--output=ofmt] [-U] 
filename")

by the end of the series.  Also, this would be a NICE opportunity to 
avoid redundancy - if DEF() always includes the synopsis line, then your 
various .help_func callbacks should not have to repeat that line in the 
C code, but rather, add a .synopsis member to struct img_cmd_t and have 
the definition of DEF() populate it directly.

>   
> +    /* Add all the help functions to the array */
> +    int i;
> +    for (i = 0; i < ARRAY_SIZE(help_functions); i++) {
> +        img_cmds[i].help_func = help_functions[i];
> +    }

Again, THIS approach to initializing things is dead wrong.  Do the 
initialization via the DEF() macro surrounding the inclusion of 
qemu-img-cmds.h.

> +
>       /* find the command */
>       for (cmd = img_cmds; cmd->name != NULL; cmd++) {
>           if (!strcmp(cmdname, cmd->name)) {
> -            return cmd->handler(argc, argv);
> +            if (strcmp("--help", argv[optind + 1]) == 0) {

Dumps core on './qemu-img convert'.  You can't blindly assume 
argv[optind + 1] is non-NULL.

Also, your approach only recognizes --help if it is the first option. 
But it would be even friendlier if ALL of the cmd->handler()s could also 
recognize --help in any position, as in 'qemu-img convert -f qcow2 
--help' (where I've typed a partial command line, then realized I want 
help writing the rest, but don't want to delete what I've got so far 
just to get the help).

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
