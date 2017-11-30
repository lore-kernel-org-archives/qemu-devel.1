Received: from eggs.gnu.org ([2001:4830:134:3::10]:46143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eKSCv-0008C5-2U
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 12:01:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eKSCr-00043X-2V
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 12:01:05 -0500
References: <20171130134159.9697-1-eblake@redhat.com>
	<20171130140154.11161-1-eblake@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <04c922b4-7287-61e7-1afc-4e64f39c52a5@redhat.com>
Date: Thu, 30 Nov 2017 11:00:58 -0600
MIME-Version: 1.0
In-Reply-To: <20171130140154.11161-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/3] checkpatch: Enforce proper do/while
 (0) style
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org

On 11/30/2017 08:01 AM, Eric Blake wrote:
> while (0) is only idiomatic in a macro definition, where the caller
> will be supplying the trailing ';'.  Warn if the macro has a duplicate.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>   scripts/checkpatch.pl | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 34df753571..acb66bff34 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -1622,6 +1622,11 @@ sub process {
>   			}
>   		}
> 
> +# 'while (0);' is odd; only macros should use while (0), without trailing ;
> +		if ($line =~ /while\s*\(0\);/) {

Should this also check for uses of 'while (false);' ?

Interestingly enough, we have an instance of 'do/while (false);' in 
tests/vhost-user-bridge.c that is NOT in a macro, but is used for the 
convenience of being able to 'break;' out early rather than using a 
goto.  Similarly for chardev/char-serial.c using 'while (0);' outside of 
a macro.  Those may be worth rewriting to use goto as separate patches 
if we want to restrict ALL use of 'while \((0|false)\);'

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
