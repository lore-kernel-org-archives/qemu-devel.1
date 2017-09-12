Received: from eggs.gnu.org ([2001:4830:134:3::10]:39377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1drpZC-0006s9-Vs
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 14:05:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1drpZ9-0002Gb-Ho
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 14:05:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48090)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1drpZ9-0002FH-2m
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 14:05:43 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DD4572F14A7
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 18:05:41 +0000 (UTC)
References: <20170912104626.8386-1-berrange@redhat.com>
	<810971dc-0a17-cf41-c11a-db991a17317a@redhat.com>
	<20170912161252.GM17633@redhat.com>
	<5994d2c2-77b3-6698-c9e0-c737c84caf68@redhat.com>
	<20170912162223.GN17633@redhat.com>
	<76f6207d-165d-d1dd-652f-67038e9f2509@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <55d31a10-5e02-e7a9-5e0a-0d84453e1d79@redhat.com>
Date: Tue, 12 Sep 2017 14:05:40 -0400
MIME-Version: 1.0
In-Reply-To: <76f6207d-165d-d1dd-652f-67038e9f2509@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] scripts: let checkpatch.pl process an
 entire GIT branch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>



On 09/12/2017 12:24 PM, Paolo Bonzini wrote:
> On 12/09/2017 18:22, Daniel P. Berrange wrote:
>> On Tue, Sep 12, 2017 at 06:14:57PM +0200, Paolo Bonzini wrote:
>>> On 12/09/2017 18:12, Daniel P. Berrange wrote:
>>>> On Tue, Sep 12, 2017 at 05:52:18PM +0200, Paolo Bonzini wrote:
>>>>> On 12/09/2017 12:46, Daniel P. Berrange wrote:
>>>>>> Currently before submitting a series, devs should run checkpatch.pl
>>>>>> across each patch to be submitted. This can be automated using a
>>>>>> command such as:
>>>>>>
>>>>>>   git rebase -i master -x 'git show | ./scripts/checkpatch.pl -'
>>>>>>
>>>>>> This is rather long winded to type, so this patch introduces a new
>>>>>> flag '--branch' to checkpatch.pl which instructs it to check every
>>>>>> patch on the current GIT branch.
>>>>>
>>>>> Great idea, though I'm not sure about having a default.  And to keep it
>>>>> easy to invoke, having a sole argument that ends with ".." might DWIM
>>>>> and enable --branch too...
>>>>
>>>> I think it is beneficial to have a default, as I figure the majority
>>>> of contributors are working on a branch that's rebased against master..
>>>> Half as many characters to type in the common case :-)
>>>
>>> With the DWIM option "--branch" and "master.." are exactly the same
>>> length. :)
>>
>> Oh hang on. I think I misunderstood what you suggested. I thought you
>> meant  'checkpatch.pl --branch master..', but IIUC you actually mean
>> 'checkpatch.pl master..' with no flag. That would work with me.
> 
> Yes, basically if length(argv) == 1 and argv[0] ends with ".." then
> enable branch.  The default for --branch with no ARGV could be
> "origin/master.."---or it could ask git-config for the upstream tracking
> branch but maybe that's too much to ask.
> 
> Paolo
> 

~Crazy suggestion~ is that the default could actually be "@{upstream}.."
which will default to whatever you've configured the upstream to be in
the branch you're working in.

Downside is that if you don't set the tracking branch during branch
creation (`git checkout -b myTopic origin/master`) or at a later date
(`git branch --set-upstream-to=origin/master`) that this reference won't
resolve.

You can check and see if it resolves to anything programmatically, though:

jhuston@probe (review) ~/s/qemu> git rev-parse "@{upstream}"
04ef33052c205170c92df21ca0b4be4f3b102188
jhuston@probe (review) ~/s/qemu> echo $status
0


jhuston@probe (master) ~/s/qemu> git checkout -b foobar
Switched to a new branch 'foobar'
jhuston@probe (foobar) ~/s/qemu> git rev-parse "@{upstream}"
fatal: no upstream configured for branch 'foobar'
jhuston@probe (foobar) ~/s/qemu> echo $status
128
