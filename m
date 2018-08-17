Received: from eggs.gnu.org ([2001:4830:134:3::10]:54561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fqhr3-0005wQ-84
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 12:44:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fqhqu-0000vx-Gq
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 12:44:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49208 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fqhqu-0000vR-4k
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 12:43:56 -0400
References: <20180817150559.16243-1-armbru@redhat.com>
	<20180817150559.16243-58-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f60696e0-52c3-8993-d911-6b3f477574a3@redhat.com>
Date: Fri, 17 Aug 2018 11:43:53 -0500
MIME-Version: 1.0
In-Reply-To: <20180817150559.16243-58-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 57/60] tests/drive_del-test: Fix
 harmless JSON interpolation bug
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
> test_after_failed_device_add() does this:
> 
>      response = qmp("{'execute': 'device_add',"
>                     " 'arguments': {"
>                     "   'driver': 'virtio-blk-%s',"
>                     "   'drive': 'drive0'"
>                     "}}", qvirtio_get_dev_type());
> 
> Wrong.  An interpolation specification must be a JSON token, it
> doesn't work within JSON string tokens.  The code above doesn't use
> the value of qvirtio_get_dev_type(), and sends arguments
> 
>      {"driver": "virtio-blk-%s", "drive": "drive0"}}
> 
> The command fails because there is no driver named "virtio-blk-%".
> Harmless, since the test wants the command to fail.  Screwed up in
> commit 2f84a92ec63.
> 
> Fix the obvious way.  The command now fails because the drive is
> empty, like it did before commit 2f84a92ec63.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   tests/drive_del-test.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
