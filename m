Received: from eggs.gnu.org ([2001:4830:134:3::10]:46710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gSjGO-0000TL-Tl
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 08:55:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gSjGL-0008PY-Ie
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 08:55:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:19975)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gSjGL-0008Ov-C8
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 08:55:21 -0500
References: <20181031115242.6558-1-d.csapak@proxmox.com>
	<20181031115242.6558-3-d.csapak@proxmox.com>
	<87sgzilx6e.fsf@dusky.pond.sub.org>
	<c38bb4f9-54cf-9348-a607-b8f0e9506904@proxmox.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <429e5696-53e2-bc32-85bf-b70c4c62f0f6@redhat.com>
Date: Fri, 30 Nov 2018 07:55:19 -0600
MIME-Version: 1.0
In-Reply-To: <c38bb4f9-54cf-9348-a607-b8f0e9506904@proxmox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/3] qapi: split host-qmp into quit and
 system-reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dominik Csapak <d.csapak@proxmox.com>, Markus Armbruster <armbru@redhat.com>
Cc: kwolf@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, mreitz@redhat.com

On 11/30/18 7:20 AM, Dominik Csapak wrote:
> On 11/30/18 10:41 AM, Markus Armbruster wrote:
>> Cc: Pavel to assess possible impact on replay.
>>
>> Cc: Eric to give him a chance to correct misunderstandings of
>> ShutdownCause.

I still need to look more closely at the series, but in answer to your 
question,


> 
> yeah switching 2 and 3 makes sense, i guess i did it this way so that
> i only have to touch the iotests one time
> 
> should i fix the iotests in both 2 and 3 when i switch them ?
> (with 2 the reason gets added there, and 3 changes the reason)
> or should i send an extra patch (4/4) that fixes only the iotests?
> or only change them in 3/3 ?

Ideally, iotests should pass after each commit (reduces chance of 
confusion down the road when a 'git bisect' is trying to pinpoint a 
cause of some other iotest failure).  iotests are a bit fuzzier than 
'make check' in terms of how long things are allowed to be checked in 
with known failures (in part because iotests has so many different ways 
to be run, and not all configurations are run all the times, so many 
corner-case configurations end up broken over long stretches of commits 
without realizing it), so that at least gives you some flexibility. But 
if you KNOW the test is broken, and reordering the patches or tweaking 
the tests to pass is easy, then you might as well do it.

Churn in the tests as output changes is not too bad - especially if it 
shows that the patch is accomplishing its stated purpose of making the 
expected output nicer.  So having the test fixed in 2 to show the reason 
and again in 3 to show a change in the reason makes sense for a patch 
series.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
