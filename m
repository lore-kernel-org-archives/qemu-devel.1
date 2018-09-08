Received: from eggs.gnu.org ([2001:4830:134:3::10]:59882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1fyTVZ-0002jZ-Fz
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 23:02:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1fyTVW-0004a6-Ph
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 23:02:01 -0400
From: John Arbuckle <programmingkidx@gmail.com>
Date: Fri,  7 Sep 2018 23:01:36 -0400
Message-Id: <20180908030136.844-1-programmingkidx@gmail.com>
Subject: [Qemu-devel] [PATCH] qemu-img.c: add help for each command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: John Arbuckle <programmingkidx@gmail.com>

Add the ability for the user to display help for a certain command. 
Example: qemu-img create --help

What is printed is all the options available to this command and an example.

Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
---
 qemu-img.c | 767 +++++++++++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 668 insertions(+), 99 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index b12f4cd..5eb38b8 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -76,11 +76,6 @@ typedef enum OutputFormat {
 /* Default to cache=writeback as data integrity is not important for qemu-img */
 #define BDRV_DEFAULT_CACHE "writeback"
 
-static void format_print(void *opaque, const char *name)
-{
-    printf(" %s", name);
-}
-
 static void QEMU_NORETURN GCC_FMT_ATTR(1, 2) error_exit(const char *fmt, ...)
 {
     va_list ap;
@@ -105,102 +100,639 @@ static void QEMU_NORETURN unrecognized_option(const char *option)
     error_exit("unrecognized option '%s'", option);
 }
 
-/* Please keep in synch with qemu-img.texi */
-static void QEMU_NORETURN help(void)
+/* Prints an overview of available help options */
+static void help(void)
 {
     const char *help_msg =
-           QEMU_IMG_VERSION
-           "usage: qemu-img [standard options] command [command options]\n"
-           "QEMU disk image utility\n"
-           "\n"
-           "    '-h', '--help'       display this help and exit\n"
-           "    '-V', '--version'    output version information and exit\n"
-           "    '-T', '--trace'      [[enable=]<pattern>][,events=<file>][,file=<file>]\n"
-           "                         specify tracing options\n"
-           "\n"
-           "Command syntax:\n"
-#define DEF(option, callback, arg_string)        \
-           "  " arg_string "\n"
-#include "qemu-img-cmds.h"
-#undef DEF
-           "\n"
-           "Command parameters:\n"
-           "  'filename' is a disk image filename\n"
-           "  'objectdef' is a QEMU user creatable object definition. See the qemu(1)\n"
-           "    manual page for a description of the object properties. The most common\n"
-           "    object type is a 'secret', which is used to supply passwords and/or\n"
-           "    encryption keys.\n"
-           "  'fmt' is the disk image format. It is guessed automatically in most cases\n"
-           "  'cache' is the cache mode used to write the output disk image, the valid\n"
-           "    options are: 'none', 'writeback' (default, except for convert), 'writethrough',\n"
-           "    'directsync' and 'unsafe' (default for convert)\n"
-           "  'src_cache' is the cache mode used to read input disk images, the valid\n"
-           "    options are the same as for the 'cache' option\n"
-           "  'size' is the disk image size in bytes. Optional suffixes\n"
-           "    'k' or 'K' (kilobyte, 1024), 'M' (megabyte, 1024k), 'G' (gigabyte, 1024M),\n"
-           "    'T' (terabyte, 1024G), 'P' (petabyte, 1024T) and 'E' (exabyte, 1024P)  are\n"
-           "    supported. 'b' is ignored.\n"
-           "  'output_filename' is the destination disk image filename\n"
-           "  'output_fmt' is the destination format\n"
-           "  'options' is a comma separated list of format specific options in a\n"
-           "    name=value format. Use -o ? for an overview of the options supported by the\n"
-           "    used format\n"
-           "  'snapshot_param' is param used for internal snapshot, format\n"
-           "    is 'snapshot.id=[ID],snapshot.name=[NAME]', or\n"
-           "    '[ID_OR_NAME]'\n"
-           "  '-c' indicates that target image must be compressed (qcow format only)\n"
-           "  '-u' allows unsafe backing chains. For rebasing, it is assumed that old and\n"
-           "       new backing file match exactly. The image doesn't need a working\n"
-           "       backing file before rebasing in this case (useful for renaming the\n"
-           "       backing file). For image creation, allow creating without attempting\n"
-           "       to open the backing file.\n"
-           "  '-h' with or without a command shows this help and lists the supported formats\n"
-           "  '-p' show progress of command (only certain commands)\n"
-           "  '-q' use Quiet mode - do not print any output (except errors)\n"
-           "  '-S' indicates the consecutive number of bytes (defaults to 4k) that must\n"
-           "       contain only zeros for qemu-img to create a sparse image during\n"
-           "       conversion. If the number of bytes is 0, the source will not be scanned for\n"
-           "       unallocated or zero sectors, and the destination image will always be\n"
-           "       fully allocated\n"
-           "  '--output' takes the format in which the output must be done (human or json)\n"
-           "  '-n' skips the target volume creation (useful if the volume is created\n"
-           "       prior to running qemu-img)\n"
-           "\n"
-           "Parameters to check subcommand:\n"
-           "  '-r' tries to repair any inconsistencies that are found during the check.\n"
-           "       '-r leaks' repairs only cluster leaks, whereas '-r all' fixes all\n"
-           "       kinds of errors, with a higher risk of choosing the wrong fix or\n"
-           "       hiding corruption that has already occurred.\n"
-           "\n"
-           "Parameters to convert subcommand:\n"
-           "  '-m' specifies how many coroutines work in parallel during the convert\n"
-           "       process (defaults to 8)\n"
-           "  '-W' allow to write to the target out of order rather than sequential\n"
-           "\n"
-           "Parameters to snapshot subcommand:\n"
-           "  'snapshot' is the name of the snapshot to create, apply or delete\n"
-           "  '-a' applies a snapshot (revert disk to saved state)\n"
-           "  '-c' creates a snapshot\n"
-           "  '-d' deletes a snapshot\n"
-           "  '-l' lists all snapshots in the given image\n"
-           "\n"
-           "Parameters to compare subcommand:\n"
-           "  '-f' first image format\n"
-           "  '-F' second image format\n"
-           "  '-s' run in Strict mode - fail on different image size or sector allocation\n"
-           "\n"
-           "Parameters to dd subcommand:\n"
-           "  'bs=BYTES' read and write up to BYTES bytes at a time "
-           "(default: 512)\n"
-           "  'count=N' copy only N input blocks\n"
-           "  'if=FILE' read from FILE\n"
-           "  'of=FILE' write to FILE\n"
-           "  'skip=N' skip N bs-sized blocks at the start of input\n";
-
-    printf("%s\nSupported formats:", help_msg);
-    bdrv_iterate_format(format_print, NULL);
-    printf("\n\n" QEMU_HELP_BOTTOM "\n");
-    exit(EXIT_SUCCESS);
+    QEMU_IMG_VERSION
+    "usage: qemu-img [standard options] command [command options]\n"
+    "QEMU disk image utility\n"
+    "\n"
+    "    '-h', '--help'       display this help and exit\n"
+    "    '-V', '--version'    output version information and exit\n"
+    "    '-T', '--trace'      [[enable=]<pattern>][,events=<file>][,file=<file>]\n"
+    "                         specify tracing options\n"
+    "\n"
+    "Command:\n"
+    "\tamend              Change options of an existing disk image\n"
+    "\tbench              Run benchmarks on a given disk image\n"
+    "\tcheck              Check the disk image for consistency or repair it\n"
+    "\tcommit             Merge the disk image into its backing file\n"
+    "\tcompare            Check if two images have the same content\n"
+    "\tconvert            Convert an image file or snapshot into another file\n"
+    "\tcreate             Create a new disk image\n"
+    "\tdd                 Copies and converts an input file into another file\n"
+    "\tinfo               Gives information about the specified image file\n"
+    "\tmap                Dump the metadata of image filename\n"
+    "\tmeasure            Calculate the file size required for a new image\n"
+    "\tsnapshot           List, apply, create or delete snapshots in a file\n"
+    "\trebase             Changes the backing file of an image file\n"
+    "\tresize             Resize an image file\n"
+    "\n\nRun 'qemu-img <command> --help' for details.\n"
+    "See <https://qemu.org/contribute/report-a-bug> for how to report bugs.\n"
+    "More information on the QEMU project at <https://qemu.org>.\n";
+    printf("%s\n", help_msg);
+}
+
+static void help_amend(void)
+{
+    const char *msg =
+    "\n"
+    "usage: qemu-img amend [--object objectdef] [--image-opts] [-p] [-q] [-f fm"
+    "t]\n"
+    "[-t cache] -o options filename\n"
+    "\n"
+    "Command parameters:\n"
+    " -f             The format of the image file.\n"
+    "\n"
+    "--image-opts    Treat filename as a set of image options, instead of a pla"
+    "in\n"
+    "                filename.\n"
+    "\n"
+    " -o             Used with a comma separated list of format specific option"
+    "s in a\n"
+    "                name=value format. Use \"-o help\" for an overview of the "
+    "options\n"
+    "                supported by the used format.\n"
+    "\n"
+    "--object        \'objectdef\' is a QEMU user creatable object definition. "
+    "See the\n"
+    "                qemu(1) manual page for a description of the object proper"
+    "ties.\n"
+    "                The most common object type is a \'secret\', which is used"
+    " to\n"
+    "                supply passwords and/or encryption keys.\n"
+    "\n"
+    " -p             Display progress bar. If the -p option is not used for a c"
+    "ommand\n"
+    "                that supports it, the progress is reported when the proces"
+    "s\n"
+    "                receives a \"SIGUSR1\" signal. Avoid using with the -q opt"
+    "ion.\n"
+    "\n"
+    " -q             Quiet mode - do not print any output (except errors). Avoi"
+    "d\n"
+    "                using with the -p option.\n"
+    "\n"
+    " -t             Specifies the cache mode that should be used with the\n"
+    "                destination file. Options are: none, writeback, writethrou"
+    "gh,\n"
+    "                directsync, and unsafe.\n"
+    "\n"
+    "Example:\n"
+    "    qemu-img amend -o compat=v3 -f qcow2 image.qcow2\n"
+    "    qemu-img amend --object secret,id=sec0,data=test --image-opts \\\n"
+    "    driver=luks,key-secret=sec0,file.filename=test.luks -o size=2G\n"
+    "\n"
+    "\n";
+    printf("%s", msg);
+}
+
+static void help_bench(void)
+{
+    const char *msg =
+    "\n"
+    "usage: qemu-img bench [-c count] [-d depth] [-f fmt]\n"
+    "[--flush-interval=flush_interval] [-n] [--no-drain] [-o offset]\n"
+    "[--pattern=pattern] [-q] [-s buffer_size] [-S step_size] [-t cache] [-w] ["
+    "-U]\n"
+    "filename\n"
+    "\n"
+    "Command parameters:\n"
+    " -c                  Number of I/O requests to perform.\n"
+    "\n"
+    " -d                  Number of I/O requests done in parallel.\n"
+    "\n"
+    " -f                  The format of the image file.\n"
+    "\n"
+    " --flush-interval    How often a flush should take place.\n"
+    "\n"
+    " -n                  Use native AIO backend if possible.\n"
+    "\n"
+    " --no-drain          Issue a flush without draining the request queue firs"
+    "t.\n"
+    "\n"
+    " -o                  The starting position.\n"
+    "\n"
+    " --pattern           The byte pattern used to in write tests.\n"
+    "\n"
+    " -q                  Quiet mode - do not print any output (except errors)."
+    "\n"
+    "                     There\'s no progress bar in case both -q and -p optio"
+    "ns are\n"
+    "                     used.\n"
+    "\n"
+    " -s                  buffer_size in bytes.\n"
+    "\n"
+    " -S                  Increases current position by step_size.\n"
+    "\n"
+    " -t                  Specifies the cache mode that should be used with the"
+    "\n"
+    "                     destination file.  Options are: none, writeback,\n"
+    "                     writethrough, directsync, and unsafe.\n"
+    "\n"
+    " -w                  Perform write test.\n"
+    "\n"
+    " -U                  Open the image in shared mode, allowing other QEMU\n"
+    "                     processes to open it in write mode. This option is on"
+    "ly\n"
+    "                     allowed when opening images in read-only mode.\n"
+    "\n"
+    "Example:\n"
+    "    qemu-img bench -c 20000 -d 50000 -f qcow2 image.qcow2\n"
+    "\n"
+    "\n";
+    printf("%s", msg);
+}
+
+static void help_check(void)
+{
+    const char *msg =
+    "\n"
+    "usage: qemu-img check [--object objectdef] [--image-opts] [-q] [-f fmt]\n"
+    "[--output=ofmt] [-r [leaks | all]] [-T src_cache] [-U] filename\n"
+    "\n"
+    "Command parameters:\n"
+    " -f         The format of the image file.\n"
+    "\n"
+    " -q         Use Quiet mode - do not print any output (except errors).\n"
+    "\n"
+    " -r         Tries to repair any inconsistencies that are found during the "
+    "check.\n"
+    "            \'-r leaks\' repairs only cluster leaks, whereas \'-r all\' fi"
+    "xes all\n"
+    "            kinds of errors, with a higher risk of choosing the wrong fix "
+    "or\n"
+    "            hiding corruption that has already occurred.\n"
+    "\n"
+    " -T         \'src_cache\' is the cache mode used to read input disk images"
+    ", the\n"
+    "            valid options are the same as for the \'cache\' option. Option"
+    "s are:\n"
+    "            none, writeback, writethrough, directsync, and unsafe.\n"
+    "\n"
+    " --object   \'objectdef\' is a QEMU user creatable object definition. See "
+    "the\n"
+    "            qemu(1) manual page for a description of the object properties"
+    ". The\n"
+    "            most common object type is a \'secret\', which is used to supp"
+    "ly\n"
+    "            passwords and/or encryption keys.\n"
+    "\n"
+    " --output   \'ofmt\' is \'human\' for human-readable output (default) or "
+    "\'json\' for\n"
+    "            JSON output.\n"
+    "\n"
+    "Example:\n"
+    "    qemu-img check image.qcow2\n"
+    "\n"
+    "\n";
+    printf("%s", msg);
+}
+
+static void help_commit(void)
+{
+    const char *msg =
+    "\n"
+    "usage: qemu-img commit [--object objectdef] [--image-opts] [-q] [-f fmt]\n"
+    "[-t cache] [-b base] [-d] [-p] filename\n"
+    "\n"
+    "Command parameters:\n"
+    " -b            The base image or backing file.\n"
+    "\n"
+    " -d            Skip emptying filename.\n"
+    "\n"
+    " -f            The format of the image file.\n"
+    "\n"
+    " --image-opts  Treat filename as a set of image options, instead of a plai"
+    "n\n"
+    "               filename.\n"
+    "\n"
+    " --object      \'objectdef\' is a QEMU user creatable object definition. S"
+    "ee the\n"
+    "               qemu(1) manual page for a description of the object propert"
+    "ies.\n"
+    "               The most common object type is a \'secret\', which is used "
+    "to\n"
+    "               supply passwords and/or encryption keys.\n"
+    "\n"
+    " -p            Display progress bar. If the -p option is not used for a co"
+    "mmand\n"
+    "               that supports it, the progress is reported when the process"
+    "\n"
+    "               receives a \"SIGUSR1\" signal.\n"
+    "\n"
+    " -q            Quiet mode - do not print any output (except errors). There"
+    "\'s no\n"
+    "               progress bar in case both -q and -p options are used.\n"
+    "\n"
+    " -t            Specifies the cache mode that should be used with the\n"
+    "               destination file.  Options are: none, writeback, writethrou"
+    "gh,\n"
+    "               directsync, and unsafe.\n"
+    "\n"
+    "Example:\n"
+    "    qemu-img commit image.qcow2\n"
+    "\n"
+    "\n";
+    printf("%s", msg);
+}
+
+static void help_compare(void)
+{
+    const char *msg =
+    "\n"
+    "usage: qemu-img compare [--object objectdef] [--image-opts] [-f fmt] [-F f"
+    "mt]\n"
+    "[-T src_cache] [-p] [-q] [-s] [-U] filename1 filename2\n"
+    "\n"
+    "Command parameters:\n"
+    " -f                 First image\'s format.\n"
+    "\n"
+    " -F                 Second image\'s format.\n"
+    "\n"
+    " --image-opts       Treat filename as a set of image options, instead of a"
+    " plain\n"
+    "                    filename.\n"
+    "\n"
+    " -T                 Specifies the cache mode that should be used with the "
+    "source\n"
+    "                    file. Options are: none, writeback, writethrough,\n"
+    "                    directsync, and unsafe.\n"
+    "\n"
+    " --object           \'objectdef\' is a QEMU user creatable object definiti"
+    "on. See\n"
+    "                    the qemu(1) manual page for a description of the objec"
+    "t\n"
+    "                    properties. The most common object type is a \'secret"
+    "\', which\n"
+    "                    is used to supply passwords and/or encryption keys.\n"
+    "\n"
+    " -p                 Display progress bar. If the -p option is not used for"
+    " a\n"
+    "                    command that supports it, the progress is reported whe"
+    "n the\n"
+    "                    process receives a \"SIGUSR1\" signal.\n"
+    "\n"
+    " -q                 Quiet mode - do not print any output (except errors)."
+    "\n"
+    "                    There\'s no progress bar in case both -q and -p option"
+    "s are\n"
+    "                    used.\n"
+    "\n"
+    " -s                 Enable strict mode. Comparisons differ when image size"
+    "s\n"
+    "                    differ or if a sector is allocated in one image and no"
+    "t\n"
+    "                    allocated in the other image.\n"
+    "\n"
+    " -U                 Open the image in shared mode, allowing other QEMU\n"
+    "                    processes to open it in write mode. This option is onl"
+    "y\n"
+    "                    allowed when opening images in read-only mode.\n"
+    "\n"
+    "Example:\n"
+    "    qemu-img compare image1.qcow image2.qcow2\n"
+    "\n"
+    "\n";
+    printf("%s", msg);
+}
+
+static void help_convert(void)
+{
+    const char *msg =
+    "\n"
+    "usage: qemu-img convert [--object objectdef] [--image-opts]\n"
+    "[--target-image-opts] [-U] [-c] [-p] [-q] [-n] [-f fmt] [-t cache]\n"
+    "[-T src_cache] [-O output_fmt] [-B backing_file] [-o options]\n"
+    "[-s snapshot_id_or_name] [-l snapshot_param] [-S sparse_size]\n"
+    "[-m num_coroutines] [-W] filename [filename2 [...]] output_filename\n"
+    "\n"
+    "Command parameters:\n"
+    " -B                      Force the output image to be created as a copy on"
+    " write\n"
+    "                         image of the specified base image.\n"
+    "\n"
+    " -c                      Compress the output image file.\n"
+    "\n"
+    " -f                      The format of the image file.\n"
+    "\n"
+    " --image-opts            Indicates that the source filename parameter is t"
+    "o be\n"
+    "                         interpreted as a full option string, not a plain"
+    "\n"
+    "                         filename.\n"
+    "\n"
+    " -l                      Specifies a snapshot parameter.\n"
+    "\n"
+    " -m                      Number of parallel coroutines for the convert pro"
+    "cess\n"
+    "\n"
+    " -n                      Skip the creation of the target volume.\n"
+    "\n"
+    " -O                      Format of the output file.\n"
+    "\n"
+    " -o                      Allows for specifying options like virtual disk s"
+    "ize.\n"
+    "\n"
+    " --object                \'objectdef\' is a QEMU user creatable object def"
+    "inition.\n"
+    "                         See the qemu(1) manual page for a description of "
+    "the\n"
+    "                         object properties. The most common object type is"
+    " a\n"
+    "                         \'secret\', which is used to supply passwords and"
+    "/or\n"
+    "                         encryption keys.\n"
+    "\n"
+    " -p                      Display progress bar. If the -p option is not use"
+    "d for\n"
+    "                         a command that supports it, the progress is repor"
+    "ted\n"
+    "                         when the process receives a \"SIGUSR1\" signal.\n"
+    "\n"
+    " -q                      Quiet mode - do not print any output (except erro"
+    "rs).\n"
+    "                         There\'s no progress bar in case both -q and -p o"
+    "ptions\n"
+    "                         are used.\n"
+    "\n"
+    " -S                      The consecutive number of bytes (defaults to 4k) "
+    "that\n"
+    "                         must contain only zeros for qemu-img to create a "
+    "sparse\n"
+    "                         image during conversion.\n"
+    "\n"
+    " -s                      The name or ID of the snapshot to use.\n"
+    "\n"
+    " -T                      Specifies the cache mode that should be used with"
+    " the\n"
+    "                         source file.\n"
+    "\n"
+    " -t                      Specifies the cache mode that should be used with"
+    " the\n"
+    "                         destination file. Options are: none, writeback,\n"
+    "                         writethrough, directsync, and unsafe.\n"
+    "\n"
+    "--target-image-opts      Indicates whether the source filename includes op"
+    "tions.\n"
+    "\n"
+    " -U                      Open the image in shared mode, allowing other QEM"
+    "U\n"
+    "                         processes to open it in write mode. This option i"
+    "s only\n"
+    "                         allowed when opening images in read-only mode.\n"
+    "\n"
+    " -W                      Allow out-of-order writes to the destination. Thi"
+    "s\n"
+    "                         option improves performance, but is only recommen"
+    "ded\n"
+    "                         for preallocated devices like host devices or oth"
+    "er raw\n"
+    "                         block devices.\n"
+    "\n"
+    "Example:\n"
+    "    qemu-img convert -f raw -O qcow2 image.img image.qcow2\n"
+    "\n"
+    "\n";
+    printf("%s", msg);
+}
+
+static void help_create(void)
+{
+    const char *msg =
+    "\n"
+    "usage: qemu-img create [--object objectdef] [-q] [-f fmt] [-b backing_file"
+    "]\n"
+    "[-F backing_fmt] [-u] [-o options] filename [size]\n"
+    "\n"
+    "Command parameters:\n"
+    " -b             The backing file used to base the output file on.\n"
+    "\n"
+    " -f             The format of the image file.\n"
+    "\n"
+    " -F             The format of the backing file.\n"
+    "\n"
+    " -u             Create the image file even if the backing file cannot be o"
+    "pened.\n"
+    "\n"
+    " -o             Allows for specifying options like virtual disk size.\n"
+    "\n"
+    "--object        \'objectdef\' is a QEMU user creatable object definition."
+    "\n"
+    "                See the qemu(1) manual page for a description of the\n"
+    "                object properties. The most common object type is a\n"
+    "                \'secret\', which is used to supply passwords and/or\n"
+    "                encryption keys.\n"
+    "\n"
+    "Example:\n"
+    "    qemu-img create -f qcow2 image.qcow2 10G\n"
+    "\n"
+    "\n";
+    printf("%s", msg);
+}
+
+static void help_dd(void)
+{
+    const char *msg =
+    "\n"
+    "usage: qemu-img dd [-f fmt] [-O output_fmt] [bs=block_size] [count=blocks]"
+    "\n"
+    "[skip=blocks] if=input of=output\n"
+    "\n"
+    "Command parameters:\n"
+    " bs                 Size of the blocks used in reading and writing (512 by"
+    "tes is\n"
+    "                    the default).\n"
+    "\n"
+    " count              The limit to how many blocks to read.\n"
+    "\n"
+    " -f                 The format of the image file.\n"
+    "\n"
+    " if                 The input file.\n"
+    "\n"
+    " -O                 Format of the output file.\n"
+    "\n"
+    " of                 The output file.\n"
+    "\n"
+    " skip               Number of blocks to skip.\n"
+    "\n"
+    "Example:\n"
+    "    qemu-img dd if=/dev/cdrom -O raw of=cd.iso\n"
+    "\n"
+    "\n";
+    printf("%s", msg);
+}
+
+static void help_info(void)
+{
+    const char *msg =
+    "\n"
+    "usage: qemu-img info [-f fmt] [--output=ofmt] [--backing-chain] filename\n"
+    "\n"
+    "Command parameters:\n"
+    " --backing-chain            Recursively enumerate thru each disk image in "
+    "the\n"
+    "                            chain for information.\n"
+    "\n"
+    " -f                         The format of the image file.\n"
+    "\n"
+    "--output                    The output format of this command. Can be \"hu"
+    "man\" or\n"
+    "                            \"json\".\n"
+    "\n"
+    "Example:\n"
+    "    qemu-img info image.qcow2\n"
+    "\n"
+    "\n";
+    printf("%s", msg);
+}
+
+static void help_map(void)
+{
+    const char *msg =
+    "\n"
+    "usage: qemu-img map [-f fmt] [--output=ofmt] filename\n"
+    "\n"
+    "Command parameters:\n"
+    " -f                 The format of the image file.\n"
+    "\n"
+    "--output            The output format of this command. Can be \"human\" or"
+    " \"json\".\n"
+    "\n"
+    "Example:\n"
+    "    qemu-img map image.qcow2\n"
+    "\n"
+    "\n";
+    printf("%s", msg);
+}
+
+static void help_measure(void)
+{
+    const char *msg =
+    "\n"
+    "usage: qemu-img measure [--output=ofmt] [-O output_fmt] [-o options] [--si"
+    "ze N ]\n"
+    "[--object objectdef] [--image-opts] [-f fmt] [-l snapshot_param]\n"
+    "filename\n"
+    "\n"
+    "Command parameters:\n"
+    " -f                 The format of the image file.\n"
+    "\n"
+    " --image-opts       Indicates that the source filename parameter is to be"
+    "\n"
+    "                    interpreted as a full option string, not a plain\n"
+    "                    filename.\n"
+    "\n"
+    " -l                 Specifies a snapshot parameter.\n"
+    "\n"
+    " -O                 Format of the output file.\n"
+    "\n"
+    " -o                 Allows for specifying options.\n"
+    "\n"
+    " --object           \'objectdef\' is a QEMU user creatable object definiti"
+    "on. See\n"
+    "                    the qemu(1) manual page for a description of the objec"
+    "t\n"
+    "                    properties. The most common object type is a \'secret"
+    "\',\n"
+    "                    which is used to supply passwords and/or encryption ke"
+    "ys.\n"
+    "\n"
+    " --output           \'ofmt\' is \'human\' for human-readable output (defau"
+    "lt) or\n"
+    "                    \'json\' for JSON output.\n"
+    "\n"
+    " --size             If given act as if creating a new empty image file usi"
+    "ng\n"
+    "                    qemu-img create.\n"
+    "\n"
+    "Example:\n"
+    "    qemu-img measure -O qcow2 --size 5G\n"
+    "\n"
+    "\n";
+    printf("%s", msg);
+}
+
+static void help_snapshot(void)
+{
+    const char *msg =
+    "\n"
+    "usage: qemu-img snapshot [-l | -a snapshot | -c snapshot | -d snapshot ]\n"
+    "filename\n"
+    "\n"
+    "Command parameters:\n"
+    " -a                 Applies the snapshot.\n"
+    "\n"
+    " -c                 Create a snapshot.\n"
+    "\n"
+    " -d                 Deletes a snapshot.\n"
+    "\n"
+    " -l                 Lists all snapshots\n"
+    "\n"
+    "Example:\n"
+    "    qemu-img snapshot -l image.qcow2\n"
+    "\n"
+    "\n";
+    printf("%s", msg);
+}
+
+static void help_rebase(void)
+{
+    const char *msg =
+    "\n"
+    "usage: qemu-img rebase [-f fmt] [-t cache] [-T src_cache] [-p] [-u] -b\n"
+    "backing_file [-F backing_fmt] filename\n"
+    "\n"
+    "Command parameters:\n"
+    " -b         The new backing file.\n"
+    "\n"
+    " -F         The format for the new backing file.\n"
+    "\n"
+    " -f         The format of the image file being rebased.\n"
+    "\n"
+    " -T         Specifies the cache mode that should be used with the source f"
+    "ile.\n"
+    "\n"
+    " -t         Specifies the cache mode that should be used with the destinat"
+    "ion\n"
+    "            file. Options are: none, writeback, writethrough, directsync, "
+    "and\n"
+    "            unsafe.\n"
+    "\n"
+    " -p         Display progress bar. If the -p option is not used for a comma"
+    "nd\n"
+    "            that supports it, the progress is reported when the process\n"
+    "            receives a \"SIGUSR1\" signal.\n"
+    "\n"
+    " -u         Operate in unsafe mode.\n"
+    "\n"
+    "Example:\n"
+    "    qemu-img rebase -b backing.img diff.qcow2\n"
+    "\n"
+    "\n";
+    printf("%s", msg);
+}
+
+static void help_resize(void)
+{
+    const char *msg =
+    "\n"
+    "usage: qemu-img resize [--shrink] [--preallocation=prealloc] filename\n"
+    "[+ | -] size\n"
+    "\n"
+    "Command parameters:\n"
+    " --preallocation    When growing an image, specify how the additional imag"
+    "e\n"
+    "                    area should be allocated on the host.\n"
+    "\n"
+    " --shrink           Informs qemu-img that the user acknowledges all loss o"
+    "f\n"
+    "                    data beyond the truncated image\'s end.\n"
+    "\n"
+    "Example:\n"
+    "    qemu-img resize image.qcow2 20G\n";
+    printf("%s", msg);
 }
 
 static QemuOptsList qemu_object_opts = {
@@ -4954,6 +5486,43 @@ int main(int argc, char **argv)
 
     cmdname = argv[optind];
 
+    /* print the help for this command */
+    if (strcmp("--help", argv[optind + 1]) == 0) {
+        if (strcmp("amend", cmdname) == 0) {
+            help_amend();
+        } else if (strcmp("bench", cmdname) == 0) {
+            help_bench();
+        } else if (strcmp("check", cmdname) == 0) {
+            help_check();
+        } else if (strcmp("commit", cmdname) == 0) {
+            help_commit();
+        } else if (strcmp("compare", cmdname) == 0) {
+            help_compare();
+        } else if (strcmp("convert", cmdname) == 0) {
+            help_convert();
+        } else if (strcmp("create", cmdname) == 0) {
+            help_create();
+        } else if (strcmp("dd", cmdname) == 0) {
+            help_dd();
+        } else if (strcmp("info", cmdname) == 0) {
+            help_info();
+        } else if (strcmp("map", cmdname) == 0) {
+            help_map();
+        } else if (strcmp("measure", cmdname) == 0) {
+            help_measure();
+        } else if (strcmp("snapshot", cmdname) == 0) {
+            help_snapshot();
+        } else if (strcmp("rebase", cmdname) == 0) {
+            help_rebase();
+        } else if (strcmp("resize", cmdname) == 0) {
+            help_resize();
+        } else {
+            printf("\'%s\' does not have help available for it\n\n", cmdname);
+            return -1;
+        }
+        return 0;
+    }
+
     /* reset getopt_long scanning */
     argc -= optind;
     if (argc < 1) {
-- 
2.7.2
