Received: from eggs.gnu.org ([2001:4830:134:3::10]:40881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fqhNS-0008WA-9r
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 12:13:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fqhDg-0000ek-LF
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 12:03:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59430 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fqhDg-0000eT-GR
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 12:03:24 -0400
References: <20180817150559.16243-1-armbru@redhat.com>
	<20180817150559.16243-42-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2ad9b303-8108-3f66-c478-65081fc4062a@redhat.com>
Date: Fri, 17 Aug 2018 11:03:21 -0500
MIME-Version: 1.0
In-Reply-To: <20180817150559.16243-42-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 41/60] json: Nicer recovery from invalid
 leading zero
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
> For input 0123, the lexer produces the tokens
> 
>      JSON_ERROR    01
>      JSON_INTEGER  23
> 
> Reporting an error is correct; 0123 is invalid according to RFC 7159.
> But the error recovery isn't nice.
> 
> Make the finite state machine eat digits before going into the error
> state.  The lexer now produces
> 
>      JSON_ERROR    0123
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Did you also want to reject invalid attempts at hex numbers, by adding 
[xXa-fA-F] to the set of characters eaten by IN_BAD_ZERO?

>   
> +    [IN_BAD_ZERO] = {
> +        ['0' ... '9'] = IN_BAD_ZERO,
> +    },
> +


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
