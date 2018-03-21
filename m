Received: from eggs.gnu.org ([2001:4830:134:3::10]:51968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eye3u-0003iY-1Y
	for Qemu-devel@nongnu.org; Wed, 21 Mar 2018 09:45:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eye3q-0004Mx-U7
	for Qemu-devel@nongnu.org; Wed, 21 Mar 2018 09:45:54 -0400
References: <20180321124417.29242-1-ptoscano@redhat.com>
	<20180321125105.GJ19514@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <65a7365f-89d5-a66c-4e7a-ce8ae1bcf595@redhat.com>
Date: Wed, 21 Mar 2018 08:45:38 -0500
MIME-Version: 1.0
In-Reply-To: <20180321125105.GJ19514@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Libguestfs] [PATCH] tests: regressions: make
 test-big-heap use a temporary empty file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Richard W.M. Jones" <rjones@redhat.com>, Pino Toscano <ptoscano@redhat.com>
Cc: libguestfs@redhat.com, "Qemu-devel@nongnu.org" <Qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>

[adding qemu lists]

On 03/21/2018 07:51 AM, Richard W.M. Jones wrote:
> On Wed, Mar 21, 2018 at 01:44:17PM +0100, Pino Toscano wrote:
>> Newer versions of qemu use file locking for the images by default, and
>> apparently that does not work with /dev/null.  Since this test just
>> calls qemu-img to get the format of an empty image, create a temporary
>> one instead.
> 
> ACK, but feels like this is a bug in qemu-img to me.

You're right that file locking on a character device like /dev/null is 
not going to work as expected, but is it a case where fcntl() actually 
fails, or is it worse where the fcntl() claiming the locks "succeeds" 
but doesn't do what we want?  That is, what were the actual error 
messages you ran into?

Is it something where qemu should instead be checking fstat() results 
and only doing locking on regular files and block devices?  At any rate, 
I agree that qemu itself should behave nicer on attempts to use 
/dev/null as an image.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
