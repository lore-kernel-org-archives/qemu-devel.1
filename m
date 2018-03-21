Received: from eggs.gnu.org ([2001:4830:134:3::10]:56394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eykoQ-0003dc-CQ
	for Qemu-devel@nongnu.org; Wed, 21 Mar 2018 16:58:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eykoL-00079S-Oq
	for Qemu-devel@nongnu.org; Wed, 21 Mar 2018 16:58:22 -0400
References: <20180321124417.29242-1-ptoscano@redhat.com>
	<20180321125105.GJ19514@redhat.com>
	<65a7365f-89d5-a66c-4e7a-ce8ae1bcf595@redhat.com>
	<2075074.dXtERdIzXi@thyrus.usersys.redhat.com>
	<20180321204420.GL3898@localhost.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <386fe69d-f45b-704a-e936-0211935977ce@redhat.com>
Date: Wed, 21 Mar 2018 15:58:05 -0500
MIME-Version: 1.0
In-Reply-To: <20180321204420.GL3898@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [Libguestfs] [PATCH] tests:
 regressions: make test-big-heap use a temporary empty file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Pino Toscano <ptoscano@redhat.com>
Cc: "Qemu-devel@nongnu.org" <Qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>, "Richard W.M. Jones" <rjones@redhat.com>, libguestfs@redhat.com, mreitz@redhat.com

On 03/21/2018 03:44 PM, Kevin Wolf wrote:
>>>
>>> You're right that file locking on a character device like /dev/null is
>>> not going to work as expected, but is it a case where fcntl() actually
>>> fails, or is it worse where the fcntl() claiming the locks "succeeds"
>>> but doesn't do what we want?  That is, what were the actual error
>>> messages you ran into?
>>
>> $ qemu-img --version
>> qemu-img version 2.10.1(qemu-2.10.1-2.fc27)
>> Copyright (c) 2003-2017 Fabrice Bellard and the QEMU Project developers
>> $ qemu-img info /dev/null
>> qemu-img: Could not open '/dev/null': Failed to get "consistent read" lock
>> Is another process using the image?
> 
> Not sure where the difference is, but I can't reproduce this on
> upstream, neither git master nor the v2.10.1 tag:

Is it a case where file locking actually works, and more than one 
process is trying to lock /dev/null at once?  (qemu-img info is 
short-lived, but could there be another longer-lived process also using 
/dev/null)?

Does using -r help (if the only reason you're telling qemu-img to 
operate on /dev/null is to probe qemu-img features, can you probe those 
same features without needing to write, which in turn requests less 
locking)?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
