Received: from eggs.gnu.org ([2001:4830:134:3::10]:51357)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gFM7b-0007bj-ET
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 12:35:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gFM7Y-0005pd-AJ
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 12:35:03 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:36935)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1gFM7X-0005p1-VM
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 12:35:00 -0400
References: <20181021165542.8692-1-jcmvbkbc@gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <46f658a3-836d-73aa-30cc-3a15f6ba1016@vivier.eu>
Date: Wed, 24 Oct 2018 17:34:49 +0100
MIME-Version: 1.0
In-Reply-To: <20181021165542.8692-1-jcmvbkbc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] scripts/qemu-binfmt-conf.sh: add bFLT
 handler registration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Filippov <jcmvbkbc@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>

On 21/10/2018 17:55, Max Filippov wrote:
> bFLT format header doesn't have enough information to register a handler
> for a specific architecture. Add switch -f / --flat that registers one
> of the qemu binaries as a handler for bFLT executable images.
> 
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> ---
> Changes v2->v3:
> - fix bFLT in the patch subject
> 
> Changes v1->v2:
> - drop unintended changes to dtc;
> 
>  scripts/qemu-binfmt-conf.sh | 32 ++++++++++++++++++++++++++++++--
>  1 file changed, 30 insertions(+), 2 deletions(-)


BTW, I'm not sure it's the good way to do that. The script has been
written with ELF in mind and no other alternative format.

Perhaps we can add a format parameter, like "--format elf" (default),
"--format bflt"  and then take the availabled CPU and mask/magic from
the list corresponding for the selected format.

And then rename qemu_set_binfmts() to qemu_elf_set_binfmts(), add
function qemu_bflt_set_binfmt() and call the one you you need according
the format you have selected.

Somehing like:

FORMAT_BINFMT_MISC_SET=qemu_elf_set_binfmts
...
    -F|--format)
       shift
       FORMAT_BINFMT_MISC_SET=qemu_$1_set_binfmts
       ;;
...

$CHECK
$FORMAT_BINFMT_MISC_SET

and then

qemu_bflt_set_binfmts()
{
   for cpu in ${qemu_target_list} ; do
       magic='bFLT\x00\x00\x00\x04'
       mask='\xff\xff\xff\xff\xff\xff\xff\xff'
       qemu="$QEMU_PATH/qemu-$cpu"
       qemu="$qemu$QEMU_SUFFIX"
       $BINFMT_SET
   done
}

Then with --systemd you provide only the cpu you want to generate, with
--debian you use update-binfmts to select the only one to import, for
/proc case we could add another parameter to only register one
interpreter (--proc CPU ?)

Thanks,
Laurent
