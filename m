Received: from eggs.gnu.org ([2001:4830:134:3::10]:33234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evMK9-00045G-Qa
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 08:13:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evMK5-0002hZ-Q0
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 08:13:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37896 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1evMK5-0002gf-LJ
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 08:13:01 -0400
References: <20180311201239.25506-1-nia.alarie@gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <486e1b60-e453-c3de-040b-8b2951ddf3a5@redhat.com>
Date: Mon, 12 Mar 2018 07:12:52 -0500
MIME-Version: 1.0
In-Reply-To: <20180311201239.25506-1-nia.alarie@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] 9p: Convert use of atoi to qemu_strtol to
 allow error checking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nia Alarie <nia.alarie@gmail.com>, qemu-devel@nongnu.org
Cc: stefanha@gmail.com, jim@groklearning.com, groug@kaod.org, joel@jms.id.au, "Daniel P. Berrange" <berrange@redhat.com>

On 03/11/2018 03:12 PM, Nia Alarie wrote:
> Signed-off-by: Nia Alarie <nia.alarie@gmail.com>
> ---
>   hw/9pfs/9p.c | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
> 

>       } else if (perm & P9_STAT_MODE_LINK) {
> -        int32_t ofid = atoi(extension.data);
> -        V9fsFidState *ofidp = get_fid(pdu, ofid);
> +        long ofid;
> +        V9fsFidState *ofidp;
> +
> +        if (qemu_strtol(extension.data, NULL, 10, &ofid) ||
> +            ofid > INT32_MAX || ofid < INT32_MIN) {

Dan has a pending patch that will add qemu_strtoi, which might be a 
nicer fit for this situation:

https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg00952.html

int32_t is not necessarily int, but all platforms that compile qemu have 
'int32_t' and 'int' both at 32 bits, so it's simpler to change to 'int 
ofid' and use Dan's function than it is to parse to long and then do 
bounds checking.  Except that Dan still needs to post an updated version 
of his patch...

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
