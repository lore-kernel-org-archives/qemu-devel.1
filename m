Received: from eggs.gnu.org ([2001:4830:134:3::10]:53410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1dJFLG-000522-JH
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 04:32:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1dJFLD-00087H-AO
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 04:32:26 -0400
Received: from lhrrgout.huawei.com ([194.213.3.17]:13591)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1dJFLD-00085G-0J
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 04:32:23 -0400
References: <1494405683-20877-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1494405683-20877-5-git-send-email-pradeep.jagadeesh@huawei.com>
	<6a035cd9-34f9-c1f5-e986-404daf941641@redhat.com>
	<57a24e21-0864-16d3-1bce-ad801875ea9f@huawei.com>
	<2c0e99ce-f3cb-90e8-baed-8fad9d39455b@redhat.com>
	<20170517182938.0c7f366e@bahia.lan>
	<6df407d5-4145-2e90-a7eb-b047819ceb75@redhat.com>
	<e1d5b2d3-bfe7-4fac-03f7-bbfbd5de10fe@huawei.com>
	<20170608184915.20056e6c@bahia.ttt.fr.ibm.com>
From: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
Message-ID: <d08e5a11-0b75-a111-40c4-2f09f37404b1@huawei.com>
Date: Fri, 9 Jun 2017 10:31:58 +0200
MIME-Version: 1.0
In-Reply-To: <20170608184915.20056e6c@bahia.ttt.fr.ibm.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 4/4] fsdev: QMP interface for throttling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: Eric Blake <eblake@redhat.com>, jani kokkonen <jani.kokkonen@huawei.com>, alberto garcia <berto@igalia.com>, qemu-devel@nongnu.org, Pradeep Jagadeesh <pradeepkiruvale@gmail.com>

On 6/8/2017 6:49 PM, Greg Kurz wrote:
> On Thu, 18 May 2017 15:30:06 +0200
> Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com> wrote:
>
>> On 5/17/2017 7:09 PM, Eric Blake wrote:
>>> On 05/17/2017 11:29 AM, Greg Kurz wrote:
>>>
>>>>>
>>>>> First point: is fsdev a Linux-only feature, or can it be compiled on
>>>>> BSD?  If it is Linux-only, then compiling a stub for Windows will still
>>>>> leave BSD broken, and your #ifdef is wrong.  Fixing compilation on mingw
>>>>> is nice, but not the only platform to worry about.
>>>>>
>>>>
>>>> fsdev compilation currently depends on CONFIG_VIRTFS which is a Linux-only
>>>> feature for the moment. There was a tentative to support it on Windows hosts
>>>> two years ago but it stayed at the RFC stage.
>>>>
>>>> But even on Linux hosts, the current fsdev implementation also depends on
>>>> the target supporting PCI and VIRTIO. We have a fsdev/qemu-fsdev-dummy.c
>>>> file to put stubs so that we don't pull all the code for such targets.
>>>>
>>>> Maybe this could be reused for the above stubs as well ?
>>>
>>> That helps.  The stub should live in qemu-fsdev-dummy.c (where it
>>> shouldn't need any #ifdef, because that file is only compiled when the
>>> condition is false), and...
>>>
>>>>
>>>>> Second point: if fsdev is indeed a platform-specific feature, then we
>>>>> don't want to advertise the QMP commands that are useless when running
>>>>> on a platform that doesn't support it. Anywhere you have to add a stub
>>>>> for compilation means you ALSO need to patch monitor.c to unregister the
>>>>> command from being advertised as a valid QMP command.  (If you used
>>>>> #ifdef __LINUX__ to guard the working version, and #ifndef __LINUX__ to
>>>>> declare the stub, then the monitor.c needs an #ifndef section within
>>>>> qmp_unregister_commands_hack() to tell QMP to not advertise the stubs.)
>>>
>>> monitor.c should wrap the unregister under #ifndef CONFIG_VIRTFS (rather
>>> than a particular platform name).
>> I did unregister the functions as mentioned above in monitor.c. But it
>> does not address the issue when I run "make docker-test-mingw@fedora".
>
> What issue is this ?
>
> I cannot even run this with your unmodified series (please note that I
> always build out-of-tree).
The issue is when I cross build the qemu, I was facing the compilation 
issue. Even it failed in patchew. So, I had to add the dummy functions 
in monitor.c and qmp.c.

-Pradeep
>> I think the VIRTFS is still enabled.
>> Only having dummy functions even in qmp.c addresses the issue.
>>
>> Regards,
>> Pradeep
>>>
>>
>>
>
