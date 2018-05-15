Received: from eggs.gnu.org ([2001:4830:134:3::10]:43471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fIapB-000766-VS
	for qemu-devel@nongnu.org; Tue, 15 May 2018 10:21:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fIap6-0002zW-Ai
	for qemu-devel@nongnu.org; Tue, 15 May 2018 10:21:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44956)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fIap6-0002zA-46
	for qemu-devel@nongnu.org; Tue, 15 May 2018 10:21:04 -0400
References: <20180514215042.25911-1-danielhb@linux.ibm.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <69f3929f-9af4-f566-b563-2412de292958@redhat.com>
Date: Tue, 15 May 2018 09:20:55 -0500
MIME-Version: 1.0
In-Reply-To: <20180514215042.25911-1-danielhb@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/1] qmp.c: system_wakeup: adding
 RUN_STATE_SUSPENDED check before proceeding
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb@linux.ibm.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On 05/14/2018 04:50 PM, Daniel Henrique Barboza wrote:
> The qmp/hmp command 'system_wakeup' is simply a direct call to
> 'qemu_system_wakeup_request' from vl.c. This function verifies if
> runstate is SUSPENDED and if the wake up reason is valid before
> proceeding.
> 
> However, no error or warning is thrown if any of those
> pre-requirements isn't met. There is no way for the caller to
> differentiate between a successful wakeup or an error state caused
> when trying to wake up a guest that wasn't suspended.

This would be the ideal place to also mention...

> 
> This patch changes qmp_system_wakeup to make the runstate verification
> before proceeding to call qemu_system_wakeup_request, firing up
> an error message if the user tries to wake up a machine that
> isn't in SUSPENDED state. The change isn't made inside
> qemu_system_wakeup_request because it is used in migration,
> ACPI and others where this usage might be valid.
> 
> Signed-off-by: Daniel Henrique Barboza <danielhb@linux.ibm.com>
> CC: Markus Armbruster <armbru@redhat.com>
> CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
> CC: Eric Blake <eblake@redhat.com>
> ---
> 
> This is a v2 of a patch that got buried:
> 
> http://lists.gnu.org/archive/html/qemu-devel/2018-01/msg00092.html
> 
> The changes in this version was all in the wording of the commit,
> reflecting the understanding reached in that discusssion:

...this text:

> silent
> failure should be interpreted as a bug and there is no API break
> in fixing this behavior - applications that didn't check the result
> will remain broken, the ones that check will have a chance to deal
> with it.
>

With the commit message further improved,
Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
