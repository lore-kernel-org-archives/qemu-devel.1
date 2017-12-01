Received: from eggs.gnu.org ([2001:4830:134:3::10]:43042)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eKsSl-00078a-9l
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 16:03:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eKsSk-0006Jm-FO
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 16:03:11 -0500
References: <20171116173810.16457-1-crosa@redhat.com>
	<20171116173810.16457-6-crosa@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <94cfacec-b804-f9de-e769-243ff4a206e7@redhat.com>
Date: Fri, 1 Dec 2017 15:03:02 -0600
MIME-Version: 1.0
In-Reply-To: <20171116173810.16457-6-crosa@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 05/10] qemu-iotests: define functions used
 in _cleanup() before its use
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On 11/16/2017 11:38 AM, Cleber Rosa wrote:
> The functions used in _cleanup() come from common.rc, which currently
> gets sourced after _cleanup() is defined and registered as a signal
> handler.  When _cleanup() is executed, it has no valid references to
> those functions, as BASH won't resolve the reference at that time.
> 

Rather, there is a (small) window of time where if the test gets killed 
after the trap handler is registered but before the function definition 
is sourced, then the trap handler will fail to execute correctly 
(although if you kill the process that early, there was probably nothing 
that the handler would have cleaned up, so you are just littering extra 
messages to stderr).

Bash does NOT require a function to exist before a trap handler 
references it - only that the function exists at the time the trap 
handler body is invoked later.

> +++ b/tests/qemu-iotests/001
> @@ -27,15 +27,15 @@ echo "QA output created by $seq"
>   here=`pwd`
>   status=1	# failure is the default!
>   
> +# get standard environment, filters and checks
> +. ./common.rc
> +
>   _cleanup()
>   {
>   	_cleanup_test_img
>   }
>   trap "_cleanup; exit \$status" 0 1 2 3 15
>   
> -# get standard environment, filters and checks
> -. ./common.rc
> -

At any rate, I do think it reads better in this order, and consistency 
is nice.

With an improved commit message,
Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
