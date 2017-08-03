Received: from eggs.gnu.org ([2001:4830:134:3::10]:58085)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ddIsZ-0007Zl-R6
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 12:21:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ddIsY-0004ne-DW
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 12:21:43 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170728164708.12202-1-eblake@redhat.com>
	<20170728164708.12202-5-eblake@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <3ea4c7f5-0e5f-e8f5-1ee0-eb6b5ea4c2e2@amsat.org>
Date: Thu, 3 Aug 2017 13:21:31 -0300
MIME-Version: 1.0
In-Reply-To: <20170728164708.12202-5-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 4/4] maint: Include bug-reporting info
 in --help output.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-block@nongnu.org, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, mreitz@redhat.com, pbonzini@redhat.com

On 07/28/2017 01:47 PM, Eric Blake wrote:
> These days, many programs are including a bug-reporting address,
> or better yet, a link to the project web site, at the tail of
> their --help output.  However, we were not very consistent at
> doing so: only qemu-nbd and qemu-qa mentioned anything, with the
> latter pointing to an individual person instead of the project.
> 
> Add a new #define that sets up a uniform string, mentioning both
> bug reporting instructions and overall project details, and which
> a downstream vendor could tweak if they want bugs to go to a
> downstream database.  Then use it in all of our binaries which
> have --help output.
> 
> The canned text intentionally references http:// instead of https://
> because our https website currently causes certificate errors in
> some browsers.  That can be tweaked later once we have resolved the
> web site issued.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
> 
> v2: tweak text to capitalize QEMU and use consistent trailing .
> 
>   include/qemu-common.h | 5 +++++
>   vl.c                  | 4 +++-
>   bsd-user/main.c       | 2 ++
>   linux-user/main.c     | 4 +++-
>   qemu-img.c            | 2 +-
>   qemu-io.c             | 5 +++--
>   qemu-nbd.c            | 2 +-
>   qga/main.c            | 2 +-
>   8 files changed, 19 insertions(+), 7 deletions(-)
> 
> diff --git a/include/qemu-common.h b/include/qemu-common.h
> index b5adbfa5e9..d29045631f 100644
> --- a/include/qemu-common.h
> +++ b/include/qemu-common.h
> @@ -22,6 +22,11 @@
>   #define QEMU_COPYRIGHT "Copyright (c) 2003-2017 " \
>       "Fabrice Bellard and the QEMU Project developers"
> 
> +/* Bug reporting information for --help arguments, About dialogs, etc */
> +#define QEMU_BUGREPORTS \
> +    "See <http://qemu.org/contribute/report-a-bug> for bug reports.\n" \
> +    "More information on the QEMU project at <http://qemu.org>."
> +
>   /* main function, renamed */
>   #if defined(CONFIG_COCOA)
>   int qemu_main(int argc, char **argv, char **envp);
> diff --git a/vl.c b/vl.c
> index fb6b2efafa..b824f81f64 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -1942,7 +1942,9 @@ static void help(int exitcode)
>              "ctrl-alt-n      switch to virtual console 'n'\n"
>              "ctrl-alt        toggle mouse and keyboard grab\n"
>              "\n"
> -           "When using -nographic, press 'ctrl-a h' to get some help.\n");
> +           "When using -nographic, press 'ctrl-a h' to get some help.\n"
> +           "\n"
> +           QEMU_BUGREPORTS "\n");
> 
>       exit(exitcode);
>   }
> diff --git a/bsd-user/main.c b/bsd-user/main.c
> index 501e16f675..4db10cb376 100644
> --- a/bsd-user/main.c
> +++ b/bsd-user/main.c
> @@ -686,6 +686,8 @@ static void usage(void)
>              "    -E var1=val2 -E var2=val2 -U LD_PRELOAD -U LD_DEBUG\n"
>              "Note that if you provide several changes to single variable\n"
>              "last change will stay in effect.\n"
> +           "\n"
> +           QEMU_BUGREPORTS "\n"
>              ,
>              TARGET_NAME,
>              interp_prefix,
> diff --git a/linux-user/main.c b/linux-user/main.c
> index 2b38d39d87..7d6e481277 100644
> --- a/linux-user/main.c
> +++ b/linux-user/main.c
> @@ -4136,7 +4136,9 @@ static void usage(int exitcode)
>              "    -E var1=val2,var2=val2 -U LD_PRELOAD,LD_DEBUG\n"
>              "    QEMU_SET_ENV=var1=val2,var2=val2 QEMU_UNSET_ENV=LD_PRELOAD,LD_DEBUG\n"
>              "Note that if you provide several changes to a single variable\n"
> -           "the last change will stay in effect.\n");
> +           "the last change will stay in effect.\n"
> +           "\n"
> +           QEMU_BUGREPORTS "\n");
> 
>       exit(exitcode);
>   }
> diff --git a/qemu-img.c b/qemu-img.c
> index f4d5f0d77d..758719e083 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -201,7 +201,7 @@ static void QEMU_NORETURN help(void)
> 
>       printf("%s\nSupported formats:", help_msg);
>       bdrv_iterate_format(format_print, NULL);
> -    printf("\n");
> +    printf("\n\n" QEMU_BUGREPORTS "\n");
>       exit(EXIT_SUCCESS);
>   }
> 
> diff --git a/qemu-io.c b/qemu-io.c
> index ec175630a6..b93553a603 100644
> --- a/qemu-io.c
> +++ b/qemu-io.c
> @@ -262,8 +262,9 @@ static void usage(const char *name)
>   "  -h, --help           display this help and exit\n"
>   "  -V, --version        output version information and exit\n"
>   "\n"
> -"See '%s -c help' for information on available commands."
> -"\n",
> +"See '%s -c help' for information on available commands.\n"
> +"\n"
> +QEMU_BUGREPORTS "\n",
>       name, name);
>   }
> 
> diff --git a/qemu-nbd.c b/qemu-nbd.c
> index b8666bb575..052eb4d067 100644
> --- a/qemu-nbd.c
> +++ b/qemu-nbd.c
> @@ -123,7 +123,7 @@ static void usage(const char *name)
>   "      --detect-zeroes=MODE  set detect-zeroes mode (off, on, unmap)\n"
>   "      --image-opts          treat FILE as a full set of image options\n"
>   "\n"
> -"Report bugs to <qemu-devel@nongnu.org>\n"
> +QEMU_BUGREPORTS "\n"
>       , name, NBD_DEFAULT_PORT, "DEVICE");
>   }
> 
> diff --git a/qga/main.c b/qga/main.c
> index b64c7ac2a2..56d5633c13 100644
> --- a/qga/main.c
> +++ b/qga/main.c
> @@ -249,7 +249,7 @@ QEMU_COPYRIGHT "\n"
>   "                    options / command-line parameters to stdout\n"
>   "  -h, --help        display this help and exit\n"
>   "\n"
> -"Report bugs to <mdroth@linux.vnet.ibm.com>\n"
> +QEMU_BUGREPORTS "\n"
>       , cmd, QGA_VIRTIO_PATH_DEFAULT, QGA_SERIAL_PATH_DEFAULT,
>       dfl_pathnames.pidfile,
>   #ifdef CONFIG_FSFREEZE
> 
