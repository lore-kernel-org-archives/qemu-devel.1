Received: from eggs.gnu.org ([2001:4830:134:3::10]:40865)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fqhNc-0008UK-7Q
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 12:13:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fqhHo-00039J-BH
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 12:07:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58586 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fqhHo-000395-6n
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 12:07:40 -0400
References: <20180817150559.16243-1-armbru@redhat.com>
	<20180817150559.16243-53-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <fa470eb3-cc13-1ab3-b0d5-19343bc3b038@redhat.com>
Date: Fri, 17 Aug 2018 11:07:35 -0500
MIME-Version: 1.0
In-Reply-To: <20180817150559.16243-53-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 52/60] json: Eliminate lexer state
 IN_WHITESPACE, pseudo-token JSON_SKIP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

On 08/17/2018 10:05 AM, Markus Armbruster wrote:
> Bonus: static json_lexer[] loses its unused elements.  It shrinks from
> 8KiB to 4.75KiB for me.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---

>           ['a' ... 'z'] = IN_KEYWORD,
> -        [' '] = IN_WHITESPACE,
> -        ['\t'] = IN_WHITESPACE,
> -        ['\r'] = IN_WHITESPACE,
> -        ['\n'] = IN_WHITESPACE,
> +        [' '] = IN_START,
> +        ['\t'] = IN_START,
> +        ['\r'] = IN_START,
> +        ['\n'] = IN_START,
>       },
>       [IN_START_INTERPOL]['%'] = IN_INTERPOL,
> +    [IN_START_INTERPOL][' '] = IN_START_INTERPOL,
> +    [IN_START_INTERPOL]['\t'] = IN_START_INTERPOL,
> +    [IN_START_INTERPOL]['\r'] = IN_START_INTERPOL,
> +    [IN_START_INTERPOL]['\n'] = IN_START_INTERPOL,

Hmm, if we did this:

[IN_START_INTERPOL] {
   ['%'] = IN_INTERPOL,
   ['\t'] = IN_START_INTERPOL,
...
}

for similarity with all our other constructs, will gcc remember that 
we've already initialized other members not listed in the clause before, 
or will it mistakenly re-0-initialize the array members not mentioned?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
