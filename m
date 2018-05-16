Received: from eggs.gnu.org ([2001:4830:134:3::10]:47448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fIxhQ-0004aM-MU
	for qemu-devel@nongnu.org; Wed, 16 May 2018 10:46:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fIxhM-0000Qt-2a
	for qemu-devel@nongnu.org; Wed, 16 May 2018 10:46:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52746 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fIxhL-0000Q7-VD
	for qemu-devel@nongnu.org; Wed, 16 May 2018 10:46:36 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3CEC84022414
	for <qemu-devel@nongnu.org>; Wed, 16 May 2018 14:46:35 +0000 (UTC)
References: <1526395713-60357-1-git-send-email-imammedo@redhat.com>
	<20180515152641.7oaxop77wgzokr7h@kamzik.brq.redhat.com>
	<3543e1cb-85b9-7f50-f97f-e8f2b98b10e0@redhat.com>
	<87eficu8g1.fsf@dusky.pond.sub.org>
	<20180516163234.79a6e692@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e2b0b10e-1420-fc4f-32a3-442bea07b809@redhat.com>
Date: Wed, 16 May 2018 09:46:33 -0500
MIME-Version: 1.0
In-Reply-To: <20180516163234.79a6e692@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] numa: clarify error message when node
 index is out of range in -numa dist, ...
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: Andrew Jones <drjones@redhat.com>, qemu-devel@nongnu.org, ehabkost@redhat.com

On 05/16/2018 09:32 AM, Igor Mammedov wrote:
>>> Actually, error_setg() is documented as taking a single phrase (no '.'
>>> included), and that if you need a second sentence, it's better to use
>>> error_append_hint().
> well, using append_hint makes it less readable, before using it we get following error:
> 
> $ qemu-system-x86_64 -numa dist,src=128,dst=1,val=20
> qemu-system-x86_64: -numa dist,src=128,dst=1,val=20: Invalid node 128, The valid node range is [0 - 127]
> $
> 
> after using it we get:
>    
> $ qemu-system-x86_64 -numa dist,src=128,dst=1,val=20
> qemu-system-x86_64: -numa dist,src=128,dst=1,val=20: Invalid node value 128
> The valid node range is [0 - 127]$
> 
> i.e. an extra newline in the middle of error message and looses automatic
> newline at the end so the shell prompt continues error message
> 

Use of error_append_hint() requires you to provide a newline (unlike 
error_setg().  But as Markus pointed out, you don't need to use it:

> 
>> Correct.  Providing help on valid values is exactly what
>> error_append_hint() is for.
>>
>>>                        Maybe Markus has an opinion on the best way to
>>> word this error message.
>>
>> Yes: "Parameter 'src' expects an integer between 0 and 127"

I like this wording better, which avoids the shortfalls that 
error_append_hint() would introduce.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
