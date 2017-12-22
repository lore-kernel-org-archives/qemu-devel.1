Received: from eggs.gnu.org ([2001:4830:134:3::10]:45032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eSBpQ-00043d-Fn
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 20:08:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eSBpP-0005ur-Dk
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 20:08:48 -0500
References: <1513901496-13538-1-git-send-email-jack.schwartz@oracle.com>
	<1513901496-13538-2-git-send-email-jack.schwartz@oracle.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b03b4cde-5ec4-b3f0-23f6-5fc4115814d1@redhat.com>
Date: Thu, 21 Dec 2017 19:08:38 -0600
MIME-Version: 1.0
In-Reply-To: <1513901496-13538-2-git-send-email-jack.schwartz@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 1/1] block: Add numeric errno field to
 BLOCK_IO_ERROR events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jack Schwartz <jack.schwartz@oracle.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, karl.heubaum@oracle.com, konrad.wilk@oracle.com

On 12/21/2017 06:11 PM, Jack Schwartz wrote:
> BLOCK_IO_ERROR events currently contain a "reason" string which is
> strerror(errno) of the error.  This enhancement provides those events with
> the numeric errno value as well, since it is easier to parse for error type
> than a string.

NACK.  Numeric errno values are platform-dependent, but QMP must be 
platform-independent.  If you want to expose errno NAMES (not values), 
then create a QAPI enum and add the enum to the error structure (so that 
you are still passing names, not int values, over the wire).

> +++ b/qapi/block-core.json
> @@ -3660,6 +3660,11 @@
>   #           io-status is present, please see query-block documentation
>   #           for more information (since: 2.2)
>   #
> +# @errno: int describing the error cause, provided for applications.
> +#         (Note: while most errnos are posix compliant between OSs, it
> +#         is possible some errno values can vary among different OSs.)
> +#         (since 2.12)

The proof is in the pudding - if your documentation has to give this big 
disclaimer, then what you are adding is not portable and should not be 
added in that manner.

> +#
>   # @reason: human readable string describing the error cause.
>   #          (This field is a debugging aid for humans, it should not
>   #           be parsed by applications) (since: 2.2)
> @@ -3675,14 +3680,17 @@
>   #      "data": { "device": "ide0-hd1",
>   #                "node-name": "#block212",
>   #                "operation": "write",
> -#                "action": "stop" },
> +#                "action": "stop",
> +#                "nospace": false,
> +#                "errno": 5,

So this should be "errno":"ENOSPC", not 5.

> +#                "reason": "Input/output error" },
>   #      "timestamp": { "seconds": 1265044230, "microseconds": 450486 } }
>   #
>   ##
>   { 'event': 'BLOCK_IO_ERROR',
>     'data': { 'device': 'str', 'node-name': 'str', 'operation': 'IoOperationType',
>               'action': 'BlockErrorAction', '*nospace': 'bool',
> -            'reason': 'str' } }
> +            'errno': 'int', 'reason': 'str' } }

and this should be the name of a QAPI enum type, not 'int'.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
