Received: from eggs.gnu.org ([2001:4830:134:3::10]:60087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1df2P2-0008MP-9g
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 07:10:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1df2P0-0004Cq-Rc
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 07:10:24 -0400
References: <20170726140218.15904-1-eblake@redhat.com>
	<20170726140218.15904-4-eblake@redhat.com>
	<877eye48u5.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <37d0bf59-d7f8-4c08-f5b5-d89be0ea1f6e@redhat.com>
Date: Tue, 8 Aug 2017 13:09:57 +0200
MIME-Version: 1.0
In-Reply-To: <877eye48u5.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/3] maint: Include bug-reporting info in
 --help output.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>, Michael Roth <mdroth@linux.vnet.ibm.com>, Laurent Vivier <laurent@vivier.eu>, Max Reitz <mreitz@redhat.com>

On 08/08/2017 13:06, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
> 
>> These days, many programs are including a bug-reporting address,
>> or better yet, a link to the project web site, at the tail of
>> their --help output.  However, we were not very consistent at
>> doing so: only qemu-nbd and qemu-qa mentioned anything, with the
>> latter pointing to an individual person instead of the project.
>>
>> Add a new #define that sets up a uniform string, mentioning both
>> bug reporting instructions and overall project details, and which
>> a downstream vendor could tweak if they want bugs to go to a
>> downstream database.  Then use it in all of our binaries which
>> have --help output.
>>
>> The canned text intentionally references http:// instead of https://
>> because our https website currently causes certificate errors in
>> some browsers.  That can be tweaked later once we have resolved the
>> web site issued.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---
>>  include/qemu-common.h | 5 +++++
>>  vl.c                  | 4 +++-
>>  bsd-user/main.c       | 2 ++
>>  linux-user/main.c     | 4 +++-
>>  qemu-img.c            | 2 +-
>>  qemu-io.c             | 5 +++--
>>  qemu-nbd.c            | 2 +-
>>  qga/main.c            | 2 +-
>>  8 files changed, 19 insertions(+), 7 deletions(-)
>>
>> diff --git a/include/qemu-common.h b/include/qemu-common.h
>> index b5adbfa5e9..e751361458 100644
>> --- a/include/qemu-common.h
>> +++ b/include/qemu-common.h
>> @@ -22,6 +22,11 @@
>>  #define QEMU_COPYRIGHT "Copyright (c) 2003-2017 " \
>>      "Fabrice Bellard and the QEMU Project developers"
>>
>> +/* Bug reporting information for --help arguments, About dialogs, etc */
>> +#define QEMU_BUGREPORTS \
>> +    "See <http://qemu.org/contribute/report-a-bug> for bug reports.\n" \
> 
> "See ... for bug reports" sounds like it's about browsing existing bugs.
> The web page is actually about reporting bugs.  What about "for how to
> report bugs"?
> 
> Since I'm basically bikeshedding already: the macro expands into more
> than just bug reporting.  Call it QEMU_HELP_BOTTOM?  Feel free to ignore
> this one.

Easily squashed:

diff --git a/bsd-user/main.c b/bsd-user/main.c
index 4db10cb376..8a6706a1c8 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -687,7 +687,7 @@ static void usage(void)
            "Note that if you provide several changes to single variable\n"
            "last change will stay in effect.\n"
            "\n"
-           QEMU_BUGREPORTS "\n"
+           QEMU_HELP_BOTTOM "\n"
            ,
            TARGET_NAME,
            interp_prefix,
diff --git a/include/qemu-common.h b/include/qemu-common.h
index d29045631f..0456c79df4 100644
--- a/include/qemu-common.h
+++ b/include/qemu-common.h
@@ -23,8 +23,8 @@
     "Fabrice Bellard and the QEMU Project developers"
 
 /* Bug reporting information for --help arguments, About dialogs, etc */
-#define QEMU_BUGREPORTS \
-    "See <http://qemu.org/contribute/report-a-bug> for bug reports.\n" \
+#define QEMU_HELP_BOTTOM \
+    "See <http://qemu.org/contribute/report-a-bug> for how to report bugs.\n" \
     "More information on the QEMU project at <http://qemu.org>."
 
 /* main function, renamed */
diff --git a/linux-user/main.c b/linux-user/main.c
index 7d6e481277..03666ef657 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -4138,7 +4138,7 @@ static void usage(int exitcode)
            "Note that if you provide several changes to a single variable\n"
            "the last change will stay in effect.\n"
            "\n"
-           QEMU_BUGREPORTS "\n");
+           QEMU_HELP_BOTTOM "\n");
 
     exit(exitcode);
 }
diff --git a/qemu-img.c b/qemu-img.c
index 758719e083..56ef49e214 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -201,7 +201,7 @@ static void QEMU_NORETURN help(void)
 
     printf("%s\nSupported formats:", help_msg);
     bdrv_iterate_format(format_print, NULL);
-    printf("\n\n" QEMU_BUGREPORTS "\n");
+    printf("\n\n" QEMU_HELP_BOTTOM "\n");
     exit(EXIT_SUCCESS);
 }
 
diff --git a/qemu-io.c b/qemu-io.c
index b93553a603..265445ad89 100644
--- a/qemu-io.c
+++ b/qemu-io.c
@@ -264,7 +264,7 @@ static void usage(const char *name)
 "\n"
 "See '%s -c help' for information on available commands.\n"
 "\n"
-QEMU_BUGREPORTS "\n",
+QEMU_HELP_BOTTOM "\n",
     name, name);
 }
 
diff --git a/qemu-nbd.c b/qemu-nbd.c
index 052eb4d067..27164b8205 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -123,7 +123,7 @@ static void usage(const char *name)
 "      --detect-zeroes=MODE  set detect-zeroes mode (off, on, unmap)\n"
 "      --image-opts          treat FILE as a full set of image options\n"
 "\n"
-QEMU_BUGREPORTS "\n"
+QEMU_HELP_BOTTOM "\n"
     , name, NBD_DEFAULT_PORT, "DEVICE");
 }
 
diff --git a/qga/main.c b/qga/main.c
index 56d5633c13..62a62755bd 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -249,7 +249,7 @@ QEMU_COPYRIGHT "\n"
 "                    options / command-line parameters to stdout\n"
 "  -h, --help        display this help and exit\n"
 "\n"
-QEMU_BUGREPORTS "\n"
+QEMU_HELP_BOTTOM "\n"
     , cmd, QGA_VIRTIO_PATH_DEFAULT, QGA_SERIAL_PATH_DEFAULT,
     dfl_pathnames.pidfile,
 #ifdef CONFIG_FSFREEZE
diff --git a/vl.c b/vl.c
index 3b53de725c..8e247cc2a2 100644
--- a/vl.c
+++ b/vl.c
@@ -1944,7 +1944,7 @@ static void help(int exitcode)
            "\n"
            "When using -nographic, press 'ctrl-a h' to get some help.\n"
            "\n"
-           QEMU_BUGREPORTS "\n");
+           QEMU_HELP_BOTTOM "\n");
 
     exit(exitcode);
 }

>> +    "More information on the qemu project at <http://qemu.org>"
> 
> "QEMU project"

This one is already fixed in the next version of the patchset.

Paolo

>> +
>>  /* main function, renamed */
>>  #if defined(CONFIG_COCOA)
>>  int qemu_main(int argc, char **argv, char **envp);
> 
> Getting late for 2.10, but it's such a lovely little improvement...
> 
