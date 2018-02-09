Received: from eggs.gnu.org ([2001:4830:134:3::10]:37860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ekFRy-0002H5-VQ
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 15:39:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ekFRu-0007jD-Fw
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 15:39:15 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39574 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ekFRu-0007id-AQ
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 15:39:10 -0500
References: <1518096522-31141-1-git-send-email-sarna@skytechnology.pl>
	<20180209021950.GK24289@lemon.usersys.redhat.com>
	<2a381250-2cf9-c70c-4805-fc5f0ec4823c@skytechnology.pl>
	<20180209151107.GH3998@localhost.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <be54533f-9b3b-9699-7aaa-4c5dd03ca0ca@redhat.com>
Date: Fri, 9 Feb 2018 14:38:52 -0600
MIME-Version: 1.0
In-Reply-To: <20180209151107.GH3998@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] block: unify blocksize types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Piotr Sarna <sarna@skytechnology.pl>
Cc: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, mreitz@redhat.com

On 02/09/2018 09:11 AM, Kevin Wolf wrote:

>> Yes, I do, thanks - I'll prepare patch v2 today. Also, I haven't found any
>> hidden dependencies on blocksize being <= 32768, so I assume changing the
>> new max value to 2^31 is safe. Could somebody more familiar with qemu code
>> confirm(or invalidate) my assumption?
> 
> The IDE code has the following line in the emulation of the IDENTIFY
> DEVICE command:
> 
>      put_le16(p + 106, 0x6000 | get_physical_block_exp(&dev->conf));
> 
> That is, the result of get_physical_block_exp() is just blindly ORed to
> the word. The IDE spec says that bits 0-3 contain the exponent. Four
> bits mean a maximum of 15 (and 2^15 = 32768). After that, we don't
> actually expose a larger block size, but start modifying reserved bits.
> 
> I haven't checked other device models, but I wouldn't rule out that they
> make similar assumptions.

NBD documents that:

The minimum block size represents the smallest addressable length and 
alignment within the export, although writing to an area that small may 
require the server to use a less-efficient read-modify-write action. If 
advertised, this value MUST be a power of 2, MUST NOT be larger than 
2^16 (65,536), and MAY be as small as 1 for an export backed by a 
regular file, although the values of 2^9 (512) or 2^12 (4,096) are more 
typical for an export backed by a block device. If a server advertises a 
minimum block size, the advertised export size SHOULD be an integer 
multiple of that block size, since otherwise, the client would be unable 
to access the final few bytes of the export.

We probably need to get that enlarged to a bigger minimum block size, if 
there really are devices that require more than a 64k minimum access 
size.  But you do NOT want 2^31 as a permitted block size; that implies 
that any action smaller than the block size will be performed as a 
read-modify-write; and reading 2G just to modify a subset then write 
back 2G is painfully slow.  1M might be a much more reasonable maximum 
block size (if 64k is indeed too small in practice for existing hardware).

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
