Received: from eggs.gnu.org ([209.51.188.92]:45037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h1G8l-0005V7-BB
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 14:54:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h1G8k-0004Mr-1d
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 14:54:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45940)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1h1G8j-0004ML-NW
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 14:54:13 -0500
References: <CAGZZdDHc12gHaNNisqqBek+2ox1BiuHhwR2k0Tavmt_t+x_D5A@mail.gmail.com>
	<0ac05885-96d6-9355-0333-31a909fd943b@redhat.com>
	<CAGZZdDEp7vxzxbWoHn5AF3g28FKSwka1WQB=U5MTv6X=XLeL7A@mail.gmail.com>
	<CAGZZdDHJ2+TFZ1ZvVtR-xfUOJj=gxEKvwHXH0Trn6ra=2Xd9og@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7c650cfd-9e23-6822-e999-2bc828b7d0f1@redhat.com>
Date: Tue, 5 Mar 2019 13:54:11 -0600
MIME-Version: 1.0
In-Reply-To: <CAGZZdDHJ2+TFZ1ZvVtR-xfUOJj=gxEKvwHXH0Trn6ra=2Xd9og@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] qemu-binfmt-conf.sh: add CPUS,
 add --reset, make -p and -c boolean (no arg)
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

On 3/5/19 1:32 PM, Unai Martinez Corral wrote:
> Signed-off-by: Unai Martinez-Corral <unai.martinezcorral@ehu.eus>

Welcome to the qemu community, and I hope you find your experience with 
your first patch pleasant.

Long subject line, I'd trim ' (no arg)'. The commit body itself should 
go into the "why" the patch is useful (what behaviors are you fixing, 
what risk of backwards-compatibility breaks do we have to contend with 
for older clients of the script, etc).  Also, a v2 patch is best sent as 
a new top-level thread, rather than in-reply to the v1 (as some of our 
automated CI tooling misses it otherwise).  More submission hints can be 
found at: https://wiki.qemu.org/Contribute/SubmitAPatch

There may be enough changes here to be worth splitting this into 
multiple patches, for easier review (focus on one thing per patch: 
adding --reset sounds different enough from changing -p/-c, which in 
turn sounds different from fixing pre-existing shell usage bugs 
regarding prepending x when using []).

> ---
>   scripts/qemu-binfmt-conf.sh | 190 +++++++++++++++++++++++-------------
>   1 file changed, 121 insertions(+), 69 deletions(-)
> 
> diff --git a/scripts/qemu-binfmt-conf.sh b/scripts/qemu-binfmt-conf.sh
> index b5a16742a1..b1aa4a312a 100755
> --- a/scripts/qemu-binfmt-conf.sh
> +++ b/scripts/qemu-binfmt-conf.sh
> @@ -6,6 +6,35 @@ mips mipsel mipsn32 mipsn32el mips64 mips64el \
>   sh4 sh4eb s390x aarch64 aarch64_be hppa riscv32 riscv64 xtensa xtensaeb \
>   microblaze microblazeel or1k x86_64"
> 
> +# check if given target CPUS is/are in the supported target list
> +qemu_check_target_list() {
> +    all="$qemu_target_list"
> +    if [ "x$1" = "xALL" ]; then
> +      checked_target_list="$all"
> +      return
> +    fi
> +    list=""
> +    bIFS="$IFS"
> +    IFS=" ,"

If you are allowing space, why not tab and newline?

> +    for target in $@; do

The ' in $@' is redundant, but doesn't hurt.

> +        unknown_target="true"
> +        for cpu in $all ; do

Why the space before ';' here, but not two lines earlier? The space 
doesn't hurt, but being consistent is nice.

> +            if [ "x$cpu" = "x$target" ] ; then

Similar questions about why only some of your additions have space 
before ; after ]

> +                list="$list $target"
> +                unknown_target="false"
> +                break
> +            fi
> +        done
> +        if [ "$unknown_target" = "true" ] ; then
> +            echo "ERROR: unknown CPU \"$target\"" 1>&2
> +            usage
> +            exit 1
> +        fi
> +    done
> +    IFS="$bIFS"
> +    checked_target_list="$list"
> +}
> +
>   i386_magic='\x7fELF\x01\x01\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x03\x00'
>   i386_mask='\xff\xff\xff\xff\xff\xfe\xfe\x00\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff\xff'
>   i386_family=i386
> @@ -167,45 +196,48 @@ qemu_get_family() {
> 
>   usage() {
>       cat <<EOF
> -Usage: qemu-binfmt-conf.sh [--qemu-path PATH][--debian][--systemd CPU]
> -                           [--help][--credential yes|no][--exportdir PATH]
> -                           [--persistent yes|no][--qemu-suffix SUFFIX]
> -

> +Usage: qemu-binfmt-conf.sh [--help][--qemu-path PATH][--qemu-suffix SUFFIX]
> +                           [--persistent][--credential][--exportdir PATH]
> +                           [--reset ARCHS][--systemd][--debian][CPUS]
> +

You are making a backwards-incompatible change with -p/-c - why is that 
okay? (It might be, but the commit message needs to give it more attention).

> +    Configure binfmt_misc to use qemu interpreter for the given target CPUS.
> +    Supported formats for CPUS are: single arch or comma/space separated list.
> +    If CPUS is empty, configure all known cpus. See QEMU target list below.

The wholesale reindentation of the --help text makes it harder to see 
what is actually new content. A separate patch to reflow/reindent the 
text before making additions will better call the reviewer's attention 
to the important changes.


>   $CHECK
> -qemu_set_binfmts
> +qemu_set_binfmts $@

This should be "$@", not $@.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
