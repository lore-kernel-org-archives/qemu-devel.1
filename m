Received: from eggs.gnu.org ([2001:4830:134:3::10]:54335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fIbRo-00044T-NQ
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:01:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fIbRf-0003iT-8J
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:01:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41032)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fIbRf-0003i7-30
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:00:55 -0400
References: <20180513085032.27773-1-sw@weilnetz.de>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e2b0f5a2-18df-79a2-7caa-45afdc09a172@redhat.com>
Date: Tue, 15 May 2018 10:00:47 -0500
MIME-Version: 1.0
In-Reply-To: <20180513085032.27773-1-sw@weilnetz.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] configure: Use strings command from cross
 development tools
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <sw@weilnetz.de>, Mike Frysinger <vapier@gentoo.org>, QEMU Developer <qemu-devel@nongnu.org>

On 05/13/2018 03:50 AM, Stefan Weil wrote:
> This fixes cross builds for the (rare) case where cross binutils
> but no native binutils are installed.
> 
> Signed-off-by: Stefan Weil <sw@weilnetz.de>
> ---
>   configure | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 

> +strings="${STRINGS-${cross_prefix}strings}"
>   strip="${STRIP-${cross_prefix}strip}"

Hmm - we have pre-existing problems in our configure file.  More on that 
below...

>   windres="${WINDRES-${cross_prefix}windres}"
>   pkg_config_exe="${PKG_CONFIG-${cross_prefix}pkg-config}"
> @@ -1956,9 +1957,9 @@ int main(int argc, char *argv[]) {
>   EOF
>   
>   if compile_object ; then
> -    if strings -a $TMPO | grep -q BiGeNdIaN ; then
> +    if "$strings" -a $TMPO | grep -q BiGeNdIaN ; then

I'd much prefer this to be:

if $strings -a $TMPO | grep...

That's because if I have something like this in my environment:

STRINGS='/path/to/strings -a'

it will only work if you allow word splitting on my variable.

...having said that, here's the pre-existing problem with user 
replacement tools that contain whitespace:

if test "$strip_opt" = "yes" ; then
   echo "STRIP=${strip}" >> $config_host_mak
fi

we are improperly quoting the whitespace when populating 
$config_host_mak, and therefore could end up attempting to execute the 
user's first argument as a standalone command, rather than the intended 
result of assigning a two-word command to a single variable.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
