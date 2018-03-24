Received: from eggs.gnu.org ([208.118.235.92]:37624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ezl5C-0004q7-Ez
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 11:32:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ezl44-0005zc-OP
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 11:27:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48992 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ezhY1-0008TH-GI
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 07:41:21 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 19A438424C
	for <qemu-devel@nongnu.org>; Sat, 24 Mar 2018 11:41:17 +0000 (UTC)
References: <20180323103239.32414-1-marcandre.lureau@redhat.com>
	<20180323153537.GS32362@xz-mi>
	<CAMxuvax=SPeOui3mGcmK8HAo7EqDbpUSZ8Fq3mVHCrLztmBCLA@mail.gmail.com>
	<15aaea55-9ebd-8a16-c25e-c9bc709fcabc@redhat.com>
	<20180324014150.GU32362@xz-mi>
From: Eric Blake <eblake@redhat.com>
Message-ID: <51f5f5e5-61c3-e5c6-e925-4f2e9fdc4403@redhat.com>
Date: Sat, 24 Mar 2018 06:41:04 -0500
MIME-Version: 1.0
In-Reply-To: <20180324014150.GU32362@xz-mi>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] monitor: fix expected qmp_capabilities
 error description regression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel <qemu-devel@nongnu.org>

On 03/23/2018 08:41 PM, Peter Xu wrote:

>> There have been quite a few patch ideas across multiple threads related to
>> OOB fallout.  Hopefully I can keep straight which patches are intended for
>> 2.12 (anything that fixes a bug, like this one, is a good candidate,
> 
> I'll mark patches with "for-2.12" if there are.
> 
>> and it
>> would be nice if we can undo the temporary reversion of exposing OOB if we
>> can solve all the issues that iotests exposed).
> 
> IMHO it'll still be risky considering what has already reported.
> 
> Here's my plan, hopefully to make everyone happy - we keep OOB turned
> off for 2.12 and even later.  In 2.13, I'll post some new patches to
> add a new monitor parameter to allow user to enable OOB explicitly,
> otherwise we never enable it.  After all, for now the only real user
> should be postcopy. Then we don't need to struggle around all these
> mess.  What do you think?

If you're going to add a CLI parameter that must be specified for OOB to 
even be advertised, then it is MUCH less invasive to existing clients 
(it does mean that opting in to OOB now requires the command line 
argument AND the capability request during qmp_capabilities) - as such, 
enabling the opt-in during 2.12 is less controversial, and I see no 
reason to defer it to 2.13, especially if you want to maximize testing 
of the new feature to shake out the bugs it encounters.

If you want to be cautious, name the command-line parameter --x-oob for 
now, we can rename it later to drop the x- prefix, or remove the 
parameter altogether if we decide by opting in via merely 
qmp_capabilities is sufficient.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
