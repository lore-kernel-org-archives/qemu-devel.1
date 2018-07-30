Received: from eggs.gnu.org ([2001:4830:134:3::10]:50971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fkE9m-0001Wd-5D
	for Qemu-devel@nongnu.org; Mon, 30 Jul 2018 15:48:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fkE9i-0003F7-1K
	for Qemu-devel@nongnu.org; Mon, 30 Jul 2018 15:48:38 -0400
References: <20180730191447.14176-1-programmingkidx@gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <10f6c96f-384f-3b4a-103e-57408f20aeb8@redhat.com>
Date: Mon, 30 Jul 2018 14:48:30 -0500
MIME-Version: 1.0
In-Reply-To: <20180730191447.14176-1-programmingkidx@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] Add interactive mode to
 qemu-img command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Arbuckle <programmingkidx@gmail.com>, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, "Qemu-devel@nongnu.org" <Qemu-devel@nongnu.org>, John Snow <jsnow@redhat.com>

On 07/30/2018 02:14 PM, John Arbuckle wrote:
> Changes qemu-img so if the user runs it without any
> arguments, it will walk the user thru making an image
> file.

Please remember to cc qemu-devel on ALL patches, as suggested by 
./scripts/getmaintainer.pl.

> 
> Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
> ---
>   qemu-img.c | 31 +++++++++++++++++++++++++++++--
>   1 file changed, 29 insertions(+), 2 deletions(-)
> 

Missing documentation patches (at a minimum, 'man qemu-img' should be 
updated to mention this new mode of operation).  I'm also going to be a 
stickler and require an addition to tests/qemu-iotests to ensure this 
new feature gets coverage and doesn't regress (at least, if others are 
even in favor of the idea. Personally, I'm 60-40 against the bloat, as 
telling the user to read --help is sufficient in my mind).

> diff --git a/qemu-img.c b/qemu-img.c
> index 9b7506b8ae..aa3df3b431 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -4873,6 +4873,32 @@ out:
>       return ret;
>   }
>   
> +/* Guides the user on making an image file */
> +static int interactive_mode()
> +{
> +    char format[100];
> +    char size[100];
> +    char name[1000];

Eww. Fixed size buffers for user-provided input are evil.  getline() is 
your friend.

> +
> +    printf("\nInteractive mode (Enter Control-C to cancel)\n");
> +    printf("Please select a format (qcow, qcow2, raw, vdi, vhdx, vmdk, vpc): ");

Incomplete.  Better to generate the list dynamically by iterating over 
the QAPI enum than it is to hard-code an incomplete list - particularly 
since distros can white- or black-list particular drivers.

> +    scanf("%100s", format);

Eww. Repeating the limit of your fixed size buffer, without checking 
that you actually read a complete line, or that the scanf actually 
succeeded in reading.  That's dangerous if a later programmer changes 
one but not both of the two lines that are supposed to be using the same 
fixed size.  Even if we accept the direction that this patch is heading 
in, it would need to be done using more robust code.

> +    printf("Please enter a size (e.g. 100M, 10G): ");
> +    scanf("%100s", size);
> +    printf("Please enter a name: ");
> +    scanf("%1000s", name);

A limit of 1000 has no bearing on actual file name lengths; a more 
typical limit of NAME_MAX and/or PATH_MAX may come into play first (as 
low as 256 on many systems, but on some systems, that value is 
intentionally undefined because there is no inherent limit).  Again, you 
should be using getline() and malloc'ing your result rather than using 
arbitrary (and probably wrong-size) fixed-size buffers.

> +
> +    const char *arguments[] = {"create", "-f", format, name, size};

Although this is valid C99, qemu tends to prefer that you declare all 
variables at the start of the scope rather than after statements.

You did not do ANY error checking that you actually parsed arguments 
from the user; that in turn could result in passing bogus arguments on 
to img_create() that could not normally happen via command line usage.

Why are you hard-coding a create, rather than going FULLY interactive 
and asking the user which sub-command (create, compare, ...) that they 
want to use?  Note that if we do want the level of interactivity to 
encompass the choice of subcommand, that you still need to make things 
programmatic, not hard-coded.  Also, John Snow had started some work on 
making qemu-img.c and associated documentation saner, including making 
subcommands more uniform; you may want to rebase your work on top of his 
cleanups, if there is even demand for this.

> +    int arg_count = 5;
> +    int return_value;
> +    return_value = img_create(arg_count, (char **)arguments);

Can we come up with a way to not have to cast away the const, if we are 
locally supplying the arguments?

> +    if (return_value == 0) {
> +        printf("Done creating image file\n");
> +    }
> +
> +    return return_value;
> +}
> +
>   static const img_cmd_t img_cmds[] = {
>   #define DEF(option, callback, arg_string)        \
>       { option, callback },
> @@ -4912,8 +4938,9 @@ int main(int argc, char **argv)
>   
>       module_call_init(MODULE_INIT_QOM);
>       bdrv_init();
> -    if (argc < 2) {
> -        error_exit("Not enough arguments");
> +
> +    if (argc == 1) { /* If no arguments passed to qemu-img */
> +        return interactive_mode();

This is placed early-enough in main() that you never use interactive 
mode if the user passed options but no subcommand (such as 'qemu-img -T 
foo'), is that intentional?  Conversely, your patch does not help if a 
user calls 'qemu-img create' without options, while it can be argued 
that if we want (partial) interactivity, why not be nice to the user and 
provide it at any step of the way rather than just when no subcommand 
name was given.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
