Received: from eggs.gnu.org ([2001:4830:134:3::10]:35980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1flDBG-00048R-P3
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 08:58:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1flDBC-0008RW-T5
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 08:58:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41754 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1flDBC-0008Pl-Ni
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 08:58:10 -0400
References: <CAB3eZfuTdzecv2ParQmbiO6sjrUJ7tpV0HEo_2=2cYC890mOCg@mail.gmail.com>
	<ac7d377c-db69-c4ee-3d90-94700259db56@redhat.com>
	<CAB3eZfuJ4g3nUdthx-sMkj9vCF6F=knu5YkGjcm8EdN-E-GQnA@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f94d3465-0dfb-a91a-04a8-efb65129f676@redhat.com>
Date: Thu, 2 Aug 2018 07:58:08 -0500
MIME-Version: 1.0
In-Reply-To: <CAB3eZfuJ4g3nUdthx-sMkj9vCF6F=knu5YkGjcm8EdN-E-GQnA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Any tutorial to read/write in qcow2 format by
 programming way?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: lampahome <pahome.chen@mirlab.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 08/02/2018 01:57 AM, lampahome wrote:

[Top-posting is difficult to read on technical lists; it's better to 
reply inline]

> I have some questions about qcow2
> If I have 2 img A & B, and A is backing file of B.
> Is the format(such as L1, L2, ref block...etc) different from A and B?

image A can be a completely different format from B (different cluster 
sizing, different refcount sizing, for that matter, image A doesn't even 
have to be qcow2).  All that matters from B's perspective is that a read 
of any cluster not present in B is satisfied by reading the same range 
of guest-visible bytes from image A in whatever manner A serves up those 
bytes; and a write to a cluster not present in B causes a COW 
(copy-on-write) operation to pull in remaining data from A for any 
portion of the cluster not covered by the write itself.  The entire 
block layer in qemu is a well-defined recursive interface of driver 
callbacks, where any particular operation calls through as few or as 
many block drivers as needed to either reach the data in question or 
determine that the data is not available.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
