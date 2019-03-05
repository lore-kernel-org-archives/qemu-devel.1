Received: from eggs.gnu.org ([209.51.188.92]:56608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h1DOD-0007WM-5b
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:58:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h1DOB-0007t7-QT
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:58:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45886)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1h1DOB-0007rg-ES
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:57:59 -0500
References: <CAGZZdDHc12gHaNNisqqBek+2ox1BiuHhwR2k0Tavmt_t+x_D5A@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0ac05885-96d6-9355-0333-31a909fd943b@redhat.com>
Date: Tue, 5 Mar 2019 10:57:57 -0600
MIME-Version: 1.0
In-Reply-To: <CAGZZdDHc12gHaNNisqqBek+2ox1BiuHhwR2k0Tavmt_t+x_D5A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] qemu-binfmt-conf.sh: add CPUS, add --reset,
 make -p and -c boolean (no arg)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: unai.martinezcorral@ehu.eus, qemu-devel@nongnu.org
Cc: riku.voipio@iki.fi, laurent@vivier.eu

On 3/5/19 12:28 AM, Unai Martinez Corral wrote:
> Related to https://bugs.launchpad.net/qemu/+bug/1817239
> 

> +++ b/scripts/qemu-binfmt-conf.sh
> @@ -6,6 +6,32 @@ mips mipsel mipsn32 mipsn32el mips64 mips64el \
>   sh4 sh4eb s390x aarch64 aarch64_be hppa riscv32 riscv64 xtensa xtensaeb \
>   microblaze microblazeel or1k x86_64"
> 
> +# check if given target CPUS is/are in the supported target list
> +qemu_check_target_list() {
> +    all="$qemu_target_list"
> +    if [ "$1" = "ALL" ]; then

Risky, if $1 can ever be "!" (I didn't trace whether the parameters for 
this function can come from a user deliberately trying to provoke a 
syntax error).  Better would be:

if [ "x$1" = xALL ]; then

> +      checked_target_list="$all"
> +      return
> +    fi
> +    list=""
> +    for target in $@; do
> +        unknown_target="true"
> +        for cpu in $all ; do
> +            if [ "$cpu" = "$target" ] ; then

Here you may be safer, since $cpu comes from $qemu_target_list which is 
under your control, but being consistent about always prefixing tests 
with leading x to avoid future changes from confusing test with 
something that might resemble an operator can't hurt.


> @@ -286,12 +315,22 @@ EOF
>   }
> 
>   qemu_set_binfmts() {
> +    if [ "$1" = "NONE" ]; then

More instances. I'll quit pointing them out.

> +      return
> +    fi
> +
>       # probe cpu type
>       host_family=$(qemu_get_family)
> 
> -    # register the interpreter for each cpu except for the native one
> +    # reduce the list of target interpreters to those given in the CLI
> +    targets="$@"
> +    if [ $# -eq 0 ]; then
> +      targets="ALL"
> +    fi
> +    qemu_check_target_list $(echo "$targets" | tr ',' ' ')

If desired, you could have used the shell's own splitting via IFS=, (and 
restoring IFS afterwards) instead of fork()ing out to echo|tr.


> +qemu_remove_interpreter() {
> +    if [ "$1" = "ALL" ]; then
> +      find /proc/sys/fs/binfmt_misc/ -type f -name 'qemu-*' -exec sh -c
> 'echo -1 > {}' \;

echo -1 is not portable (you are not guaranteed that echo won't try to 
treat it as an option); better would be using printf.

> +    else
> +        qemu_check_target_list $(echo "$1" | tr ',' ' ')
> +        for t in $checked_target_list; do
> +            find /proc/sys/fs/binfmt_misc/ -type f -name "qemu-$t" -exec
> sh -c 'echo -1 > {}' \;

and again

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
