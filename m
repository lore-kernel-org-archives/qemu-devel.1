Received: from eggs.gnu.org ([2001:4830:134:3::10]:53260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ejAM3-0005Rm-FK
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 16:00:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ejAM0-0006SD-6k
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 16:00:39 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60336 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ejAM0-0006S7-1Z
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 16:00:36 -0500
References: <20180202130336.24719-1-armbru@redhat.com>
	<20180202130336.24719-19-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7f5c57d6-3b57-cb3c-a4b4-3b5144afcef8@redhat.com>
Date: Tue, 6 Feb 2018 15:00:24 -0600
MIME-Version: 1.0
In-Reply-To: <20180202130336.24719-19-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC 18/21] qapi/common: Fix guardname() for
 funny filenames
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

On 02/02/2018 07:03 AM, Markus Armbruster wrote:
> guardname() fails to return a valid C identifier for arguments
> containing anything but [A-Za-z0-9_.-'].  Fix that.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   scripts/qapi/common.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
> index 7ffffc78d9..7d497b5b17 100644
> --- a/scripts/qapi/common.py
> +++ b/scripts/qapi/common.py
> @@ -1860,7 +1860,7 @@ def mcgen(code, **kwds):
>   
>   
>   def guardname(filename):
> -    return c_name(filename, protect=False).upper()
> +    return re.sub(r'[^A-Za-z0-9_]', '_', filename).upper()

For some choices of filename, the old code prefixes a q_ (via c_name) 
which gets turned into Q_ in the final guard name.  The new code does 
not.  Then again, all of the names protected by c_name() all contain 
lower case, while guard names are all upper case; so we aren't 
protecting ourselves from defining a reserved word; the main use for 
c_name() is to protect ourselves where we are not changing case (for 
example, _BOOL is no better than Q__BOOL as a guard name for a file 
named _Bool).

Might be worth mentioning this design consideration in the commit 
message, but the change itself is reasonable.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
