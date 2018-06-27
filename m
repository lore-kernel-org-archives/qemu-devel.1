Received: from eggs.gnu.org ([2001:4830:134:3::10]:52107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fYCdA-0004qW-2V
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 11:46:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fYCcf-0006H5-MD
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 11:45:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53680 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fYCcf-0006FE-93
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 11:44:45 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2685AB5C9
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 15:44:44 +0000 (UTC)
References: <20180626154028.11133-1-pbonzini@redhat.com>
	<20180626154028.11133-5-pbonzini@redhat.com>
	<6f643a0b-71f4-4034-d8ec-c5a0a2f84ba6@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8c63167d-c5e4-5fe4-ddae-5c69c7fd46e0@redhat.com>
Date: Wed, 27 Jun 2018 17:44:42 +0200
MIME-Version: 1.0
In-Reply-To: <6f643a0b-71f4-4034-d8ec-c5a0a2f84ba6@redhat.com>
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
To: Michal Privoznik <mprivozn@redhat.com>, qemu-devel@nongnu.org

On 26/06/2018 18:31, Michal Privoznik wrote:
>>  
>> +static bool pr_manager_helper_is_connected(PRManager *p)
>> +{
>> +    PRManagerHelper *pr_mgr = PR_MANAGER_HELPER(p);
>> +    bool result;
>> +
>> +    qemu_mutex_lock(&pr_mgr->lock);
>> +    result = (pr_mgr->ioc != NULL);
> I worry it is not that easy. pr_mgr->ioc is unset only when there's
> PR_IN/PR_OUT command coming from the guest (in pr_manager_helper_run ->
> pr_manager_helper_write). In fact, after 5/5 that is also the time when
> the event is delivered. But that might be too late for mgmt app to
> restart the helper process (although pr_manager_helper_run() tries to
> reconnect for 5 seconds before giving up).

That's true, however the important thing IMO is to have a QMP interface
that libvirt can use; everything else is just quality of implementation.

qemu-pr-helper anyway does something only when a guests sends it a PR
command - and with libvirt's per-guest model, that would (hopefully)
mean that the only case that remains is when someone manually kills the
qemu-pr-helper process.  In that case there's a certain amount of PEBKAC
involved... :)

Paolo

> The patch is good code-wise though.
