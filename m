Received: from eggs.gnu.org ([2001:4830:134:3::10]:47116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1fYQzn-00023y-Jq
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 03:05:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1fYQzk-0007wD-Ez
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 03:05:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51496 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mprivozn@redhat.com>) id 1fYQzk-0007v1-9c
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 03:05:32 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5CD15BF58D
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 07:05:31 +0000 (UTC)
References: <20180626154028.11133-1-pbonzini@redhat.com>
	<20180626154028.11133-5-pbonzini@redhat.com>
	<6f643a0b-71f4-4034-d8ec-c5a0a2f84ba6@redhat.com>
	<8c63167d-c5e4-5fe4-ddae-5c69c7fd46e0@redhat.com>
From: =?UTF-8?B?TWljaGFsIFByw612b3puw61r?= <mprivozn@redhat.com>
Message-ID: <7c40a4b2-1a4e-8ace-a58f-a6419ffd6df1@redhat.com>
Date: Thu, 28 Jun 2018 09:05:29 +0200
MIME-Version: 1.0
In-Reply-To: <8c63167d-c5e4-5fe4-ddae-5c69c7fd46e0@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/5] pr-manager: add query-pr-managers QMP
 command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

On 06/27/2018 05:44 PM, Paolo Bonzini wrote:
> On 26/06/2018 18:31, Michal Privoznik wrote:
>>>  
>>> +static bool pr_manager_helper_is_connected(PRManager *p)
>>> +{
>>> +    PRManagerHelper *pr_mgr = PR_MANAGER_HELPER(p);
>>> +    bool result;
>>> +
>>> +    qemu_mutex_lock(&pr_mgr->lock);
>>> +    result = (pr_mgr->ioc != NULL);
>> I worry it is not that easy. pr_mgr->ioc is unset only when there's
>> PR_IN/PR_OUT command coming from the guest (in pr_manager_helper_run ->
>> pr_manager_helper_write). In fact, after 5/5 that is also the time when
>> the event is delivered. But that might be too late for mgmt app to
>> restart the helper process (although pr_manager_helper_run() tries to
>> reconnect for 5 seconds before giving up).
> 
> That's true, however the important thing IMO is to have a QMP interface
> that libvirt can use; everything else is just quality of implementation.
> 
> qemu-pr-helper anyway does something only when a guests sends it a PR
> command - and with libvirt's per-guest model, that would (hopefully)
> mean that the only case that remains is when someone manually kills the
> qemu-pr-helper process.  In that case there's a certain amount of PEBKAC
> involved... :)

Unless an assert() is triggered ;-)

But since you merged my suggested changes in 5/5 libvirt can catch the
event pretty soon, so in my testing qemu was still left with 3-4
connection retries which is plenty.

Michal
