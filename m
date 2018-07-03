Received: from eggs.gnu.org ([2001:4830:134:3::10]:34080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1faB8U-0003ef-3E
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 22:33:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1faB8Q-0005EX-Sa
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 22:33:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38970 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1faB8Q-0005EF-Gy
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 22:33:42 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E7722B797
	for <qemu-devel@nongnu.org>; Tue,  3 Jul 2018 02:33:41 +0000 (UTC)
References: <20180702162218.13678-1-armbru@redhat.com>
	<20180702162218.13678-31-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0de63ffd-0dba-7d02-8fea-18b2e04c02aa@redhat.com>
Date: Mon, 2 Jul 2018 21:33:40 -0500
MIME-Version: 1.0
In-Reply-To: <20180702162218.13678-31-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 30/32] qmp: Clean up capability negotiation
 after commit 02130314d8c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, stefanha@redhat.com, dgilbert@redhat.com

On 07/02/2018 11:22 AM, Markus Armbruster wrote:
> qmp_greeting() offers capabilities to the client, and
> qmp_qmp_capabilities() accepts or denies capabilities requested by the
> client.  The two compute the set of available capabilities
> independently.  Not nice.
> 
> Clean this up as follows.  Compute available capabilities just once in
> monitor_qmp_caps_reset(), and store them in Monitor member
> qmp.capab_offered[].  Have qmp_greeting() and qmp_qmp_capabilities()
> use that.  Both are now oblivious of capability details.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   monitor.c | 93 ++++++++++++++++++++++++-------------------------------
>   1 file changed, 40 insertions(+), 53 deletions(-)
> 
> diff --git a/monitor.c b/monitor.c
> index 876a3a23a7..590e5b5b04 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -172,7 +172,8 @@ typedef struct {
>        * mode.
>        */
>       QmpCommandList *commands;
> -    bool qmp_caps[QMP_CAPABILITY__MAX];
> +    bool capab_offered[QMP_CAPABILITY__MAX]; /* capabilities offered */
> +    bool capab[QMP_CAPABILITY__MAX];         /* offered and accepted */

Could also store as uint32_t, using '1U << bit' to compute various 
capabilities as a bitmask (up to 32 capabilities).  But it's not 
frequently executed, so this works.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
